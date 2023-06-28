{{ config(
    materialized = 'incremental',
    unique_key = 'order_id'
) }}


WITH orders_incremental AS (
    SELECT
        id AS order_id,
        user_id AS customer_id,
        order_date,
        status
    FROM
        {{ source("jaffle_shop", "orders") }}
    {% if is_incremental() %}
    WHERE
        -- We are allowing records to be ingested that are upto 3 days old,
        -- duplicates wont be generated because we have specified unique key in the config
        order_date >= SELECT DATEADD(DAY, -3, MAX(order_date)) FROM {{ this }}
    {% endif %}
)

SELECT * FROM orders
