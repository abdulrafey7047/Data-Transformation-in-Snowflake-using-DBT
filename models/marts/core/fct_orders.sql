WITH 

orders AS (
    SELECT * FROM {{ ref("stg_order") }}
),

payments AS (
    SELECT * FROM {{ ref("stg_payment") }}
),

fct_orders AS (

    SELECT
        order_id,
        payment_id,
        amount
    FROM
        orders
    LEFT JOIN payments on orders.order_id = payments.orderid
)

SELECT * FROM fct_orders
