with
    sources as (
        select 
          cast (addressid as int) as addressid
          , addressline1
          , addressline2
          , city
          , stateprovinceid
          , postalcode
          , spatiallocation
          , rowguid
          , modifieddate
        from {{ source('dev_gilberto', 'address') }} 
    )

select *
from sources
