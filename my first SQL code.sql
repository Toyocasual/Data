--my first sql code

--use the employees_db databse
use  employees_db
--show all data from job history
select *
from job_history
--show just the column end date and employee_id 
select end_date as 'birth date' , employee_id
from job_history
--show all column in department
select *
from departments
--give the number of rows in the department table
select COUNT (*) as 'count rows'
  from departments
  --give the numbers of row in each column in the department table
select count (department_id) as 'count dept id', count (department_name) as 'count dept name', count (manager_id) as 'count manager', count (location_id) as 'count location'
  from departments
  --count the numbers of distinct values from the location_id column
  select count (distinct(location_id)) as 'distinct number'
  from departments
  --sort out the location_id column in ascending order
  select distinct(location_id)
  from departments
  order by location_id
  --sort out the location_id in descending order
  select distinct(location_id)
  from departments
  order by location_id desc
  --group the location_id and give the total counts of the department_id and sort the count in ascending order
  select location_id, count (department_id) as count_dept
  from departments
  group by location_id
  order by count_dept
  --group the location_id and sum all of the values in the department_id
   select location_id, sum (department_id) as sum_dept
  from departments
  group by location_id
  order by sum_dept
  --select all columns from the employee data 
  select *
  from employees
  --1.Display the minimum salary.
  select min(salary) as 'minimum salary'
  from employees
  --2.Display the highest salary.
   select max(salary) as 'maximum salary'
  from employees
  --3.Display the total salary of all employees
  select sum(salary) as 'sum of salary'
  from employees
  --4.Display the average salary of all employees.
  select AVG(salary) as 'average salary'
  from employees
  --5.a query to count the number of rows in the employee table. The result should be just one row.
  select count(*) as 'numbers of column'
  from employees
  --6.a query to count the number of employees that make commission.
  select count(commission_pct)
  from employees
   select count(commission_pct)
  from employees
  where commission_pct is not null
  --7.a query to count the number of employees’ first name column. 
  select count(first_name) as 'first name'
  from employees
  select count(commission_pct)
  from employees
  where commission_pct is not null
  --8.Display all employees that make less than Peter Hall.
  select salary
  from employees
  where first_name = 'peter' and last_name = 'hall'

select first_name, last_name, salary
from employees
where salary < (select salary
  from employees
  where first_name = 'peter' and last_name = 'hall')
 --9.Display all the employees in the same department as Lisa Ozer.
 
 select department_id
 from employees 
 where first_name = 'lisa' and last_name = 'ozer'
 select first_name , last_name , department_id
 from employees
 where department_id = ( select department_id
 from employees 
 where first_name = 'lisa' and last_name = 'ozer')
 --10.Display all the employees in the same department as Martha Sullivan and that make more than TJ Olson.
select salary
from employees
where first_name = 'tj' and last_name = 'olson'
 select department_id 
 from employees 
 where first_name = 'martha' and last_name = 'sullivan'
 select first_name , last_name ,department_id,salary
 from employees
 where department_id = ( select department_id 
 from employees
 where first_name = 'martha' and last_name='sullivan') and salary>(select salary
from employees
where first_name='tj' and last_name='olson')
--11.Display all the departments that exist in the departments table that are not in the employees’ table. Do not use a where clause.
select  distinct department_id from departments
select distinct department_id from employees
--first way with the where clause
select (department_id)
from departments
where department_id not in (select distinct(department_id)
from employees where department_id is not null);
--second way without the where clause
select department_id from departments
except
select department_id from employees
--12.Display all the departments that exist in department tables that are also in the employees’ table. Do not use a where clause.
--with the where clause
select department_id from departments
where department_id in (select department_id from employees);
--without the where clause
select department_id from departments
intersect 
select department_id from employees
--13.Display all the departments name, street address, postal code, city, and state of each department. Use the departments and locations table for this query.
select * from departments;
select * from locations;
SELECT department_name, street_address, postal_code, city, state_province, department_id 
from departments
left join locations 
on departments.location_id  = locations.location_id 
--14.Display the first name and salary of all the employees in the accounting departments. 
select first_name, salary,DEPARTMENT_ID
from employees
where department_id in (select department_id from departments where  department_name = 'ACCOUNTING')

--15.Display all the last name of all the employees whose department location id are 1700 and 1800.
select * from departments
select * from employees
select last_name, department_id
from employees
where department_id in ( select department_id from departments where location_id in (1700,1800))


SELECT last_name, em.department_id, location_id
FROM employees AS em
JOIN departments AS dep
ON em.department_id = dep.department_id
WHERE location_id IN (1700,1800);

--16.Display the phone number of all the employees in the Marketing department.
SELECT phone_number FROM employees
WHERE department_id = (SELECT department_id FROM departments
WHERE department_name = 'Marketing')
--17.Display all the employees in the Shipping and Marketing departments who make more than 3100.
SELECT first_name, last_name, salary, department_id
FROM employees
WHERE department_id IN
(SELECT department_id FROM departments WHERE department_name IN ('Shipping', 'Marketing'))
AND salary > 3100;

--18.Write an SQL query to print the first three characters of FIRST_NAME from employee’s table.

select SUBSTRING(first_name,1,3) 
from employees

SELECT SUBSTRING(first_name,1,3) AS emp_first3
FROM employees;

--19.Display all the employees who were hired before Tayler Fox.
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date < (SELECT hire_date
FROM employees
WHERE first_name = 'Tayler' AND last_name = 'Fox');

--20.Display names and salary of the employees in executive department. 
SELECT first_name, last_name, salary
FROM employees
WHERE department_id = (SELECT department_id FROM departments WHERE department_name = 'Executive');

--21. Display the employees whose job ID is the same as that of employee 141.
SELECT first_name, last_name, job_id
FROM employees
WHERE job_id = (SELECT job_id FROM employees WHERE employee_id = 141);

--22.For each employee, display the employee number, last name, salary, and salary increased by 15% and expressed as a whole number. Label the column New Salary.

select employee_id, last_name, salary,convert(int,(salary + (salary*15/100))) as 'new salary'
from employees

--23.Write an SQL query to print the FIRST_NAME and LAST_NAME from employees table into a single column COMPLETE_NAME. A space char should separate them
select first_name, last_name, concat( first_name,' ',last_name) as complete_name
from employees

--24.Display all the employees and their salaries that make more than Abel.ZZ
select first_name, last_name, employee_id, salary
from employees
where salary >(select salary from employees where last_name = 'Abel')
--25.Create a query that displays the employees’ last names and commission amounts. If an employee does not earn commission, put “no commission”. Label the column COMM.  
SELECT last_name, commission_pct,
(CASE WHEN commission_pct IS NULL THEN 'no commission'
    ELSE CONVERT(VARCHAR, commission_pct) END) AS COMM
FROM employees

--26.Create a unique listing of all jobs that are in department 80. Include the location of department in the output.
select * from jobs
select * from employees
select * from departments

SELECT DISTINCT job_id, dep.department_id, location_id
FROM employees AS emp
JOIN departments AS dep
ON emp.department_id = dep.department_id
WHERE dep.department_id = 80;

SELECT DISTINCT job_id, dep.department_id, dep.location_id, street_address
FROM employees AS emp
JOIN departments AS dep
ON emp.department_id = dep.department_id
JOIN locations AS loc
ON dep.location_id = loc.location_id
WHERE dep.department_id = 80;


--27.Write a query to display the employee’s last name, department name, location ID, and city of all employees who earn a commission.
select * from departments
select * from employees
select * from locations 

SELECT last_name, dept.department_name, dept.location_id, city, commission_pct
from employees as emp
left join departments as dept
on emp.department_id = dept.department_id
left join LOCATIONS as loc
on dept.location_id = loc.location_id
where commission_pct is not null


--28.Create a query to display the name and hire date of any employee hired after employee Davies.
select first_name, last_name, hire_date
from employees
where hire_date > (select hire_date from employees where last_name = 'Davies')
--29.Write an SQL query to show one row twice in results from a table.
select * from LOCATIONS
union all
select * from LOCATIONS
order by location_id
--30.Display the highest, lowest, sum, and average salary of all employees.Label the columns Maximum,
--Minimum, Sum, and Average, respectively. Round your results to the nearest whole number
select cast(max(salary) as int) as maximum, cast(min(salary) as int) as minimum, cast(sum(salary) as int) as 'sum', cast(avg(salary) as int) as average
from employees 
--31.Write an SQL query to show the top n (say 10) records of a table.
select top 10 * 
from LOCATIONS
--32.Display the MINIMUN, MAXIMUM, SUM AND AVERAGE salary of each job type.
select convert(int,(min(salary))) as minimum, convert(int,(max(salary))) as maximum, convert(int,(sum(salary))) as TOTAL, CONVERT(int,(avg(salary))) as AVERAGE, job_id
FROM EMPLOYEES 
GROUP BY job_id
order by total
--33.Display all the employees and their managers from the employees’ table.
SELECT emp.employee_id, emp.first_name, emp.last_name,emp.manager_id, man.first_name, man.last_name
FROM employees AS emp
LEFT JOIN employees AS man
ON emp.manager_id = man.employee_id


--34.Determine the number of managers without listing them. Label the column NUMBER of managers. Hint: use manager_id column to determine the number of managers.
select count(manager_id) as Number_of_managers
from employees
--35.Write a query that displays the difference between the HIGHEST AND LOWEST salaries. Label the column DIFFERENCE.
select max(salary) - min(salary) as 'Difference'
from employees
--36.Display the sum salary of all employees in each department.
select department_id, count(employee_id) as count_emp, sum(salary) as sum_of_salaries
from employees
group by department_id
ORDER BY count_emp

--37.Write a query to display each department's name, location, number of employees, and the average salary of employees in the department.
--Label the column NAME, LOCATION, NUMBER OF PEOPLE, respectively
select department_name as 'NAME',LOCATION_ID as 'location', count(employee_id) as 'NUMBER OF PEOPLE', AVG(SALARY)
FROM DEPARTMENTS
INNER JOIN employees
ON DEPARTMENTS.DEPARTMENT_ID = EMPLOYEES.DEPARTMENT_ID
GROUP BY DEPARTMENTS.department_name, DEPARTMENTS.location_id

--38.Write an SQL query to find the position of the alphabet (‘J’) in the first name column ‘Julia’ from employee’s table.
--39.. Create a query to display the employee number and last name of all employees who earns more than the average salary. Sort the result in ascending order of salary.
SELECT EMPLOYEE_ID, LAST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES)
ORDER BY SALARY
--40.Write a query that displays the employee number and last names of all employees who work in a department with any employees whose last name contains a letter U.
SELECT employee_id, last_name
FROM employees
WHERE department_id IN (SELECT department_id
FROM employees
WHERE last_name LIKE '%U%')
ORDER BY department_id;
--41.Display the last name, department number and job id of all employees whose department location ID is 1700.
SELECT LAST_NAME, D.DEPARTMENT_ID, JOB_ID, location_id
FROM EMPLOYEES AS E
LEFT JOIN DEPARTMENTS AS D
ON E.department_id = D.department_id
WHERE location_id = 1700
--42.Display the last name and salary of every employee who reports to king.
SELECT LAST_NAME, SALARY 
FROM employees
WHERE manager_id = (SELECT employee_id FROM EMPLOYEES WHERE FIRST_NAME = 'KING' OR LAST_NAME = 'KING')
--43.Display the department number, last name, job ID of every employee in Executive department.
SELECT DEPT.department_id, LAST_NAME, JOB_ID, DEPARTMENT_NAME
FROM EMPLOYEES AS EMP
LEFT JOIN departments AS DEPT
ON EMP.department_id = DEPT.department_id
WHERE DEPARTMENT_NAME = 'EXECUTIVE'
--44.) Display all last name, their department name and id from employees and department tables.
SELECT LAST_NAME, DEPARTMENT_NAME, EMPLOYEE_ID
FROM employees AS e
LEFT JOIN departments AS d
ON e.department_id = d.department_id;
--45.Display all the last name department name, id and location from employees, department, and locations tables.
SELECT last_name, department_name, e.department_id, d.location_id
FROM employees AS e
LEFT JOIN departments AS d
ON e.department_id = d.department_id
LEFT JOIN locations AS l
ON d.location_id = l.location_id;
--46.Write an SQL query to print all employee details from the employees table order by DEPARTMENT Descending.
SELECT * FROM EMPLOYEES
ORDER BY department_id DESC
--47.Write a query to determine who earns more than Mr. Tobias:
SELECT FIRST_NAME, LAST_NAME, SALARY
FROM employees
WHERE SALARY > (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'TOBIAS' OR LAST_NAME = 'TOBIAS')
--48.Write a query to determine who earns more than Mr. Taylor
SELECT concat(first_name,' ',last_name), salary FROM employees
WHERE SALARY > (SELECT max(salary) from employees where first_name = 'talor' or last_name = 'taylor') 
--49.Find the job with the highest average salary.
SELECT TOP 1 JOB_ID, CAST(AVG(SALARY) AS INT) AS AVERAGE_SALARY
FROM EMPLOYEES
GROUP BY job_id
ORDER BY AVERAGE_SALARY DESC
--50.Find the employees that make more than Taylor and are in department 80.
SELECT EMPLOYEE_ID, department_id FROM employees
WHERE department_id = 80 and SALARY > (SELECT max(salary) from employees where first_name = 'talor' or last_name = 'taylor') 
--51.Display all department names and their full street address.
select DEPARTMENT_NAME, STREET_ADDRESS
FROM DEPARTMENTS
LEFT JOIN LOCATIONS 
ON DEPARTMENTS.location_id = LOCATIONS.location_id
--52.Write a query to display the number of people with the same job.
SELECT COUNT(EMPLOYEE_ID) AS NO_OF_PEOPLE, JOB_ID
FROM EMPLOYEES
GROUP BY job_id
--53.Write an SQL query to fetch “FIRST_NAME” from employees table in upper case.
SELECT UPPER(FIRST_NAME) AS FIRST_NAME
FROM EMPLOYEES
--54.Display the full name and salary of the employee that makes the most in departments 50 and 80.
SELECT  CONCAT(FIRST_NAME,' ',LAST_NAME) AS 'FULL NAME', SALARY, DEPARTMENT_ID
FROM EMPLOYEES
WHERE SALARY IN ((SELECT MAX(SALARY) FROM EMPLOYEES WHERE department_id = 50), (SELECT MAX(SALARY) FROM EMPLOYEES WHERE department_id = 80)) 
--55.Display the department names for the departments 10, 20 and 30.
SELECT DEPARTMENT_NAME,DEPARTMENT_ID
FROM DEPARTMENTS
WHERE department_id IN  (10,20,30)
--56.Display all the manager id and department names of all the departments in United Kingdom (UK).
SELECT MANAGER_ID, DEPARTMENT_NAME, COUNTRY_ID
FROM DEPARTMENTS AS DEPT
LEFT JOIN LOCATIONS AS LOC
ON DEPT.location_id = LOC.location_id
WHERE country_id = 'UK'
--57.Display the full name and phone numbers of all employees who are not in location id 1700. 
SELECT  concat(FIRST_NAME, ' ', LAST_NAME) as 'FULL NAME', PHONE_NUMBER, LOCATION_ID
FROM EMPLOYEES AS EMP
LEFT JOIN DEPARTMENTS AS DEPT
ON EMP.department_id = DEPT.department_id
WHERE LOCATION_ID  <> 1700     
--58.Display the full name, department name and hire date of all employees that were hired after Shelli Baida.
SELECT FIRST_NAME, LAST_NAME, DEPARTMENT_NAME, HIRE_DATE
FROM EMPLOYEES AS EMP
LEFT JOIN DEPARTMENTS AS DEPT
ON EMP.department_id = DEPT.department_id
WHERE hire_date > (SELECT hire_date FROM EMPLOYEES WHERE FIRST_NAME = 'SHELLI' AND last_name = 'BAIDA')
--59.Display the full name and salary of all employees who make the same salary as Janette King.
SELECT FIRST_NAME, LAST_NAME, SALARY
FROM employees
WHERE SALARY = (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'JANETTE' AND LAST_NAME = 'KING')
--60.Display the full name hire date and salary of all employees who were hired in 2007 and make more than Elizabeth Bates.
SELECT FIRST_NAME, LAST_NAME, HIRE_DATE, SALARY
FROM EMPLOYEES
WHERE YEAR(hire_date) = 2007 AND SALARY > (SELECT SALARY FROM EMPLOYEES WHERE FIRST_NAME = 'ELIZABETH' AND LAST_NAME = 'BATES')
--61.Issue a query to display all departments whose average salary is greater than $8000. 
 with cte as  
   (SELECT DEPARTMENT_ID, CAST(AVG(SALARY) AS INT) AS AVERAGE
FROM EMPLOYEES
GROUP BY department_id)
select department_id, average from cte where AVERAGE > 8000
--62.Issue a query to display all departments whose maximum salary is greater than 10000.
with cte as 
(SELECT DEPARTMENT_ID, CAST(MAX(SALARY) AS INT) AS MAXIMUM
FROM EMPLOYEES
GROUP BY department_id)
select department_id, maximum from cte where maximum > 10000
--63.Issue a query to display the job title and total monthly salary for each job that has a total salary exceeding $13,000.
--Exclude any job title that looks like rep and sort the result by total monthly salary.
SELECT emp.job_id, job_title, SUM(salary) AS monthly_sal
FROM employees AS emp
JOIN jobs
ON emp.job_id = jobs.job_id
GROUP BY emp.job_id, job_title
having SUM(salary) > 13000 AND job_title NOT LIKE ('%rep%')
ORDER BY SUM(salary) DESC
--64.Issue a query to display the department id, department name, location id and city of departments 20 and 50.
SELECT DEPARTMENT_ID, DEPARTMENT_NAME, DEPT.LOCATION_ID, CITY
FROM DEPARTMENTS AS DEPT
LEFT JOIN LOCATIONS AS LOC
ON DEPT.location_id = LOC.location_id
WHERE department_id in (20,50)
--65.Issue a query to display the city and department name that are having a location id of 1400. 
SELECT CITY, DEPARTMENT_NAME
FROM LOCATIONS AS LOC
LEFT JOIN departments AS DEPT
ON LOC.location_id = DEPT.location_id
WHERE LOC.location_id = 1400
--66.Display the salary of last name, job id and salary of all employees whose salary is equal to the minimum salary.
SELECT LAST_NAME, JOB_ID, SALARY
FROM EMPLOYEES
WHERE SALARY = (SELECT MIN(SALARY) FROM employees)
--67.Display the departments who have a minimum salary greater that of department 50.
with cte
as (select department_id, min(salary) as min_salary
from employees 
group by department_id)
select department_id, min_salary from cte 
where min_salary > (select min_salary from cte where department_id = 50)
--68.Issue a query to display all employees who make more than Timothy Gates and less than Harrison Bloom.
with cte as 
(select concat(first_name, ' ',last_name) as full_name ,salary from employees where salary > (select salary from employees where first_name = 'timothy' and last_name = 'gates'))
select full_name, salary from cte 
where salary < (select salary from employees where first_name = 'harrison' and last_name = 'bloom')
order by salary
--69.Issue a query to display all employees who are in Lindsey Smith or Joshua Patel department, who make more than Ismael Sciarra and were hired in 2007 and 2008.
select concat(first_name, ' ', last_name) as full_name, department_id, hire_date from employees 
where department_id in (select department_id from employees where (first_name = 'lindsey' and last_name = 'smith') or (first_name = 'joshua' and last_name = 'patel')) and salary > (select salary from 
employees where first_name = 'ismael' and last_name = 'sciarra') and 
year(hire_date) in (2007,2008)
--70.Issue a query to display the full name, 10-digit phone number, salary, department name, street address, postal code, city, and state province of all employees.
select concat(first_name,' ',last_name) as full_name, phone_number,salary, department_name, street_address, postal_code, city, state_province
from employees as emp
left join departments as dept
on  emp.department_id = dept.department_id
left join LOCATIONS as loc 
on dept.location_id = loc.location_id
--71.Write an SQL query that fetches the unique values of DEPARTMENT from employees table and prints its length.
select distinct(department_name) as dist, len(department_name) as lenght from departments
--72.Write an SQL query to print all employee details from the Worker table order by FIRST_NAME Ascending.
select * from employees
order by first_name