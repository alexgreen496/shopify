{%- set category_titles = ['Inventory management', 'Orders and shipping', 'Marketing', 'Places to sell', 'Finances', 'Productivity', 'Store design', 'Trust and security', 'Reporting',
'Sales and conversion optimization', 'Finding and adding products', 'Customer support' ] -%}

with apps as (

    select *

    from {{ ref('stg_apps') }}

),

categories as (

    select
    category_id,

    -- pivot category_title to maintain uniqueness of app_id (apps are in multiple categories).

    {% for category_title in category_titles -%}

        case when category_title = '{{ category_title }}' then 1 else 0 end
        as {{ dbt_utils.slugify(category_title) }}

        {%- if not loop.last -%}
         ,
        {% endif -%}

        {%- endfor %}

    from {{ ref('stg_categories') }}

),

apps_categories as (

    select *

    from {{ ref('stg_apps_categories') }}
    left join categories using (category_id)

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

    -- to use select * with exceptions here, would need to materialise cte's as database objects 
    -- or rename app_id columns outside of apps model.

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
    key_benefits.key_benefit_title,
    key_benefits.key_benefit_description,
    pricing_plan_features.pricing_plan_id, 
    pricing_plan_features.pricing_plan_feature,
    pricing_plans.pricing_plan_title,
    pricing_plans.price,

    -- making category_titles snake-case.

    {% for category_title in category_titles -%}

        {{ dbt_utils.slugify(category_title) }}

        {%- if not loop.last -%}
         ,
        {% endif -%}

        {%- endfor %}
    
    from apps
    left join apps_categories using (app_id)
    left join key_benefits using (app_id)
    left join pricing_plan_features using (app_id)
    left join pricing_plans using (pricing_plan_id)

)

select * from final