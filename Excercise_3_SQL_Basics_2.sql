====== Exercise 3 - SQL Basics 2 ======

-- 1 | Count how many employees have two middle letters (third and fourth) in PC name as J0. Set this column name to be PC_name_part.
--------------------------------------------------
SELECT count(PC) AS PC_name_part FROM emps
WHERE SUBSTRING(PC, 3, 2) = 'J0'
--------------------------------------------------

##################################################
-- 2 | Show the employee count for each taxcode. Sort the result set in descending order by count.
--------------------------------------------------
SELECT taxcode, COUNT(*) AS employee_count 
FROM emps
GROUP BY taxcode
ORDER BY employee_count DESC
--------------------------------------------------

##################################################
-- 3 | Count the sum for rate values of employees working in departments C-M and province (prov) being AB. Set result set column name to be Total.
--------------------------------------------------
SELECT dept, prov, SUM(RATE) as Total
FROM emps
WHERE dept BETWEEN 'C' AND 'M'
AND prov = 'AB'
GROUP BY dept
--------------------------------------------------

##################################################
-- 4 | Count the minimum and maximum rate values of employees for the each of the following cities: Brooks, Red Deer and St Albert. Set result set column names to be Smallest and Greatest.
--------------------------------------------------
SELECT City, MIN(rate) AS Smallest, MAX(rate) AS Greatest
FROM emps
WHERE City IN ('Brooks', 'Red Deer', 'St Albert')
GROUP BY City
--------------------------------------------------

##################################################
-- 5 | Count the amount of employees having rate value between 8-12 from each department. Result set column name should be Count. In addition, include department in the result set. Sort result set by Count column in ascending order.
--------------------------------------------------
SELECT dept, COUNT(*) AS Count
FROM emps
WHERE rate BETWEEN 8 AND 12
GROUP BY dept
ORDER BY Count ASC
--------------------------------------------------

##################################################
-- 6 | Create new usernames for employees using string functions. Username should include first two letters from firstname, last two letters from surname, employees employee number and department. For example, Sara Koo would have a username called "SAOO1A". Set column name as Username.
--------------------------------------------------
SELECT *, CONCAT(SUBSTRING(gname, 1, 2), RIGHT(surname, 2), empnum, dept) AS USERNAME
FROM emps
--------------------------------------------------

##################################################
-- 7 | Select all different surnames and present surnames in lowercase letters in the result set. Use column name To_lower. Order result set by surname in descending order.
--------------------------------------------------
SELECT DISTINCT surname, LOWER(surname) AS To_Lower
FROM emps
ORDER BY surname DESC
--------------------------------------------------

##################################################
-- 8 | Select employee firstname, surname and the length of gname (use column name gname_length). Include only employees whose firstname length is either 3, 5 or 7.
--------------------------------------------------
SELECT gname, surname, LENGTH(gname) AS gname_length
FROM emps
WHERE LENGTH(gname) IN (3, 5, 7)
--------------------------------------------------

##################################################
/* 9 | Categorize employees in the following manner:

    Department between A-C and rate between 6-8: Group A
    Department between D-F and rate between 9-11: Group B
    Department between G-I and rate between 12-14: Group C
    All other employees: Group D

Include columns gname, surname and a newly created column (use column name empcat) in the result set. Order the result set by categorization value in ascending order. */
--------------------------------------------------
SELECT gname, surname,
	CASE
    WHEN dept BETWEEN 'A' AND 'C' AND (rate BETWEEN 6 AND 8) THEN 'Group A'
	WHEN dept BETWEEN 'D' AND 'F' AND (rate BETWEEN 9 AND 11) THEN 'Group B'
    WHEN dept BETWEEN 'G' AND 'I' AND (rate BETWEEN 12 AND 14) THEN 'Group C'
    ELSE 'Group D'
    END AS empcat
FROM emps
ORDER BY empcat ASC
--------------------------------------------------

##################################################
-- 10 | If rate value would describe the monthly rate value for each employee, calculate how much would it be for each employee in daily basis 
-- (assume there will be 30 days in a month we are inspecting). Daily rate value should be presented with one decimal. Use column name daily_rate for 
-- the newly created column. Present employees empnum, gname, surname and calculated rate value in the result set.
--------------------------------------------------
SELECT empnum, gname, surname, ROUND(rate / 30, 1) AS daily_rate
FROM emps
GROUP BY empnum
--------------------------------------------------