{{ config(materialized = 'table', schema = env_var('DBT_STAGESCHEMA', 'STAGING')) }}
 
select
 
empid ,
lastname ,
firstname ,
title ,
To_Date(hiredate, 'MM/DD/YY') as HireDate ,
office ,
extension ,
Reportsto ,
YearSalary
 
from
 
{{ source('qwt_raw', 'employees') }}