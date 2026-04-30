-- 전 사원의 사번, 이름, 현재 급여를 출력해주세요. 

SELECT 
	emp.emp_id
	,emp.`name`
	,sal.salary
FROM employees emp
	INNER JOIN salaries sal
		ON emp.emp_id = sal.emp_id
--  ON 절에 추가로 조건을 달아줄 때 AND를 씀
			AND emp.fire_at IS NULL 
			AND sal.end_at IS NULL 
						
-- 	LEFT JOIN salaries sal
-- 		ON emp.emp_id = sal.emp_id 
-- 			AND sal.end_at IS NULL 
-- WHERE emp.fire_at IS NULL 
ORDER BY emp.emp_id DESC 
;


SELECT 
	COUNT(fire_at)
	,COUNT(*)
FROM employees 
;









