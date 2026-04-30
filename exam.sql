-- 직원(퇴사자 포함)의 이름과 입사일을 조회하세요.
SELECT 
	emp.`name`
	,emp.hire_at 
FROM employees emp
;


-- `d005` 부서에 속한 현재 재직 중인 직원의 직원 ID를 조회하세요.
SELECT 
	emp.emp_id
FROM employees emp
	JOIN department_emps depe
		ON emp.emp_id = depe.emp_id
			AND emp.fire_at IS NULL 
			AND depe.dept_code = 'D005'
			AND depe.end_at IS NULL 
;


-- 1995년 1월 1일 이후에 입사한 직원(퇴사자 포함)의 정보를 입사일 순서대로 정렬하여 조회하세요.
SELECT 
	*
FROM employees emp
WHERE emp.hire_at > '1995-01-01'
ORDER BY emp.hire_at ASC 
;


-- 현재 각 부서별로 몇 명의 직원이 있는지 계산하고, 직원 수가 많은 부서부터 순서대로 조회하세요.
SELECT 
	deps.dept_name
	,COUNT(deps.dept_name) cnt_dept_name
FROM department_emps depe
	JOIN departments deps
		ON deps.dept_code = depe.dept_code
			AND deps.end_at IS NULL 
			AND depe.end_at IS NULL 
GROUP BY deps.dept_name
ORDER BY cnt_dept_name DESC 
;


-- 재직 중인 각 직원의 현재 연봉 정보를 조회하세요.
SELECT 
	emp.`name`
	,sal.salary
FROM employees emp
	JOIN salaries sal 
		ON emp.emp_id = sal.emp_id 
			AND emp.fire_at IS NULL 
			AND sal.end_at IS NULL 
;


-- 재직 중인 각 직원의 이름과 해당 직원의 현재 부서 이름을 함께 조회하세요.
SELECT 
	emp.`name`
	,deps.dept_name
FROM employees emp
	JOIN department_emps depe
		ON emp.emp_id = depe.emp_id
			AND emp.fire_at IS NULL 
			AND depe.end_at IS NULL 
	JOIN departments deps
		ON depe.dept_code = deps.dept_code
			AND deps.end_at IS NULL 
;

-- `마케팅부` 부서의 현재 매니저의 이름을 조회하세요.
SELECT 
	emp.`name`
FROM employees emp
	JOIN department_managers dema
		ON emp.emp_id = dema.emp_id
			AND emp.fire_at IS NULL 
			AND dema.end_at IS NULL 
	JOIN departments deps
		ON deps.dept_code = dema.dept_code
			AND deps.dept_name = '마케팅부'
;
-- 현재 재직 중인 각 직원의 이름, 성별, 직책(title)을 조회하세요.
SELECT 
	emp.`name`
	,emp.gender
	,tit.title
FROM title_emps tie
	JOIN employees emp
		ON emp.emp_id = tie.emp_id
			AND emp.fire_at IS NULL 
			AND tie.end_at IS NULL 
	JOIN titles tit
		ON tit.title_code = tie.title_code
;
-- 현재 가장 높은 연봉을 받는 상위 5명의 직원 ID와 연봉을 조회하세요.
SELECT 
	emp.emp_id
	,sal.salary
FROM employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
			AND emp.fire_at IS NULL 
			AND sal.end_at IS NULL 
ORDER BY sal.salary DESC
LIMIT 5			
;


-- 각 부서의 현재 평균 연봉을 계산하고, 평균 연봉이 43,500,000 이상인 부서만 조회하세요.
SELECT 
	floor(AVG(sal.salary)) avg_sal
	,depa.dept_name
FROM department_emps deps
	JOIN salaries sal
		ON deps.emp_id = sal.emp_id
			AND sal.end_at IS NULL 
			AND deps.end_at IS NULL 
	JOIN departments depa
		ON depa.dept_code = deps.dept_code
			AND depa.end_at IS NULL 
GROUP BY depa.dept_name			
HAVING avg_sal >= 43500000	
;

-- 문제 11. 아래 구조의 테이블을 생성하는 SQL을 작성하세요.
-- 
-- **Table Name**: `users`
-- 
-- | Column Name | Data Type | Note |
-- |---|---|---|
-- | `user_id` | `INT` | PRIMARY KEY, AUTO INCREMENT, UNSIGNED |
-- | `user_name` | `VARCHAR(30)` | NOT NULL |
-- | `auth_flg` | `CHAR(1)` | DEFAULT `'0'` |
-- | `birthday` | `DATE` | NOT NULL |
-- | `created_at` | `DATETIME` | DEFAULT 현재 날짜·시각 |
CREATE TABLE users (
	user_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT 
	,user_name VARCHAR(30) NOT NULL 
	,auth_flg CHAR(1) DEFAULT '0'
	,birthday DATE NOT NULL 
	,created_at DATETIME DEFAULT CURRENT_TIMESTAMP()
);

-- 문제 12. 문제11에서 만든 테이블에 아래 데이터를 입력하는 SQL을 작성하세요.
-- | 항목 | 값 |
-- |---|---|
-- | user_id | 자동 증가 |
-- | user_name | `'그린'` |
-- | auth_flg | `'0'` |
-- | birthday | `2024-01-26` |
-- | created_at | 오늘 날짜 |
INSERT INTO users (
  user_id
 ,user_name
 ,auth_flg 
 ,birthday 
 ,created_at 
)
VALUES(
  100 
 ,'그린' 
 ,'0' 
 ,'2024-01-26'
 ,NOW() 
);


-- 문제 13. [문제 12] 에서 입력한 레코드를 아래 데이터로 갱신하는 SQL을 작성하세요.
-- | 항목 | 값 |
-- |---|---|
-- | user_name | `'테스터'` |
-- | auth_flg | `'1'` |
-- | birthday | `2007-03-01` |
ALTER TABLE 



-- 문제 14. [문제 12]에서 입력한 레코드를 삭제하는 SQL을 작성하세요.
TRUNCATE TABLE users;



-- 문제 15. [문제 11]에서 만든 테이블에 아래 컬럼을 추가하는 SQL을 작성하세요.
-- | Column Name | Data Type | Note |
-- |---|---|---|
-- | `addr` | `VARCHAR(100)` | NOT NULL, DEFAULT `'-'` |
ALTER TABLE users ADD COLUMN addr VARCHAR(100) NOT NULL DEFAULT '-';


-- 문제 16. [문제 11]에서 만든 테이블을 삭제하는 SQL을 작성하세요.
DROP TABLE users;



-- 아래 두 테이블에서 **유저명(username), 생일(birthday), 랭크명(rankname)** 을 조회하는 SQL을 작성하세요.
-- 
-- - `rankmanagement`의 FK인 `userid`는 `users`의 `userid`를 참조
-- 
-- **Table: users**
-- 
-- | userid (PK) | username | authflg | birthday | createdat |
-- |---|---|---|---|---|
-- | 1 | green | 0 | 2024-01-26 | 2024-01-26 10:51:27 |
-- 
-- **Table: rankmanagement**
-- 
-- | rankid (PK) | userid (FK) | rankname |
-- |---|---|---|
-- | 1 | 1 | manager |
