WITH

customers AS (
    SELECT * FROM {{ ref("stg_customer") }}
),

orders AS (
    SELECT * FROM {{ ref("stg_order") }}
),

custom_oders AS (

    SELECT
        customer_id,
        min(order_date) AS first_order_date,
        max(order_date) AS most_recent_order_date,
        count(order_id) AS number_of_orders
    FROM
        orders
    GROUP BY
        1
),

final AS (

    SELECT
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        custom_oders.first_order_date,
        custom_oders.most_recent_order_date,
        coalesce(custom_oders.number_of_orders, 0) AS number_of_orders
    FROM
        customers
    LEFT JOIN custom_oders USING (customer_id)
)

SELECT * FROM final

