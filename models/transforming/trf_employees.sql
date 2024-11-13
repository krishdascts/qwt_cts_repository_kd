{{ config(materialized = 'table', schema = 'transforming') }}
 
select
emp.empid,
emp.lastname,
emp.firstname,
emp.title,
off.address,
off.city,
off.stateprovince,
off.phone,
emp.hiredate,
iff(mgr.firstname is null, emp.firstname, mgr.firstname) as manager_name,
iff(mgr.title is null, emp.title, mgr.title) as manager_title,
iff(emp.extension = '-', 'NA', emp.extension) as extension,
emp.yearsalary
from
{{ref('stg_employees')}} as emp left join {{ref('stg_employees')}} as mgr
on emp.reportsto = mgr.empid
inner join {{ref('stg_offices')}} as off on emp.office = off.officeid