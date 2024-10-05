# AtliQ-Hardware-Consumer-Goods-Ad-Hoc-Insights


[![SQL](https://img.shields.io/badge/SQL-Database%20Analysis-orange)](https://github.com/kohitkakde/AtliQ-Hardware-Consumer-Goods-Ad-Hoc-Insights/blob/main/Atliq%20Ad-Hoc%20code.sql).

AtliQ Hardware Consumer Goods: Ad-Hoc-Insights
Project Overview and Problem Statement
Atliq Hardware (imaginary company) is one of the leading computer hardware producers in India and well expanded in other countries too. specializes in selling computers and accessories.

The management noticed that they did not get enough insights to make quick and smart data-informed decisions. However, Tony Sharma (Data Analytics Director ) wants to expand their data analytics team by adding several junior data analysts. So he decided to conduct a SQL challenge which will help him understand both tech and soft skills

Now the company wants insights for 10 ad hoc / business requests.



## Data Structure/ Data Modeling and Tools
<u>  </u> 

The 'gdb023' (atliq_hardware_db) database was provided to me to work on and it includes six main tables:

1. dim_customer: contains customer-related data
2. dim_product: contains product-related data
3. fact_gross_price: contains gross price information for each product
4. fact_manufacturing_cost: contains the cost incurred in the production of each product
5. fact_pre_invoice_deductions: contains pre-invoice deductions information for each product
6. fact_sales_monthly: contains monthly sales data for each product.


Here is the Data Model that I have created in Power BI for the Visualization part -
![atliq Hardware Modelling](https://github.com/user-attachments/assets/0699dddd-f869-4b2f-b8bb-ae534470366a)


### Tools used -

I used My SQL to answer the questions
and Power BI for visualization




## 10 Ad-Hoc Requests and Answers:
<u>  </u>  


### 1. Provide the list of markets in which customer "Atliq Exclusive" operates its business in the APAC region.

![image](https://github.com/user-attachments/assets/951d301e-3885-4ef2-bcfe-b1fc30a4a364)


### 2. What is the percentage of unique product increase in 2021 vs. 2020? The final output contains these fields, unique_products_2020, unique_products_2021, percentage_chg

![Screenshot 2024-09-10 091209](https://github.com/user-attachments/assets/0c272779-8570-40d9-be0d-dd2f078984c8)

### 3. Provide a report with all the unique product counts for each segment and sort them in descending order of product counts. The final output contains 2 fields, segment product_count

![Screenshot 2024-09-10 091734](https://github.com/user-attachments/assets/c07dccb6-2868-4d01-af10-dc7da2b81699)

### 4. Follow-up: Which segment had the most increase in unique products in 2021 vs 2020? The final output contains these fields, segment product_count_2020, product_count_2021, difference

![Screenshot 2024-09-10 092319](https://github.com/user-attachments/assets/42703bea-c4d7-45be-877b-2b224fd1730a)


### 5. Get the products that have the highest and lowest manufacturing costs. The final output should contain these fields, product_code, product, manufacturing_cost

![Screenshot 2024-09-10 092133](https://github.com/user-attachments/assets/f43d5369-2e9a-4e07-9656-cf6fc8fa466c)

### 6. Generate a report that contains the top 5 customers who received an average high pre_invoice_discount_pct for the fiscal year 2021 and in the Indian market. The final output contains these fields, customer_code, customer, average_discount_percentage

![Screenshot 2024-09-10 092455](https://github.com/user-attachments/assets/fb52f2ae-dbd1-4086-abb8-5d595975b707)

### 7. Get the complete report of the Gross sales amount for the customer “Atliq Exclusive” for each month. This analysis helps to get an idea of low and high-performing months and make strategic decisions. The final report contains these columns: Month, Year, Gross sales Amount for 2020 for 2021

![Screenshot 2024-09-10 094123](https://github.com/user-attachments/assets/73af9a85-0ca7-4987-a688-40621a7a3989)

### 8. In which quarter of 2020, got the maximum total_sold_quantity? The final output contains these fields sorted by the total_sold_quantity, --> Quarter, total_sold_quantity

![Screenshot 2024-09-10 100208](https://github.com/user-attachments/assets/10ed473a-faa2-45aa-a579-9c83c4fbb008)

### 9. Which channel helped to bring more gross sales in the fiscal year 2021 and the percentage of contribution? The final output contains these fields --> channel, gross_sales_mln, percentage

![Screenshot 2024-09-10 100257](https://github.com/user-attachments/assets/059588a9-9462-458f-947a-caf9c90569a3)

### 10. Get the Top 3 products in each division that have a high total_sold_quantity in the fiscal_year 2021 ? The final output contains these fields, division, product_code

![Screenshot 2024-09-10 100331](https://github.com/user-attachments/assets/8fd743a9-d6e0-44cb-b8c0-6a5860a3c51c)

===============================================================================================================



### You can view the SQL code [here](https://github.com/kohitkakde/AtliQ-Hardware-Consumer-Goods-Ad-Hoc-Insights/blob/main/Atliq%20Ad-Hoc%20code.sql).
