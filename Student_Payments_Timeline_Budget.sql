-- State of Maryland Higher Education Institution Budget Audit Analysis [UNIVERSITY SYSTEM OF MARYLAND - USM]

-- DESCRIPTION: To understand how budget allowances can impact state funding for university services and resources
-- by analyzing where it goes and recommendations to manage their budget based on certain circumstances and evidence given.

-- TOPIC: Timelime Analysis of the Program Used on Contropller's Resources (University - USM).

-- BIG QUESTION: How Much Funding (Restricted/Unrstricted) is allocated to their resources for each institution by MD state - specially UMD College Park? 

######### USE DATABASE ########
USE usmd_operate_budget;
###############################

######################### SUBTOPIC 1: Changes in Payment BY TIMELINE ###########################

-- Find the difference in budget between these years by student payments - using unrestricted and restricted funds.

-- Compare what you had found by observing

-- A). Current Unrestricted Funds 

-- NEED to INCLUDE FUND TYPE BC THEY'RE DEPEND ON WHAT FUNDS SHOULD BE USED FOR....
SELECT t.fis_year AS 'Year',
	   t.name_program AS 'Program Name',
       t.fund_type AS 'Fund Type',
	   CONCAT("$", t.Budget_fy, ".00") AS 'Current Budget', 
	   CONCAT("$", t.Budget_fy - t.previous_fiscial_year, '.00') AS 'Difference Between Budgets by FY'
FROM (SELECT Fiscal_Year AS fis_year,
			 Fund_Type AS fund_type,
			 Program_Name AS name_program,
			 Budget AS Budget_fy,
	  -- Make a new part that states the difference from previous part
	  LAG (Budget, 1)
      OVER (PARTITION BY Program_Name ORDER BY Fiscal_Year) AS previous_fiscial_year
      -- Connect the dots....
	  FROM Academic_Program AP
		JOIN Budget_Descrp BD
			USING(ac_prog_id)
		JOIN Budget_Overview BO
			USING(descrp_id)
		JOIN Budget_Transaction BT
			USING(receipt_id)
		JOIN Fiscial_Year FY
			USING(fiscial_id)
		JOIN Fund_Type
			USING(fund_id)
		JOIN Institution I
			USING(inst_id)
		JOIN Comptroller CM
			USING(conptroller_id)
		JOIN Service_Descp SD
			USING(service_id)
	  WHERE Institution_Name = 'University of Maryland, College Park (UMD/UMCP)' AND Service = 'Student Payments' AND Descrip_Service = 'Salaries, Wages and Fringe Benefits' AND Fund_Type = 'Current Unrestricted Funds')t
ORDER BY name_program ASC, fis_year ASC;

-- NOTES:

-- Many of the tuition being paid goes more on the unrestricted funds rather than the restricted funds which we all know where the funds are going
-- BUT NOT the type of funds used as cateorgized by USM and MD Higher Education state regulations.

-- Why is this? Why is UMD/UMCP used more on the unrestricted funds than restricted? What impact does it make and whether it would benefit on 
-- budget goals?

-- 1). All programs have used more on their unrestricted budgets than the restricted funds

-- 2). The most unrestricted funds that were used widely is the "Academic Support". Many funds were used to 
-- support academic achievement for students who needs resources as their essentials for their education.
-- However, let's see how the timeline goes to see what factors may be played in this investigation.

-- 3). Major funds that were used as essentials are (a - Academic Support, b - Research, c - Instruction).

-- Still, many questions are needed to investigate this.

-- a). What impact does funding made to students? - ask which resources are useful and which are not needed;
-- b). Would tuition increase be necessary to keep up the funds and why?




-- B). Current Restricted Funds 
SELECT t.fis_year AS 'Year',
	   t.name_program AS 'Program Name',
       t.fund_type AS 'Fund Type',
	   CONCAT("$", t.Budget_fy, ".00") AS 'Current Budget', 
	   CONCAT("$", t.Budget_fy - t.previous_fiscial_year, '.00') AS 'Difference Between Budgets by FY'
FROM (SELECT Fiscal_Year AS fis_year,
			 Fund_Type AS fund_type,
			 Program_Name AS name_program,
			 Budget AS Budget_fy,
	  -- Make a new part that states the difference from previous part
	  LAG (Budget, 1)
      OVER (PARTITION BY Program_Name ORDER BY Fiscal_Year) AS previous_fiscial_year
      -- Connect the dots....
	  FROM Academic_Program AP
		JOIN Budget_Descrp BD
			USING(ac_prog_id)
		JOIN Budget_Overview BO
			USING(descrp_id)
		JOIN Budget_Transaction BT
			USING(receipt_id)
		JOIN Fiscial_Year FY
			USING(fiscial_id)
		JOIN Fund_Type
			USING(fund_id)
		JOIN Institution I
			USING(inst_id)
		JOIN Comptroller CM
			USING(conptroller_id)
		JOIN Service_Descp SD
			USING(service_id)
	  WHERE Institution_Name = 'University of Maryland, College Park (UMD/UMCP)' AND Service = 'Student Payments' AND Descrip_Service = 'Salaries, Wages and Fringe Benefits' AND Fund_Type = 'Current Restricted Funds')t
ORDER BY name_program ASC, fis_year ASC;

-- NOTES: 
-- 1). Most cateogries were spent more on the restricted funds (rather than unrestricted). They were used more to get out of these funds before the unrestricted funds next
-- What could be because of the budget procedures on restricted/unrestricted on tuition payments used?

-- 2). After spending, the three mentioned here (2017-18 Aux Entreprises, Institutional Support, and Student Services) were all deficit. Funding has been garnished, and it
-- shows that the three have been widely used throughout this timeline. We wonder why this happened in which the books will explain more on evidence.

-- 3). We expected that the instruction has been commonly used since this is an educational institution, but we found on the restricted side that they have been used at 
-- $329,842.00, which is a lot but not have used completely. That means, they retained that budget as their own savings to keep the funds without running out. 

-- 4). In all of this, since this is cateorgized as 'Salaries and Wages', this shows that how UMD is spending, in which the fact that they want to get the non-essential ones 
-- (like the three mentioned) out first, before the essentials that they are using to keep up the funds (Instruction, Research, Academic Support).