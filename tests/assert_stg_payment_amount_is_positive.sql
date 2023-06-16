WITH

payments AS (
    SELECT * FROM {{ ref("stg_payment") }}
)

SELECT
    orderid,
    sum(amount) AS total_amount
FROM
    payments
GROUP BY
    orderid
HAVING
    total_amount < 0