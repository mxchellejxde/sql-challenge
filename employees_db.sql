-- create table employee
drop table employees;
create table employees (
	emp_no INTEGER PRIMARY KEY,
	emp_title_id VARCHAR(5) NOT NULL,
	birth_date DATE NOT NULL,
	first_name VARCHAR(100) NOT NULL,
	last_name VARCHAR(100) NOT NULL,
	sex VARCHAR(1),
	hire_date DATE NOT NULL
	);
select * from employees;

-- create table dept_emp
drop table dept_emp;
create table dept_emp(
	emp_no INTEGER,
	dept_no VARCHAR(4) NOT NULL
	);
select * from dept_emp;

-- create table departments
drop table departments;
create table departments (
	dept_no VARCHAR(4) PRIMARY KEY NOT NULL,
	dept_name VARCHAR(100) NOT NULL
	);
select * from departments;

-- create table salaries
drop table salaries;
create table salaries (
	emp_no INTEGER,
	salary INTEGER
	);
select * from salaries;

-- create table titles
drop table titles;
create table titles (
	title_id VARCHAR(5) PRIMARY KEY NOT NULL,
	title VARCHAR(100) NOT NULL
	);
select * from titles;
	
-- create table dept_manager
drop table dept_manager;
create table dept_manager(
	dept_no VARCHAR(4) NOT NULL,
	emp_no INTEGER
	);
select * from dept_manager;
	
-- 1. List the employee number, last name, first name, sex, and salary of each employee.
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees as e
INNER JOIN salaries as s ON e.emp_no=s.salary;

-- 2. List the first name, last name, and hire date for the employees who were hired in 1986.
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1986-12-31';

-- 3. List the manager of each department along with their department number, department name, employee number, last name, and first name.
SELECT dm.dept_no, d.dept_name, dm.emp_no, e.last_name, e.first_name
FROM dept_manager as dm
LEFT JOIN departments as d
on dm.dept_no = d.dept_no
LEFT JOIN employees as e
on dm.emp_no = e.emp_no;

-- 4. List the department number for each employee along with that employee’s employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name,e.first_name, d.dept_name, de.emp_no
FROM employees as e
LEFT JOIN dept_emp as de
on e.emp_no = de.emp_no
LEFT JOIN departments as d
on de.dept_no = d.dept_no;

-- 5. List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.
SELECT first_name, last_name, sex
FROM employees
WHERE left(last_name,1) = 'B' and first_name = 'Hercules';

-- 6. List each employee in the Sales department, including their employee number, last name, and first name.
SELECT e.emp_no, e.last_name, e.first_name
FROM departments as d
LEFT JOIN dept_emp as de
on d.dept_no = de.dept_no
LEFT JOIN employees as e
on de.emp_no = e.emp_no
WHERE d.dept_name = 'Sales';

-- 7. List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM departments as d
LEFT JOIN dept_emp as de
on d.dept_no = de.dept_no
LEFT JOIN employees as e
on de.emp_no = e.emp_no
WHERE (d.dept_name = 'Sales') or (d.dept_name = 'Development');

-- 8. List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).
SELECT last_name, count(last_name) as count
FROM employees
GROUP BY last_name
ORDER by count desc;