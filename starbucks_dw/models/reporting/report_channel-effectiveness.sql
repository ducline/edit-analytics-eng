WITH channel_analysis AS (
    SELECT
        communication_channel,
        COUNT(CASE WHEN responded = TRUE THEN 1 END) AS total_responses,
        COUNT(*) AS total_offers
    FROM {{ ref('fct_offer_transactions') }}
    GROUP BY communication_channel
)
SELECT
    communication_channel,
    SUM(total_responses) AS total_responses,
    SUM(total_offers) AS total_offers,
    {{ calculate_response_rate('SUM(total_responses)', 'SUM(total_offers)') }} AS response_rate
FROM channel_analysis
ORDER BY response_rate DESC;
