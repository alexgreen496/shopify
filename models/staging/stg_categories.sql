with categories as (
    
    select
        id as category_id,
        title as category_title

    from {{ source('shopify', 'categories') }}
    
)

select * from categories