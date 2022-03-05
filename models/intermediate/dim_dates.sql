with date_spine as (

    {{ dbt_date.get_date_dimension('2009-01-01', '2020-01-01') }}
    
)

select * from date_spine
