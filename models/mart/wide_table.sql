with wide_table as (

    select *

    from {{ ref('dim_apps') }}


)

select *
from wide_table