{%- set review_ratings = ['1', '2', '3', '4', '5'] -%}

with reviews as (

    select *

    from {{ ref('fct_reviews') }}

),

apps as (

    select *

    from {{ ref('dim_apps') }}

),

joined as (
   select
   app_id,
   review_rating,
   apps.category_title
   from reviews
   left join apps using (app_id)
),

final as (

    select
    category_title,
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