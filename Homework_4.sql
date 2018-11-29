CREATE OR REPLACE VIEW avg_departments_salary_v
(
	dept_no,
	dept_name,
    avg_salary
)
AS
select dept.dept_no,
	   dept.dept_name,
       avg(sal.salary)
from departments dept
join dept_emp de
   on dept.dept_no = de.dept_no
      and curdate() between de.from_date and de.to_date
join salaries sal
  on de.emp_no = sal.emp_no
     and curdate() between sal.from_date and sal.to_date
group by dept.dept_no,
	     dept.dept_name
order by dept.dept_name;
#
CREATE OR REPLACE VIEW max_employee_salaries_v
(
	emp_no,
    first_name,
    last_name,
	max_salary
)
AS
select emp_no,
       first_name,
       last_name,
       max(salary)
from employees emp
join salaries sal
  on emp.emp_no = sal.emp_no
group by emp_no,
         first_name,
		 last_name;
#         
CREATE OR REPLACE VIEW employees_cnt_by_dept_v
(
	dept_no,
    dept_name,
    employees_cnt
)
AS
select dept.dept_no,
	   dept.dept_name,
       count(de.emp_no)
from departments dept
join dept_emp de
   on dept.dept_no = de.dept_no
      and curdate() between de.from_date and de.to_date
group by dept.dept_no,
	     dept.dept_name;
#
CREATE OR REPLACE VIEW info_by_dept_v
(
	dept_no,
    dept_name,
    employees_cnt,
    salary_total
)
AS
select dept.dept_no,
	   dept.dept_name,
       count(de.emp_no),
       sum(sal.salary)
from departments dept
join dept_emp de
   on dept.dept_no = de.dept_no
      and curdate() between de.from_date and de.to_date
join salaries sal
  on de.emp_no = sal.emp_no
     and curdate() between sal.from_date and sal.to_date
group by dept.dept_no,
	     dept.dept_name
order by dept.dept_name;
#
# Создать функцию, которая найдет менеджера по имени и фамилии.
DELIMITER //
CREATE FUNCTION get_manager_no (p_first_name VARCHAR(14), p_last_name VARCHAR(16))
RETURNS INT
READS SQL DATA
BEGIN
	declare manager_no int;
    set manager_no = (
						select dm.emp_no
						from employees emp
						join dept_emp de
						  on emp.emp_no = de.emp_no
							 and curdate() between de.from_date and de.to_date
						join dept_manager dm
						  on de.dept_no = dm.dept_no
							 and curdate() between dm.from_date and dm.to_date
						where 1=1
							  and emp.first_name = p_first_name
                              and emp.last_name = p_last_name
					 );
	RETURN IFNULL(manager_no, 0);
END//
#
# Создать триггер, который при добавлении нового сотрудника будет выплачивать ему вступительный бонус, занося запись об этом в таблицу salary.
DELIMITER //
CREATE TRIGGER employees_ai_trg
AFTER INSERT 
ON employees FOR EACH ROW
BEGIN
	insert into salaries(emp_no, salary, from_date, to_date)
    values (new.emp_no, 5000, new.hire_date, new.hire_date);
END//