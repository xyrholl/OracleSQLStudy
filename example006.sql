-- OR REPLACE VIEW를 많이 사용함.
--문제1) EMPLOYEES 테이블에서 20번 부서의 세부 사항을 포함하는 EMP_20 VIEW를 생성 하라 
CREATE VIEW emp_20
AS
SELECT e.employee_id, e.first_name, e.last_name, e.job_id, e.salary , d.department_name, d.location_id
FROM employees e, departments d
WHERE e.department_id = d.department_id
AND e.department_id = 20;

SELECT *
FROM emp_20;

DROP VIEW emp_20;
--문제2) EMPLOYEES 테이블에서 30번 부서만 EMPLOYEE_ID 를 emp_no 로 LAST_NAME을 name으로 SALARY를 sal로 바꾸어 EMP_30 VIEW를 생성하라. 
CREATE VIEW emp_30 ("emp_no", "name", "sal")
AS
SELECT employee_id, last_name, salary
FROM employees
WHERE department_id = 30; -- 3가지 column 만 가지고 왔기 때문에 추가나 수정이 불가능한 view 이다.

SELECT *
FROM emp_30;

DROP VIEW emp_30;
--문제3) 부서별로 부서명,최소 급여,최대 급여,부서의 평균 급여를 포함하는 DEPT_SUM VIEW을 생성하여라. 
CREATE OR REPLACE VIEW dept_sum("부서명", "최소 급여", "최대 급여", "부서의 평균 급여")
AS
SELECT DISTINCT d.department_name,
MIN(e.salary)OVER(PARTITION BY e.department_id ),
MAX(e.salary)OVER(PARTITION BY e.department_id ),
ROUND(AVG(e.salary)OVER(PARTITION BY e.department_id))
FROM employees e, departments d
WHERE e.department_id = d.department_id;

CREATE OR REPLACE VIEW dept_sum("부서명", "최소 급여", "최대 급여", "부서의 평균 급여")
AS
SELECT DISTINCT d.department_name, MIN(e.salary), MAX(e.salary),ROUND(AVG(e.salary))
FROM employees e, departments d
WHERE e.department_id = d.department_id
GROUP BY d.department_name;

SELECT *
FROM dept_sum;

DROP VIEW dept_sum;

--문제4) 앞에서 생성한 EMP_20,EMP_30 VIEW을 삭제하여라. ^^
DROP VIEW emp_20;
DROP VIEW emp_30;
-- SEQUENCE

--문제1) 초기값1부터 최대값999,999까지 1씩 증가하는 TEST_SEQ SEQUENCE를 생성하여라.
CREATE SEQUENCE test_seq
INCREMENT BY 1 -- 증가 설정
START WITH 1 -- 시작 숫자 설정
MAXVALUE 999999 -- 최대 설정 (보통생략함.)
NOCACHE -- 오라클서버가 미리 할당하고, 유지하는것을 결정
NOCYCLE -- 최대값, 최소값에 도달한 후에 계속 값을 생성할지를 지정
MINVALUE 1; -- 최소 설정 

--문제2) 1번에서 작성한 SRQUENCE의 현재 값을 조회하여라.
SELECT test_seq.NEXTVAL
FROM dual;
SELECT test_seq.CURRVAL -- sequence CURRVAL has been selected before sequence NEXTVAL
FROM dual;

--문제3) CURRVAL과 NEXTVAL을 설명하여라.
-- CURRVAL 은 현재의 시퀀스넘버를 불러오는것이며,
-- NEXTVAL 은 다음 시퀀스 값을 생성해 역할을 한다.
-- 즉, 초기에 NEXTVAL을 실행시키지 않으면, 시퀀스값이 없기 때문에 시퀀스를 생성하고 바로 CURRVAL 을 실행하면 오류가 나온다.

--문제4) 1번에서 생성한 SRQUENCE를 삭제하여라.
DROP SEQUENCE test_seq;