
create view base as
	select prod, sum(quant) as SUM_Q, month
	from sales
	group by prod,month
	ORDER BY MONTH,prod;
 
create view MAX_MIN as
	select max(SUM_Q) as MAX_Q, min(SUM_Q) as MIN_Q, prod
	from base
	group by prod;

with MAX_Q as(
	select base.prod,MAX_MIN.MAX_Q,base.month as MOST_FAV_MO,MAX_MIN.MIN_Q
	from base,MAX_MIN
	WHERE base.prod=MAX_MIN.prod and base.SUM_Q=MAX_MIN.MAX_Q )
	
select MAX_Q.prod,MAX_Q.max_q,MAX_Q.MOST_FAV_MO,MAX_Q.MIN_Q,base.month as LEAST_FAV_MO
from base,MAX_Q
where base.prod=MAX_Q.prod and base.SUM_Q=MAX_Q.MIN_Q 
