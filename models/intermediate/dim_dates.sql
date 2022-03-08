with date_spine as (

    {{ dbt_date.get_date_dimension('2009-01-01', '2020-01-01') }}

),

dates as (
        
        select 
        date_day as date_key,
        day_of_week,
        day_of_week_name,
        day_of_month,
        month_of_year,
        month_name,
        year_number

        from date_spine

)

select * from dates