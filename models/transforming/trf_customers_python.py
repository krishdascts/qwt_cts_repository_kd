def model(dbt,session):
    trf_customers_df=dbt.ref("stg_customers")
    return trf_customers_df