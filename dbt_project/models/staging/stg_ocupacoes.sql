{{ config(materialized='table') }}

SELECT
    id_paciente AS id,
    TRIM(ocupacao) AS ocupacao -- Remove espaços extras
FROM public.dados_brutos