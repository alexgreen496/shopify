with categories as (

    select *

    from {{ ref('stg_categories') }}

),

apps_categories as (

    select *

    from {{ ref('stg_apps_categories') }}

),

final as (

    select *

    from apps_categories
    left join categories using (category_id)
)

select * from final