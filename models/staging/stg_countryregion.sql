with
    sources as (
        select 
          countryregioncode
          , name as countryname
          , modifieddate
        from {{ source('dev_gilberto', 'countryregion') }} 
    )

select *
from sources
