{{ config(materialized='table') }}

WITH base AS (
    SELECT 
        id,
        n_atendimentos_atencao_primaria,
        n_atendimentos_hospital
    FROM {{ ref('stg_dados') }}
),

flag_uso_excessivo AS (
    SELECT 
        id,

        -- Flag para uso excessivo do hospital sem atendimento primário
        CASE 
            WHEN n_atendimentos_hospital > 50 AND n_atendimentos_atencao_primaria = 0 THEN 1
            ELSE 0
        END AS flag_uso_excessivo

    FROM base
)

SELECT * FROM flag_uso_excessivo