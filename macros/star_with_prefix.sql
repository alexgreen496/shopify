{% macro star_with_prefix(from, prefix, except=[]) -%}

    {%- do dbt_utils._is_relation(from, 'star') -%}
    {%- do dbt_utils._is_ephemeral(from, 'star') -%}

    -- Prevent querying of db in parsing mode. This works because this macro does not create any new refs.
    {%- if not execute -%}
        {{ return('') }}
    {% endif %}

    -- Get the columns we want to prefix
    {%- set include_cols = [] -%}
    {%- set cols = adapter.get_columns_in_relation(from) -%}

    {%- for col in cols -%}

        {%- if col.column not in except -%}
            {% do include_cols.append(col.column) %}

        {%- endif %}
    {%- endfor %}

    -- Select the columns in the list of exceptions normally
    {% for col in except -%}

        {{ adapter.quote(col)|trim }},{{ '\n  ' }}

    {%- endfor -%}

    -- Select all other columns and give them the prefix
    {% for col in include_cols -%}

        {{ adapter.quote(col)|trim }} as {{ prefix + col }}
        {%- if not loop.last %},{{ '\n  ' }}{% endif %}

    {%- endfor -%}

{%- endmacro %}