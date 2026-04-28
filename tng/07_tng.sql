-- 1. 사원의 사원번호, 이름, 직급코드를 출력해 주세요.
SELECT 
	emp.emp_id
	,emp.`name`
	,tt.title_code
FROM employees emp
	JOIN title_emps tps
		ON emp.emp_id = tps.emp_id
	JOIN titles tt
		ON tps.title_code = tt.title_code
;


-- 2. 사원의 사원번호, 성별, 현재 연봉을 출력해 주세요.
SELECT 
	emp.emp_id
	,emp.gender
	,sal.salary
FROM employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
WHERE sal.end_at IS NULL 
;


-- 3. 10010 사원의 이름과 과거부터 현재까지 연봉 이력을 출력해 주세요.
SELECT 
	emp.`name`
	,sal.salary
FROM employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
WHERE emp.emp_id = 10010
;


-- 4. 사원의 사원번호, 이름, 소속부서명을 출력해 주세요.
SELECT 
	emp.emp_id
	,emp.`name`
	,dep.dept_name
FROM employees emp
	JOIN department_emps deps
		ON emp.emp_id = deps.emp_id
	JOIN departments dep
		ON deps.dept_code = dep.dept_code
;


-- 5. 현재 연봉의 상위 10위까지 사원의 사번, 이름, 연봉을 출력해 주세요.
SELECT 
	emp.emp_id
	,emp.`name`
	,sal.salary
FROM employees emp
	JOIN salaries sal
		ON sal.emp_id = emp.emp_id
WHERE sal.end_at IS NULL 
ORDER BY sal.salary DESC
LIMIT 10
;


-- 6. 현재 각 부서의 부서장의 부서명, 이름, 입사일을 출력해 주세요.
SELECT 
	dep.dept_name
	,emp.`name`
	,emp.hire_at	
FROM employees emp
	JOIN department_managers dema
		ON dema.emp_id = emp.emp_id
	JOIN departments dep
		ON dema.dept_code = dep.dept_code
;

-- 7. 현재 직급이 "부장"인 사원들의 연봉 평균을 출력해 주세요.
-- 7-1. (보너스)현재 각 부장별 이름, 연봉평균
SELECT 
	emp.`name`
	,AVG(salary) avg_sal
FROM employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
	JOIN title_emps tps
		ON emp.emp_id = tps.emp_id
	JOIN titles tt
		ON tt.title_code = tps.title_code
WHERE tt.title = '부장'
		AND sal.end_at IS NULL 
GROUP BY emp.emp_id
;

-- 8. 부서장직을 역임했던 모든 사원의 이름과 입사일, 사번, 부서번호(코드)를 출력해 주세요.
SELECT 
	emp.`name`
	,emp.hire_at
	,emp.emp_id
FROM employees emp
	JOIN department_managers dema
		ON dema.emp_id = emp.emp_id
;	

-- 9. 현재 각 직급별 평균연봉 중 60,000,000이상인 직급의 직급명, 평균연봉(정수)를을 평균연봉 내림차순으로 출력해 주세요.
SELECT 
	tt.title
	, AVG(sal.salary) avg_sal
FROM title_emps tps
	JOIN salaries sal
		ON sal.emp_id = tps.emp_id
	JOIN titles tt
		ON tt.title_code = tps.title_code
GROUP BY tt.title_code
HAVING avg_sal >= 60000000
ORDER BY avg_sal DESC
;


-- 10. 성별이 여자인 사원들의 직급별 사원수를 출력해 주세요.
SELECT 
	tt.title
	,COUNT(tt.title) cnt_title
FROM employees emp
	JOIN title_emps tmp
		ON emp.emp_id = tmp.emp_id
	JOIN titles tt
		ON tt.title_code = tmp.title_code
WHERE emp.gender = 'F'
GROUP BY tt.title
;
