====== Exercise 2 - SQL Basics 1 ======

-- 1 | Select employees from department V who live in Villeneuve.
--------------------------------------------------

SELECT * FROM emps

SELECT surname, gname FROM emps
	WHERE dept = 'V' AND city = 'Villeneuve'

--------------------------------------------------

##################################################
-- 2 | Select firstname and lastname of employees whose surname doesn't start with letters A, R, S or T.
--------------------------------------------------

SELECT gname, surname FROM emps
WHERE surname NOT LIKE 'A%' 
	AND surname NOT LIKE 'R%'
		AND surname NOT LIKE 'S%'
			AND surname NOT LIKE 'T%'

--------------------------------------------------

##################################################
-- 3 | Select employees (firstname and lastname) whose employee number is not in range 100-200.
--------------------------------------------------

SELECT empnum, gname, surname from emps 
	WHERE empnum NOT BETWEEN 100 AND 200 

--------------------------------------------------

##################################################
-- 4 | Select employees whose rate value is between 6-8 and phone number ends in either number 1 or number 2.
--------------------------------------------------

SELECT empnum, dept, gname, surname, rate, phone FROM emps
	WHERE rate BETWEEN 6.00 AND 8.00
		AND (phone LIKE '%1'
			OR phone LIKE '%2')

--------------------------------------------------

##################################################
-- 5 | Select employees whose phonenumber's third number is 9 and who come from cities with name starting with letter G or E. Order the result set by phonenumber.
--------------------------------------------------

SELECT empnum, dept, gname, surname, phone, city FROM emps
	WHERE phone LIKE '__9%'
		AND (city LIKE 'g%' OR city LIKE 'e%')
			ORDER BY phone

--------------------------------------------------

##################################################
-- 6 | Select all different provinces (PROV) and show the result set in descending order.
--------------------------------------------------

SELECT DISTINCT prov FROM emps 
	ORDER BY prov DESC

--------------------------------------------------

##################################################
-- 7 | Select employees (firstname only) who live in Calmar, Banff or Boyle and whose address has avenue (AVE).
--------------------------------------------------

SELECT gname, city, address FROM emps
	WHERE city IN ('Calmar', 'Banff', 'Boyle')
		AND (address LIKE '%ave%')

--------------------------------------------------

##################################################
-- 8 | Select departments and managers, but show only thirty departments starting from twentieth row.
--------------------------------------------------

SELECT dept, manager FROM dept
	LIMIT 30 OFFSET 19

--------------------------------------------------

##################################################
-- 9 | Select departments with budget lower than 50000 or higher than 100000. Set budget column name as Limited and sort the result set by budget in descending order.
--------------------------------------------------

SELECT dept, budget AS Limited FROM dept
	WHERE budget < 50000.00 OR budget > 100000.00
		ORDER BY budget desc

--------------------------------------------------

##################################################
-- 10 | Select department and its duty for departments having HAMILTON J as a manager.
--------------------------------------------------

SELECT dept, duty FROM dept
	WHERE manager = 'Hamilton J'

--------------------------------------------------

##################################################
-- 11 | Select departments where manager name's second letter is A and duty is one of the divisions (DIV).
--------------------------------------------------

SELECT dept, manager, duty FROM dept
	WHERE manager LIKE '_A%'
		 AND (duty LIKE '%div%')

--------------------------------------------------

##################################################
-- 12 | Select departments with dept not being between F-M and budget should be either 16750, 18000, 57000, 120000 or 200000. Dept, manager and duty should be included in the result set.
--------------------------------------------------

SELECT dept, manager, duty, budget FROM dept
	WHERE dept NOT BETWEEN 'F' AND 'M'
		AND (budget IN (16750, 18000, 57000, 120000, 200000))

--------------------------------------------------

##################################################
-- 13 | Select employees whose taxcode is either 1 or 2 and either one of the following two conditions match: third character in address is either 6 or 8 or alternatively city's name starts with letter C.
--------------------------------------------------

SELECT empnum, surname, gname, taxcode, address, city FROM emps
	WHERE taxcode IN (1, 2)
		AND (address LIKE '__6%' OR address LIKE '__8%')
			OR (city LIKE 'C%')

--------------------------------------------------