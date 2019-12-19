/* 
view : 가상테이블 vue
실체가 없는 테이블.
실제 저장되는 것이 아니다 => pointer

table <- view 뷰를 통해서 table을 볼 수 있다. 창틀과 같은 존재?
한개의  view로 여거개의 table의 데이터를 검색하는것이 가능하다.
오라클 개발자는 view를 많이 만들어 놓고 사용한다. 신용이 높고 검색속도가 빠르다. 제한을 설정할 수 있다.

뷰를 만들때 null을 허용하지 않는 컬럼을 넣어주어야한다.
*/

CREATE VIEW UB_TEST_01(
job_id, job_title, min_salary
)AS
SELECT job_id, job_title, min_salary
FROM jobs;

SELECT *
FROM UB_TEST_01; -- 창문을 통해서 바라본 데이터

INSERT INTO UB_TEST_01
VALUES ('DEVELOPER', '개발자', 10000); -- 창문에 데이터를 넣었음.

SELECT *
FROM jobs; -- 실체에도 데이터가 들어간것을 확인 할 수 있음.

ROLLBACK;
COMMIT;
DELETE FROM UB_TEST_01 WHERE job_title = '개발자';

CREATE TABLE test01(
key_01 VARCHAR2(10),
key_02 VARCHAR2(10),
col_01 VARCHAR2(10),
col_02 VARCHAR2(10),
CONSTRAINT pk_test_02 PRIMARY KEY (key_01, key_02)
);

CREATE VIEW UB_TEST_02(
key_01, key_02, col_01,
CONSTRAINT pk_ub_test_02 PRIMARY KEY(key_01, key_02) -- 설정하지 않으면 값을 집어 넣을때 오류가 발생 할 수 있음. 그러므로, 키값은 항상 동일하게 넣어야한다.
DISABLE NOVALIDATE
)AS
SELECT key_01, key_02, col_01
FROM test01;

INSERT INTO UB_TEST_02 (key_01, key_02, col_01)
VALUES ('1', '2', '111'); -- 두번실행시 unique constraint (HR.PK_TEST_02) violated

INSERT INTO UB_TEST_02 (key_01, key_02, col_01)
VALUES ('1', '1', '111');

SELECT *
FROM UB_TEST_02; -- 뷰를 통한 확인

SELECT *
FROM test01; -- 실제 테이블 확인

-- READONLY
CREATE OR REPLACE VIEW EMPVIEW( -- 해당테이블을 지우고 다
"사원번호",
"성",
"입사일",
"업무",
CONSTRAINT pk_ub_emp PRIMARY KEY ("사원번호") DISABLE NOVALIDATE
) AS
SELECT employee_id, last_name, eamil, hire_date, job_id
FROM employees
WITH READ ONLY;

SELECT *
FROM EMPVIEW;

INSERT INTO empview
VALUES(400, 'kim', 'kim@naver.com', sysdate, 'IT_PROG');

ROLLBACK;

CREATE OR REPLACE VIEW depr_emp_view
AS SELECT d.department_name, d.location_id, d.department_id
FROM employees E, departments d
WHERE e.department_id = d.department_id
WITH READ ONLY;