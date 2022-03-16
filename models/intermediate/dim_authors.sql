
with authors as (

        select 
        author as author_key,
        min(review_rating) as min_review,
        max(review_rating) as max_review,
        {{ round_to_2_decimal_places('avg(review_rating) ') }} as avg_review,
        count(app_id) as total_apps_reviewed
      --  case when (count(author) having {{author}} = 1 over
      --  (order by posted_at)) <10 then 1 else null end as new_user
        
        from {{ ref('stg_reviews') }}

        group by author

)

select * from authors