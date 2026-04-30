-- 문제 1. 직원(퇴사자 포함)의 이름과 입사일을 조회하세요.
SELECT 
	`name`
	,hire_at
FROM employees
;


-- 문제 2. `d005` 부서에 속한 현재 재직 중인 직원의 직원 ID를 조회하세요.
SELECT 
	emp_id
FROM department_emps 
WHERE 
   dept_code = 'D005'
	AND end_at IS NULL 
;

-- 문제 3. 1995년 1월 1일 이후(그 시점도 포함)에 입사한 직원(퇴사자 포함)의 정보를 입사일 순서대로 정렬하여 조회하세요.
SELECT 
	*
FROM employees
WHERE 
	hire_at >= '1995-01-01'
ORDER BY hire_at 
;


-- 문제 4. 현재 각 부서별로 몇 명의 직원이 있는지 계산하고, 직원 수가 많은 부서부터 순서대로 조회하세요.
SELECT 
	dept_code
	,COUNT(*) cnt 
FROM department_emps
WHERE 
	end_at IS NULL 
GROUP BY dept_code
ORDER BY COUNT(*) DESC 
;

-- 문제 5. 재직 중인 각 직원의 현재 연봉 정보를 조회하세요.
SELECT 
	sal.salary
	,emp.*
FROM employees emp
	JOIN salaries sal
		ON emp.emp_id = sal.emp_id
			AND sal.end_at IS NULL 
			AND emp.fire_at IS NULL 
;


-- 문제 6. 재직 중인 각 직원의 이름과 해당 직원의 현재 부서 이름을 함께 조회하세요.
SELECT
	emp.`name`
	,dep.dept_name
FROM employees emp 
	JOIN department_emps dee
		ON emp.emp_id = dee.emp_id
	JOIN departments dep
		ON dee.dept_code = dep.dept_code
WHERE 
	emp.fire_at IS NULL 
	AND dee.end_at IS NULL 
;


-- 문제 7. `마케팅부` 부서의 현재 매니저의 이름을 조회하세요.
SELECT
	emp.`name`
	,dep.dept_name
FROM employees emp 
	JOIN department_managers dem
		ON emp.emp_id = dem.emp_id
	JOIN departments dep
		ON dem.dept_code = dep.dept_code
WHERE 
	emp.fire_at IS NULL 
	AND dem.end_at IS NULL 
	AND dep.dept_name = '마케팅부'
;


-- 문제 8. 현재 재직 중인 각 직원의 이름, 성별, 직책(title)을 조회하세요.
SELECT 
	emp.`name`
	,emp.gender
	,tit.title
FROM employees emp
	JOIN title_emps tie
		ON emp.emp_id = tie.emp_id
	JOIN titles tit
		ON tit.title_code = tie.title_code
WHERE 
	tie.end_at IS NULL 
	AND emp.fire_at IS NULL 
;


-- 문제 9. 현재 가장 높은 연봉을 받는 상위 5명의 직원 ID와 연봉을 조회하세요.
SELECT 
	emp_id
	,salary
FROM salaries 
WHERE 
	end_at IS NULL 
ORDER BY salary DESC 
LIMIT 5
;


-- 문제 10. 각 부서의 현재 평균 연봉을 계산하고, 평균 연봉이 43,500,000 이상인 부서만 조회하세요.
SELECT 
	dee.dept_code
	,AVG(sal.salary) avg_sal
FROM department_emps dee
	JOIN salaries sal
		ON dee.emp_id = sal.emp_id
WHERE 
	dee.end_at IS NULL 
	AND sal.end_at IS NULL 
GROUP BY dee.dept_code
HAVING AVG(sal.salary) >= 43500000
;






-- 문제 11. 아래 구조의 테이블을 생성하는 SQL을 작성하세요.
CREATE TABLE users(
	user_id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT 
	,user_name VARCHAR(30) NOT NULL 
	,auth_flg CHAR(1) DEFAULT '0'
	,birthday DATE NOT NULL 
	,created_at DATETIME DEFAULT CURRENT_TIMESTAMP()
);


-- 문제 12. 문제11에서 만든 테이블에 아래 데이터를 입력하는 SQL을 작성하세요.
-- DEFAULT 되어 있는건 따로 안 넣고 생략해도 상관 없다. 
-- PK(user_id) 에 AUTO_INCREMENT 되어있는 건 따로 값을 절대로 넣지 마라!
INSERT INTO users(
	user_name
	,birthday
)
VALUES(
	'그린'
	,'2024-01-26'
);


-- 문제 13. [문제 12] 에서 입력한 레코드를 아래 데이터로 갱신하는 SQL을 작성하세요.
-- | 항목 | 값 |
-- |---|---|
-- | user_name | `'테스터'` |
-- | auth_flg | `'1'` |
-- | birthday | `2007-03-01` |

-- where 절에는 반드시 PK 로 해야 한다! (아무리 하나밖에들 없더라도 user_name 같은 걸로는 금지!!)
UPDATE users
SET 
	user_name = '테스터'
	,auth_flg = '1'
	,birthday = '2007-03-01'
WHERE 
	user_id = 1
;


-- 문제 14. [문제 12]에서 입력한 레코드를 삭제하는 SQL을 작성하세요.
delete FROM users
WHERE 
	user_id = 1 
;


-- 문제 15. [문제 11]에서 만든 테이블에 아래 컬럼을 추가하는 SQL을 작성하세요.
-- | Column Name | Data Type | Note |
-- |---|---|---|
-- | `addr` | `VARCHAR(100)` | NOT NULL, DEFAULT `'-'` |
ALTER TABLE users 
ADD COLUMN addr VARCHAR(100) NOT NULL DEFAULT '-'
; 


-- 문제 16. [문제 11]에서 만든 테이블을 삭제하는 SQL을 작성하세요.
DROP TABLE users;



-- 문제 17. 아래 두 테이블에서 **유저명(username), 생일(birthday), 랭크명(rankname)** 을 
-- 조회하는 SQL을 작성하세요.
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


-- rankmanagement가 안 만들어져 있어서 실행은 안 됨!
SELECT 
	usr.user_name
	,usr.birthday
	,rkm.rankname
FROM users rsr
	JOIN rankmanagement rkm	
		ON rsr.userid = rkm.userid
;

