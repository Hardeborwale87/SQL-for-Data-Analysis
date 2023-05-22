====== Exercise 4 - SQL Basics 3 ======

/*1 | Select employees whose address starts with number 9 and create a column where employee names are presented in a 
following format: Firstname First_letter_of_surname (For example SARA KOO -> SARA K). In addition for address and 
this new name column, present department and its duty in the result set. Order result set by department.*/
--------------------------------------------------
SELECT e.address, CONCAT(e.gname, ' ', SUBSTRING(e.surname, 1, 1)) Firstname_First_letter_of_surname, d.dept, d.duty 
FROM emps e
INNER JOIN dept d ON e.dept = d.dept
WHERE e.address LIKE '9%'
ORDER BY d.dept
--------------------------------------------------

##################################################
-- 2 | Select all departments and include also those departments where no one works. Include department and duty of 
-- department in the result set. (Please notice that by default all departments have employees so this query won't 
-- return any extra rows with default data!)
--------------------------------------------------
SELECT dept, duty 
FROM dept

SELECT d.dept, d.duty
FROM dept d
LEFT JOIN emps e ON d.dept = e.dept
GROUP BY d.dept

--------------------------------------------------

##################################################
/*3 | Select employees whose province (PROV) is either NJ, ON or BC and whose manager's name starts with B (for 
example Black D). Present employee number, gname, surname and province in the result set.*/
--------------------------------------------------
SELECT e.empnum, e.gname, e.prov, d.manager
FROM emps e
INNER JOIN dept d ON e.dept = d.dept
WHERE e.prov IN ('NJ', 'ON', 'BC')
AND manager LIKE 'B%'
--------------------------------------------------

##################################################
/* 4 | Select all managers whose department's budget is under 200000 and department they lead less than 10 employees. 
Present manager, budget and employee count in the result set. Order result set by employee count in descending order.*/
--------------------------------------------------
SELECT d.manager, d.budget, COUNT(e.dept) AS employee_count
FROM dept d
INNER JOIN emps e ON d.dept = e.dept
WHERE d.budget < 200000
AND e.empnum < 10
GROUP BY d.manager
ORDER BY employee_count 
--------------------------------------------------

##################################################
/*5 | Create two columns for the result set: One for employees so that employee name is presented in the following 
format: || Surname -- Firstname || (for example || Johnson -- Mike ||) and another which categorises employees in the
 following manner:

    Cat1: Employees employee number is between 1-100 and department's budget is 100000 at most
    Cat2: Employees employee number is between 101-300 and department's budget is between 100001 and 150000
    Cat3: All other employees belong here*/
--------------------------------------------------
SELECT CONCAT(e.surname, ' -- ', e.gname) AS 'Surname -- Firstname',
	CASE
    WHEN e.empnum BETWEEN '1' AND '100' AND (d.budget <= 100000) THEN 'Cat1'
	WHEN e.empnum BETWEEN '100' AND '300' AND (d.budget BETWEEN 100001 AND 150000) THEN 'Cat2'
    ELSE 'Cat3'
    END AS Category
FROM emps e
INNER JOIN dept d ON e.dept = d.dept
--------------------------------------------------

##################################################
/*6 | Use UNION to combine the following two queries: Select employees who live in Winnipeg or Didsbury and another 
query for employees whose surnames first letter is between A-M. Include department, firstname, surname, address and 
city in the result set.*/
--------------------------------------------------
SELECT dept, gname, surname, address, city
FROM emps
WHERE city IN ('Winnipeg', 'Didsbury')
UNION
SELECT dept, gname, surname, address, city
FROM emps
WHERE surname REGEXP '^[A-M]'
 
--------------------------------------------------

##################################################
/*7 | Use both UNION and JOIN and get the following information in one result set (use three different queries with UNION):

    Employees who work in department having budget between 50000-100000
    Employees whose address ends with RD
    Employees whose department ID (dept) has only on letter (length is 1)

The criteria presented below should be taken into consideration with the result set.

    Result set should include department, budget, address, employees firstname and surname as well as computer's identifier
    Result set should be in ascending order by department*/
--------------------------------------------------
SELECT d.dept, d.budget, e.address, e.gname, e.surname, e.pc
FROM dept d
JOIN emps e ON d.dept = e.dept
WHERE d.budget BETWEEN 50000 AND 100000
UNION
SELECT d.dept, d.budget, e.address, e.gname, e.surname, e.pc
FROM dept d
JOIN emps e ON d.dept = e.dept
WHERE e.address LIKE '%RD'
UNION
SELECT d.dept, d.budget, e.address, e.gname, e.surname, e.pc
FROM dept d
JOIN emps e ON d.dept = e.dept
WHERE LENGTH(d.dept) = 1
ORDER BY dept ASC
--------------------------------------------------

##################################################
-- 8 | Select employees working in departments Q-Z who have different rate value than any employees who work in 
-- department A. Tip: Use IN subquery!
--------------------------------------------------
SELECT *
FROM emps
WHERE dept IN ('Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z')
  AND rate NOT IN (
    SELECT DISTINCT rate
    FROM emps
    WHERE dept = 'A')
--------------------------------------------------

##################################################
-- 9 | Select employees whose firstname length is less than 5 and department's duty is same as the employee Alex Dettmer.
 -- Result set should include department, duty and the firstname and surname of employee.
--------------------------------------------------
SELECT d.duty, e.dept, e.gname, e.surname
FROM dept d
JOIN emps e ON e.dept = d.dept
WHERE CHAR_LENGTH(e.gname) < 5
AND d.duty IN (
	SELECT duty
    FROM dept
    WHERE gname = 'Alex' AND surname = 'Dettmer')
--------------------------------------------------

##################################################
-- 10 | Select firstname, surname and phone numbers of employees whose department's duty is any of the DIVs (DIV 1-15).
--------------------------------------------------
SELECT e.gname, e.surname, e.phone, d.duty
FROM emps e
JOIN dept d ON e.dept = d.dept
WHERE d.duty LIKE 'DIV%'
AND d.duty REGEXP '^DIV [1-9][0-5]?$'
--------------------------------------------------

##################################################
-- 11 | Select all employees whose rate value is more than the average of all rate values.
--------------------------------------------------
SELECT *
FROM emps
WHERE rate > (
    SELECT AVG(rate)
    FROM emps)
--------------------------------------------------