{%- set review_ratings = ['1', '2', '3', '4', '5'] -%}

with reviews as (

    select *

    from {{ ref('fct_reviews') }}

),

int_categories as (

    select *

    from {{ ref('int_categories') }}

),

apps as (

    select *

    from {{ ref('dim_apps') }}
    left join int_categories using (app_id)

),

joined as (
    select 
    app_id,
    review_rating,
    category_title
    from reviews
    left join apps using (app_id)

),

final as (

    select
    category_title,

    -- for each review rating, count the number of the reviews with that rating, pivoted to a column.

    {% for review_rating in review_ratings -%}
    count(case when review_rating = {{ review_rating }} then review_rating else null end) 
    as count_of_rating_{{ review_rating }}
    {%- if not loop.last -%}
    ,
    {% endif %}
    {% endfor -%}
    from joined
    group by category_title 
   
)

select * from final