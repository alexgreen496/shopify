with apps as (

    select
    {{ dbt_utils.star(from=ref('dim_apps'), except=["category_id", "pricing_plan_id"]) }}

    from {{ ref('dim_apps') }}

),

reviews as (

    select *

    from {{ ref('fct_reviews') }}

),

authors as (

    select *

    from {{ ref('dim_authors') }}

),

dates as (

    select *

    from {{ ref('dim_dates') }}

),

final as (

    select
        day_of_week as posted_at_day_of_week,
        day_of_week_name as posted_at_day_of_week_name,
        day_of_month as posted_at_day_of_month,
        month_of_year as posted_at_month_of_year,
        month_name as posted_at_month_name,
        year_number as posted_at_year_number

    from apps
    inner join reviews using (app_id)
    left join authors on reviews.author = authors.author_key
    left join dates on reviews.posted_at = dates.date_key

)

select * from final