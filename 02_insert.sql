-- INSERT 문
-- DML 중 하나로 신규 데이터를 저장하기 위해 사용하는 쿼리

-- INSERT INTO 테이블명 [(컬럼1, 컬럼2...)]
-- VALUES (값1, 값2...);
INSERT INTO employees (
 `name`,
  birth,
  gender,
  hire_at,
  fire_at,
  sup_id,
  created_at,
  updated_at
)
VALUES (
  '김민수',
  '1999-12-23',
  'M',
  NOW(),
  NULL,
  NULL,
  NOW(),
  NOW()
), (
  '김정욱',
  '1995-06-01',
  'M',
  NOW(),
  NULL,
  NULL,
  NOW(),
  NOW()
), (
  '김정태',
  '2001-06-01',
  'M',
  NOW(),
  NULL,
  NULL,
  NOW(),
  NOW()
);



SELECT *
FROM employees
ORDER BY emp_id DESC 
LIMIT 10
;



INSERT INTO title_emps (
  emp_id,
  title_code,
  start_at,
  end_at,
  created_at,
  updated_at,
  deleted_at
)
SELECT 
  emp_id,
  'T001',
  NOW(),
  NULL,
  NOW(),
  NOW(),
  NULL
FROM employees
WHERE emp_id > 100000
;






