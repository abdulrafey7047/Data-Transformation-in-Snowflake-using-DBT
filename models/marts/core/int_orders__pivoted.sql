{% set payment_methods = ['credit_card', 'coupon', 'bank_transfer', 'gift_card'] %}

WITH

payments AS (
   SELECT * FROM {{ ref('stg_payment') }}
),

pivoted AS (
    SELECT
        order_id,
        {#- for payment_method in get_distinct_payment_methods('payment_method') #}
            {{payment_method}}
        {# endfor -#}
        {% for payment_method in payment_methods -%}
        SUM(CASE WHEN payment_method = '{{ payment_method }}' THEN amount ELSE 0 END) AS {{ payment_method }}_amount
        {%- if not loop.last -%}
         ,
        {% endif -%}
        {%- endfor %}
    FROM
        payments
    GROUP BY
        order_id
)

SELECT * FROM pivoted
