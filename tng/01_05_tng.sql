-- 1. 직급테이블의 모든 정보를 조회해주세요.
SELECT *
FROM titles
;


-- 2. 급여가 60,000,000 이하인 사원의 사번을 조회해 주세요.
SELECT sal.emp_id
FROM salaries AS sal 		 
WHERE sal.salary <= 60000000
		 AND sal.end_at IS NULL 
;


-- 3. 급여가 60,000,000에서 70,000,000인 사원의 사번을 조회해 주세요.
SELECT sal.emp_id
FROM salaries AS sal 		 
WHERE (sal.salary >= 60000000 AND sal.salary <= 70000000)
		 AND sal.end_at IS NULL 
;


-- 4. 사원번호가 10001, 10005인 사원의 사원테이블의 모든 정보를 조회해 주세요.
SELECT *
FROM employees
WHERE emp_id = 10001
OR emp_id = 10005
;



-- 5. 직급에 '사'가 포함된 직급코드와 직급명을 조회해 주세요.
SELECT titles.title_code, titles.title
FROM titles
HAVING titles.title LIKE '%사%'
;


-- 6. 사원 이름 오름차순으로 정렬해서 조회해 주세요.
SELECT emp.`name`
FROM employees AS emp
ORDER BY emp.`name`
;


-- 7. 사원별 전체 급여의 평균을 조회해 주세요.
SELECT AVG(salary)
FROM salaries AS sal
GROUP BY emp_id
;


-- 8. 사원별 전체 급여의 평균이 30,000,000 ~ 50,000,000인,
--   사원번호와 평균급여를 조회해 주세요.
SELECT emp_id, AVG(salary) 
FROM salaries
WHERE end_at IS NULL
GROUP BY emp_id
HAVING AVG(salary) >= 30000000 AND AVG(salary) <= 50000000
;


-- 9. 사원별 전체 급여 평균이 70,000,000이상인,
--   사원의 사번, 이름, 성별을 조회해 주세요.
SELECT emp_id, `name`, gender 
FROM employees 
WHERE emp_id IN  (
   SELECT sal.emp_id
	FROM salaries AS sal 
	WHERE end_at IS NULL 
	GROUP BY emp_id
	HAVING AVG(salary) >= 70000000
 )
;

-- 10. 현재 직급이 'T005'인,
--   사원의 사원번호와 이름을 조회해 주세요.
SELECT emp_id, `name`
FROM employees 
WHERE emp_id IN (
	SELECT department_emps.emp_id