with authors as (

        select 
        author as author_key,
        min(review_rating) as min_review,
        max(review_rating) as max_review,
        avg(review_rating) as avg_review,
        count(app_id) as total_apps_reviewed
        
        from {{ ref('stg_reviews') }}

        group by author

)

select * from authors