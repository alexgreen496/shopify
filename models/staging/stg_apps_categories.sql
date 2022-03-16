with apps_categories as (

    select
        app_id, 
        category_id 

    from {{ source('shopify', 'apps_categories') }}
)

select * from apps_categories

