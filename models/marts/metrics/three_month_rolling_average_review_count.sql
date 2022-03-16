with  reviews as (

    select *

    from {{ ref('fct_reviews') }}

),

dates as (
    
    -- select * with prefix "posted_at_" as we will be joing these columns on fct_reviews.posted_at.

    select
    {{ star_with_prefix(from=ref("dim_dates"), prefix="posted_at_", except=[]) }}

    from {{ ref('dim_dates') }}

),

intermediary as (

    select
    dates.posted_at_month_number,
    dates.posted_at_month_name,
    dates.posted_at_year_number,
    dates.posted_at_month_year,
    count(review_rating) as monthly_total_reviews

    from reviews
    inner join dates on reviews.posted_at = dates.posted_at_date_key
    {{ dbt_utils.group_by(n=4) }}
    order by posted_at_year_number, posted_at_month_number

),

final as (

    select distinct
    posted_at_month_number,
    posted_at_month_name,
    posted_at_year_number,
    posted_at_month_year,
    monthly_total_reviews,

    -- take the rolling average of review counts over a 3 month period rounded to 2 decimal places.

    {{ round_to_2_decimal_places('avg(monthly_total_reviews) over 
    (order by posted_at_year_number, posted_at_month_number 
    rows between 2 preceding and current row)') }} as three_month_rolling_average_review_count
    
    from intermediary
    order by posted_at_year_number, posted_at_month_number
    
)

select * from final