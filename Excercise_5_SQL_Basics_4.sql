====== Exercise 5 - SQL Basics 4 ======

/*1 | Create a new table called account with the following columns:
    	- accountID (primary key)
        - account_type (account type: guest, normal, administrator)
    	- priority (whole number which describes user's priority)*/
--------------------------------------------------
CREATE TABLE account(
accountID INT NOT NULL,
account_type VARCHAR(50),
priority INT,
PRIMARY KEY (accountID));
--------------------------------------------------

##################################################
/*2 | Create a connection between account and emps tables (Tip: First think what column you should bring from emps table 
	and then create a new column for it). Use the following options in foreign key definition:
	- UPDATE CASCADE
	- DELETE NO ACTION*/
--------------------------------------------------
-- Create the emps table
CREATE TABLE emps (
  emp_id INT PRIMARY KEY,
  emp_name VARCHAR(50),
  emp_email VARCHAR(50)
);

-- Create the account table with a foreign key column
CREATE TABLE account (
  accountID INT PRIMARY KEY NOT NULL,
  account_type VARCHAR(50),
  emp_id INT,
  FOREIGN KEY (emp_id) REFERENCES emps(emp_id)
    ON UPDATE CASCADE
    ON DELETE NO ACTION
);
--------------------------------------------------

##################################################
-- 3 | Add a new column called last_update. The current date should be added automatically for this column when new data is inserted.
--------------------------------------------------
ALTER TABLE account 
ADD COLUMN last_update DATETIME
--------------------------------------------------

##################################################
-- 4 | Add automatic counter for accountID column so that this field value will be automatically generated each time a new data is inserted.
--------------------------------------------------
ALTER TABLE account
MODIFY COLUMN accountID INT NOT NULL AUTO_INCREMENT
--------------------------------------------------

##################################################
/*5 | Create input validation check with TRIGGER. The following check has to be made:
	- Account type must be one of the forementioned types: guest, normal or administrator.
	- Negative priority numbers as well as priority numbers above 100 should not be allowed.*/
--------------------------------------------------
CREATE TRIGGER account_input_validation
BEFORE INSERT ON account
FOR EACH ROW
BEGIN
    IF (account_type NOT IN ('guest', 'normal', 'administrator')) THEN
        SET MESSAGE_TEXT = 'Invalid account type.'
    END IF
    
    IF (priority < 0 OR priority > 100) THEN
        SET MESSAGE_TEXT = 'Priority number must be between 0 and 100.'
    END IF
END
--------------------------------------------------