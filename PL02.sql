/* 
FUNCTION함수
매개변수, return 값
SELECT
*/
SET SERVEROUTPUT ON

CREATE OR REPLACE FUNCTION func(p_val IN NUMBER)RETURN NUMBER
IS
v_val NUMBER;
BEGIN
v_val := p_val;
v_val := v_val*2;
RETURN p_val;

END;
/

SELECT func(24)
FROM dual;

CREATE OR REPLACE FUNCTION tax(p_value IN NUMBER) RETURN NUMBER
IS
BEGIN
RETURN (p_value * 0.15);
END;
/

SELECT tax(20000)
FROM dual;

VAR tax_val NUMBER;
EXEC :tax_val := tax(1000);
PRINT tax_val;

-- 급여와 커미션을 합쳐서 세금을 계산
CREATE OR REPLACE FUNCTION tax2(
p_sal IN employees.salary%TYPE,
p_bonus IN employees.commission_pct%TYPE) RETURN NUMBER
IS

BEGIN

RETURN (( p_sal + NVL(p_bonus,0) * p_sal) *0.15); -- 실급여 + 보너스 * 세금%

END;
/

SELECT first_name, (salary + salary*NVL(commission_pct,0))실급여, tax2(salary,commission_pct)세금
FROM employees;

-- 사원의 번호를 입력하면, 그사원의 업무명, 부서명을 구할 수 있는 함수
CREATE OR REPLACE FUNCTION getjobName(p_empno IN employees.employee_id%TYPE) RETURN VARCHAR2
IS
v_jobname jobs.job_id%TYPE;
BEGIN
SELECT j.job_title INTO v_jobname
FROM employees e, jobs j
WHERE e.job_id = j.job_id
AND e.employee_id = p_empno;

RETURN (v_jobname);
END;
/

SELECT getjobName(100)
FROM dual;

VAR name VARCHAR2(20);
EXEC :name := getjobname(100);
PRINT name;