CREATE DATABASE HR_Analytics;
USE hr_analytics;

SELECT COUNT(*) FROM hr_1;
SELECT COUNT(*) FROM hr_2;

# KPI 1 :Total Employees

SELECT 
    COUNT(*) AS Total_Employees
FROM HR_1;


# KPI 2 : Total Attrition Count

SELECT 
    COUNT(*) AS Total_Attrition
FROM HR_1
WHERE Attrition = 'Yes';


# KPI 3 : Overall Attrition Rate (%)

SELECT 
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 
        / COUNT(*),
        2
    ) AS Attrition_Rate_Percent
FROM HR_1;


# KPI 4 : Average Monthly Income (Overall)

SELECT 
    ROUND(AVG(MonthlyIncome), 2) AS Avg_Monthly_Income
FROM HR_2;


# KPI 5 : Average Years at Company

SELECT 
    ROUND(AVG(YearsAtCompany), 2) AS Avg_Years_At_Company
FROM HR_2;


# KPI 6 :Active Employees

SELECT 
    COUNT(*) AS Active_Employees
FROM HR_1
WHERE Attrition = 'No';


# KPI 7 : Average Attrition Rate for all Departments

SELECT 
    Department,
    ROUND(
        (SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0)
        / COUNT(*),
    2
    ) AS Attrition_Rate_Percent
FROM hr_1
GROUP BY Department
ORDER BY Attrition_Rate_Percent DESC;


# KPI-8 : Average Hourly Rate of Male Research Scientist

  SELECT 
    ROUND(AVG(HourlyRate), 2) AS Avg_Hourly_Rate
FROM HR_1
WHERE Gender = 'Male'
  AND JobRole = 'Research Scientist';

  
  # KPI 9 : Attrition Rate vs Monthly Income
  
  SELECT
    CASE
        WHEN h2.MonthlyIncome < 3000 THEN 'Low Income'
        WHEN h2.MonthlyIncome BETWEEN 3000 AND 7000 THEN 'Medium Income'
        ELSE 'High Income'
    END AS Income_Band,

    COUNT(*) AS Total_Employees,

    SUM(CASE WHEN h1.Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrition_Count,

    ROUND(
        SUM(CASE WHEN h1.Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 
        / COUNT(*),
        2
    ) AS Attrition_Rate_Percent

FROM HR_1 h1
JOIN HR_2 h2
  ON h1.EmployeeNumber = h2.`Employee ID`
GROUP BY Income_Band
ORDER BY Attrition_Rate_Percent DESC;


#  KPI 10 : Average Working Years for Each Department

  SELECT
    h1.Department,
    ROUND(AVG(h2.YearsAtCompany), 2) AS Avg_Working_Years
FROM HR_1 h1
JOIN HR_2 h2
  ON h1.EmployeeNumber = h2.`Employee ID`
GROUP BY h1.Department
ORDER BY Avg_Working_Years DESC;

  
 # KPI 11 :Job Role vs Work Life Balance
  
  SELECT
    h1.JobRole,
    ROUND(AVG(h2.WorkLifeBalance), 2) AS Avg_Work_Life_Balance
FROM HR_1 h1
JOIN HR_2 h2
  ON h1.EmployeeNumber = h2.`Employee ID`
GROUP BY h1.JobRole
ORDER BY Avg_Work_Life_Balance DESC;


# KPI 12 : KPIAttrition Rate vs Years Since Last Promotion
SELECT
    h2.YearsSinceLastPromotion,
    COUNT(*) AS Total_Employees,
    SUM(CASE WHEN h1.Attrition = 'Yes' THEN 1 ELSE 0 END) AS Attrition_Count,
    ROUND(
        SUM(CASE WHEN h1.Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS Attrition_Rate_Percent
FROM HR_1 h1
JOIN HR_2 h2
  ON h1.EmployeeNumber = h2.`Employee ID`
GROUP BY h2.YearsSinceLastPromotion
ORDER BY h2.YearsSinceLastPromotion;
