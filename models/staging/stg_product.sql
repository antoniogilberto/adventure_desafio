with
    sources as (
        select 
          productid
          , name as productname
          , productnumber
          , makeflag
          , finishedgoodsflag
          , color
          , safetystocklevel
          , reorderpoint
          , standardcost
          , listprice
          , size
          , sizeunitmeasurecode
          , weightunitmeasurecode
          , weight as productweight
          , daystomanufacture
          , productline
          , class
          , style
          , productsubcategoryid
          , productmodelid
          , sellstartdate
          , sellenddate
          , discontinueddate
          , rowguid
          , modifieddate
        from {{ source('dev_gilberto', 'product') }} 
    )

select *
from sources