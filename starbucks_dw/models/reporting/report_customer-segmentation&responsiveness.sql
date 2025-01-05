WITH customer_responses AS (
    SELECT
        customer_id,
        demographic_segment,
        behavioral_segment,
        COUNT(CASE WHEN responded = TRUE THEN 1 END) AS total_responses,
        COUNT(*) AS total_offers
    FROM {{ ref('fct_customer_transactions') }}
    GROUP BY customer_id, demographic_segment, behavioral_segment
)
SELECT
    demographic_segment,
    behavioral_segment,
    SUM(total_responses) AS total_responses,
    SUM(total_offers) AS total_offers,
    {{ calculate_response_rate('SUM(total_responses)', 'SUM(total_offers)') }} AS response_rate
FROM customer_responses
GROUP BY demographic_segment, behavioral_segment
ORDER BY response_rate DESC;
