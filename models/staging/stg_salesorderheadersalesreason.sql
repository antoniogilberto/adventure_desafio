with
    sources as (
        select 
          salesorderid
          , salesreasonid 
          , modifieddate
        from {{ source('dev_gilberto', 'salesorderheadersalesreason') }} 
    )

select *
from sources