-- depends_on: {{ ref('stg_orders') }}

{{ config(materialized = 'incremental', unique_key = ['OrderId', 'LineNo']) }}
 
select
od.*
from
{{source('qwt_raw', 'orders')}} as o inner join
{{source("qwt_raw", 'orderdetails')}} od
on o.OrderId = od.OrderId
 
{% if is_incremental() %}
 
    where o.OrderDate > (select max(OrderDate) from stg_orders)
 
{% endif %}