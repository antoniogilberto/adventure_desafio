with dim_product as (
    select
        product_sk
        , productid
    from {{ ref('dim_product')}}
)

, dim_salesorderheaderdetail as (
    select *
    from {{ ref('dim_salesorderheaderdetail')}}
)

, int_salesorderdetail as (
    select  
        salesorderdetailid
        , orderqty
        , productid
        , unitprice
        , unitpricediscount
        , grossrevenue
        , discount
    from {{ ref('int_salesorderdetail') }}
)

, fct_salesorderdetail as (
    select
        {{ dbt_utils.generate_surrogate_key (
            ['dim_salesorderheaderdetail.salesorderdetailid'
            , 'int_salesorderdetail.salesorderdetailid']
        ) }} as salesorderdetail_sk        
        , dim_product.productid as product_fk
        , dim_salesorderheaderdetail.salesorderdetailid as salesorderdetail_fk
        , int_salesorderdetail.productid
        , int_salesorderdetail.salesorderdetailid
        , int_salesorderdetail.orderqty
        , int_salesorderdetail.unitprice
        , int_salesorderdetail.unitpricediscount
        , int_salesorderdetail.grossrevenue
        , int_salesorderdetail.discount
    from int_salesorderdetail
    left join dim_product on int_salesorderdetail.productid = dim_product.productid
    left join dim_salesorderheaderdetail on int_salesorderdetail.salesorderdetailid = dim_salesorderheaderdetail.salesorderdetailid
)

select *
from fct_salesorderdetail