with
    sources as (
        select 
          salesorderid
          , revisionnumber
          , orderdate
          , duedate
          , shipdate
          , status as orderstatus
          , onlineorderflag
          , purchaseordernumber
          , accountnumber
          , customerid
          , salespersonid
          , territoryid
          , billtoaddressid
          , shiptoaddressid
          , shipmethodid
          , creditcardid
          , creditcardapprovalcode
          , currencyrateid
          , subtotal
          , taxamt
          , freight
          , totaldue
          , comment
          , rowguid
          , modifieddate 
        from {{ source('dev_gilberto', 'salesorderheader') }} 
    )

select *
from sources