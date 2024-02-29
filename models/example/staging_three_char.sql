-- This is your dbt model file

{{ config(materialized='incremental') }}
{{ config(tags=["stagingmodels"]) }}
{{ config(tags=["all3char_model"]) }}

WITH staggingthreechar AS (
    SELECT 
        AllCountry.id,
        CONCAT(AllCountry.countryname, AllCountry.effectivedate, ThreeCharCountry.code_3) as uniquecode,
        AllCountry.countryname,
        ThreeCharCountry.code_3,
        AllCountry.effectivedate,
        AllCountry.expireddate,
        AllCountry.updateddate,
        CURRENT_TIMESTAMP as lastrefresh_date
    FROM 
        AllCountry
    INNER JOIN 
        ThreeCharCountry 
    ON 
        AllCountry.id = ThreeCharCountry.id
    {% if is_incremental() %}
    WHERE 
        AllCountry.updateddate > (SELECT MAX(lastrefresh_date) FROM {{ this }})
    {% endif %}
)

SELECT *
FROM staggingthreechar
