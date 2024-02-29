

{% macro macrodemo_two(AllCountry)%}



SELECT {{AllCountry}}.id,
{{AllCountry}}.countryname
from 
{{AllCountry}}

{% endmacro %}