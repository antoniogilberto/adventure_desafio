with
    sources as (
        select 
          customerid
          , personid
          , storeid
          , territoryid
          , rowguid
          , modifieddate
        from {{ source('dev_gilberto', 'customer') }} 
    )

select *
from sources