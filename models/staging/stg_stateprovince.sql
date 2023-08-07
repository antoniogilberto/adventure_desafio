with
    sources as (
        select 
          stateprovinceid
          , stateprovincecode
          , countryregioncode
          , isonlystateprovinceflag
          , name as statename
          , territoryid
          , rowguid
          , modifieddate
        from {{ source('dev_gilberto', 'stateprovince') }} 
    )

select *
from sources