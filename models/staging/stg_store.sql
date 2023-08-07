with
    sources as (
        select 
          businessentityid
          , name as storename
          , salespersonid
        from {{ source('dev_gilberto', 'store') }} 
    )

select *
from sources