{{
  config(
    schema = 'lending',
    alias = 'base_borrow',
    partition_by = ['blockchain', 'project', 'block_month'],
    materialized = 'incremental',
    file_format = 'delta',
    incremental_strategy = 'merge',
    unique_key = ['blockchain', 'project', 'version', 'transaction_type', 'token_address', 'tx_hash', 'evt_index'],
  )
}}

{%
  set models = [
    ref('lending_arbitrum_base_borrow'),
    ref('lending_base_base_borrow'),
    ref('lending_bnb_base_borrow'),
    ref('lending_celo_base_borrow'),
    ref('lending_ethereum_base_borrow'),
    ref('lending_optimism_base_borrow'),
    ref('lending_polygon_base_borrow'),
    ref('lending_avalanche_c_base_borrow'),
    ref('lending_fantom_base_borrow')
  ]
%}

{% for model in models %}
select
  blockchain,
  project,
  version,
  transaction_type,
  loan_type,
  token_address,
  borrower,
  repayer,
  liquidator,
  amount,
  block_month,
  block_time,
  block_number,
  tx_hash,
  evt_index
from {{ model }}
{% if not loop.last %}
union all
{% endif %}
{% endfor %}
