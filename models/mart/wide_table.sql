with apps as (

    select *

    from {{ ref('dim_apps') }}

),

reviews as (

    select *

    from {{ ref('fct_reviews') }}

),

final as (

    select * 

    from apps

    inner join reviews using (app_id)
)

select *
from final