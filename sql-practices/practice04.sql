-- 서브쿼리(SUBQUERY) SQL 문제입니다.
	
-- 문제1.
-- 현재 전체 사원의 평균 급여보다 많은 급여를 받는 사원은 몇 명이나 있습니까?
select count(*)
from salaries
where salary < (select avg(salary) from salaries where salaries.to_date = '9999-01-01');

-- 문제2. 
-- 현재, 각 부서별로 최고의 급여를 받는 사원의 사번, 이름, 부서 급여을 조회하세요. 단 조회결과는 급여의 내림차순으로 정렬합니다.
select c.dept_name, a.first_name, d.salary
from employees a, dept_emp b, departments c, salaries d
where a.emp_no = b.emp_no
and b.dept_no = c.dept_no
and a.emp_no = d.emp_no
and b.to_date = '9999-01-01'
and d.to_date = '9999-01-01'
and (b.dept_no, d.salary) in (
select a.dept_no, max(b.salary)
from dept_emp a, salaries b
where a.emp_no = b.emp_no
and a.to_date = '9999-01-01'
and b.to_date = '9999-01-01'
group by a.dept_no
);

-- 문제3.
-- 현재, 사원 자신들의 부서의 평균급여보다 급여가 많은 사원들의 사번, 이름 그리고 급여를 조회하세요 
select employees.emp_no, employees.first_name, salary
from employees, (
select a.dept_no, avg(b.salary) as avg_salary
from dept_emp a, salaries b
where a.emp_no = b.emp_no
and a.to_date = '9999-01-01'
and b.to_date = '9999-01-01'
group by a.dept_no
) as d, salaries
where salaries.emp_no = employees.emp_no
and salary < d.avg_salary;

-- 문제4.
-- 현재, 사원들의 사번, 이름, 그리고 매니저 이름과 부서 이름을 출력해 보세요.
with manager as (
select d.dept_no, first_name, last_name
from employees e
join dept_manager dm on dm.emp_no = e.emp_no
join departments d on dm.dept_no = d.dept_no
where dm.to_date = '9999-01-01'
)
select e.emp_no, concat(e.first_name, ' ', e.last_name) '사원이름', concat(m.first_name, ' ', m.last_name) '매니저이름', dept_name
from employees e
join dept_emp de on e.emp_no = de.emp_no
join departments d on de.dept_no = d.dept_no
join manager m on m.dept_no = d.dept_no
where de.to_date = '9999-01-01';

-- 문제5.
-- 현재, 평균급여가 가장 높은 부서의 사원들의 사번, 이름, 직책 그리고 급여를 조회하고 급여 순으로 출력하세요.
select e.emp_no, first_name, last_name, dept_name, salary
from employees e, dept_emp de, departments d, salaries s
where de.emp_no = e.emp_no
and de.dept_no = d.dept_no
and e.emp_no = s.emp_no
and de.to_date = '9999-01-01'
and s.to_date = '9999-01-01'
and d.dept_no = (
select d.dept_no
from employees e, dept_emp de, departments d, salaries s
where de.emp_no = e.emp_no
and de.dept_no = d.dept_no
and e.emp_no = s.emp_no
and de.to_date = '9999-01-01'
and s.to_date = '9999-01-01'
group by d.dept_no
order by avg(salary) desc
limit 1
)
order by salary desc;

-- 문제6.
-- 현재, 평균 급여가 가장 높은 부서의 이름 그리고 평균급여를 출력하세요.
select dept_name, avg(salary)
from employees e, dept_emp de, departments d, salaries s
where e.emp_no = de.emp_no
and de.dept_no = d.dept_no
and s.emp_no = e.emp_no
group by d.dept_no
order by avg(salary) desc
limit 1;

-- 문제7.
-- 현재, 평균 급여가 가장 높은 직책의 타이틀 그리고 평균급여를 출력하세요.
select title, avg(salary)
from titles t, salaries s
where t.emp_no = s.emp_no
group by title
order by avg(salary) desc
limit 1;
