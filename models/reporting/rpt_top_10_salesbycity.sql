{{config(materialized='view',schema='reporting')}}
select 
c.companyname,
c.contactname,
sum(o.linesalesamount) as sales,
sum(o.quantity) as total_orders,
avg(o.margin) as avg_margin
From
{{ref('fct_orders')}} as o 
inner join {{ref('dim_customers')}} as c
on o.customerid=c.customerid where c.city = {{var('v_city',"'London'")}}
group by c.companyname,c.contactname
order by sales desc