{% macro round_to_2_decimal_places(column_name, decimal_places=2) %}
    round( {{ column_name }}, {{ decimal_places }})
{%- endmacro %}