SELECT
    orderid,
    sum(amount) AS total_amount
FROM
    {{ ref("stg_payment") }}
GROUP BY
    orderid
HAVING
    total_amount < 0