with date_spine as (

    -- generate date spine from dates 2009-01-01 to 2020-01-01.

    {{ dbt_date.get_date_dimension('2009-01-01', '2020-01-01') }}

),

dates as (
        
        select 
        date_day as date_key,
        day_of_week,
        day_of_week_name,
        day_of_month,
        date_part('month', date_day) as month_number,
        month_name,
        year_number,
        concat(month_name,' ',date_part('year', date_day)) as month_year

        from date_spine

)

select * from dates