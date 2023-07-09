{% macro get_distinct_payment_methods(payment_method_column) -%}
{%- call statement('distinct_payment_methods', fetch_result=True) -%}
     SELECT DISTINCT {{ payment_method_column }} FROM {{ ref('stg_payment') }}
{%- endcall -%}
{% set result = load_result('distinct_payment_methods')['data'] %}
         {{result}}
{%- endmacro %}