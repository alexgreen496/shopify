with reviews as (

    select
        app_id, 
        author, 
        rating as review_rating,
        posted_at, 
        body, 
        helpful_count, 
        developer_reply, 
        developer_reply_posted_at

    from {{ source('shopify', 'reviews') }}
    
)

select * from reviews