{{ config(materialized='table') }}

SELECT
    id_paciente,
    sexo,
    CAST(CASE 
        WHEN obito IN ('1', 'True') THEN 1
        WHEN obito IN ('0', 'False') THEN 0
        ELSE NULL
    END AS INTEGER) AS obito,
    bairro,
    raca_cor,
    ocupacao,
    religiao,
    CAST(CASE 
        WHEN luz_eletrica IN ('1', 'True') THEN 1
        WHEN luz_eletrica IN ('0', 'False') THEN 0
        ELSE NULL
    END AS INTEGER) AS luz_eletrica,
    CAST(data_cadastro AS TIMESTAMP) AS data_cadastro,
    escolaridade,
    nacionalidade,
    renda_familiar,
    CAST(data_nascimento AS DATE) AS data_nascimento,
    em_situacao_de_rua,
    CAST(frequenta_escola AS INTEGER) AS frequenta_escola,
    meios_transporte,
    doencas_condicoes,
    identidade_genero,
    meios_comunicacao,
    orientacao_sexual,
    CAST(CASE 
        WHEN familia_beneficiaria_auxilio_brasil IN ('1', 'True') THEN 1
        WHEN familia_beneficiaria_auxilio_brasil IN ('0', 'False') THEN 0
        ELSE NULL
    END AS INTEGER) AS familia_beneficiaria_auxilio_brasil,
    CAST(CASE 
        WHEN crianca_matriculada_creche_pre_escola IN ('1', 'True') THEN 1
        WHEN crianca_matriculada_creche_pre_escola IN ('0', 'False') THEN 0
        ELSE NULL
    END AS INTEGER) AS crianca_matriculada_creche_pre_escola,
    CAST(altura AS FLOAT) AS altura,
    CAST(peso AS FLOAT) AS peso,
    CAST(pressao_sistolica AS FLOAT) AS pressao_sistolica,
    CAST(pressao_diastolica AS FLOAT) AS pressao_diastolica,
    CAST(n_atendimentos_atencao_primaria AS INTEGER) AS n_atendimentos_atencao_primaria,
    CAST(n_atendimentos_hospital AS INTEGER) AS n_atendimentos_hospital,
    CAST(updated_at AS TIMESTAMP) AS updated_at,
    tipo
FROM public.dados_brutos