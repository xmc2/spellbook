{{ config(
        schema = 'tokens_polygon',
        alias = 'balances_daily_agg_base',
        file_format = 'delta',
        materialized='incremental',
        incremental_strategy='merge',
        incremental_predicates = [incremental_predicate('DBT_INTERNAL_DEST.block_time')],
        unique_key = ['block_number', 'unique_key'],
        )
}}

with balances_raw as (
{{balances_fix_schema(source('tokens_polygon', 'balances_polygon'), 'polygon')}}
)

{{
    balances_daily_agg(
        balances_raw = 'balances_raw'
    )
}}
