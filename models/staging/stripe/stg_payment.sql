WITH payment AS (

    SELECT
        id AS payment_id,
        orderid,
        paymentmethod,
        status,
        amount,
        created
    FROM
        {{ source("stripe", "payment") }}
)


SELECT * FROM payment
