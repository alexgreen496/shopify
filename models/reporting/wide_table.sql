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
    
    select
    {{ star_with_prefix(from=ref("dim_dates"), prefix="posted_at_", except=[]) }}

    from {{ ref('dim_dates') }}

),

final as (

    select *
    
    from apps
    inner join reviews using (app_id)
    left join authors on reviews.author = authors.author_key
    left join dates on reviews.posted_at = dates.posted_at_date_key

)

select * from final