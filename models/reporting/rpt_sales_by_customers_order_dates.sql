{{ config(materialized = 'view', schema = 'reporting') }}
 
WITH customers as
(
    select customerid,companyname,contactname,city
    from {{ref('dim_customers')}}

),
orders as
(
    select customerid,quantity,linesalesamount,orderdate
    from {{ref('fct_orders')}}
),

customers_orders as
(
    select 
    customers.companyname as companyname,
    customers.contactname as contactname,
    customers.city as city,
    min(orders.orderdate) as first_order_date,
    max(orders.orderdate) as recent_order_date,
    sum(orders.quantity) as total_orders,
    sum(orders.linesalesamount) as total_sales

    from customers inner join orders on customers.customerid=orders.customerid

    group by companyname,contactname,city
    order by total_sales desc
)
select * from customers_orders