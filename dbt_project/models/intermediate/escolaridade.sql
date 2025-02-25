{{ config(materialized='table') }}

WITH base AS (
    SELECT 
        c.id,
        s.escolaridade,  -- Pegando escolaridade da tabela staging p usar idade ja calculada
        c.idade_corrigida AS idade 
    FROM {{ ref('calculate_idade') }} c
    LEFT JOIN {{ ref('stg_dados') }} s ON c.id = s.id
),

ajuste_escolaridade AS (
    SELECT
        id,
        escolaridade,
        idade,
        
        -- Ajusta escolaridade p 'Não sabe ler/escrever' para crianca com idade < 3 anos
        CASE 
            WHEN idade < 3 AND escolaridade NOT IN ('Não sabe ler/escrever', NULL) 
            THEN 'Não sabe ler/escrever'
            ELSE escolaridade
        END AS escolaridade_corrigida

    FROM base
)

SELECT * FROM ajuste_escolaridade