with  reviews as (

    select *

    from {{ ref('fct_reviews') }}

),

dates as (
    
    select
    {{ star_with_prefix(from=ref("dim_dates"), prefix="posted_at_", except=[]) }}

    from {{ ref('dim_dates') }}

),

final as (

    select distinct
    dates.posted_at_month_number,
    dates.posted_at_month_name,
    dates.posted_at_year_number,
    dates.posted_at_month_year,
    avg(review_rating) over (order by posted_at_month_year) as moving_average_month
    
    from reviews
    inner join dates on reviews.posted_at = dates.posted_at_date_key
    order by posted_at_year_number, posted_at_month_number

)

select * from final