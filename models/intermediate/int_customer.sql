with customer as (
    select 
        customerid 
        , personid 
        , storeid 
        , territoryid 
    from {{ ref('stg_customer') }}
)

, store as (
    select 
        businessentityid 
        , storename
        , salespersonid 
    from {{ ref('stg_store') }}
)

, person as (
    select 
        businessentityid
        , concat(ifnull(firstname,' '),' ',ifnull(middlename,' '),' ',ifnull(lastname,' ')) as fullname
    from {{ ref('stg_person') }}
)

, customer_join as (
    select
        customer.customerid 
        , customer.personid 
        , customer.storeid 
        , customer.territoryid 
        , person.businessentityid 
        , person.fullname
        , store.storename
        , store.salespersonid 
        , case
            when person.fullname is null
            then store.storename
            else person.fullname 
            end as customerfullname
    from customer
    left join person on customer.personid = person.businessentityid
    left join store on customer.storeid = store.businessentityid

)

select *
from customer_join