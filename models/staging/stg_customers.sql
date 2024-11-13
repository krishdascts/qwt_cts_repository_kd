{{config(materialized='table')}}
select 
* 
From
{{source('qwt_raw','customer')}}