{{ config(materialized='table') }}

WITH base AS (
    SELECT 
        id,
        CAST(data_nascimento AS DATE) AS data_nascimento,
        CAST(updated_at AS TIMESTAMP) AS updated_at,
        CAST(data_cadastro AS TIMESTAMP) AS data_cadastro,
        CAST(data_atualizacao_cadastro AS TIMESTAMP) AS data_atualizacao_cadastro,
        obito
    FROM {{ ref('stg_dados') }}
),

idade_calculada AS (
    SELECT
        id,
        data_nascimento,
        updated_at,
        data_cadastro,
        data_atualizacao_cadastro,
        obito,

        -- Calcular idade correta considerando aniversário
        EXTRACT(YEAR FROM updated_at) - EXTRACT(YEAR FROM data_nascimento) - 
            CASE 
                WHEN EXTRACT(MONTH FROM updated_at) < EXTRACT(MONTH FROM data_nascimento) 
                OR (EXTRACT(MONTH FROM updated_at) = EXTRACT(MONTH FROM data_nascimento) 
                    AND EXTRACT(DAY FROM updated_at) < EXTRACT(DAY FROM data_nascimento)) 
                THEN 1 
                ELSE 0 
            END AS idade,

        -- Flag de erro para idades inconsistentes
        CASE 
            WHEN obito = 0 AND 
                (EXTRACT(YEAR FROM updated_at) - EXTRACT(YEAR FROM data_nascimento) -
                    CASE 
                        WHEN EXTRACT(MONTH FROM updated_at) < EXTRACT(MONTH FROM data_nascimento) 
                        OR (EXTRACT(MONTH FROM updated_at) = EXTRACT(MONTH FROM data_nascimento) 
                            AND EXTRACT(DAY FROM updated_at) < EXTRACT(DAY FROM data_nascimento)) 
                        THEN 1 
                        ELSE 0 
                    END) > 110 
            THEN TRUE
            ELSE FALSE
        END AS flag_dado_erro,

        -- idade máxima de 110 anos quando obito = 0
        CASE 
            WHEN obito = 0 AND 
                (EXTRACT(YEAR FROM updated_at) - EXTRACT(YEAR FROM data_nascimento) -
                    CASE 
                        WHEN EXTRACT(MONTH FROM updated_at) < EXTRACT(MONTH FROM data_nascimento) 
                        OR (EXTRACT(MONTH FROM updated_at) = EXTRACT(MONTH FROM data_nascimento) 
                            AND EXTRACT(DAY FROM updated_at) < EXTRACT(DAY FROM data_nascimento)) 
                        THEN 1 
                        ELSE 0 
                    END) > 110 
            THEN 110
            ELSE 
                (EXTRACT(YEAR FROM updated_at) - EXTRACT(YEAR FROM data_nascimento) -
                    CASE 
                        WHEN EXTRACT(MONTH FROM updated_at) < EXTRACT(MONTH FROM data_nascimento) 
                        OR (EXTRACT(MONTH FROM updated_at) = EXTRACT(MONTH FROM data_nascimento) 
                            AND EXTRACT(DAY FROM updated_at) < EXTRACT(DAY FROM data_nascimento)) 
                        THEN 1 
                        ELSE 0 
                    END)
        END AS idade_corrigida

    FROM base
)

SELECT * FROM idade_calculada