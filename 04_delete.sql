-- DELETE 문
-- DML 중 하나로 저장된 기존 데이터를 삭제하기위해
-- 사용하는 쿼리

-- DELETE FROM 테이블명
-- [WHERE 조건];  
-- where 절은 절대로 빼먹지 말자!!! 

DELETE 
FROM employees
WHERE emp_id = 100005
;