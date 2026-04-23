-- update 문
-- DML 중 하나로 저장되어 있는 기존 데이터를
-- 수정하기 위해 사용하는 쿼리
-- UPDATE 테이블명
-- SET 
--   컬럼1 = 값1
--  ,컬럼2 = 값2
--  [...]
-- [WHERE 조건];


UPDATE employees
SET 
  `name` = '반장님'
WHERE 
	emp_id = 100005
;  


--  휴먼 에러를 줄이기 위해 update ~ set 부분을 지우고
-- select 문을 대신 써서 결과를 확인한 뒤 
-- update 문을 집어 넣을 때도 set 보다 
-- where 절을 먼저 써서 실수를 방지하자.
update employees
SET `name` = 
WHERE emp_id = 100005
;  



-- 100005번 사원의 생일을 '2020-01-01', 이름을 '마이콜'로 변경해주세요. 

UPDATE employees 
SET `name` = '마이콜',
     birth = '2020-01-01'
WHERE emp_id = 100005
;




