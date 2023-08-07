with salesorderheadersalesreason as (
    select 
        salesorderid
        , salesreasonid
    from {{ ref('stg_salesorderheadersalesreason') }}
)

, salesreason as (
    select 
        salesreasonid
        , reasonname
        , reasontype
    from {{ ref('stg_salesreason') }}
)

, salesreason_join as (
    select
        salesorderheadersalesreason.salesreasonid
        , salesorderheadersalesreason.salesorderid
        , salesreason.reasonname
        , salesreason.reasontype
    from salesorderheadersalesreason
    left join salesreason on salesorderheadersalesreason.salesreasonid = salesreason.salesreasonid 
)

select *
from salesreason_join