WITH raw_data AS (
    SELECT
        *,
        -- Padronização do campo 'obito'
        CASE 
            WHEN obito IN ('1', 'True') THEN 1
            WHEN obito IN ('0', 'False') THEN 0
            ELSE NULL
        END AS obito_padronizado,

        -- Padronização do campo 'luz_eletrica'
        CASE 
            WHEN luz_eletrica IN ('1', 'True') THEN 1
            WHEN luz_eletrica IN ('0', 'False') THEN 0
            ELSE NULL
        END AS luz_eletrica_padronizado,

        -- Padronização do campo 'familia_beneficiaria_auxilio_brasil'
        CASE 
            WHEN familia_beneficiaria_auxilio_brasil IN ('1', 'True') THEN 1
            WHEN familia_beneficiaria_auxilio_brasil IN ('0', 'False') THEN 0
            ELSE NULL
        END AS familia_beneficiaria_auxilio_brasil_padronizado,

        -- Padronização do campo 'crianca_matriculada_creche_pre_escola'
        CASE 
            WHEN crianca_matriculada_creche_pre_escola IN ('1', 'True') THEN 1
            WHEN crianca_matriculada_creche_pre_escola IN ('0', 'False') THEN 0
            ELSE NULL
        END AS crianca_matriculada_creche_pre_escola_padronizado

    FROM {{ source('dados_brutos', 'dados_ficha_a_desafio') }} -- AJUSTADO PARA O `sources.yml`
)

SELECT * FROM raw_data;