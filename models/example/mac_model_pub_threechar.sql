{{ config(materialized='incremental') }}


{% set sqlq = macro_staging_three_char('pub_3char') %}   ----macro calling
        
    {{sqlq}}

    {% if is_incremental() %}
    WHERE 
        updateddate > (SELECT MAX(lastrefresh_date) FROM {{ this }})
    {% endif %}









