CREATE DATABASE mydb;
USE mydb;

-- -------------------
-- 테이블 생성
--  CREATE TABLE 테이블명 (
-- 		-- PK설정 방법1 && AUTO_INCREMENT 설정
--   	컬럼 타입(크기) PRIMARY KEY AUTO_INCREMENT
-- 		-- NULL 비허용
--   	컬럼 타입(크기) NOT NULL  
-- 		-- 초기값 지정
--   	,컬럼 타입 DEFAULT '값'
-- 		-- PK설정 방법2
--   	,CONSTRAIN PK명 PRIMARY KEY(컬럼)
-- 		-- FK설정(보통 ALTER문으로 적용)
--   	,CONSTRAIN FK명 FOREIGN KEY(컬럼)
--   		REFERENCE 참조테이블(참조컬럼) [ON DELETE 동작 / ON UPDATE 동작]
-- 		-- UNIQUE설정
--   	,CONSTRAIN UNIQUE명 UNIQUE (컬럼)
-- 		-- CHECK설정
--   	,CONSTRAIN CHECK명 CHECK (조건)
--  );
-- -------------------
CREATE TABLE users (
	id				BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT 
	,`name`		VARCHAR(50) NOT NULL 
	,gender 		CHAR(1) NOT NULL COMMENT "M: 남자, F: 여자"
	,created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP()
	,updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP()
	,deleted_at DATETIME 
);

-- 게시글 테이블
-- pk, 유저번호, 제목, 내용, 작성일, 수정일, 삭제일
CREATE TABLE posts (
	id				BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT 
	,user_id		BIGINT UNSIGNED NOT NULL  
	,title 		VARCHAR(50) NOT NULL
	,content 	VARCHAR(1000) NOT NULL
	,created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP()
	,updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP()
	,deleted_at DATETIME 
);


-- -------------------
-- 테이블 수정
-- -------------------

-- 컬럼 추가
-- ALTER TABLE [테이블명] ADD COLUMN [컬럼명] [타입] [제약조건];
ALTER TABLE users ADD COLUMN age INT UNSIGNED NOT NULL;

-- 컬럼 데이터 타입의 수정
-- ALTER TABLE [테이블명] MODIFY COLUMN [컬럼명] [타입] [제약조건];
ALTER TABLE users MODIFY COLUMN age BIGINT NOT NULL;

-- 컬럼 삭제
-- ALTER TABLE [테이블명] DROP COLUMN [컬럼명];
ALTER TABLE users DROP COLUMN age;



-- 제약조건 (Constraint) 추가/삭제

-- FK Constraint 추가
-- ALTER TABLE [테이블명] ADD CONSTRAINT [Constraint명] FOREIGN KEY (Constraint 부여 컬럼명) REFERENCES 참조테이블명(참조테이블 컬럼명);
ALTER TABLE posts 
ADD CONSTRAINT fk_posts_user_id
FOREIGN KEY (user_id) REFERENCES users(id);

-- FK Constraint 삭제
-- ALTER TABLE [테이블명]DROP CONSTRAINT [Constraint명];
ALTER TABLE posts DROP CONSTRAINT fk_posts_user_id;



-- ------------------------------
-- AUTO_INCREAMENT 값 변경(MySQL은 100을 처음부터 적으면 그보다 적은 숫자가 안 들어감!)
-- ------------------------------
ALTER TABLE users AUTO_INCREMENT = 1;
INSERT INTO users(`name`, gender) VALUES('HONG', 'F');

-- -----------------------------
-- 테이블의 모든 데이터를 깨끗하게 제거하는 문
-- -----------------------------
TRUNCATE TABLE users;


-- -----------------------------
-- 테이블 삭제
-- 하위 테이블인 posts부터 먼저 삭제한다.
-- -----------------------------

-- DROP TABLE posts;
-- DROP TABLE users;

DROP TABLE posts, users;






