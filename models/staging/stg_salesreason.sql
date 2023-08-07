with
    sources as (
        select 
          salesreasonid
          , name as reasonname
          , reasontype
          , modifieddate
        from {{ source('dev_gilberto', 'salesreason') }} 
    )

select *
from sources