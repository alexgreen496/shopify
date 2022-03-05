with apps as (

    select
    {{ dbt_utils.star(from=ref('dim_apps'), except=["category_id", "pricing_plan_id"]) }}

    from {{ ref('dim_apps') }}

),

reviews as (

    select *

    from {{ ref('fct_reviews') }}

),

dates as (

    select *

    from {{ ref('dim_dates') }}

),

final as (

    select * 

    from apps
    inner join reviews using (app_id)
    left join dates on reviews. posted_at = dates.date_day

)

select * from final