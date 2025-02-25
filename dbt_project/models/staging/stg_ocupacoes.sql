{{ config(materialized='table') }}

SELECT
    id_paciente AS id,  -- Definir o identificador correto
    TRIM(ocupacao) AS ocupacao -- Removendo espaços extras
FROM public.dados_brutos