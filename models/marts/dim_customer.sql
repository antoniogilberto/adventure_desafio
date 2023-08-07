with stg_salesorderheader as(
    select
        distinct(customerid)
    from {{ ref('stg_salesorderheader')}}
)

, int_customer as (
    select
        customerid 
        , personid 
        , storeid 
        , territoryid 
        , businessentityid 
        , customerfullname
        , storename
        , salespersonid
    from {{ ref('int_customer') }}    
)

, dim_customer as (
    select
        {{ dbt_utils.generate_surrogate_key (
            ['stg_salesorderheader.customerid'
            , 'int_customer.customerid']
        ) }} as customer_sk
        , int_customer.customerid
        , int_customer.customerfullname
    from stg_salesorderheader
    left join int_customer on stg_salesorderheader.customerid = int_customer.customerid
)

select *
from dim_customer