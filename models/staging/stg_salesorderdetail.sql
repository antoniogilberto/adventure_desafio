with
    sources as (
        select 
          salesorderid
          , salesorderdetailid
          , carriertrackingnumber
          , orderqty
          , productid
          , specialofferid
          , unitprice
          , unitpricediscount
          , rowguid
          , modifieddate
        from {{ source('dev_gilberto', 'salesorderdetail') }} 
    )

select *
from sources