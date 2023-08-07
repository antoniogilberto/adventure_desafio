with dim_salesorderheaderdetail as (
    select 
        {{ dbt_utils.generate_surrogate_key (
            ['int_salesorderdetail.salesorderid']
        ) }} as salesorder_sk    
        , {{ dbt_utils.generate_surrogate_key (
            ['int_salesorderdetail.salesorderdetailid']
        ) }} as salesorderdetail_sk    
        , salesorderid 
        , salesorderdetailid 
    from {{ ref('int_salesorderdetail') }}
)

select *
from dim_salesorderheaderdetail