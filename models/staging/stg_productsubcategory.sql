with
    sources as (
        select 
            productsubcategoryid
            , productcategoryid
            , name as subcategoryname
        from {{ source('dev_gilberto', 'productsubcategory') }} 
    )

select *
from sources