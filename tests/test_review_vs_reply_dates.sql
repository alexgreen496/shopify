with review_vs_reply_test as (

    select * 

    from {{ ref('stg_reviews') }}

    where posted_at > developer_reply_posted_at

)

select * from review_vs_reply_test