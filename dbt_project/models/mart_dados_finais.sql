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
    DATE_PART('year', AGE(data_nascimento)) AS idade,
    em_situacao_de_rua,
    frequenta_escola,
    meios_transporte,
    doencas_condicoes,
    identidade_genero,
    meios_comunicacao,
    orientacao_sexual,
    familia_beneficiaria_auxilio_brasil,
    crianca_matriculada_creche_pre_escola,
    altura,
    peso,
    pressao_sistolica,
    pressao_diastolica,
    n_atendimentos_atencao_primaria,
    n_atendimentos_hospital,
    updated_at,
    tipo
FROM {{ ref('int_tratamento') }}
WHERE altura IS NOT NULL AND peso IS NOT NULL