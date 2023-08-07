with dim_customer as (
    select
        customer_sk
        , customerid
    from {{ ref('dim_customer')}}
)

, dim_location as(
    select
        shiptoaddress_sk
        , shiptoaddressid
    from {{ ref('dim_location')}}        
)

, dim_creditcard as(
    select
        creditcard_sk
        , creditcardid
    from {{ ref('dim_creditcard')}}        
)


, dim_salesorderheaderdetail as (
    select 
        salesorderid
        , count(distinct salesorderdetailid) as items
    from {{ ref('dim_salesorderheaderdetail')}}
    group by salesorderid
)

, stg_salesorderheader as (
    select 
        salesorderid
        , orderdate 
        , shipdate 
        , case
            when orderstatus = 1 then 'In_process'
            when orderstatus = 2 then 'Approved'
            when orderstatus = 3 then 'Backordered' 
            when orderstatus = 4 then 'Rejected' 
            when orderstatus = 5 then 'Shipped'
            when orderstatus = 6 then 'Cancelled' 
            else 'No status'
        end as orderstatus
        , customerid 
        , salespersonid 
        , billtoaddressid 
        , shiptoaddressid
        , shipmethodid 
        , creditcardid
        , subtotal 
        , taxamt
        , freight 
        , totaldue 
    from {{  ref('stg_salesorderheader')  }}
)

, fct_salesorderheader as (
    select 
        {{ dbt_utils.generate_surrogate_key (
            ['stg_salesorderheader.salesorderid']
        ) }} as salesorderheader_sk 
        , dim_customer.customerid as customer_fk
        , dim_location.shiptoaddressid as shiptoaddress_fk
        , dim_creditcard.creditcardid as creditcard_fk
        , dim_salesorderheaderdetail.salesorderid as salesorder_fk
        , stg_salesorderheader.salesorderid 
        , stg_salesorderheader.orderdate 
        , stg_salesorderheader.shipdate 
        , stg_salesorderheader.orderstatus
        , stg_salesorderheader.customerid 
        , stg_salesorderheader.salespersonid 
        , stg_salesorderheader.billtoaddressid 
        , stg_salesorderheader.shiptoaddressid
        , stg_salesorderheader.shipmethodid 
        , stg_salesorderheader.creditcardid
        , stg_salesorderheader.subtotal 
        , stg_salesorderheader.taxamt
        , stg_salesorderheader.freight 
        , stg_salesorderheader.totaldue 
    from stg_salesorderheader
    left join dim_location on stg_salesorderheader.shiptoaddressid = dim_location.shiptoaddressid
    left join dim_customer on stg_salesorderheader.customerid = dim_customer.customerid
    left join dim_creditcard on stg_salesorderheader.creditcardid = dim_creditcard.creditcardid
    left join dim_salesorderheaderdetail on stg_salesorderheader.salesorderid = dim_salesorderheaderdetail.salesorderid
)

select *
from fct_salesorderheader