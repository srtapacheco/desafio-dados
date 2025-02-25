{{ config(materialized='table') }} 

WITH base AS (
    SELECT 
        id,
        altura,
        peso,
        pressao_sistolica,
        pressao_diastolica
    FROM {{ ref('stg_dados') }}
),

tratamento_anomalias AS (
    SELECT 
        id,

        -- Verificação de anomalias na altura
        CASE 
            WHEN altura <= 50 OR altura >= 250 OR altura = 0 THEN TRUE
            ELSE FALSE
        END AS flag_altura_anomala,

        -- Corrigir altura impossível para NULL
        CASE 
            WHEN altura <= 50 OR altura >= 250 OR altura = 0 THEN NULL
            ELSE altura
        END AS altura_corrigida,

        -- Verificação de anomalias no peso
        CASE 
            WHEN peso <= 3 OR peso >= 250 OR peso = 0 THEN TRUE
            ELSE FALSE
        END AS flag_peso_anomalo,

        -- Corrigir peso impossível para NULL
        CASE 
            WHEN peso <= 3 OR peso >= 250 OR peso = 0 THEN NULL
            ELSE peso
        END AS peso_corrigido,

        -- Verificação de anomalias na pressão arterial
        CASE 
            WHEN pressao_sistolica >= 280 OR pressao_diastolica >= 160 
                 OR pressao_sistolica = 0 OR pressao_diastolica = 0 
                 OR pressao_sistolica <= pressao_diastolica 
            THEN TRUE
            ELSE FALSE
        END AS flag_pressao_anomala,

        -- Corrigir pressão arterial impossível para NULL
        CASE 
            WHEN pressao_sistolica >= 280 OR pressao_sistolica = 0 THEN NULL
            ELSE pressao_sistolica
        END AS pressao_sistolica_corrigida,

        CASE 
            WHEN pressao_diastolica >= 160 OR pressao_diastolica = 0 THEN NULL
            ELSE pressao_diastolica
        END AS pressao_diastolica_corrigida

    FROM base
)

SELECT * FROM tratamento_anomalias