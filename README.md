### [OPEN DATA] University System of Maryland Operating Budget Audit Analysis (University of Maryland, College Park)                                                                                                                                 
##### Dataset Link: https://opendata.maryland.gov/Budget/Maryland-Operating-Budget-CUR-and-CR/4mca-332u/about_data

#### PURPOSE: To understand how the University System of Maryland (including with an USMD institution - University of Maryland, College Park) operates on a budget/finance scale that is available on the open data page. This helps to track down where the amount is going to its institutions' goals as well as the challenges it faced on its operations on an data audit scale. 

#### REASON: In search of curiosity and with the intent to understand the scope of the data, this puts a path forward to better imporve management and intelligence through auditing and inspection that will help shape my goals in the Inspector General field.

Analyzed sets of data in the State of Maryland’s Budget Open Data to investigate where payment sources such as student tuition as well as grants populated from one of the USM’s institutions (University of Maryland, College Park). 
This was in attention of the changes of USM’s budgeting issues in scope of the economic and political environment that can affect how the university/institution can achieve its mission and financial goals to specific needs for students, faculty, and staff operations. 

Through data analytics tools, I was able to find patterns not only where the source of the budget is going but also with trend changes by each fiscal year that explains how the university is operating on its funding source.



##### SOURCES: 

1). Sears, B.P. & Ford, W.J. (2025). Universities told they should brace for the coming year’s 7% budget cut. Maryland Matters. Retrieved from January 30, 2026. https://marylandmatters.org/2025/06/12/universities-told-they-should-brace-for-the-coming-years-7-budget-cut/

2). Grauntt, S (2025). University Regents Approve Fiscal Year 2026 Budget that cuts spending, raises tuition and fees. Maryland Matters. Retrieved from January 30, 2026. https://marylandmatters.org/2025/06/13/university-regents-approve-fiscal-2026-budget-that-cuts-spending-raises-tuition-and-fees/


Tools Programmed via SQL (MySQL Workbench) and importing CSV files with Google Sheets and Apple Numbers.

CREDIT: State of Maryland Open Data Portal (https://opendata.maryland.gov/)


Data Set and Queries (Specifically UMCP - University of MD College Park Campus):

https://opendata.maryland.gov/Budget/Maryland-Operating-Budget-CUR-and-CR/4mca-332u/explore/query/SELECT%0A%20%20%60fiscal_year%60%2C%0A%20%20%60agency_code%60%2C%0A%20%20%60agency_name%60%2C%0A%20%20%60unit_code%60%2C%0A%20%20%60unit_name%60%2C%0A%20%20%60program_code%60%2C%0A%20%20%60program_name%60%2C%0A%20%20%60subprogram_code%60%2C%0A%20%20%60subprogram_name%60%2C%0A%20%20%60object_code%60%2C%0A%20%20%60object_name%60%2C%0A%20%20%60comptroller_subobject_code%60%2C%0A%20%20%60comptroller_subobject_name%60%2C%0A%20%20%60agency_subobject_code%60%2C%0A%20%20%60agency_subobject_name%60%2C%0A%20%20%60fund_type_name%60%2C%0A%20%20%60budget%60%2C%0A%20%20%60organization_code%60%2C%0A%20%20%60category%60%2C%0A%20%20%60category_title%60%0AORDER%20BY%20%60fiscal_year%60%20ASC%20NULL%20LAST%0ASEARCH%20%22University%20of%20Maryland%2C%20College%20Park%20Campus%22/page/filter
