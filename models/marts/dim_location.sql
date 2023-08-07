with stg_salesorderheader as(
    select
        distinct(shiptoaddressid)
    from {{ ref('stg_salesorderheader')}}
)

, int_location as (
    select
        addressid 
	    , addressline1
	    , addressline2 
	    , city 
	    , stateprovinceid 
	    , postalcode 
	    , stateprovincecode 
	    , countryregioncode 
	    , statename
	    , territoryid
	    , countryname
    from {{ ref('int_location') }}
)

, dim_location as (
    select
        {{ dbt_utils.generate_surrogate_key (
            ['stg_salesorderheader.shiptoaddressid'
            , 'int_location.addressid']
        ) }} as shiptoaddress_sk
		, addressid as shiptoaddressid
	    , int_location.addressline1
	    , int_location.city 
	    , int_location.postalcode 
	    , int_location.statename
	    , int_location.countryname
    from stg_salesorderheader
    left join int_location on stg_salesorderheader.shiptoaddressid = int_location.addressid
)

select *
from dim_location