{{ config(materialized='table') }}

SELECT
    id,
    LOWER(TRIM(ocupacao)) AS ocupacao_normalizada -- Normaliza para minúsculas e remove espaços extras
FROM {{ ref('stg_ocupacoes') }}