
##Walmart Sales Analysis ##

## Create Database ##

CREATE DATABASE Walmart_Schema;


SELECT
        * 
FROM  
     walmartdata;



## Date formate change##

UPDATE walmartdata
SET date = STR_TO_DATE(date, '%Y-%m-%d');



## Changing Data type for Date column text to Date ##
ALTER TABLE walmartdata
MODIFY COLUMN date DATE;

ALTER TABLE walmartdata
MODIFY COLUMN Invoice_ID varchar(100);

ALTER TABLE walmartdata
MODIFY COLUMN Branch varchar(100);


## Modifying the Data types for columns in table ##

ALTER TABLE walmartdata
MODIFY COLUMN Invoice_ID varchar(100),
MODIFY COLUMN Branch varchar(100),
MODIFY COLUMN City varchar(100),
MODIFY COLUMN Customer_type varchar(100),
MODIFY COLUMN Gender varchar(100),
MODIFY COLUMN Product_line varchar(100),
MODIFY COLUMN Unit_price decimal(10,2),
MODIFY COLUMN `Tax_5%` decimal(10,4),
MODIFY COLUMN Total decimal(10,3),
MODIFY COLUMN `Time` TIME,
MODIFY COLUMN Payment varchar(100),
MODIFY COLUMN cogs decimal(10,3),
MODIFY COLUMN gross_margin_percentage decimal(10,1),
MODIFY COLUMN gross_income decimal(10,1),
MODIFY COLUMN Rating decimal(10,1)
;






## 1.  Retrieve all columns for sales made in a specific branch (e.g., Branch 'A') ##

SELECT 
        *
FROM
	 walmartdata
WHERE
       Branch="A";




## 2. Find the total sales for each product line. ##

SELECT 
      Product_line, 
      round(SUM(total),2) AS total_sales
FROM 
     walmartdata
GROUP BY 
       product_line;



## 3. List all sales transactions where the payment method was 'Cash'.##

SELECT 
		*
FROM 
       walmartdata
WHERE 
       Payment="Cash";




## 4.  Calculate the total gross income generated in each city. ##

SELECT 
       City,
	   round(sum(gross_income),2) as Total_gross_income
FROM 
       walmartdata
GROUP BY
		City;


## 5. Find the average rating given by customers in each branch. ##

SELECT 
       Branch,
	   round(avg(Rating),1) as Average_rating
FROM 
	   walmartdata
GROUP BY 
         Branch;


## 6. Determine the total quantity of each product line sold. ##

SELECT 
       Product_line,
       sum(Quantity) as Total_Quantity
FROM
       walmartdata
GROUP BY
        Product_line;


    
## 7. List the top 5 products by unit price.##

SELECT 
      Product_line,
      Max(Unit_price) as Maximum_Unit_Price
FROM
      walmartdata
GROUP BY 
         Product_line
ORDER BY
         Maximum_Unit_price Desc
LIMIT 5;


## 8. Find sales transactions with a gross margin percentage greater than 30%. ##

SELECT 
        *
 FROM
      walmartdata
WHERE
	  gross_margin_percentage =">30%";
     


## 9.  Retrieve sales transactions that occurred on weekends.##


SELECT
        *
FROM
      walmartdata
WHERE
	  DAYOFWEEK(STR_TO_DATE(`Date`, '%Y-%m-%d')) IN (1, 7);



## 10.  Calculate the total sales and gross income for each month. ##

SELECT 
      DATE_FORMAT(STR_TO_DATE(`Date`, '%Y-%m-%d'), '%Y-%m') AS Month_Year,
      SUM(Total) AS Total_Sales,
      SUM(gross_income) AS Total_Gross_Income
FROM 
     walmartdata
GROUP BY 
       DATE_FORMAT(STR_TO_DATE(`Date`, '%Y-%m-%d'), '%Y-%m')
ORDER BY 
       Month_Year;

      
## 11.  Find the number of sales transactions that occurred after 6 PM. ##

SELECT 
      count(*) as Transaction_After_6PM
FROM
     walmartdata
WHERE
      Time(`Time`) >'18:00:00';
     
     
     
## 12.  List the sales transactions that have a higher total than the average total of all transactions. ##

 
WITH AvgTotal AS (
    SELECT 
        AVG(Total) AS Average_Total
    FROM 
        walmartdata
)
 SELECT 
         *
 FROM 
      walmartdata
WHERE 
      Total > (SELECT Average_Total FROM AvgTotal);
    
    
## 13.  Find customers who made more than 5 purchases in a single month. ##
  
WITH MonthlyPurchases AS (
    SELECT
        Customer_type,
        DATE_FORMAT(`DATE`, '%Y-%m') AS Purchase_Month,
        COUNT(*) AS Purchases
    FROM 
        walmartdata
    GROUP BY
        Customer_type,
        DATE_FORMAT(`DATE`, '%Y-%m')
)
   SELECT
         Customer_type,
         Purchase_Month,
		 Purchases
   FROM 
        MonthlyPurchases
  WHERE
        Purchases > 5
  ORDER BY
          Customer_type,
          Purchase_Month;
         

## 14. Calculate the cumulative gross income for each branch by date. ##


SELECT 
      Branch,
      `date`,
      gross_income,
      SUM(gross_income) OVER (PARTITION BY Branch ORDER BY `date`) AS Cumulative_Gross_Income
FROM 
     walmartdata
ORDER BY 
	    Branch,
		`date`;
    
    
    
## 15. Find the total cogs for each customer type in each city. ##

SELECT 
       city,
       Customer_type,
       round(sum(cogs),2) as Total_cogs
 FROM 
       walmartdata
 GROUP BY 
         City,
         Customer_type
 ORDER BY
		 City,
         Customer_type;












       






