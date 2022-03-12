with apps as (

    select *

    from {{ ref('stg_apps') }}

),

apps_categories as (

    select *

    from {{ ref('stg_apps_categories') }}

),

categories as (

    select *

    from {{ ref('stg_categories') }}

),

key_benefits as (

    select *

    from {{ ref('stg_key_benefits') }}

),

pricing_plan_features as (

    select *

    from {{ ref('stg_pricing_plan_features') }}

),


pricing_plans as (

    select *

    from {{ ref('stg_pricing_plans') }}

),

final as (

    select
    apps.app_id,
    apps.app_url, 
    apps.app_title, 
    apps.developer, 
    apps.developer_link, 
    apps.icon, 
    apps.average_rating, 
    apps.reviews_count, 
    apps.app_description, 
    apps.tagline, 
    apps.pricing_hint,
    apps_categories.category_id,
    categories.category_title,
    key_benefits.key_benefit_title,
    key_benefits.key_benefit_description,
    pricing_plan_features.pricing_plan_id, 
    pricing_plan_features.pricing_plan_feature,
    pricing_plans.pricing_plan_title,
    pricing_plans.price

    from apps
    left join apps_categories using (app_id)
    left join categories using (category_id)
    left join key_benefits using (app_id)
    left join pricing_plan_features using (app_id)
    left join pricing_plans using (pricing_plan_id)

)

select * from final