-- 서브쿼리(SUBQUERY) SQL 문제입니다.
	
-- 문제1.
-- 현재 전체 사원의 평균 급여보다 많은 급여를 받는 사원은 몇 명이나 있습니까?
SELECT 
    COUNT(*)
FROM
    salaries
WHERE
    salary < (SELECT 
            AVG(salary)
        FROM
            salaries
        WHERE
            salaries.to_date = '9999-01-01');

-- 문제2. 
-- 현재, 각 부서별로 최고의 급여를 받는 사원의 사번, 이름, 부서 급여을 조회하세요. 단 조회결과는 급여의 내림차순으로 정렬합니다.
SELECT 
    c.dept_name, a.first_name, d.salary
FROM
    employees a,
    dept_emp b,
    departments c,
    salaries d
WHERE
    a.emp_no = b.emp_no
        AND b.dept_no = c.dept_no
        AND a.emp_no = d.emp_no
        AND b.to_date = '9999-01-01'
        AND d.to_date = '9999-01-01'
        AND (b.dept_no , d.salary) IN (SELECT 
            a.dept_no, MAX(b.salary)
        FROM
            dept_emp a,
            salaries b
        WHERE
            a.emp_no = b.emp_no
                AND a.to_date = '9999-01-01'
                AND b.to_date = '9999-01-01'
        GROUP BY a.dept_no);

-- 문제3.
-- 현재, 사원 자신들의 부서의 평균급여보다 급여가 많은 사원들의 사번, 이름 그리고 급여를 조회하세요 
SELECT 
    employees.emp_no, employees.first_name, salary
FROM
    employees,
    (SELECT 
        a.dept_no, AVG(b.salary) AS avg_salary
    FROM
        dept_emp a, salaries b
    WHERE
        a.emp_no = b.emp_no
            AND a.to_date = '9999-01-01'
            AND b.to_date = '9999-01-01'
    GROUP BY a.dept_no) AS d,
    salaries
WHERE
    salaries.emp_no = employees.emp_no
        AND salary < d.avg_salary;

-- 문제4.
-- 현재, 사원들의 사번, 이름, 그리고 매니저 이름과 부서 이름을 출력해 보세요.
SELECT 
    a.emp_no,
    CONCAT(a.first_name, ' ', a.last_name) as name,
    CONCAT(d.first_name, ' ', d.last_name) as manage_name,
    e.dept_name
FROM
    employees a,
    dept_emp b,
    dept_manager c,
    employees d,
    departments e
WHERE
    a.emp_no = b.emp_no
        AND b.dept_no = c.dept_no
        AND d.emp_no = d.emp_no
        AND c.dept_no = e.dept_no
        AND b.to_date = '9999-01-01'
        AND c.to_date = '9999-01-01';

-- 문제5.
-- 현재, 평균급여가 가장 높은 부서의 사원들의 사번, 이름, 직책 그리고 급여를 조회하고 급여 순으로 출력하세요.
SELECT 
    e.emp_no, first_name, last_name, dept_name, salary
FROM
    employees e,
    dept_emp de,
    departments d,
    salaries s
WHERE
    de.emp_no = e.emp_no
        AND de.dept_no = d.dept_no
        AND e.emp_no = s.emp_no
        AND de.to_date = '9999-01-01'
        AND s.to_date = '9999-01-01'
        AND d.dept_no = (SELECT 
            d.dept_no
        FROM
            employees e,
            dept_emp de,
            departments d,
            salaries s
        WHERE
            de.emp_no = e.emp_no
                AND de.dept_no = d.dept_no
                AND e.emp_no = s.emp_no
                AND de.to_date = '9999-01-01'
                AND s.to_date = '9999-01-01'
        GROUP BY d.dept_no
        ORDER BY AVG(salary) DESC
        LIMIT 1)
ORDER BY salary DESC;

-- 문제6.
-- 현재, 평균 급여가 가장 높은 부서의 이름 그리고 평균급여를 출력하세요.
SELECT 
    dept_name, AVG(salary)
FROM
    employees e,
    dept_emp de,
    departments d,
    salaries s
WHERE
    e.emp_no = de.emp_no
        AND de.dept_no = d.dept_no
        AND s.emp_no = e.emp_no
GROUP BY d.dept_no
ORDER BY AVG(salary) DESC
LIMIT 1;

-- 문제7.
-- 현재, 평균 급여가 가장 높은 직책의 타이틀 그리고 평균급여를 출력하세요.
SELECT 
    title, AVG(salary)
FROM
    titles t,
    salaries s
WHERE
    t.emp_no = s.emp_no
GROUP BY title
ORDER BY AVG(salary) DESC
LIMIT 1;


  
