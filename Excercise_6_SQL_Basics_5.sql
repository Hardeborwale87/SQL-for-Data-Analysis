====== Exercise 6 - SQL Basics 5 ======

1 | Insert three new rows into accounts table:
	- administrator type for employee 315 with priority number 100
	- normal type for employee 422 with priority number 50
	- guest type for employee 22 with priority number 20
--------------------------------------------------
INSERT INTO account (accountID, account_type, priority)
VALUES 
    (315, 'administrator', 100),
    (422, 'normal', 50),
    (22, 'guest', 20)
--------------------------------------------------

##################################################
2 | Change the account_type for employee 22 so that it will be normal.
--------------------------------------------------
UPDATE account
SET account_type = 'normal'
WHERE accountID = 22
--------------------------------------------------

##################################################
3 | Raise the priority number of employee 22 by 20 %.
--------------------------------------------------
UPDATE account
SET priority = priority * 1.2
WHERE accountID = 22
--------------------------------------------------

##################################################
4 | Create a new table called account_backup with similar structure as accounts table.
--------------------------------------------------
CREATE TABLE account_backup(
accountID INT NOT NULL,
account_type VARCHAR(50),
priority INT,
PRIMARY KEY (accountID));
--------------------------------------------------

##################################################
5 | Copy the content of accounts table to account_backup with one query.
--------------------------------------------------
INSERT INTO account_backup (accountID, account_type, priority)
SELECT accountID, account_type, priority
FROM account
--------------------------------------------------

##################################################
6 | Remove the rows referring to employee 422 from accounts and account_backup tables.
--------------------------------------------------
BEGIN
DELETE FROM account WHERE accountID = 422
DELETE FROM account_backup WHERE accountID = 422
COMMIT

--------------------------------------------------