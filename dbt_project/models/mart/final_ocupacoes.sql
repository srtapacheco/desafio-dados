{{ config(materialized='table') }}

SELECT 
    id,
    ocupacao_normalizada,
    CASE
        WHEN ocupacao_normalizada LIKE '%motorista%' THEN 'motorista'
        WHEN ocupacao_normalizada LIKE '%pedreiro%' THEN 'pedreiro'
        WHEN ocupacao_normalizada LIKE '%musico%' THEN 'músico'
        WHEN ocupacao_normalizada LIKE '%montador%' THEN 'montador'
        WHEN ocupacao_normalizada LIKE '%pesquisador%' THEN 'pesquisador'
        WHEN ocupacao_normalizada LIKE '%supervisor%' THEN 'supervisor'
        WHEN ocupacao_normalizada LIKE '%atendente%' THEN 'atendente'
        WHEN ocupacao_normalizada LIKE '%pesquisador%' THEN 'pesquisador'
        ELSE ocupacao_normalizada -- As outras ocupações ficam como estão
    END AS ocupacao_categoria
FROM {{ ref('normalize_ocupacoes') }}