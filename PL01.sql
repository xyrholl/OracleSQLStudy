/*
    block 되어 있는 처리 -> 함수화
    매개변수, RETURN 값
    PROCUDURE   - INSERT, DELETE, UPDATE
    FUNCTION    - SELECT
    TRIGGER     - UTIL
*/
SET SERVEROUTPUT ON

CREATE OR REPLACE PROCEDURE myProc(inNum IN NUMBER, outNum OUT NUMBER)
IS
    -- 선언부
BEGIN
    -- 실행부
    DBMS_OUTPUT.PUT_LINE('inNum:' || inNum);
    
    outNum := 333;
    -- 예외처리
END;
/

/* 호출 */
VAR val NUMBER;             /* int val; */   
EXECUTE myproc(111, :val);  /* 프로시저 호출 */    
PRINT val;                  /* 출력 */           

-- 매개 변수가 없는 경우
CREATE OR REPLACE PROCEDURE hellProc
IS
    msg VARCHAR2(10);
BEGIN
    msg := 'helloProc';
    DBMS_OUTPUT.PUT_LINE(msg || '호출');
END;
/

EXEC hellproc;

-- departments row추가
INSERT INTO departments(department_id, department_name, location_id)
VALUES(300, '관리부', 1400);

ROLLBACK;

CREATE OR REPLACE PROCEDURE add_dept(p_deptno IN departments.department_id%TYPE,
                                    p_deptname IN departments.department_name%TYPE,
                                    p_deptloc IN departments.location_id%TYPE)
IS    
BEGIN
    INSERT INTO departments(department_id, department_name, location_id)
    VALUES(p_deptno, p_deptname, p_deptloc);
    
    -- COMMIT;
EXCEPTION WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('추가에 실패했습니다');
   -- ROLLBACK;
END;
/
                                    
EXECUTE add_dept(301, '신규부서', 2500);

-- update salary
-- 사원번호를 입력 받아서 급여인상 30%
CREATE OR REPLACE PROCEDURE updateSal(v_empno IN NUMBER)
IS
BEGIN
    UPDATE employees
    SET salary = salary * 1.3
    WHERE employee_id = v_empno;
    
    -- COMMIT;
END;
/

ACCEPT empno PROMPT '사원번호:'
EXECUTE updatesal(&empno);
ROLLBACK;

-- 사원번호를 입력받으면 그 사원의 이름, 사원번호, 사원급여도 출력이 되도록 작성하라.
CREATE OR REPLACE PROCEDURE emp_info(p_empno IN employees.employee_id%TYPE)
IS
    v_emp employees%ROWTYPE;
BEGIN
    SELECT first_name, employee_id, salary
        INTO v_emp.first_name, v_emp.employee_id, v_emp.salary
    FROM employees
    WHERE employee_id = p_empno;
    
    DBMS_OUTPUT.PUT_LINE('이름:'||v_emp.first_name);
    DBMS_OUTPUT.PUT_LINE('사원번호:'||v_emp.employee_id);
    DBMS_OUTPUT.PUT_LINE('급여:'||v_emp.salary);    
END;
/

EXECUTE emp_info(102);

/*
    Cursor : 저장 주소 공간 -> pointer
    암시적 커서 : 자동생성
        SQL%ROWCOUNT : ROW의 수
        SQL%FOUND : ROW의 수가 한개이상일 경우
        SQL%NOTFOUND : ROW의 수가 0
    
    명시적 커서 : 수동생성
*/
-- 암시적 커서
CREATE OR REPLACE PROCEDURE implicit_cursor(p_empname IN employees.first_name%TYPE)
IS
    v_sal employees.salary%TYPE;
    v_update_row NUMBER;    -- 몇개의 행이 수정되는지 조사하는 부분의 변수
BEGIN
    -- 검색
    SELECT salary INTO v_sal
    FROM employees
    WHERE first_name = p_empname;
    
    -- 검색된 데이터가 있는 경우
    IF SQL%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('검색된 데이터 있습니다');
    END IF;
    
    -- 수정
    UPDATE employees
    SET salary = salary * 1.1
    WHERE first_name = p_empname;
    
    -- 출력
    v_update_row := SQL%ROWCOUNT;
    DBMS_OUTPUT.PUT_LINE('급여가 인상된 사원수:' || v_update_row);

EXCEPTION WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('검색된 데이터가 없습니다');
END;

-- Steven 

EXECUTE implicit_cursor('길동');

ROLLBACK;

-- 명시적 커서
CREATE OR REPLACE PROCEDURE expCursor_test(v_deptno IN departments.department_id%TYPE)
IS
    CURSOR dept_avg
    IS
    SELECT d.department_name, COUNT(e.employee_id) CNT,
        ROUND(AVG(salary), 3) SAL
    FROM employees e, departments d
    WHERE e.department_id = d.department_id
        AND e.department_id = v_deptno
    GROUP BY d.department_name;
    
    -- CURSOR에 PATCH하기 위한 변수들을 선언
    v_dname departments.department_name%TYPE;
    emp_cnt NUMBER;
    sal_avg NUMBER;   
    
BEGIN
    -- CURSOR OPEN    
    OPEN dept_avg;
    
    -- CURSOR FETCH
    FETCH dept_avg INTO v_dname, emp_cnt, sal_avg;

    DBMS_OUTPUT.PUT_LINE('부서명:' || v_dname);
    DBMS_OUTPUT.PUT_LINE('사원수:' || emp_cnt);
    DBMS_OUTPUT.PUT_LINE('급여평균:' || sal_avg);

    -- CURSOR CLOSE
    CLOSE dept_avg;
END;
/

EXECUTE expcursor_test(50);
