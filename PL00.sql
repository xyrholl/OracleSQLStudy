/*
PL / SQL procedural extension to Structured Query Language
procedure = 처리자
PL 이란?
SQL을 확장한 순차적인 언어이다, proceduer, function, trigger
SQL Query문을 간단히 접근하기 위하여 작성해 놓은 함수라고 볼 수 있다.

+ script 섞어 사용이 가능하다.
script 란? 소프트 프로그램을 규격화 해놓은 언어.
*/

/*
Script 구조
1. 선언부 : 사용할 변수, 상수를 선언, 초기화
2. 실행부 : 실제 처리할 Query 부분이나 제어문등을 활용. 실제 처리
3. 예외처리부 : 각종 오류 부분

*/

SET SERVEROUTPUT ON -- 한번만 실행시켜 두면 다시 실행하지 않아도 된다. scanner 비슷
BEGIN 
--(실행부)
dbms_output.put_line('HELLO PL');
END;
/
--SET SERVEROUTPUT OFF

DECLARE
--(선언부)
message VARCHAR2(10);
BEGIN
--(실행부)
message := 'hello PL';
DBMS_OUTPUT.PUT_LINE('message = ' || message);
--(예외처리부)
END;
/



-- if
DECLARE
counter INTEGER;
BEGIN
counter := 1;
counter := counter+1;
IF counter IS NULL THEN
DBMS_OUTPUT.PUT_LINE('result: counter is null ');
--ELSIF
ELSE
DBMS_OUTPUT.PUT_LINE('result: counter is NOT null ');
END IF;

END;
/

--FOR
DECLARE
counter INTEGER;
i INTEGER; -- 루프형 변수를 미리 선언을 해놓고 사용해야한다.
BEGIN
FOR i IN 1..9 LOOP
DBMS_OUTPUT.PUT_LINE('i - ' || i);
counter := i*2;

DBMS_OUTPUT.PUT_LINE('2* ' || i || ' = ' || counter);
END LOOP;
END;
/

DECLARE
v_count NUMBER := 0; -- 변수 선언과 동시에 초기화도 가능하다.
v_total NUMBER := 0;
BEGIN
LOOP
EXIT WHEN v_count = 10; -- : 이 없음.
v_count := v_count +1;
v_total := v_total + v_count;
DBMS_OUTPUT.PUT_LINE('count = ' || v_count);

END LOOP;
DBMS_OUTPUT.PUT_LINE('total = ' || v_total);
END;
/

DECLARE
v_count NUMBER := 0; -- 변수 선언과 동시에 초기화도 가능하다.
v_total NUMBER := 0;
BEGIN
WHILE v_count < 10
LOOP
v_count := v_count+1;
v_total := v_total + v_count;
END LOOP;
DBMS_OUTPUT.PUT_LINE('total = ' || v_total);
END;
/

-- GOTO 문
DECLARE
v_name VARCHAR2(10) := 'LEE';
v_case NUMBER := 1;
BEGIN
CASE
WHEN MOD(v_case, 2) = 0 THEN GOTO test1;
WHEN MOD(v_case, 2) = 1 THEN GOTO test2;
ELSE GOTO err;
END CASE;
<<test1>>
DBMS_OUTPUT.PUT_LINE(v_name||'is woman');
GOTO sub_end;
<<test2>>
DBMS_OUTPUT.PUT_LINE(v_name||'is man');
GOTO sub_end;
<<err>>
DBMS_OUTPUT.PUT_LINE('err');
GOTO sub_end;
<<sub_end>>
DBMS_OUTPUT.PUT_LINE('Exit');
END;
/

-- 예외처리부
DECLARE
counter INTEGER;
BEGIN
counter := 10;
counter := counter /0;
EXCEPTION WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE('EXCEPTION exist');
END;
/

-- varray : VARIABLE ARRAY
DECLARE
TYPE varray_test IS VARRAY(3) OF INTEGER; -- int[] varray_test = new int[3];
varr varray_test; -- 타입형 이기 때문에 변수로 변형해야 사용가능하다.
BEGIN
varr := varray_test(111, 222, 333);
DBMS_OUTPUT.PUT_LINE('varr(1) =' || varr(1) );
DBMS_OUTPUT.PUT_LINE('varr(2) =' || varr(2) );
DBMS_OUTPUT.PUT_LINE('varr(3) =' || varr(3) );
END;
/

-- 강력권장 PL
ACCEPT p_deptno PROMPT '부서번호를 입력하시오(급여의 합)' -- 입력받을때
DECLARE
v_salTotal NUMBER;
BEGIN
SELECT SUM(salary) INTO v_salTotal -- SELECT절에서 OUTPUT 할때 사용해야함. INTO ~~~
FROM employees
WHERE department_id = &p_deptno; -- &로 Script 안으로 가지고 오는 부호 
DBMS_OUTPUT.PUT_LINE(&p_deptno || '번 부서의 급여의 합은' || TO_CHAR(v_saltotal,'$999,999,999') );
END;
/

-- 사원번호 입력 받고 그 사원의 급여에 1000을 더한 값으로 갱신(UPDATE)하여라.
-- 사원번호, 갱신된 급여를 출력하라.
ACCEPT p_deptno PROMPT '1000 더받을 사원번호 입력' -- 입력받을때
DECLARE
v_salTotal employees.salary%TYPE;
BEGIN

SELECT salary INTO v_salTotal
FROM employees
WHERE employee_id = &p_deptno;
DBMS_OUTPUT.PUT_LINE(&p_deptno || '번 사원의 갱신전 급여' || TO_CHAR(v_saltotal,'$999,999,999') );

UPDATE employees
SET salary = salary -1000
WHERE employee_id = &p_deptno;

SELECT salary INTO v_salTotal
FROM employees
WHERE employee_id = &p_deptno;
DBMS_OUTPUT.PUT_LINE(&p_deptno || '번 사원의 갱신후 급여' || TO_CHAR(v_saltotal,'$999,999,999') );

ROLLBACK;

SELECT salary INTO v_salTotal
FROM employees
WHERE employee_id = &p_deptno;
DBMS_OUTPUT.PUT_LINE(&p_deptno || '번 사원의 롤백 급여' || TO_CHAR(v_saltotal,'$999,999,999') );
END;
/

-- ROW TYPE -> 사원번호, 급여, 등등을 한몫에 받아올수 있는것 
DECLARE -- 클래스
v_emp employees%ROWTYPE; -- 필드값
-- COLUMN명이 자동적으로 변수명이 된다.
-- v_emp.first_name, v_emp.last_name ...
BEGIN -- 메인메소드

SELECT employee_id, first_name, last_name, salary  -- 메소드1
INTO v_emp.employee_id, v_emp.first_name, v_emp.last_name, v_emp.salary
FROM employees
WHERE employee_id = 100;

DBMS_OUTPUT.PUT_LINE('사원번호' || v_emp.employee_id);
DBMS_OUTPUT.PUT_LINE('첫번째 이름' || v_emp.first_name);
DBMS_OUTPUT.PUT_LINE('마지막 이름' || v_emp.last_name);
DBMS_OUTPUT.PUT_LINE('급여' || v_emp.salary);

END;
/

-- 이름, 급여, 부서번호를 입력받아서
-- 사원추가. INSERT INTO employees 테이블 job_id : IT_PROG, email : 이름@naver.com
-- 부서번호가 30번 일경우에 입력받은 급여에 20% 인상해서 입력
-- 부서번호가 60번 일경우에 받은급여세 10% 인상해서 입력.

ACCEPT p_name PROMPT '이 름'
ACCEPT p_salary PROMPT '급 여:'
ACCEPT p_deptno PROMPT '부서번호:'

DECLARE
v_name employees.last_name%TYPE := '&p_name'; 
v_salary employees.salary%TYPE := &p_salary;
v_deptno employees.department_id%TYPE := &p_deptno;
BEGIN

DBMS_OUTPUT.PUT_LINE('사원번호' || v_name);
DBMS_OUTPUT.PUT_LINE('급여' || v_salary);
DBMS_OUTPUT.PUT_LINE('부서번호' || v_deptno);

IF v_deptno = 30 THEN
v_salary := v_salary*1.2;
ELSIF v_deptno = 60 THEN
v_salary := v_salary*1.1;
END IF;

INSERT INTO employees(employee_id, last_name, salary, hire_date, department_id, job_id, email)
VALUES(employees_seq.NEXTVAL, v_name, v_salary, SYSDATE, v_deptno, 'IT_PROG', v_name||'@naver.com');

END;
/

