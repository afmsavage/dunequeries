SELECT date_trunc('day', call_block_time), COUNT("call_success") as transactions
FROM wrappedbtc."WBTC_call_transfer"
WHERE date_trunc('day', call_block_time) >= '20200226' AND call_success=True
GROUP BY 1
ORDER BY 1;