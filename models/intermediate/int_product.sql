with product as (
    select 
	    productid 
        , productsubcategoryid
	    , productname
	    , productnumber 
	    , color 
	    , standardcost 
	    , listprice
    from {{ ref('stg_product') }}
)

, productsubcategory as (
    select 
        productsubcategoryid
        , productcategoryid
        , subcategoryname
    from {{ ref('stg_productsubcategory') }}
)

, productcategory as (
    select 
        productcategoryid
        , categoryname
    from {{ ref('stg_productcategory') }}
)

, product_join as (
    select
	    product.productid 
	    , product.productname
	    , product.productnumber 
	    , product.color 
	    , product.standardcost 
	    , product.listprice 
	    , productsubcategory.subcategoryname
	    , productcategory.categoryname
    from product
    left join productsubcategory on product.productsubcategoryid = productsubcategory.productsubcategoryid
    left join productcategory on productcategory.productcategoryid = productsubcategory.productcategoryid
)

select *
from product_join