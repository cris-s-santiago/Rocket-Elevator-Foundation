
--How many contact requests are made per month?
SELECT to_char(creation_date, 'YYYY-MM') as "Month"
      ,count(contact_id) as ContactPerMonth
  FROM public.fact_contacts
 group by "Month"
 order by "Month" desc;

-----------------------------------------------
--How many bid solicitations are made per month?
SELECT to_char(creation_date, 'YYYY-MM') as "Month"
      ,count(quote_id) as QuotePerMonth
  FROM public.fact_quotes
 group by "Month"
 order by "Month" desc;
 
 ----------------------------------------------
--How many elevators per customer do we have?
 SELECT customer_id as "Customer", count(id) as ElevPerCustomers
  FROM public.fact_elevators
 group by "Customer";
 
 