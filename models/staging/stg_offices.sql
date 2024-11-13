{{ config(materialized = 'table', schema = env_var('DBT_STAGESCHEMA', 'STAGING')) }}
 
select
    Office as OfficeID,
    OfficeAddress as Address,
    OfficePostalCode as PostalCode,
    OfficeCity as City,
    OfficeStateProvince as StateProvince,
    OfficePhone as Phone,
    OfficeFax as Fax,
    OfficeCountry as Country
from
{{source('qwt_raw', 'offices')}}