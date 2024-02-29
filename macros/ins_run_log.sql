{% macro ins_run_log(results) %}
    {%- if execute -%}
        {%- set parsed_results = parse_run_log(results) -%}
        {%- if parsed_results | length  > 0 -%}
            {%- set run_type =parsed_results[0].get('resource_type') -%}
            {%- if run_type =='test' -%}
                {%- set log_loc= var('log_loc2') -%}
            {%- else -%}
                {%- set log_loc= var('log_loc1') -%}
            {%- endif -%}
        {%- endif -%}
        {%- if parsed_results | length  > 0 -%}
            {% set insert_dbt_results_query -%}
                insert into  {{log_loc}}
                    (
                        result_id,
                        database_name,
                        schema_name,
                        name,
                        resource_type,
                        status,
                        execution_time,
                        start_date
                ) values
                    {%- for parsed_result_dict in parsed_results -%}
                            {%- set table_name = parsed_result_dict.get('name') -%}
                            {%- set start_dt = parsed_result_dict.get('start_date') -%}
                            (
                                '{{ parsed_result_dict.get('result_id') }}',
                                '{{ parsed_result_dict.get('database_name') }}',
                                '{{ parsed_result_dict.get('schema_name') }}',
                                '{{ parsed_result_dict.get('name') }}',
                                '{{ parsed_result_dict.get('resource_type') }}',
                                '{{ parsed_result_dict.get('status') }}',
                                '{{ parsed_result_dict.get('execution_time') }}',
                                 current_timestamp
                            ) {{- "," if not loop.last else "" -}}
                    {%- endfor -%}
            {%- endset -%}
                {%- do run_query(insert_dbt_results_query) -%}
        {%- endif -%}
    {%- endif -%}
{% endmacro %}
