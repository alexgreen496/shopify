with pricing_plans as (

    select
        id as pricing_plan_id,
        app_id, 
        title as pricing_plan_title,
        price

    from {{ source('shopify', 'pricing_plans') }}
    
)

select * from pricing_plans