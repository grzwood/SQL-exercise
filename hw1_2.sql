with 
base as (
	select prod,month,sum(quant)as sum_q
	from sales 
	group by prod,month),
MAX_MIN as (
	select max(sum_q)as MOST_POP_TOTAL_Q,min(sum_q) as LEAST_POP_TOTAL_Q,month
	from base
	group by month),
MAX as(
	select  MAX_MIN.month, MAX_MIN.MOST_POP_TOTAL_Q, MAX_MIN.LEAST_POP_TOTAL_Q, base.prod as MOST_POPULAR_PROD
	from MAX_MIN,base
	where MAX_MIN.month=base.month and base.sum_q=MAX_MIN.MOST_POP_TOTAL_Q
)
select  MAX.month, MAX.MOST_POPULAR_PROD, MAX.MOST_POP_TOTAL_Q, base.prod as LEAST_POPULAR_PROD, MAX.LEAST_POP_TOTAL_Q
from MAX,base
where MAX.month=base.month and MAX.LEAST_POP_TOTAL_Q=base.sum_q
order by MAX.month
