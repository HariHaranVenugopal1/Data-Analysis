-- Show the available databases
SHOW DATABASES;

-- Use the specified schema/database
USE new_schema;

-- Show all the tables within the current database
SHOW TABLES;

-- Query to view all data from the chain_dataset_coffee table
SELECT * FROM chain_dataset_coffee;

-- Sales and Profitability Analysis
-- What are the total sales and profits for each store, state, or market?
SELECT State, Market, 
       SUM(Sales) AS total_sales, 
       SUM(Profit) AS total_profit
FROM chain_dataset_coffee
GROUP BY State, Market;

-- Which stores or states are the most and least profitable?
SELECT Market, State, 
       SUM(Profit) AS total_profit
FROM chain_dataset_coffee
GROUP BY State, Market
ORDER BY total_profit DESC;

-- What is the profit margin for each product line and product type?
SELECT productLine, ProductType, 
       SUM(Profit) AS total_profit, 
       SUM(Sales) AS total_sales,
       (SUM(Profit) / SUM(Sales)) * 100 AS Profit_Margin_Percentage
FROM chain_dataset_coffee
GROUP BY productLine, ProductType
ORDER BY Profit_Margin_Percentage DESC;

-- Cost and Expense Analysis
-- What is the average cost of goods sold (COGS) per store or state?
SELECT Market, 
       AVG(Target_COGS) AS Average_COGS
FROM chain_dataset_coffee
GROUP BY Market
ORDER BY Average_COGS DESC;

-- Highest other expenses or total expenses, and how does this impact profitability?
SELECT market, 
       SUM(Sales) AS total_sales, 
       SUM(profit) AS total_profit, 
       SUM(OtherExpenses) AS total_Otherexpenses,
       SUM(totalexpence) AS total_totalexpence, 
       (SUM(Profit) / SUM(Sales)) * 100 AS Profit_Margin_Percentage
FROM chain_dataset_coffee
GROUP BY market
ORDER BY total_totalexpence DESC;

-- Product Analysis
-- What are the best-performing product lines or product types in terms of sales and profit?
SELECT ProductLine, 
       SUM(Sales) AS Total_Sales, 
       SUM(Profit) AS Total_Profit
FROM chain_dataset_coffee
GROUP BY ProductLine
ORDER BY Total_Sales DESC, Total_Profit DESC;

-- Stores Exceeding or Falling Short of Targets
SELECT Store_id, 
       AVG(Sales) AS Avg_Sales, 
       AVG(TargetSales) AS Avg_TargetSales, 
       AVG(Profit) AS Avg_Profit, 
       AVG(Target_Profit) AS Avg_TargetProfit, 
       AVG(Cogs) AS Avg_Cogs, 
       AVG(Target_COGS) AS Avg_Target_COGS,
       CASE 
           WHEN AVG(Sales) > AVG(TargetSales) THEN 'Exceeds Target Sales'
           WHEN AVG(Sales) < AVG(TargetSales) THEN 'Falls Short of Target Sales'
           ELSE 'Meets Target Sales'
       END AS Sales_Performance,
       CASE 
           WHEN AVG(Profit) > AVG(Target_Profit) THEN 'Exceeds Target Profit'
           WHEN AVG(Profit) < AVG(Target_Profit) THEN 'Falls Short of Target Profit'
           ELSE 'Meets Target Profit'
       END AS Profit_Performance,
       CASE 
           WHEN AVG(Cogs) > AVG(Target_COGS) THEN 'Exceeds Target COGS'
           WHEN AVG(Cogs) < AVG(Target_COGS) THEN 'Falls Short of Target COGS'
           ELSE 'Meets Target COGS'
       END AS COGS_Performance
FROM chain_dataset_coffee
GROUP BY Store_id
ORDER BY Store_id;
