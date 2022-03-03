with reviews as (

    select
        app_id
    from {{ source('shopify', 'reviews') }}

)

select * from reviews