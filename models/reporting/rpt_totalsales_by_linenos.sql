{{ config(materialized= 'view', schema = 'reporting') }}
 
--{% set linenos = [1, 2, 3] %} -- Defining and setting a variable
{% set linenos = get_line_numbers() %} -- Defining and setting a variable from Macro
 
select
orderid,
{% for linenumber in linenos %} -- Using the variable for looping
 
sum(case when lineno = {{linenumber}} then Linesalesamount end) as lineno{{linenumber}}_sales,
 
{% endfor %}
 
/*sum(case when lineno = 1 then Linesalesamount end) as lineno1_sales,
sum(case when lineno = 2 then Linesalesamount end) as lineno2_sales,
sum(case when lineno = 3 then Linesalesamount end) as lineno3_sales,
*/
 
sum(Linesalesamount) as total_sales,
avg(margin) as avg_margin
from
{{ref('fct_orders')}}
group by 1