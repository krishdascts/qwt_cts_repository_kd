{{ config(materialized = 'table', schema = env_var('DBT_STAGESCHEMA', 'STAGING')) }}
select 
* 
From
{{source('qwt_raw','products')}}