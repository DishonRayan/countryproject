
-- Use the `ref` function to select from other models

{{ config(materialized='incremental') }}
{{ config(tags=["stagingmodels"]) }}
{{ config(tags=["all2char_model"]) }}

WITH staggingtwochar AS (
    
SELECT 
AllCountry.id,
 CONCAT(AllCountry.countryname, AllCountry.effectivedate, TwoCharCountry.code_2) as uniquecode,
    AllCountry.countryname,
    TwoCharCountry.code_2,
    AllCountry.effectivedate,
    AllCountry.expireddate,
    AllCountry.updateddate,
    CURRENT_TIMESTAMP as lastrefresh_date
FROM 
    AllCountry
INNER JOIN 
    TwoCharCountry 
ON 
    AllCountry.id = TwoCharCountry.id
{% if is_incremental() %}
 where AllCountry.updateddate > (select max(lastrefresh_date) from {{ this }})
{% endif %}

)

select *from staggingtwochar
