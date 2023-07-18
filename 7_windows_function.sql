use internships;
create table employee(
id int,
salary decimal(10,2),
age int,
email_id varchar(100),
phone_number varchar(15),
location varchar(100)
);
INSERT INTO Employee (id, salary, age, phone_number, email_id, location)
VALUES (1, 50000, 37, '9837438787', 'kannan@example.com', 'srilanka');

INSERT INTO Employee (id, salary, age, phone_number, email_id, location)
VALUES (2, 30000, 35, '8988833849', 'oviya@example.com', 'Paris');

INSERT INTO Employee (id, salary, age, phone_number, email_id, location)
VALUES (3, 35000, 41, '7823892777', 'sparrow@example.com', 'New York');

INSERT INTO Employee (id, salary, age, phone_number, email_id, location)
VALUES (4, 40000, 28, '7647868747', 'priya@example.com', 'Berlin');

INSERT INTO Employee (id, salary, age, phone_number, email_id, location)
VALUES (5, 55000, 31, '5656565656', 'liya@example.com', 'india');

INSERT INTO Employee (id, salary, age, phone_number, email_id, location)
VALUES (6, 65000, 36, '7778889999', 'libiya@example.com', 'us');

INSERT INTO Employee (id, salary, age, phone_number, email_id, location)
VALUES (7, 70000, 39, '9994319631', 'raj@example.com', 'Greenland');

INSERT INTO Employee (id, salary, age, phone_number, email_id, location)
VALUES (8, 65000, 27, '9872347263', 'kumar@example.com', 'London');

INSERT INTO Employee (id, salary, age, phone_number, email_id, location)
VALUES (9, 92000, 33, '7866533546', 'madesh@example.com', 'New York');

INSERT INTO Employee (id, salary, age, phone_number, email_id, location)
VALUES (10, 58000, 37, '9834568700', 'aruna@example.com', 'Paris');

INSERT INTO Employee (id, salary, age, phone_number, email_id, location)
VALUES (2, 60000, 35, '7639369367', 'sharon@example.com', 'London');

INSERT INTO Employee (id, salary, age, phone_number, email_id, location)
VALUES (12, 48000, 26, '97157339252', 'daniel@example.com', 'us');

INSERT INTO Employee (id, salary, age, phone_number, email_id, location)
VALUES (13, 62000, 32, '984041271', 'libiya@example.com', 'New York');

INSERT INTO Employee (id, salary, age, phone_number, email_id, location)
VALUES (5, 56000, 30, '8148921824', 'jeno@example.com', 'Berlin');

INSERT INTO Employee (id, salary, age, phone_number, email_id, location)
VALUES (15, 70000, 35, '8838707308', 'magadhish@example.com', 'London');

INSERT INTO Employee (id, salary, age, phone_number, email_id, location)
VALUES (12, 53000, 31, '8508061437', 'raj@example.com', 'Paris');

INSERT INTO Employee (id, salary, age, phone_number, email_id, location)
VALUES (15, 53000, 31, '5554441250', 'vinoth@example.com', 'India');

INSERT INTO Employee (id, salary, age, phone_number, email_id, location)
VALUES (14, 95000, 31, '9994153568', 'pugazh@example.com', 'india');



select * from employee;

#Update the changes in the employee table as added in the SQL basics repository 
UPDATE employee SET salary = 78000.00 WHERE id = 5;

#Generate the consecutive numbers for each record locationswise
SELECT 
    id,
    age,
    email_id,
    location,
    phone_number,
    ROW_NUMBER() OVER (PARTITION BY location ORDER BY id) AS consecutive_number
FROM employee;

# From the employee tables derive a new table called employee_updated with no duplicates
CREATE TABLE employee_updated AS
SELECT id, age, email_id, phone_number, location
FROM (
    SELECT id,  age, email_id, phone_number, location,
           ROW_NUMBER() OVER (PARTITION BY phone_number, location ORDER BY id) AS row_num
    FROM employee
) AS temp
WHERE row_num = 1;
select*from employee_updated

# FRom the employee write a select query to get all the duplicate phone numbers
SELECT id,  age, email_id, phone_number, location
FROM (
    SELECT id, age, email_id, phone_number, location,
           COUNT(*) OVER (PARTITION BY phone_number) AS occurrences
    FROM employee
) AS temp
WHERE occurrences > 1;

#Implement a logic to show the difference between row_number and row_id
SELECT ROW_NUMBER() OVER (ORDER BY id) AS row_number, id, age
FROM employee;
SELECT ROWID AS row_id, id,  age
FROM employee;

#implement the different common table expressions to implement the below case statements
# Arrange the employees in increasing order of their salary
WITH SortedEmployee AS (
    SELECT id,  age, email_id, location, salary,
           ROW_NUMBER() OVER (ORDER BY salary) AS row_num
    FROM employee
)
SELECT id,  age, email_id, location, salary
FROM SortedEmployee
ORDER BY salary;
#Arrange the employees based on the increasing order of their salary location wise

WITH SortedEmployee AS (
    SELECT id,  age, email_id, location, salary,
           ROW_NUMBER() OVER (PARTITION BY location ORDER BY salary) AS row_num
    FROM employee
)
SELECT id,  age, email_id, location, salary
FROM SortedEmployee
ORDER BY location, salary;
# Pick the employee with the second-highest salary in each location
WITH RankedEmployee AS (
    SELECT id,  age, email_id, location, salary,
           ROW_NUMBER() OVER (PARTITION BY location ORDER BY salary DESC) AS row_num
    FROM employee
)
SELECT id,  age, email_id, location, salary
FROM RankedEmployee
WHERE row_num = 2;
# Pick the employee with least salary in each location
WITH RankedEmployee AS (
    SELECT id,  age, email_id, location, salary,
           ROW_NUMBER() OVER (PARTITION BY location ORDER BY salary) AS row_num
    FROM employee
)
SELECT id,  age, email_id, location, salary
FROM RankedEmployee
WHERE row_num = 1;