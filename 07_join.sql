-- -----------------------------------
-- JOIN문
-- 두 개 이상의 테이블을 묶어서 하나의 결과 집합으로 출력
-- -----------------------------------



-- -----------------------------------
-- INNER JOIN (교집합)
-- 복수의 테이블이 공통적으로 만족하는 테이블을 출력
-- -----------------------------------

-- 전 사원의 사번, 이름, 현재급여를 출력해주세요.

-- 표준 문법
SELECT 
	emp.emp_id
	,emp.`name`
	,sal.salary
FROM employees emp 
   JOIN salaries sal
		ON emp.emp_id = sal.emp_id
--    AND sal.end_at IS NULL  ==> where 절 대신에 이것도 가능 
WHERE 
	sal.end_at IS NULL 
;

-- 옛날 문법
SELECT 
	emp.emp_id
	,emp.`name`
	,sal.salary
FROM employees emp, salaries sal
WHERE 
		emp.emp_id = sal.emp_id
	AND sal.end_at IS NULL  
;


-- 재직중인 사원의 사번, 이름, 생일, 부서명
SELECT 
	emp.emp_id
	,emp.`name`
	,emp.birth
	,dept.dept_name
FROM employees emp
	JOIN department_emps dee
		ON emp.emp_id = dee.emp_id
			AND dee.end_at IS NULL 
	JOIN departments dept 
		ON dee.dept_code = dept.dept_code
;


-- -----------------------------------
-- LEFT JOIN
-- -----------------------------------
SELECT 
	*
FROM employees emp
	LEFT JOIN salaries sal
		ON emp.emp_id = sal.emp_id
			AND sal.end_at IS NULL 
;


-- -----------------------------------
-- UNION
-- 두 개 이상의 쿼리의 결과를 합쳐서 출력
-- UNION        (중복 레코드 제거)
-- UNION ALL    (중복 레코드 제거 안함)
-- -----------------------------------
SELECT * FROM employees WHERE emp_id IN (1, 3)
UNION ALL 
SELECT * FROM employees WHERE emp_id IN (1, 5);



-- -----------------------------------
-- SELF JOIN
-- 같은 테이블 끼리 join
-- -----------------------------------
SELECT 
	emp.emp_id
	,emp.`name`
	,supe.*
FROM employees emp 
	JOIN employees supe
		ON emp.sup_id = supe.emp_id
			AND emp.sup_id IS NOT NULL 
;