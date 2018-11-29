use world;
#
#Выбрать все данные о городе.
select lct.locality_name,
       cn.country_name,
	   rn.region_name,
       ds.district_name
from world.localities lct
join world.countries cn
   on lct.country_id = cn.country_id
join world.regions rn
  on lct.region_id = rn.region_id
left join world.districts ds
       on lct.district_id = ds.district_id
where 1=1
      and lct.locality_name = 'Королёв';
#
#Выбрать все города из Московской области.
select lct.loacality_id,
	   lct.locality_name
from world.localities lct
join world.regions rn
  on lct.region_id = rn.region_id
     and rn.region_name = 'Московская область';
#
use employees;
#
#Выбрать среднюю зарплату по отделам.
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
#Выбрать максимальную зарплату у сотрудника за время его работы.
select -- first_name,
       -- last_name,
       max(salary)
from employees emp
join salaries sal
  on emp.emp_no = sal.emp_no
where 1=1
	  and first_name = 'Иван'
	  and last_name = 'Иванов';
#
#Удалить одного сотрудника, у которого максимальная зарплата.
delete from employees
where 1=1
      and emp_no = (select emp_no
                    from salaries sal
                    where 1=1
                          and curdate() between sal.from_date and sal.to_date
					order by salary desc
                    limit 1);
#
#Посчитать количество сотрудников во всех отделах.
select dept.dept_no,
	   dept.dept_name,
       count(de.emp_no)
from departments dept
join dept_emp de
   on dept.dept_no = de.dept_no
      and curdate() between de.from_date and de.to_date
group by dept.dept_no,
	     dept.dept_name
order by dept.dept_name;
#
#Найти количество сотрудников в отделах и посмотреть, сколько всего денег получает отдел.
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