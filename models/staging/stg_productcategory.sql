with
    sources as (
        select 
            productcategoryid
          , name as categoryname
        from {{ source('dev_gilberto', 'productcategory') }} 
    )

select *
from sources