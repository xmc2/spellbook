{{
    config(
        tags = ['legacy'],
        schema = 'transfers_celo',
        alias = alias('erc721_rolling_hour', legacy_model=True)
    )
}}

-- DUMMY TABLE, WILL BE REMOVED SOON
select 1
