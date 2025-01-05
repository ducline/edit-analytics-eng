{% macro calculate_response_rate(responses, total_offers) %}
ROUND({{ responses }} * 100.0 / {{ total_offers }}, 2)
{% endmacro %}
