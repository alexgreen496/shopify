with reviews as (

    select *

    from {{ ref('fct_reviews') }}

),

apps as (

    -- select * except for category_id and pricing_plan_id (not needed).

    select
    {{ dbt_utils.star(from=ref('dim_apps'), except=["category_id", "pricing_plan_id"]) }}

    from {{ ref('dim_apps') }}

),

authors as (

    select *

    from {{ ref('dim_authors') }}

),

dates as (
    
    -- select * with prefix "posted_at_" as we will be joing these columns on fct_reviews.posted_at.

    select
    {{ star_with_prefix(from=ref("dim_dates"), prefix="posted_at_", except=[]) }}

    from {{ ref('dim_dates') }}

),

final as (

    select *
    
    from reviews
    left join apps using (app_id)
    left join authors on reviews.author = authors.author_key
    left join dates on reviews.posted_at = dates.posted_at_date_key

)

select * from final