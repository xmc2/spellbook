{{config(alias='project_wallets',
        post_hook='{{ expose_spells(\'["optimism"]\',
                                    "sector",
                                    "labels",
                                    \'["msilb7"]\') }}'
)}}

SELECT

    array('optimism') as blockchain,
    address,
    project_name AS name,
    'project wallet' AS category,
    'msilb7' AS contributor,
    'static' AS source,
    timestamp('2023-01-28') as created_at,
    NOW() AS updated_at

FROM {{ ref('addresses_optimism_grants_funding') }}
GROUP BY 1,2,3

-- UNION ALL

-- Add additional project wallet labels here