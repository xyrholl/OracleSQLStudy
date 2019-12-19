-- 문제1) 테이블명 address, id, name, addr, phone, email 생성하기.
CREATE TABLE address (id VARCHAR2(10), name VARCHAR2(10), addr VARCHAR2(10), phone VARCHAR2(10), email VARCHAR2(10));

-- 문제2) 주소록 테이블의 구조와 데이터를 복사하여 addr_second 테이블을 생성. (구조와 데이터만 복사해서 생성함.)
CREATE TABLE addr_second AS SELECT * FROM address;

-- 문제3) 주소록 테이블에서 id, name 칼럼만 복사하여 addr_forth 테이블을 생성(구조만 복사)
CREATE TABLE addr_forth AS SELECT id, name FROM address WHERE 1=2;

-- 문제4) Address 테이블에 5개의 데이터를 추가하세요.
INSERT INTO address VALUES
  ('1 First', 'G45 EU8', 'Paris', 'CA', 'US');

-- 문제5) Address 테이블에서 id, name, 만 가진 Address2테이블을 만들고, 자료를 전부 가지고 오기.
CREATE TABLE address2 AS SELECT id, name FROM address; 

-- 문제6) 주소록 테이블에 날짜 타입을 가지는 birth 칼럼을 추가.
ALTER TABLE address
ADD birth DATE;

-- 문제7) 주소록 테이블에 문자 타입을 가지는 comments 칼럼을 추가. 기본값은 'NO COmment'로 지정하여라.
ALTER TABLE address
ADD (comments VARCHAR2(100) default 'NO Comment');

-- 문제8) 주소록 테이블에서 comments 칼럼을 삭제
ALTER TABLE address
DROP (comments);

-- 문제9) 주소록 테이블에서 phone 칼럼의 데이터 타입의 크기를 50으로 증가.
ALTER TABLE address
MODIFY (phone VARCHAR2(50));

DROP TABLE address
CASCADE CONSTRAINTS;

DROP TABLE addr_second
CASCADE CONSTRAINTS;

DROP TABLE addr_forth
CASCADE CONSTRAINTS;

-- 문제1) emp 테이블에서 부서별로 인원수, 평균, 급여, 급여의 합 , 최소급여, 최대 급여를 포함하는 emp_deptno 테이블을 생성하라.
CREATE TABLE emp_deptno AS SELECT COUNT(*)"인원수", AVG(sal)"평균급여", SUM(sal)"급여의 합", MIN(sal)"최소급여", MAX(sal)"최대급여" FROM emp GROUP BY deptno;

-- 문제2) emp_depto 테이블에 etc column을 추가하라. 단, 자료형음 varchar(50)을사용.
ALTER TABLE emp_deptno
ADD etc_column VARCHAR2(50);

-- 문제3) 자료형 15로 수정
ALTER TABLE emp_deptno
MODIFY etc_column VARCHAR2(15);

-- 문제4) 테이블에 있는 etc를 삭제하고 확인
ALTER TABLE emp_deptno
DROP (etc_column);

-- 문제5) 이전에 생성한 emp 테이블의 이름을 emp_dept
ALTER TABLE emp_deptno
RENAME TO emp_dept;

RENAME emp_deptno TO emp_dept; -- 이것도 가능.

-- 문제6) 테이블삭제
DROP TABLE emp_dept
CASCADE CONSTRAINTS;

-- 문제7) employees 테이블을 emp 테이블로 생성하고 복제 해라.
CREATE TABLE emp AS SELECT * FROM employees;

-- 문제8) emp 테이블에 row를 추가, 다만 반드시 데이터를 기입 null 설정.
INSERT INTO emp (employee_id, frist_name, last_name, email, phone_number, hire_date, job_id, salary, commission_pct, manager_id, department_id)
VALUES (300, null, '홍', 'HONG@naver.com', null, SYSDATE, 'IT_PROG', 10000, NULL, NULL, 60);

-- 문제9) employees 테이블에서 empno ename sal hiredate 선택 emp_10 테이블을 생성
CREATE TABLE emp_10 AS SELECT empno, ename, sal, hiredate FROM emp;

-- 문제10)emp 테이블에서 사원번호가 107인 사원의 부서를 10번으로 변경
UPDATE employees
SET department_id = 10
WHERE employee_id = 107;

-- 문제11) emp 테이블에서 사원번호가 180 인 사원의 부서를 20, 급여를 3500으로 변경 하여라.
UPDATE employees
SET department_id = 20, salary = 3500
WHERE employee_id = 180;

-- 문제11) emp 테이블에서 smith의 업무와 급여가 hall의 업무와 급여와 일치하도록 수정하여라.
UPDATE employees
SET job_id = (SELECT job_id FROM employees WHERE last_name IN('Hall')),
salary = (SELECT salary FROM employees WHERE last_name IN('Hall'))
WHERE last_name IN('Smith'); -- HALL 업무 SA_REP, 급여 9000
