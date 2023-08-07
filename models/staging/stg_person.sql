with
    sources as (
        select 
          businessentityid
          , persontype
          , namestyle
          , title
          , firstname
          , middlename
          , lastname
          , suffix
          , emailpromotion
          , additionalcontactinfo
          , demographics
          , rowguid
          , modifieddate
        from {{ source('dev_gilberto', 'person') }} 
    )

select *
from sources