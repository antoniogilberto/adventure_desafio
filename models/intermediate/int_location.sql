with address as (
    select 
        addressid
        , addressline1
        , addressline2
        , city
        , stateprovinceid
        , postalcode
    from {{ ref('stg_address') }}
)

, stateprovince as (
    select 
        stateprovinceid
        , stateprovincecode
        , countryregioncode
        , statename
        , territoryid
    from {{ ref('stg_stateprovince') }}
)

, countryregion as (
    select 
        countryregioncode
        , countryname
    from {{ ref('stg_countryregion') }}
)

, location_join as (
    select
        address.addressid 
	    , address.addressline1
	    , address.addressline2 
	    , address.city 
	    , address.stateprovinceid 
	    , address.postalcode 
	    , stateprovince.stateprovincecode 
	    , stateprovince.countryregioncode 
	    , stateprovince.statename
	    , stateprovince.territoryid
	    , countryregion.countryname
    from address
    left join stateprovince on address.stateprovinceid = stateprovince.stateprovinceid
    left join countryregion on stateprovince.countryregioncode = countryregion.countryregioncode
)

select *
from location_join