{{ config(materialized='table') }}

SELECT
    id_paciente AS id,
    
    -- Campos categóricos convertidos para TEXT
    CAST(raca_cor AS TEXT) AS raca_cor,
    CAST(ocupacao AS TEXT) AS ocupacao,
    CAST(religiao AS TEXT) AS religiao,
    CAST(escolaridade AS TEXT) AS escolaridade,
    CAST(nacionalidade AS TEXT) AS nacionalidade,
    CAST(identidade_genero AS TEXT) AS identidade_genero,
    CAST(orientacao_sexual AS TEXT) AS orientacao_sexual,
    CAST(situacao_profissional AS TEXT) AS situacao_profissional,
    CAST(vulnerabilidade_social AS TEXT) AS vulnerabilidade_social,
    
    -- Campos binários convertidos para INTEGER (0 ou 1)
    CAST(
        CASE 
            WHEN LOWER(TRIM(CAST(sexo AS TEXT))) = 'male' THEN 1
            WHEN LOWER(TRIM(CAST(sexo AS TEXT))) = 'female' THEN 0
            ELSE NULL
        END AS INTEGER
    ) AS sexo,
    
    CAST(
        CASE 
            WHEN LOWER(TRIM(CAST(obito AS TEXT))) IN ('1', 'true') THEN 1
            WHEN LOWER(TRIM(CAST(obito AS TEXT))) IN ('0', 'false') THEN 0
            ELSE NULL
        END AS INTEGER
    ) AS obito,
    
    CAST(
        CASE 
            WHEN LOWER(TRIM(CAST(luz_eletrica AS TEXT))) IN ('1', 'true') THEN 1
            WHEN LOWER(TRIM(CAST(luz_eletrica AS TEXT))) IN ('0', 'false') THEN 0
            ELSE NULL
        END AS INTEGER
    ) AS luz_eletrica,
    
    CAST(
        CASE 
            WHEN LOWER(TRIM(CAST(familia_beneficiaria_auxilio_brasil AS TEXT))) IN ('1', 'true') THEN 1
            WHEN LOWER(TRIM(CAST(familia_beneficiaria_auxilio_brasil AS TEXT))) IN ('0', 'false') THEN 0
            ELSE NULL
        END AS INTEGER
    ) AS familia_beneficiaria_auxilio_brasil,
    
    CAST(
        CASE 
            WHEN LOWER(TRIM(CAST(crianca_matriculada_creche_pre_escola AS TEXT))) IN ('1', 'true') THEN 1
            WHEN LOWER(TRIM(CAST(crianca_matriculada_creche_pre_escola AS TEXT))) IN ('0', 'false') THEN 0
            ELSE NULL
        END AS INTEGER
    ) AS crianca_matriculada_creche_pre_escola,
    
    CAST(
        CASE 
            WHEN LOWER(TRIM(CAST(frequenta_escola AS TEXT))) IN ('1', 'true') THEN 1
            WHEN LOWER(TRIM(CAST(frequenta_escola AS TEXT))) IN ('0', 'false') THEN 0
            ELSE NULL
        END AS INTEGER
    ) AS frequenta_escola,
    
    CAST(
        CASE 
            WHEN LOWER(TRIM(CAST(em_situacao_de_rua AS TEXT))) IN ('1', 'true') THEN 1
            WHEN LOWER(TRIM(CAST(em_situacao_de_rua AS TEXT))) IN ('0', 'false') THEN 0
            ELSE NULL
        END AS INTEGER
    ) AS em_situacao_de_rua,
    
    CAST(
        CASE 
            WHEN LOWER(TRIM(CAST(possui_plano_saude AS TEXT))) IN ('1', 'true') THEN 1
            WHEN LOWER(TRIM(CAST(possui_plano_saude AS TEXT))) IN ('0', 'false') THEN 0
            ELSE NULL
        END AS INTEGER
    ) AS possui_plano_saude,
    
    -- Campos numéricos
    CAST(altura AS FLOAT) AS altura,
    CAST(peso AS FLOAT) AS peso,
    CAST(pressao_sistolica AS FLOAT) AS pressao_sistolica,
    CAST(pressao_diastolica AS FLOAT) AS pressao_diastolica,
    
    CAST(n_atendimentos_atencao_primaria AS INTEGER) AS n_atendimentos_atencao_primaria,
    CAST(n_atendimentos_hospital AS INTEGER) AS n_atendimentos_hospital,
    
    -- Campos de data
    CAST(data_nascimento AS DATE) AS data_nascimento,
    CAST(data_cadastro AS TIMESTAMP) AS data_cadastro,
    CAST(data_atualizacao_cadastro AS TIMESTAMP) AS data_atualizacao_cadastro,
    CAST(updated_at AS TIMESTAMP) AS updated_at

FROM public.dados_brutos
