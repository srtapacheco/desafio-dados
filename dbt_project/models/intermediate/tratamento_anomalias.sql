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

        -- Verificação de anomalias na altura fora do intervalo possivel
        CASE 
            WHEN altura < 50 OR altura > 250 THEN TRUE
            ELSE FALSE
        END AS flag_altura_anomala,

        -- Substitui alturas impossíveis por NULL
        CASE 
            WHEN altura < 50 OR altura > 250 THEN NULL
            ELSE altura
        END AS altura_corrigida,

        -- Verificação de anomalias na peso fora do intervalo possivel
        CASE 
            WHEN peso < 2 OR peso > 500 THEN TRUE
            ELSE FALSE
        END AS flag_peso_anomalo,

        -- Substituir pesos impossíveis por NULL
        CASE 
            WHEN peso < 2 OR peso > 500 THEN NULL
            ELSE peso
        END AS peso_corrigido,

        -- Verificação de anomalias na pressao fora do intervalo possivel
        CASE 
            WHEN pressao_sistolica < 60 OR pressao_sistolica > 300 
                 OR pressao_diastolica < 30 OR pressao_diastolica > 200 
                 OR pressao_sistolica <= pressao_diastolica 
            THEN TRUE
            ELSE FALSE
        END AS flag_pressao_anomala,

        -- Substitui pressões impossíveis por NULL
        CASE 
            WHEN pressao_sistolica < 60 OR pressao_sistolica > 300 
                 OR pressao_diastolica < 30 OR pressao_diastolica > 200 
                 OR pressao_sistolica <= pressao_diastolica 
            THEN NULL
            ELSE pressao_sistolica
        END AS pressao_sistolica_corrigida,

        CASE 
            WHEN pressao_sistolica < 60 OR pressao_sistolica > 300 
                 OR pressao_diastolica < 30 OR pressao_diastolica > 200 
                 OR pressao_sistolica <= pressao_diastolica 
            THEN NULL
            ELSE pressao_diastolica
        END AS pressao_diastolica_corrigida

    FROM base
)

SELECT * FROM tratamento_anomalia