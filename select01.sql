-- DML insert, delete, select(90%), update
/*  QUERY문     
    
    SELECT 
        (값, 문자, COLUMN, 함수, SUB QUERY)
    FROM
        (TABLE명, SUB QUERY)
*/
SELECT 1 FROM DUAL;

-- 현재 계정의 테이블을 모두 명세
SELECT * FROM TAB;

SELECT * FROM EMP;

-- 테이블에서 원하는 컬럼의 값만을 명세
SELECT empno, ename, sal
FROM EMP;

SELECT ename, sal, sal + 300
FROM emp;

SELECT empno, sal, sal * 12
FROM emp;

-- alias    int alias[] = array;    alias[0] = 12;
SELECT empno AS 사원번호, sal "월급", sal * 12 "일년치 연봉"
FROM emp;

-- 연결 연산자 + ||  "ABC" + "DEF"   "ABC" || "DEF"
SELECT ename || " has $" || sal as 월급
FROM emp;

-- distinct : 중복행의 사제   -- group by
SELECT DISTINCT deptno
FROM emp;

-- desc : table의 column의 자료형을 명세 
DESC dept;

--[실습문제]
-- scott
--1)emp 테이블에서 사원번호, 사원이름, 월급을 출력하시오.
SELECT empno, ename, sal
FROM emp;
--2)emp 테이블에서 사원이름과 월급을 출력하는데 컬럼명은 이 름, 월 급으로
--바꿔서 출력하시오.
SELECT ename as "이 름", sal as "월 급"
FROM emp;
--3)emp 테이블에서 사원번호, 사원이름, 월급, 연봉을 구하고 각각 컬럼명은
--사원번호,사원이름,월급,연봉으로 출력하시오.
SELECT empno as 사원번호, ename as "사원이름", sal 월급, sal * 12 AS "연봉"
FROM emp;
--4)emp 테이블의 업무(job)를 중복되지 않게 표시하시오.
SELECT DISTINCT job
FROM emp;

--5)emp 테이블의 사원명과 업무로 연결(SMITH,CLERK)해서 표시하고 
--컬럼명은 Employee and Job으로 표시하시오.
SELECT '(' || ename || ',' || job || ')' as "Employee and Job"
FROM emp;

-- hr
-- 문제1) EMPLOYEES Table의 모든 자료를 출력하여라.
SELECT * FROM employees;

-- 문제2) EMPLOYEES Table의 컬럼들을 모두 출력하라.
DESC employees;

-- 문제3) EMPLOYEES Table에서 사원 번호, 이름, 급여, 담당업무를 출력하여라.
SELECT employee_id, first_name, salary, job_id
FROM employees;

-- 문제4) 모든 종업원의 급여를 $300증가 시키기 위해서 덧셈 연산자를 
-- 사용하고 결과에 SALARY+300을 디스플레이 합니다.
SELECT first_name, salary, salary + 300
FROM employees;

-- 문제5) EMP 테이블에서 사원번호, 이름, 급여, 보너스, 보너스 금액을 출력하여라. 
-- (참고로 보너스는 월급 + (월급*커미션))
SELECT employee_id, first_name, salary, NVL(commission_pct, 0),
    NVL(salary + (salary * commission_pct), 0) as "보너스"
FROM employees;
-- NVL(컬럼명, 앞의 컬럼의 값이 null일 경우 나타낼 값)

-- 문제6) EMPLOYEES 테이블에서 LAST_NAME을 이름으로 
-- SALARY을 급여로 출력하여라.
SELECT last_name as "이 름", salary "급 여" 
FROM employees;

-- 문제7) EMPLOYEES 테이블에서 LAST_NAME을 Name으로 
-- SALARY * 12를 Annual Salary(연봉)로 출력하여라
SELECT last_name AS "Name", salary*12 as "Annual Salary"
FROM employees;

-- 문제8) EMPLOYEES 테이블에서 이름과 업무를 연결하여 출력하여라.
SELECT first_name || ' ' || job_id
FROM employees;

-- 문제9) EMPLOYEES 테이블에서 이름과 업무를 
-- “KING is a PRESIDENT” 형식으로 출력하여라. 
SELECT '"' || last_name || ' is a ' || job_id || '"'
FROM employees;

-- 문제10) EMPLOYEES 테이블에서 이름과 연봉을 
-- “KING: 1 Year salary = 60000” 형식으로 출력하여라. 
SELECT '"' || last_name || ': 1 Year salary = ' || salary*12 || '"' as "이름과 연봉"
FROM employees;

-- 문제11) EMPLOYEES 테이블에서 JOB을 모두 출력하라.
SELECT DISTINCT job_id
FROM employees;
