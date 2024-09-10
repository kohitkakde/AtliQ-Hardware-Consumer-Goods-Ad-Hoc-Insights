USE `gdb023`;
select * from dim_customer;
select * from dim_product;
select * from fact_gross_price;
select * from fact_sales_monthly;
select * from fact_manufacturing_cost;
select * from fact_pre_invoice_deductions;


/*---------	Que 1 --------------*/
select distinct(market) from dim_customer 
where customer = 'Atliq Exclusive' and region = 'APAC';

/*-----------------------------------------------------------------------------------------------------------------------------------------
Que 2.  What is the percentage of unique product increase in 2021 vs. 2020? The final output contains these fields, 
a) unique_products_2020 
b) unique_products_2021 
c) percentage_chg 
----------------------------------------------------------------------------------------------------------------------------------------------*/


with year2020 as(
					select count(distinct (product_code)) as unique_products_2020 from fact_manufacturing_cost where cost_year= 2020 ), 
	 year2021 as ( select  count(distinct (product_code)) as unique_products_2021 from fact_manufacturing_cost where cost_year = 2021 )
     
select unique_products_2020,unique_products_2021, round((unique_products_2021-unique_products_2020)/unique_products_2020*100,2) as percentage_chg from year2020 cross join year2021 ;
               
               
/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------

Que 3.   Provide a report with all the unique product counts for each  segment  and sort them in descending order of product counts. The final output contains 2 fields, 
a) segment  
b) product_count 
----------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

select segment , count(distinct product_code) as product_count from dim_product 
group by segment 
order by product_count desc;

/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------

Que 4.  Follow-up: Which segment had the most increase in unique products in 2021 vs 2020? The final output contains these fields, segment 
a) product_count_2020 
b) product_count_2021 
c) difference
----------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

with cte2020 as(
				select p.segment , count( distinct m.product_code) as product_count_2020  from fact_sales_monthly m join dim_product p using(product_code)  where fiscal_year =2020 group by p.segment ),
                
	cte2021 as (
				select p.segment , count( distinct m.product_code) as product_count_2021 from fact_sales_monthly m  join dim_product p using(product_code)  where fiscal_year =2021 group by p.segment)
                
select * , product_count_2021 -product_count_2020 as difference from cte2020 join cte2021 using (segment)
order by difference desc ;

/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------

Que 5.  Get the products that have the highest and lowest manufacturing costs. The final output should contain these fields, 
a) product_code 
b) product 
c) manufacturing_cost

----------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

(select m.product_code ,
		p.product ,
		m.manufacturing_cost
        from fact_manufacturing_cost m 
        join dim_product p using (product_code) 
        order by manufacturing_cost desc limit 1)
 union all
 (select m.product_code ,
		p.product ,
		m.manufacturing_cost
        from fact_manufacturing_cost m 
        join dim_product p using (product_code) 
        order by manufacturing_cost asc limit 1);
 
/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------

Que 6.  Generate a report which contains the top 5 customers who received an average high  pre_invoice_discount_pct  for the  fiscal  year 2021  and in the Indian  market. 
The final output contains these fields, 
a) customer_code 
b) customer 
c) average_discount_percentage

----------------------------------------------------------------------------------------------------------------------------------------------------------------------*/


select p.customer_code, c.customer, concat(round(avg(p.pre_invoice_discount_pct)*100,2),"%") as average_discount_percentage
from fact_pre_invoice_deductions p join dim_customer c using(customer_code) 
where p.fiscal_year = 2021 and market = "india"
group by p.customer_code, c.customer
order by avg(p.pre_invoice_discount_pct) desc 
limit 5;


/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------

Que 7.Get the complete report of the Gross sales amount for the customer “Atliq Exclusive” for each month. This analysis helps to  get an idea of low and high-performing months and take strategic decisions. 
The final report contains these columns: 
a) Month 
b) Year 
c) Gross sales Amount 

----------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

select month(m.date) as Month,
	   m.fiscal_year,
       concat(round(sum(p.gross_price*m.sold_quantity)/1000000,2),"M") as Gross_sales_Amount 
       from fact_sales_monthly m join fact_gross_price p using (product_code)
								 join dim_customer using (customer_code)
       where customer = "Atliq Exclusive"
	
       group by Month, m.fiscal_year
       order by month desc;


/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------

Que 8.  In which quarter of 2020, got the maximum total_sold_quantity? The final output contains these fields sorted by the total_sold_quantity, 
Quarter 
total_sold_quantity 

----------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
		
        
select case when month(date) in (9,10,11) then 'Q1'
			When month(date) in (12,1,2) then 'Q2'
            when month(date) in (3,4,5) then 'Q3'
            Else 'Q4' end as Quarters, 
            format(sum(sold_quantity),0) as total_sold_quantity 
from 
	fact_sales_monthly
where 
	fiscal_year = 2020
group by 
	Quarters
order by 
	total_sold_quantity desc;


/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------

Que 9.  Which channel helped to bring more gross sales in the fiscal year 2021 and the percentage of contribution?  The final output  contains these fields, 
a) channel 
b) gross_sales_mln 
c) percentage 

----------------------------------------------------------------------------------------------------------------------------------------------------------------------*/
		
with channelper as (
select 
	c.channel, 
	round(sum(g.gross_price*m.sold_quantity)/1000000,2)  as gross_sales_mln  
from 
	dim_customer c 
join 
	fact_sales_monthly m 
    using (customer_code)
join
	fact_gross_price g
	on g.Product_code = m.Product_code
    and g.fiscal_year = m.fiscal_year
where 
	m.fiscal_year = 2021
group by c.channel)


select * , concat(round( gross_sales_mln*100/sum(gross_sales_mln)over(),2),"%") as percentage 
from 
	channelper 
order by
	percentage desc;
    
    
/*-----------------------------------------------------------------------------------------------------------------------------------------------------------------
Que 10.  Get the Top 3 products in each division that have a high total_sold_quantity in the fiscal_year 2021? The final output contains these fields, 
a) division 
b) product_code 
----------------------------------------------------------------------------------------------------------------------------------------------------------------------*/

with top3 as(

select 
	p.division,
    p.product_code,
    sum(m.sold_quantity) as total_sales
from dim_product p
join
	fact_sales_monthly m 
    using (product_code)
join
	fact_gross_price g
	on g.Product_code = m.Product_code
    and g.fiscal_year = m.fiscal_year
where 
	m.fiscal_year = 2021
group by
	p.division,
    p.product_code
order by 
	total_sales
	),
 
cte2 as(
select 
	*,
	dense_rank() over(partition by division order by total_sales) as dense
from top3 )

select 
	division,
    product_code,
    total_sales
from cte2
where 
	dense <= 3;

