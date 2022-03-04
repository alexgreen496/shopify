with apps as (

    select *

    from {{ ref('dim_apps') }}

),

reviews as (

    select *

    from {{ ref('fct_reviews') }}

),

wide_table as (

    select * 

    from apps

    join reviews using (app_id)
)

select *
from wide_table