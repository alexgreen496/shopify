with apps as (
    
    select
        app_id, 
        url as app_url,
        title as app_title,
        developer,
        developer_link, 
        icon, 
        rating as average_rating, 
        reviews_count, 
        description_raw as app_description_raw,
        description as app_description,
        tagline, 
        pricing_hint
   
    from {{ source('shopify', 'apps') }}
    
)

select * from apps

