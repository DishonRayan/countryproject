--------------------olkd -----------


{% macro macro_staging_three_char(job) %}

   {% set query %}
        SELECT pubsql
        FROM public.jobsql
        where jobid = '{{job}}'
    {% endset %}


{% set result = run_query(query)%}

   {%- if execute and result|length > 0 -%}
        {% set jobsql = result.columns[0][0] %}
    {% endif %}

{{ return(jobsql) }}

{% endmacro %}



