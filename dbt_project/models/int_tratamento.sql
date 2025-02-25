{{ config(materialized='table') }}

SELECT
    id_paciente,
    sexo,
    obito,
    luz_eletrica,
    bairro,
    ocupacao,
    religiao,
    escolaridade,
    nacionalidade,
    renda_familiar,
    data_nascimento,
    em_situacao_de_rua,
    frequenta_escola,
    meios_transporte,
    doencas_condicoes,
    identidade_genero,
    meios_comunicacao,
    orientacao_sexual,
    familia_beneficiaria_auxilio_brasil,
    crianca_matriculada_creche_pre_escola,
    -- Tratamento de valores inconsistentes
    CASE WHEN altura BETWEEN 50 AND 250 THEN altura ELSE NULL END AS altura,
    CASE WHEN peso BETWEEN 10 AND 300 THEN peso ELSE NULL END AS peso,
    CASE WHEN pressao_sistolica BETWEEN 70 AND 200 THEN pressao_sistolica ELSE NULL END AS pressao_sistolica,
    CASE WHEN pressao_diastolica BETWEEN 40 AND 120 THEN pressao_diastolica ELSE NULL END AS pressao_diastolica,
    n_atendimentos_atencao_primaria,
    n_atendimentos_hospital,
    updated_at,
    tipo
FROM {{ ref('stg_dados_brutos') }}