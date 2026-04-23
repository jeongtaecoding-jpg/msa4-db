-- 쿼리 작성 순서 기본 틀

-- SELECT [DISTINCT] [컬럼명]
-- FROM [테이블명]
-- WHERE [쿼리 조건]
-- GROUP BY [컬럼명] HAVING [집계함수 조건]
-- ORDER BY [컬럼명 ASC || 컬럼명 DESC]
-- LIMIT [n] OFFSET [n]
-- ;



-- SELECT 문
-- DML 중 하나로, 저장되어 있는 
-- 데이터를 조회하기 위해 사용하는 쿼리

-- 조회한 데이터 중 특정 컬럼만 출력
-- ``(백틱)으로 감싸면, 컬럼으로써 인식시킨다 라는 의미
SELECT 
	`name` -- name 은 예약어이기 때문에 ` `으로 감싼다.
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
WHERE fire_at IS NULL;


SELECT * 
FROM employees
WHERE fire_at IS NOT NULL;


-- 출생년도가  1990년인 사원을 출력해주세요.
SELECT *
FROM employees
WHERE birth >= '1990-01-01'
AND birth <= '1990-12-31'
;


-- 이름이 '김철수' 또는 '정유리'인 사원을 조회해주세요.
SELECT *
FROM employees
WHERE `name` = '조은혜'
OR `name` = '정유리'
;


-- 1990년 출생이거나, 이름이 정유리인 사원을 출력해주세요.
SELECT * 
FROM employees
WHERE ( birth >= '1990-01-01' AND birth <= '1990-12-31')
OR  `name` = '정유리'
;


-- BETWEEN 연산자: 지정한 범위 내의 데이터를 조회 
SELECT * 
FROM employees
WHERE birth BETWEEN '1990-01-01' AND '1990-12-31'
;


-- 사원번호가 10005, 10010인 사원을 조회해주세요.
SELECT * 
FROM employees
WHERE emp_id = 10005
OR emp_id = 10010
;
-- 데이터 타입은 문자열이면 ' '으로 감싸고 그냥 숫자면 숫자 그대로 적는 게 문법상 옳음


-- IN 연산자 : 다수의 지정한 값과 일치하는 데이터 조회
SELECT *
FROM employees
WHERE emp_id IN (10005, 10010)
;


-- LIKE절 : 문자열의 내용을 조회
--  % : 글자수와 상관없이 조회할 경우 사용
-- 이름에 우가 포함되어 있는 사원 조회
SELECT * 
FROM employees
WHERE `name` LIKE '%우%'
;
-- 이름이 우로 시작하는 사원 조회
SELECT * 
FROM employees
WHERE `name` LIKE '우%'
;


-- _ : 언더바의 개수만큼 글자수를 허용해서 조회 
SELECT * 
FROM employees
WHERE `name` LIKE '_우_'
;


-- ORDER BY 절 : 데이터를 정렬 
SELECT *
FROM employees 
ORDER BY `name`, birth DESC
;


-- LIMIT : 출력 갯수를 제한
-- 사번 오름차순으로 정렬된 상위 10명 조회해주세요.
SELECT * 
FROM employees 
ORDER BY emp_id
LIMIT 10
;


--  OFFSET : 시작의 위치(지정한 숫자 + 1)를 지정해줌
-- 조회 결과에서 21번째부터 10개를 조회
SELECT * 
FROM employees 
ORDER BY emp_id 
-- LIMIT 10 OFFSET 20 
-- ( 아래내용으로도 표현 가능)  

-- OFFSET 자리(왼쪽), LIMIT 자리(오른쪽)      단!  무조건 LIMIT를 넣어야함 (OFFSET은 문법상 틀림)
LIMIT 20, 10
;



-- 집계함수 
-- SUM(컬럼) : 해당 컬럼의 합계를 출력
-- MAX(컬럼) : 해당 컬럼의 값 중 최대값을 출력 
-- MIN(컬럼) : 해당 컬럼의 값 중 최소값을 출력
-- AVG(컬럼) : 해당 컬럼의 평균을 출력  
SELECT 
  SUM(salary) AS sum_sal,
  MAX(salary) AS max_sal,
  MIN(salary) AS ,
  AVG(salary) AS
FROM salaries
WHERE end_at IS NULL 
;


-- COUNT(컬럼명 //(또는) *) : 검색 결과의 레코드 수를 출력
--   * : 총 레코드 수를 반환
SELECT COUNT(*)
FROM employees
; 
--  컬럼명 : 검색 결과 중, 해당 컬럼의 값이 NULL이 아닌 레코드의 총 수를 출력  
SELECT COUNT(fire_at)
FROM employees
; 


-- 현재 받고있는 급여 중, 
-- 가장 많이 받는 급여와, 가장 적게 받는 급여를 출력해 주세요.
SELECT 
   MAX(salary) AS MAX, 
   MIN(salary) AS min
FROM salaries
WHERE end_at IS NULL
;


-- DISTINCT 키워드 : 검색결과에서 중복되는 레코드 없이 조회
SELECT DISTINCT emp_id 
FROM salaries
;



-- GROUP BY절, HAVING 절 
-- 그룹으로 묶어서 조회
-- 직책별 사원수
SELECT
   --  SELECT 절에 작성하는 컬럼은 
   --  GROUP BY 절에서 사용한 컬럼과
   --  집계함수만 작성해야 한다.(표준 문법)  
  title_code,
  COUNT(*) AS cnt
FROM title_emps
WHERE end_at IS NULL
GROUP BY title_code
;


-- 직책 코드에 `02`가 포함된 직책별 사원수
SELECT 
  title_code,
  COUNT(*)
FROM title_emps
WHERE end_at IS NULL 
GROUP BY title_code
HAVING title_code LIKE '%02%'
;

-- 직책별 사원수 중, 10000명 이상인 직책의 사원수를 출력
-- 10000명 이상 : 그룹핑 해야지만 계산 가능, 그리고 그 조건을 HAVING 절에 적어야 함.
SELECT 
  title_code,
  COUNT(*) cnt
FROM title_emps
WHERE end_at IS NULL 
GROUP BY title_code
HAVING cnt >= 10000
;







