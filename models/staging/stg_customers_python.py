def model(dbt,session):
    dbt.config(materialized='table',schema='staging')
    stg_customers_df=dbt.source("qwt_raw","customer")
    return stg_customers_df