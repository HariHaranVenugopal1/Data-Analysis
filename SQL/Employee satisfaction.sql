SHOW DATABASES;
USE new_schema;
SHOW TABLES;

SELECT * FROM extended_employee_performance_and_productivity_data;

-- Query 1: Employee Performance Analysis
SELECT Department, AVG(Performance_Score) AS average_performance
FROM extended_employee_performance_and_productivity_data
GROUP BY Department
ORDER BY average_performance DESC;

-- Query 2: Salary and Performance Correlation
SELECT Monthly_Salary, AVG(Performance_Score) AS average_performance
FROM extended_employee_performance_and_productivity_data
GROUP BY Monthly_Salary
ORDER BY Monthly_Salary ASC;

-- Query 3: Resignation Trends by Department
SELECT Department, COUNT(Resigned) AS resignation
FROM extended_employee_performance_and_productivity_data
WHERE Resigned = 'True'
GROUP BY Department
ORDER BY resignation DESC;

-- Query 4: Impact of Overtime on Performance
SELECT Overtime_Hours, AVG(Performance_Score) AS Avg_Performance
FROM extended_employee_performance_and_productivity_data
GROUP BY Overtime_Hours;

-- Query 5: Sick Days vs Performance
SELECT Sick_Days, AVG(Performance_Score) AS Avg_Performance
FROM extended_employee_performance_and_productivity_data
GROUP BY Sick_Days
ORDER BY Avg_Performance DESC;

-- Query 6: Training Hours and Employee Performance
SELECT Training_Hours, AVG(Performance_Score) AS Avg_Performance
FROM extended_employee_performance_and_productivity_data
GROUP BY Training_Hours
ORDER BY Training_Hours;

-- Query 7: Years at Company and Performance
SELECT Years_At_Company, AVG(Performance_Score) AS Avg_Performance
FROM extended_employee_performance_and_productivity_data
GROUP BY Years_At_Company
ORDER BY Avg_Performance;

-- Query 8: Employees Working Remotely vs Performance
SELECT Remote_Work_Frequency, AVG(Performance_Score) AS Avg_Performance
FROM extended_employee_performance_and_productivity_data
GROUP BY Remote_Work_Frequency
ORDER BY Remote_Work_Frequency;

-- Query 9: Employee Performance and Education Level
SELECT Education_Level, AVG(Performance_Score) AS Avg_Performance
FROM extended_employee_performance_and_productivity_data
GROUP BY Education_Level;
