-- 무결성 : COLUMN에 지정하는 성질이다.
-- P. Primary Key(PK) : 기본키. NULL을 허용하지 않음. 중복을 허용하지 않음. ID와 같은 의미를 갖는다.
-- U. Unique Key (UK) : 고유키. NULL을 허용함. 중복을 허용하지 않음. email
-- F. Foreign Key (FK) : 외래키. NULL을 허용함. Other Table 에서 PK 또는 UK 이여야 함. 목적 : 테이블과 테이블을 연결해주는 목적(JOIN)
-- CHECK : 범위를 설정. NULL을 허용함.
-- NOT NULL : NULL을 허용하지 않음.

--NOT NULL
CREATE TABLE tb_test(COL_01 VARCHAR2(10) NOT NULL, COL_02 VARCHAR2(10));

INSERT INTO tb_test(COL_01, COL_02)
VALUES('AAA', 'aaa');
SELECT * FROM tb_test;

INSERT INTO tb_test(COL_01, COL_02)
VALUES('AAA', '');
SELECT * FROM tb_test;

INSERT INTO tb_test(COL_01, COL_02)
VALUES('', ''); --cannot insert NULL into ("HR"."TB_TEST"."COL_01") -- 무결성

-- Primary Key = NOT NULL + Unique Key
-- 유일하게 식별할 수 있는 정의된 규칙
-- 한테이블에서 최대 32개 COLUMN까지 지정할 수 있다.
-- CONSTRAINT = 무결성

CREATE TABLE test_01(KEY_01 VARCHAR2(10) CONSTRAINT PK_TEST_01 PRIMARY KEY, KEY_02 VARCHAR2(10), KEY_03 VARCHAR2(20));

INSERT INTO TEST_01(KEY_01, KEY_02, KEY_3)
VALUES ('AAA', 'aaa', '111'); -- 두번실행시 ORA-00001: unique constraint (HR.PK_TEST_01) violated

DROP TABLE test_01
CASCADE CONSTRAINTS;

CREATE TABLE test_01(KEY_01 VARCHAR2(10) CONSTRAINT PK_TEST_01 PRIMARY KEY, KEY_02 VARCHAR2(10) CONSTRAINT PK_TEST_02 PRIMARY KEY, KEY_03 VARCHAR2(20));

CREATE TABLE test_01(
KEY_01 VARCHAR2(10) ,
KEY_02 VARCHAR2(20),
KEY_03 VARCHAR2(20),
CONSTRAINT PK_TEST_01 PRIMARY KEY(KEY_01, KEY_02));

-- PK가 두가지 이상일 경우 쌍으로 취급해서 하나만 달라도 다르게 사용 가능하다.

CREATE TABLE test_01(
KEY_01 VARCHAR2(10) ,
KEY_02 VARCHAR2(20),
KEY_03 VARCHAR2(20)
);

-- 기본키 추가
ALTER TABLE TEST_01
ADD CONSTRAINT PK_TEST_01
PRIMARY KEY (KEY_01);

-- 기본키 삭제
ALTER TABLE test_01
DROP CONSTRAINT PK_TEST_01; -- 지정해서 지워줌.

-- Unique Key : 고유키
-- 유일한 값, NULL을 허용함.
DROP TABLE TEST_01
CASCADE CONSTRAINTS;

CREATE TABLE test_01(
UKEY_1 VARCHAR2(10) CONSTRAINT UK_TEST_01 UNIQUE, 
COL_1 VARCHAR2(10),
COL_2 VARCHAR2(10)
);

INSERT INTO test_01 (UKEY_1,COL_1,COL_2)
VALUES('AAA', 'aaa', '111'); -- 2번 실행시. unique constraint (HR.UK_TEST_01) violated

INSERT INTO test_01 (UKEY_1,COL_1,COL_2)
VALUES('', 'aaa', '111'); -- NULL값 허용.

SELECT * FROM test_01;

-- CHECK
-- 데이터의 값의 허용하는 것. 범위, 특정한 값의 지정이 가능.
-- NULL을 허용함.

DROP TABLE test_01
CASCADE CONSTRAINTS;

CREATE TABLE test_01(
KEY_01 VARCHAR2(10),
COL_01 VARCHAR2(10),
CONSTRAINT chk_test_01 CHECK (KEY_01 IN('사과', '배', '바나나')),
CONSTRAINT chk_test_02 CHECK (COL_01 >0 AND COL_01 <= 100)
);

INSERT INTO test_01 (key_01, COL_01)
VALUES ('사과', 0 ); -- check constraint (HR.CHK_TEST_02) violated

INSERT INTO test_01 (key_01, COL_01)
VALUES ('귤', 10 ); -- check constraint (HR.CHK_TEST_01) violated

INSERT INTO test_01 (key_01, COL_01)
VALUES ('', '' );
SELECT * FROM test_01; -- 특정값, 범위값 이외에는 null만을 허용함.


-- Foreign Key -- PK와 자료형과 값이 같아야한다.
-- 테이블간에 연결하기 위한 무결성 제약조건이다.
-- 다른테이블에 값이 PK(primary key) 이거나 UK(unipue key)로 사용이 가능하다.
-- NULL을 허용한다.

-- PK가 있는 테이블 departments
CREATE TABLE test_par(
pkey_01 VARCHAR2(10)
,pkey_02 VARCHAR2(10)
,col_01 VARCHAR2(10)
,col_02 VARCHAR2(10)
, CONSTRAINT pk_test_01 PRIMARY KEY (pkey_01, pkey_02)
);

-- FK가 있는 테이블 employees
CREATE TABLE test_chd(
col_01 VARCHAR2(10)
, fkey_01 VARCHAR2(10)
, fkey_02 VARCHAR2(10)
, CONSTRAINT fk_test_01 FOREIGN KEY ( fkey_01,fkey_02) REFERENCES test_par(pkey_01, pkey_02) -- Reffrences 로 키가 연결됨.
);

INSERT INTO test_par (pkey_01, pkey_02, col_01, col_02)
VALUES ('AAA', 'aaa', '111', '222');

INSERT INTO test_par (pkey_01, pkey_02, col_01, col_02)
VALUES ('BBB', 'bbb', '111', '222');

INSERT INTO test_chd (col_01, fkey_01, fkey_02)
VALUES ('가나다', 'AAA', 'aaa');

INSERT INTO test_chd (col_01, fkey_01, fkey_02)
VALUES ('가나다', 'BBB', 'bbb');

INSERT INTO test_chd (col_01, fkey_01, fkey_02)
VALUES ('가나다', 'BBB', 'aaa'); -- integrity constraint (HR.FK_TEST_01) violated - parent key not found

INSERT INTO test_chd (col_01, fkey_01, fkey_02)
VALUES ('가나다', '', ''); -- NULL 값을 허용한다.

SELECT *
FROM test_chd; -- null 값이 허용됨.

SELECT *
FROM test_par; -- null 값이 허용되지 않음.

-- UPDATE
CREATE TABLE emp
AS
SELECT * FROM employees; -- 복사를 하더라도 제약조건이 복사 되지 않는다.

UPDATE emp
SET salary = 12000, department_id = null -- 여러가지를 세팅할때 , 로 구분하여 세팅이 가능하다
WHERE employee_id = 100;

COMMIT; -- 커밋을 해야 밖에서도 적용이 된다. git 과 비슷한것.
ROLLBACK; -- 커밋 전에 되돌릴 수 있음.

-- DELETE
DELETE
FROM emp
WHERE salary > 15000; -- 조건에 맞는 데이터를 삭제 가능하다. 업데이트와 동일하게 커밋전에 롤백이 가능하다.
