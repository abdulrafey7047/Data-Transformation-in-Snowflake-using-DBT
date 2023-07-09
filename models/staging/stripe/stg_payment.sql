WITH payment AS (

    SELECT
        id AS payment_id,
        orderid AS order_id,
        paymentmethod AS payment_method,
        status,
        -- amount is stored in cents, convert it to dollars
        {{ cents_to_dollars('amount', 4) }} as amount,
        created as created_at
    FROM
        {{ source("stripe", "payment") }}
)

SELECT * FROM payment
