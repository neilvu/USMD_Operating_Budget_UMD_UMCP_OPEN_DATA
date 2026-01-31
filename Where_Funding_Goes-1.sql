-- State of Maryland Higher Education Institution Budget Audit Analysis [UNIVERSITY SYSTEM OF MARYLAND - USM]

-- DESCRIPTION: To understand how budget allowances can impact state funding for university services and resources
-- by analyzing where it goes and recommendations to manage their budget based on certain circumstances and evidence given.

-- TOPIC: Where payment comes from and how it is being allocated? WHERE THE BUDGET GOES TO?

-- BIG QUESTION: How Much Funding is allocated to their resources for each institution by MD state? 

######### USE DATABASE ########
USE usmd_operate_budget;
###############################

####### SPECIFIC SOURCE of Funding #######
-- Student Payments
##########################################

######################### SUBTOPIC 1: Source of Payment  ###########################

-- Refer to Part 2). Sources_of_Funding, but by Specific Fiscal Year.

-- Institution: University of Maryland, College Park

-- A). Fisical Year: 2017
SELECT t.fis_year AS 'Year',
	   t.inst_name AS 'Name of Institution',
	   t.rev_sor AS 'Source of Input (Revenue)',
       t.fund_type AS 'Type of Funding Source',
	   CONCAT("$", t.total, '.00') AS 'Total Payments'
FROM 
	(SELECT Fiscal_Year AS fis_year,
			Institution_Name AS inst_name,
			Service AS rev_sor,
			Fund_Type AS fund_type,
			ROUND(SUM(Budget)) AS total
     FROM Budget_Transaction
			JOIN Budget_Overview
				USING(receipt_id)
			JOIN Budget_Descrp
				USING(descrp_id)
			JOIN Institution
				USING(inst_id)
			JOIN Fiscial_Year
				USING(fiscial_id)
		    JOIN Academic_Program
				USING(ac_prog_id)
			JOIN Comptroller
				USING(conptroller_id)
			JOIN Fund_Type
				USING(fund_id)
     GROUP BY Fiscal_Year, Institution_Name, Service, Fund_Type
     -- Include fisical year and School Name
     HAVING Fiscal_Year = '2017' AND Institution_Name = 'University of Maryland, College Park (UMD/UMCP)' AND Service = 'Student Payments'
     ORDER BY Fund_Type ASC, total DESC)t
GROUP BY fis_year, inst_name, rev_sor, fund_type, total;


-- B). Fisical Year: 2018:
SELECT t.fis_year AS 'Year',
	   t.inst_name AS 'Name of Institution',
	   t.rev_sor AS 'Source of Input (Revenue)',
       t.fund_type AS 'Type of Funding Source',
	   CONCAT("$", t.total, '.00') AS 'Total Payments'
FROM 
	(SELECT Fiscal_Year AS fis_year,
			Institution_Name AS inst_name,
			Service AS rev_sor,
			Fund_Type AS fund_type,
			ROUND(SUM(Budget)) AS total
     FROM Budget_Transaction
			JOIN Budget_Overview
				USING(receipt_id)
			JOIN Budget_Descrp
				USING(descrp_id)
			JOIN Institution
				USING(inst_id)
			JOIN Fiscial_Year
				USING(fiscial_id)
		    JOIN Academic_Program
				USING(ac_prog_id)
			JOIN Comptroller
				USING(conptroller_id)
			JOIN Fund_Type
				USING(fund_id)
     GROUP BY Fiscal_Year, Institution_Name, Service, Fund_Type
     -- Include fisical year and School Name
     HAVING Fiscal_Year = '2018' AND Institution_Name = 'University of Maryland, College Park (UMD/UMCP)'
     ORDER BY Fund_Type ASC, total DESC)t
GROUP BY fis_year, inst_name, rev_sor, fund_type, total;

-- What did you notice from this?

-- A). Unrestricted Payments
-- FY2017, Student Payments, Unrestricted Funds = '$21,011,899.00'.
-- FY2018, Student Payments, Unrestricted Funds = '$22,261,411.00'.

-- B). Restricted Payments
-- FY2017, Student Payments, Restricted Funds = '$5,950,754.00'.
-- FY2018, Student Payments, Restricted Funds = '$4,883,124.00'.



######################### SUBTOPIC 2: Where it is going to?  ###########################

-- Destination of Source: Salaries, Wages, Fringe
-- EXPLIINATION: 

SELECT t.fis_year AS 'Year',
	   t.inst_name AS 'Name of Institution',
	   t.rev_sor AS 'Source of Input (Revenue)',
       t.fund_type AS 'Type of Funding Source',
       t.output AS 'Where it is going?',
	   CONCAT("$", t.total, '.00') AS 'Total Payments'
FROM 
	(SELECT Fiscal_Year AS fis_year,
			Institution_Name AS inst_name,
			Service AS rev_sor,
			Fund_Type AS fund_type,
            Descrip_Service AS output,
			ROUND(SUM(Budget)) AS total
     FROM Budget_Transaction
			JOIN Budget_Overview
				USING(receipt_id)
			JOIN Budget_Descrp
				USING(descrp_id)
			JOIN Institution
				USING(inst_id)
			JOIN Fiscial_Year
				USING(fiscial_id)
		    JOIN Academic_Program
				USING(ac_prog_id)
			JOIN Comptroller
				USING(conptroller_id)
			JOIN Service_Descp
				USING(service_id)
			JOIN Fund_Type
				USING(fund_id)
     GROUP BY Fiscal_Year, Institution_Name, Service, Fund_Type, Descrip_Service
     -- Include fisical year and School Name
     HAVING Institution_Name = 'University of Maryland, College Park (UMD/UMCP)' AND Service = 'Student Payments'
     ORDER BY Fiscal_Year ASC, Fund_Type ASC, total DESC)t
GROUP BY fis_year, inst_name, rev_sor, fund_type, output, total;

-- NOTES: Restricted Funds decreases whereas Unrestricted Funds goes up.
-- 





######################### SUBTOPIC 3: Output of Funding and Amount Used ###########################

-- Now that you know where the funding goes, what was the result of the output?

-- Compare the amount used in all of the contropller's resources.

-- A). Overall 
SELECT t.fis_year AS 'Year',
       t.result AS 'Result of Budget',
	   CONCAT("$", t.total, '.00') AS 'Total Payments'
FROM 
	(SELECT Fiscal_Year AS fis_year,
			Institution_Name AS inst_name,
			Service AS rev_sor,
			Fund_Type AS fund_type,
            Descrip_Service AS output,
            Program_Name AS result,
			ROUND(SUM(Budget)) AS total
    FROM Academic_Program AP
		JOIN Budget_Descrp BD
			USING(ac_prog_id)
		JOIN Budget_Overview BO
			USING(descrp_id)
		JOIN Budget_Transaction BT
			USING(receipt_id)
		JOIN Fiscial_Year FY
			USING(fiscial_id)
		JOIN Institution I
			USING(inst_id)
		JOIN Comptroller CM
			USING(conptroller_id)
		JOIN Service_Descp SD
			USING(service_id)
		JOIN Fund_Type
			USING(fund_id)
     GROUP BY Fiscal_Year, Institution_Name, Service, Fund_Type, Descrip_Service, Program_Name
     -- Include fisical year and School Name
     HAVING Institution_Name = 'University of Maryland, College Park (UMD/UMCP)' AND Service = 'Student Payments' AND Fund_Type = 'Current Unrestricted Funds' AND Descrip_Service = 'Salaries, Wages and Fringe Benefits'
     ORDER BY Fiscal_Year ASC, total DESC)t
GROUP BY fis_year, result, total;



-- B). Specific by the fiscial year
-- 2017
SELECT t.fis_year AS 'Year',
       t.result AS 'Result of Budget',
       t.total_result AS 'Total Count',
	   CONCAT("$", t.total, '.00') AS 'Total Payments'
FROM 
	(SELECT Fiscal_Year AS fis_year,
			Institution_Name AS inst_name,
			Service AS rev_sor,
            Descrip_Service AS output,
            Program_Name AS result,
            COUNT(Program_Name) AS total_result,
			ROUND(SUM(Budget)) AS total
    FROM Academic_Program AP
		JOIN Budget_Descrp BD
			USING(ac_prog_id)
		JOIN Budget_Overview BO
			USING(descrp_id)
		JOIN Budget_Transaction BT
			USING(receipt_id)
		JOIN Fiscial_Year FY
			USING(fiscial_id)
		JOIN Institution I
			USING(inst_id)
		JOIN Comptroller CM
			USING(conptroller_id)
		JOIN Service_Descp SD
			USING(service_id)
     GROUP BY Fiscal_Year, Institution_Name, Service, Descrip_Service, Program_Name
     -- Include fisical year and School Name
     HAVING Fiscal_Year = '2017' AND Institution_Name = 'University of Maryland, College Park (UMD/UMCP)' AND Service = 'Student Payments' AND Descrip_Service = 'Salaries, Wages and Fringe Benefits'
     ORDER BY Fiscal_Year ASC, total DESC)t
GROUP BY fis_year, result, total_result, total;


-- 2018
SELECT t.fis_year AS 'Year',
       t.result AS 'Result of Budget',
       t.total_result AS 'Total Count',
	   CONCAT("$", t.total, '.00') AS 'Total Payments'
FROM 
	(SELECT Fiscal_Year AS fis_year,
			Institution_Name AS inst_name,
			Service AS rev_sor,
            Descrip_Service AS output,
            Program_Name AS result,
            COUNT(Program_Name) AS total_result,
			ROUND(SUM(Budget)) AS total
    FROM Academic_Program AP
		JOIN Budget_Descrp BD
			USING(ac_prog_id)
		JOIN Budget_Overview BO
			USING(descrp_id)
		JOIN Budget_Transaction BT
			USING(receipt_id)
		JOIN Fiscial_Year FY
			USING(fiscial_id)
		JOIN Institution I
			USING(inst_id)
		JOIN Comptroller CM
			USING(conptroller_id)
		JOIN Service_Descp SD
			USING(service_id)
     GROUP BY Fiscal_Year, Institution_Name, Service, Descrip_Service, Program_Name
     -- Include fisical year and School Name
     HAVING Fiscal_Year = '2018' AND Institution_Name = 'University of Maryland, College Park (UMD/UMCP)' AND Service = 'Student Payments' AND Descrip_Service = 'Salaries, Wages and Fringe Benefits'
     ORDER BY Fiscal_Year ASC, total DESC)t
GROUP BY fis_year, result, total_result, total;

-- The result is the outline of all budget used in university resources from the State of Maryland's Contropller.

##################################################################
-- Overall Budget for UMD College Park.....
SELECT 
       t.result AS 'Result of Budget',
       t.total_result AS 'Total Count',
	   CONCAT("$", t.total, '.00') AS 'Total Payments'
FROM 
	(SELECT 
			Institution_Name AS inst_name,
			Service AS rev_sor,
            Descrip_Service AS output,
            Program_Name AS result,
            COUNT(Program_Name) AS total_result,
			ROUND(SUM(Budget)) AS total
    FROM Academic_Program AP
		JOIN Budget_Descrp BD
			USING(ac_prog_id)
		JOIN Budget_Overview BO
			USING(descrp_id)
		JOIN Budget_Transaction BT
			USING(receipt_id)
		JOIN Institution I
			USING(inst_id)
		JOIN Comptroller CM
			USING(conptroller_id)
		JOIN Service_Descp SD
			USING(service_id)
     GROUP BY Institution_Name, Service, Descrip_Service, Program_Name
     -- Include fisical year and School Name
     HAVING Institution_Name = 'University of Maryland, College Park (UMD/UMCP)' AND Service = 'Student Payments' AND Descrip_Service = 'Salaries, Wages and Fringe Benefits'
     ORDER BY total DESC)t
GROUP BY result, total_result, total;
##################################################################


















