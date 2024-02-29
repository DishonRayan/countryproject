{{ config(materialized='incremental') }}

{% set sqlq = macro_staging_two_char('stg_2char') %}   ----macro calling

    {{sqlq}}

{% if is_incremental() %}
 where updateddate > (select max(lastrefresh_date) from {{ this }})
{% endif %}





