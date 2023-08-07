with
    sources as (
        select 
          creditcardid
          , cardtype
          , cardnumber
          , expmonth
          , expyear
        from {{ source('dev_gilberto', 'creditcard') }} 
    )

select *
from sources