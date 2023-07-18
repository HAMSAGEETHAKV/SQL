1.Get the order id alone from the order_Id column and name it as Order_id

select substring(order_id,4,length(order_id)) as 
order_id from sales_purchase_data_updated;

2.  order_month,  should have month of the order date and year_month should have year of the month

select month(order_date) as order_month , concat(month(order_date),'-',year(order_date)) 
as order_year from sales_purchase_data_updated;

3. Customer id must be in the mentioned format

select substring(customer_id,4,length(customer_id)) as
cust_id from sales_purchase_data_updated;

4. Concatenate Region,Country, city, state as location_info for each records

select concat(country,'_',city,'_',state) as location_info from sales_purchase_data_updated;

5. From the derived table sales_purchase_data_updated table create a new table called Sales_order_info 

create table sales_info as select Product_ID,Category,Sub_Category,Product_Name,Sales,Quantity, (sales/quantity) as per_quantity_price,
case 
when sales > 1000 then 'super'
when sales > 400 and sales < 1000 then 'average'
else 'low'
end as super_type,
Profit,
case when profit < 0 then 1
else 0 
end as Loss 
from sales_purchase_data;

select*from sales_info;

6) Count of distinct order_ids in  sales_purchase_data_updated table

SELECT COUNT(DISTINCT order_id) AS distinct_order_count
FROM sales_purchase_data_updated;

7) Count of Unique product names in Sales_order_info 

SELECT COUNT(DISTINCT product_name) as unique_product_name
FROM sales_info;

8) Count of distinct Segments in sales_purchase_data_updated table

SELECT COUNT(DISTINCT SEGMENT) as distinct_segment
from sales_purchase_data_updated;

9) Recent order date in  sales_purchase_data_updated table

SELECT order_date FROM sales_purchase_data_updated
where month(order_date) <= 6 AND month(Order_Date) >= 5 AND year(Order_Date)=2023;

10)Old order date in sales_purchase_data_updated table

SELECT min(order_date) as old_order_id FROM sales_purchase_data_updated;

11) Customer info of all the columns for the maximum order date

SELECT * FROM sales_purchase_data_updated
WHERE order_date = (SELECT MAX(order_date) FROM sales_purchase_data_updated);

12) No .of Unique Customers from Texas and New york

SELECT COUNT(DISTINCT CASE WHEN State="Texas" THEN Customer_id END )AS No_of_Customer_Texas,
COUNT(DISTINCT CASE WHEN State="New_york" THEN customer_id END)AS No_of_customer_New_york
from sales_purchase_data_updated;
