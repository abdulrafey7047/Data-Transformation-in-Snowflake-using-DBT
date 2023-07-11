{% macro get_distinct_payment_methods(payment_method_column) -%}

     {%- if execute -%}
          {{ log('Getting distinct payment methods', info=True) }}
          {%- call statement('results', fetch_result=true, auto_begin=true) -%}
               SELECT DISTINCT {{ payment_method_column }} FROM {{ ref('stg_payment') }}
          {%- endcall -%}
          {%- set results_data = load_result('results')['data'] -%}
          {{ log('Distinct payment methods retrieved', info=True) }}
          {%- for i in results_data -%}
            {{ i[0] }}
            {%- if not loop.last -%}
              ,
            {%- endif -%}
          {%- endfor -%}
     {%- endif -%}

{%- endmacro %}