with pricing_plan_features as (

    select
        app_id, 
        pricing_plan_id, 
        feature as pricing_plan_feature
    from {{ source('shopify', 'pricing_plan_features') }}

)

select * from pricing_plan_features