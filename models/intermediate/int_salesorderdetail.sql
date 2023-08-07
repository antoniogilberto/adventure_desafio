with salesorderdetail as (
    select 
        salesorderid 
        , salesorderdetailid 
        , orderqty 
        , productid 
        , unitprice 
        , unitpricediscount 
        , (orderqty * unitprice) as grossrevenue
        , (orderqty * unitprice * unitpricediscount) as discount
    from {{ ref('stg_salesorderdetail') }}
)

, salesorderdetail_join as (
    select
        salesorderdetail.salesorderid 
        , salesorderdetail.salesorderdetailid 
        , salesorderdetail.orderqty 
        , salesorderdetail.productid 
        , salesorderdetail.unitprice 
        , salesorderdetail.unitpricediscount 
        , salesorderdetail.grossrevenue
        , salesorderdetail.discount 
    from salesorderdetail
)

select *
from salesorderdetail_join