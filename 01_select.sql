-- SELECT 문
-- DML 중 하나로, 저장되어 있는 
-- 데이터를 조회하기 위해 사용하는 쿼리

-- 조회한 데이터 중 특정 컬럼만 출력
-- ``으로 감싸면, 컬럼으로써 인식시킨다 라는 의미
SELECT 
	`name` -- name 은 예약어이기 때문에 ` `로 감싼다.
	,gender
	,emp_id
FROM employees;


-- 테이블 전체 컬럼 조회: *(Asterisk)
-- 실행은 나누어진 쿼리들을 순서대로 실행한다.
-- 현재 쿼리 실행은 세미콜론(;)을 기준으로 나누어 실행한다.
SELECT *
FROM employees; 


-- WHERE 절 : 특정 컬럼의 값이 일치한 데이터만 조회
SELECT * 
FROM employees
WHERE emp_id = 10009;


SELECT * 
FROM employees
WHERE `name` = '김민수';


SELECT *
FROM employees
WHERE birth >= '1990-01-01';


SELECT * 
FROM employees
WHERE fire_at IS NOT NULL;





