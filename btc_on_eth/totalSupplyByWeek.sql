SELECT
week,
SUM(transfer) over (order by week)
FROM
(
    SELECT
    date_trunc('week', evt_block_time) as week,
    sum(value/1e18) as transfer -- 18 decimals
    FROM erc20."ERC20_evt_Transfer"
    WHERE contract_address = '\x5228a22e72ccc52d415ecfd199f99d0665e7733b'
    AND "from" = '\x0000000000000000000000000000000000000000'
    GROUP BY 1
UNION
    SELECT
    date_trunc('week', evt_block_time) as week,
    sum(-value/1e18) as transfer
    FROM erc20."ERC20_evt_Transfer"
    WHERE contract_address = '\x5228a22e72ccc52d415ecfd199f99d0665e7733b'
    AND "to" = '\x0000000000000000000000000000000000000000'
    GROUP BY 1
) as net;