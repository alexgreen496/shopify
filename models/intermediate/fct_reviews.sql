with reviews as (

    select *

    from {{ ref('stg_reviews') }}


)

select *
from reviews