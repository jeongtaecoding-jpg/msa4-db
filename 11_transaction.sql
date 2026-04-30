-- --------------------------
-- Transaction
-- --------------------------

-- Transaction 시작
START TRANSACTION;

-- Transaction 진행중(이것만 실행 뒤엔 다른 SQL(트랜잭션) 틀어도 반영이 안 됨) ==> 독립성(isolation)
INSERT INTO employees(
	`name`
	,birth
	,gender
	,hire_at
)
VALUES(
	'김정태'
	,'2001-06-01'
	,'M'
	,NOW()
);

-- TRANSACTION은 커밋이나 롤백 중 하나를 실행하면 자동으로 종료
-- 커밋한 뒤엔 다른 앱 틀어도 반영 ==> 영속성(Durability)
COMMIT;

-- 커밋하기 전에 문제가 생겨서 되돌릴 때 (커밋 뒤엔 소용 없음!)
ROLLBACK;