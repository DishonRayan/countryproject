{{ config(materialized='table') }}

with macro_two as (
    {{macrodemo_two('AllCountry')}}
)

select *from macro_two


