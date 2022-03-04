with key_benefits as (

    select
        app_id, 
        title as key_benefit_title,
        description as key_benefit_description
    from {{ source('shopify', 'key_benefits') }}

)

select * from key_benefits