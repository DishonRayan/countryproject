{{ config(materialized='table') }}


{{ config(tags=["pubmodels"]) }}
{{ config(tags=["all2char_model"]) }}

with pubtwochar as(
 select *
from {{ ref('staging_two_char') }}
)


select *from pubtwochar