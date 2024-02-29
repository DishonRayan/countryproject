
{% macro parse_run_log(results) %}
    {%- set parsed_results = [] %}

    {% for run_result in results %}
        {% set run_result_dict = run_result.to_dict() %}
        {% set timing = run_result_dict.get('timing', []) %}
        {% if timing and timing | length > 0 %}
            {% set start_dt = timing[0].get('started_at') %}
        {% else %}
            {% set start_dt = None %}
        {% endif %}
        {% set node = run_result_dict.get('node') %}
        {% set parsed_result_dict = {
                'result_id': invocation_id ~ '.' ~ node.get('unique_id'),
                'database_name': node.get('database'),
                'schema_name': node.get('schema'),
                'name': node.get('name'),
                'resource_type': node.get('resource_type'),
                'status': run_result_dict.get('status'),
                'execution_time': run_result_dict.get('execution_time'),
                'start_date': start_dt
                }%}
        {% do parsed_results.append(parsed_result_dict) %}
    {% endfor %}
    {{ return(parsed_results) }}
{% endmacro %}