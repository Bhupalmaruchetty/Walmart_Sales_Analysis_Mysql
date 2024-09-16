# Walmart Sales Analysis Using Mysql 🛒 


![image](https://github.com/user-attachments/assets/71f278da-2994-493c-a5e9-6538ab0ad66c)

**Introduction:**

Walmart is a giant retail company founded in 1962 by Sam Walton, operating thousands of stores and online platforms worldwide. Known for its "everyday low prices" strategy, Walmart is the largest retailer in the U.S. and one of the biggest globally. 

The company is expanding its online presence to compete with Amazon and employs over 2 million people worldwide. Committed to sustainability, Walmart focuses on using renewable energy and reducing waste as it continues to grow and adapt, balancing both physical stores and e-commerce to serve its customers.

**Problem Statement:**

Walmart's mission to help people save money and live better, we need a comprehensive analysis of our sales data to drive strategic decision-making. Specifically, we aim to:

1.Assess sales performance across different branches, product lines, and payment methods to identify trends and patterns.

2.Examine gross income, customer behavior, and transaction patterns in various cities and during different timeframes to uncover insights into market dynamics.

3.Use these insights to pinpoint opportunities for growth and improve operational strategies, ultimately enhancing customer satisfaction and optimizing our sales performance.


**Create a Database:**

       CREATE DATABASE Walmart_Schema;

**Import Data:**

**1. Select Database:**
In the left panel, choose your database, right-click, and select Table Data Import Wizard.
  
  **2. Import CSV:**
 Browse and select your CSV file, map the columns, and click "Next" to start the import.

 **3. Retrieving Data from the table:**

        SELECT * from walmart data; 

**Dataset:**

![image](https://github.com/user-attachments/assets/9e3b45a7-b875-40a3-bbae-87dd29128b75)

**Results:**

![image](https://github.com/user-attachments/assets/7682c73a-94cc-444d-884f-979e65989aaf)
  


  **4. Data Type Changes checking**

  ![image](https://github.com/user-attachments/assets/7e91fc41-2772-4645-a84e-88c7dc35d9b6)

  **Date formate changing:**

       UPDATE walmartdata
       SET date = STR_TO_DATE(date, '%Y-%m-%d');

 **Changing Data type for Date column text to Date:**
    
       ALTER TABLE walmartdata
       MODIFY COLUMN date DATE;

 Modifying Data types for Remaining Columns:

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


**After changing data types for columns:**

![image](https://github.com/user-attachments/assets/1ef46de8-ca64-46ec-928a-a5eefbf06969)

**Case Study Questions & Solutions**

**1.Retrieve all sales columns for a specific branch (e.g., Branch 'A').**
   
         SELECT *
         FROM walmartdata
         WHERE Branch="A";
   
**Results:** 340 Rows Returned

![image](https://github.com/user-attachments/assets/b2939f6f-f249-4fa5-a69a-8fe4905bf253)


1.Using **SELECT***  get everything from the rows that match.

2.The **FROM** clause is used to specify the **walmartdata** from where you want to retrieve data.

3.The **WHERE** Clause Filters the results to include only the rows where **Branch="A"** .



**2. Find the total sales for each product line:**

     SELECT 
           Product_line, 
           round(SUM(total),2) AS total_sales
     FROM 
          walmartdata
     GROUP BY 
           product_line;


**Results:**

![image](https://github.com/user-attachments/assets/bd871c19-364c-454d-aa28-ef4f3b9eef38)
      

**1.FROM walmartdata:** It looks for this information in the walmartdata table.

**2.GROUP BY:** It groups the data by each product type, so the total sales are calculated separately for each type.

**3.SELECT :**

**Product_line:** The type of product.

**round(SUM(total),2) AS total_sales:** The total sales  for each product type, rounded to two decimal places.


**3.Retrieve all rows from the Walmart dataset where the payment method is "Cash".**

      SELECT *
      FROM walmartdata
      WHERE Payment="Cash";

**Results:**

 
![image](https://github.com/user-attachments/assets/8fa15022-2b56-4c45-82e4-163f806a69e8)

**4. Calculate the total gross income generated in each city.**

        SELECT
             City,
             round(sum(gross_income),2) as Total_gross_income
        FROM walmartdata
        GROUP BY City;

**Results:**

![image](https://github.com/user-attachments/assets/85233390-1fec-4822-8a14-1dfa4cc3b8b9)

**5. Find the average rating given by customers in each branch.**

         SELECT
               Branch,
               round(avg(Rating),1) as Average_rating
         FROM walmartdata
         GROUP BY Branch
         ORDER BY Branch;

**Results:**

  ![image](https://github.com/user-attachments/assets/b2707202-9c8d-4f6b-b199-56c24e199160)

**6. Determine the total quantity of each product line sold.**

      SELECT
             Product_line,
             sum(Quantity) as Total_Quantity
      FROM
             walmartdata
      GROUP BY
             Product_line;

**Results:**
      
![image](https://github.com/user-attachments/assets/6735d0c9-96ce-41f5-a528-1fe43b314d8d)

**7. List the top 5 products by unit price.**

       SELECT
             Product_line,
             Max(Unit_price) as Maximum_Unit_Price
      FROM
           walmartdata
      GROUP BY
            Product_line
      ORDER BY Maximum_Unit_price Desc
      LIMIT 5;

**Results:**

![image](https://github.com/user-attachments/assets/66fb5e96-d7b1-40b6-b828-47d130d17fe3)

**8. Find sales transactions with a gross margin percentage greater than 30%.**

      SELECT 
             *
      FROM
            walmartdata
      WHERE
           gross_margin_percentage =">30%";

Results:

![image](https://github.com/user-attachments/assets/5f79a170-d146-474b-9396-233a23caf0a2)

**9. Retrieve sales transactions that occurred on weekends.**

      SELECT
             *
      FROM
           walmartdata
      WHERE
           DAYOFWEEK(STR_TO_DATE(`Date`, '%Y-%m-%d')) IN (1, 7);

**Results:**
       
![image](https://github.com/user-attachments/assets/4b14f1dc-dc85-4952-aec4-717d0b2f7605)

**10. Calculate the total sales and gross income for each month.**

      SELECT
            DATE_FORMAT(STR_TO_DATE(`Date`,'%Y-%m-%d'),'%Y-%m’)AS Month_Year,
            SUM(Total) AS Total_Sales,
            SUM(gross_income) AS Total_Gross_Income
      FROM
            walmartdata
      GROUP BY
               DATE_FORMAT(STR_TO_DATE(`Date`, '%Y-%m-%d'),'%Y-%m')
      ORDER BY
        Month_Year;
            
**Results:**
 
 ![image](https://github.com/user-attachments/assets/bcb71398-5a49-4248-92f7-b1c514318136)

 **11. Find the number of sales transactions that occurred after 6 PM.**

     SELECT

           COUNT(*) as Transaction_After_6PM

     FROM
          walmartdata
     WHERE
           Time(`Time`) >'18:00:00';

**Results:**
 
 ![image](https://github.com/user-attachments/assets/4b58e713-dd0b-42bc-abc1-8eaa1a74ea64)

**12. List the sales transactions that have a higher total than the average total of all transactions.**

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

**Results:**

![image](https://github.com/user-attachments/assets/5864ab6b-4162-429e-8aa6-f7ca9f645ba9)

**13. Find customers who made more than 5 purchases in a single month.**

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
                  
Results:

![image](https://github.com/user-attachments/assets/6c5fd06a-d264-4608-8303-c91b1e69dad0)

**14. Calculate the cumulative gross income for each branch by date.**

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

Results:

![image](https://github.com/user-attachments/assets/f7f8d693-e850-49ff-8fc3-ac1dd8a0d94d) 

![image](https://github.com/user-attachments/assets/4e28a61b-5efd-4a67-aa97-fa85de17f72f)

![image](https://github.com/user-attachments/assets/8d13afab-eb10-4c58-a439-e0c758024660)

**15. Find the total cogs for each customer type in each city.**

    SELECT
           City,
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

**Results:**

![image](https://github.com/user-attachments/assets/d96e2185-6c1e-44e7-b11d-0bcc61d27586)


**Key Insights:**

**1.Branch Transactions:**

**Top:** Branch A has the most transactions, showing strong customer engagement.

**Lowest:** Branch C has the fewest transactions, indicating less customer activity.

**2.Branch Rankings:**

**Highest:** Branch C (7.1) has the best customer satisfaction rating.

**Lowest:** Branch B (6.8) has a lower rating, suggesting a need for improvement.

**3.Product Line Sales:**

**Top:** Electronics and Accessories sold the most units (971), showing high demand.

**Lowest:** Health and Beauty sold the fewest units, indicating lower interest or potential inventory issues.

**4.Gross Income by City:**

Highest: Naypyitaw earned $5,265.40, reflecting strong performance.

Lowest: Yangon earned $5,057.20, showing potential for growth.

**5.Cash Transactions:**
Heavy reliance on cash may suggest customer preferences or limited use of digital payments.

**6.Weekend Activity:** 297 transactions occurred on weekends, indicating high customer activity.

**7.Monthly Sales:**

**Top:** January 2019 had the highest sales ($116,291.91) and gross income ($5,537.30).

**Lowest:** February 2019 had the lowest sales ($97,219.41) and gross income ($4,628.90).

**8.Customer Purchases Analysis:**

Normal customer purchases peaked in January, dropped in February, and then rose again in March. Member purchases saw a decrease in February but recovered in March.

**Recommendations:**

**1.Boost February Sales:** Run promotions to increase sales during the low February period.

**2.Improve Branch B:** Apply successful strategies from Branch C to enhance Branch B’s performance.

**3.Enhance Yangon Sales:** Increase marketing efforts to grow sales in Yangon.

**4.Optimize Weekends:** Increase staffing and inventory for the high weekend transaction volume.

**5.Promote High Performers:** Focus on selling Electronics and Accessories more, and improve Health and Beauty sales.

**6.Adjust Strategies Regularly:**
 Continuously monitor sales data and adjust strategies to improve performance.
