{{ config(materialized='table') }}


{{ config(tags=["pubmodels"]) }}
{{ config(tags=["all3char_model"]) }}

with pubthreechar as (
 select *
from {{ ref('staging_three_char') }}
)


select *from pubthreechar
    