with apps as (

    select *

    from {{ ref('stg_apps') }}


)

select *
from apps