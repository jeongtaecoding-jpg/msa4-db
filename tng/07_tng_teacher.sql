-- 1. 사원의 사원번호, 이름, 직급코드를 출력해 주세요.
SELECT 
	emp.emp_id
	,emp.`name`
	,tie.title_code
FROM employees emp
	JOIN title_emps tie
		ON emp.emp_id = tie.emp_id
			AND emp.fire_at IS NULL 
			AND tie.end_at IS NULL 
;

-- 2. 사원의 사원번호, 성별, 현재 연봉을 출력해 주세요.
-- emp.fire_at 을 넣는 게 좀 더 정확한 필터링이 가능함 
SELECT 
	emp.emp_id
	,emp.gender
	,sal.salary
FROM employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
WHERE 
		 emp.fire_at IS NULL 
	AND sal.end_at IS NULL 
;

-- 3. 10010 사원의 이름과 과거부터 현재까지 연봉 이력을 출력해 주세요.
SELECT 
	emp.`name`
	,sal.salary
FROM employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
			AND emp.emp_id = 10010
ORDER BY sal.start_at ASC
;


-- 4. 사원의 사원번호, 이름, 소속부서명을 출력해 주세요.
SELECT 
	emp.emp_id
	,emp.`name`
	,dept.dept_name
FROM employees emp
	JOIN department_emps depe
		ON	emp.emp_id = depe.emp_id
			AND depe.end_at IS NULL 
	JOIN departments dept
		ON depe.dept_code = dept.dept_code
			AND dept.end_at IS NULL 
WHERE emp.fire_at IS NULL 
ORDER BY emp.emp_id
;

-- 5. 현재 연봉의 상위 10위까지 사원의 사번, 이름, 연봉을 출력해 주세요.
SELECT 
	emp.emp_id
	,emp.`name`
	,sal.salary
FROM employees emp
	JOIN salaries sal 
		ON emp.emp_id = sal.emp_id
			AND sal.end_at IS NULL 
			AND emp.fire_at IS NULL 
ORDER BY sal.salary DESC 
LIMIT 10
;


-- 속도 개선 버전 ( 공간 복잡도는 증가할 수 있음)
SELECT 
	emp.emp_id
	,emp.`name`
	,tmp_sal.salary
FROM employees emp
	 JOIN (
	 	 SELECT 
	 	 	sal.emp_id
	 	 	,sal.salary
	 	 FROM salaries sal
	 	 WHERE 
	 	 	 sal.end_at IS NULL 
	 	 ORDER BY sal.salary DESC
	 	 LIMIT 10
	 ) tmp_sal
		 ON emp.emp_id = tmp_sal.emp_id
	 		 AND emp.fire_at IS NULL 
ORDER BY tmp_sal.salary DESC 
;

-- 6. 현재 각 부서의 부서장의 부서명, 이름, 입사일을 출력해 주세요.
SELECT 
	dept.dept_name
	,emp.`name`
	,emp.hire_at
FROM employees emp
	JOIN department_managers depm
		ON emp.emp_id = depm.emp_id
			AND emp.fire_at IS NULL 
			AND depm.end_at IS NULL 
	JOIN departments dept
		ON depm.dept_code = dept.dept_code
			AND dept.end_at IS NULL 
ORDER BY dept.dept_code ASC
;

-- 7. 현재 직급이 "부장"인 사원들의 연봉 평균을 출력해 주세요.
SELECT 
	tie.emp_id
	,AVG(sal.salary) avg_sal
FROM title_emps tie
	JOIN titles tit
		ON tie.title_code = tit.title_code
			AND tit.title = '부장'
			AND tie.end_at IS NULL 
	JOIN salaries sal 
		ON sal.emp_id = tie.emp_id
GROUP BY tie.emp_id
;

-- 7-1. (보너스)현재 각 부장별 이름, 연봉평균



-- 8. 부서장직을 역임했던 모든 사원의 이름과 입사일, 사번, 부서번호를 출력해 주세요.
SELECT 
	emp.`name`
	,emp.hire_at
	,emp.emp_id
	,depm.dept_code
FROM department_managers depm
	JOIN employees emp
		ON depm.emp_id = emp.emp_id
ORDER BY depm.dept_code, depm.start_at
;

-- 9. 현재 각 직급별 평균연봉 중 60,000,000이상인 직급의 직급명, 평균연봉(정수)를을 평균연봉 내림차순으로 출력해 주세요.
SELECT 
	tit.title
	,FLOOR(AVG(sal.salary)) avg_sal
FROM title_emps tie
	JOIN salaries sal
		ON tie.emp_id = sal.emp_id
			AND tie.end_at IS NULL 
			AND sal.end_at IS NULL 
	JOIN titles tit
		ON tie.title_code = tit.title_code
GROUP BY tie.title_code, tit.title
HAVING avg_sal >= 60000000
ORDER BY avg_sal DESC
;


-- 10. 성별이 여자인 사원들의 직급별 사원수를 출력해 주세요.
SELECT 
	tie.title_code
	,COUNT(*)
FROM employees emp
	JOIN title_emps tie
		ON emp.emp_id = tie.emp_id
			AND emp.fire_at IS NULL 
			AND tie.end_at IS NULL 
GROUP BY tie.title_code
ORDER BY tie.title_code
;


-- 성별이 남자와 여자 모두 
SELECT 
	tie.title_code
	,emp.gender
	,COUNT(*)
FROM employees emp
	JOIN title_emps tie
		ON emp.emp_id = tie.emp_id
			AND emp.fire_at IS NULL 
			AND tie.end_at IS NULL 
GROUP BY tie.title_code, emp.gender
ORDER BY emp.gender, tie.title_code
;


-- 전체 평균 급여보다 높은 급여를 받은 기록을 조회
SELECT
	emp.emp_id
	,emp.`name`
	,sal.salary
FROM salaries sal
	JOIN employees emp
		ON sal.emp_id = emp.emp_id
			AND emp.fire_at IS NULL 
WHERE 
	sal.salary >= (
		SELECT 
			AVG(sala.salary) avg_sal
		FROM salaries sala
		WHERE 
			sala.end_at IS NULL 
	)
	AND sal.end_at IS NULL 
ORDER BY sal.salary ASC
;	
	
	
-- 가장 높은 급여를 받은 이력이 있는 사원의 사번과 급여를 조회
SELECT 	
	sal.emp_id
	,sal.salary
FROM salaries sal
WHERE 
   sal.salary = (
		SELECT 
			MAX(salary)
		FROM salaries
	)
;	



