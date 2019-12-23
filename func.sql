-- Standard function ������ �⺻ �Լ�

-- DUAL : �������̺� - ���Ȯ�ο� �ӽ� ���̺�
SELECT 1 FROM DUAL; -- 1 
SELECT 'A' FROM DUAL;
SELECT '��' FROM DUAL;
SELECT 32*24 FROM DUAL;

-- �����ռ�
-- CHR(N) : ASCII ���� ���ڷ� ��ȯ �ϴ� �Լ�
SELECT CHR(65) FROM DUAL; -- A
SELECT CHR(97) FROM DUAL; -- a

-- �������� A �Դϴ�.
SELECT '�� ������ ' || CHR(65) || '�Դϴ�' FROM DUAL; -- �ΰ��� �÷��� �����Ҷ� ����ϴ°� ||
-- JAVA "�� ������ " + CHR(65) + "�Դϴ�"

--LPAD(RPAD) : �������� ��ĭ(Ư������)���� ä���

SELECT LPAD('BBB', 10) FROM DUAL;
SELECT RPAD('BBB', 10) FROM DUAL;
SELECT LPAD('BBB', 10, '7') FROM DUAL;

-- INSTR == INDEXOF('a') java�� 0���� �����ϸ� DATABASE�� 1���� �����Ѵ�

SELECT INSTR('123A456B678C', 'A') FROM DUAL; -- 4��°�� A �� �ִ�.
SELECT INSTR('123A456B678CB', 'B', 8) FROM DUAL; -- 8��° ���� B�� ã�ƶ�.
SELECT INSTR('123A456B678CB', 'B', 4, 1) FROM DUAL; -- 4��°���� �����ؼ� ù��° B�� ã�ƶ� == 8
SELECT INSTR('123A456B678CB', 'B', 4, 2) FROM DUAL; -- 4��°���� �����ؼ� �ι�° B�� ã�ƶ� == 13

 -- REPLACE: ���ڿ� ġ���Լ�  
 SELECT REPLACE('AAAAABCD', 'A') FROM DUAL; --A�� ��������� ġȯ�ض�
 SELECT REPLACE('AAAAABCD', 'A', 'a') FROM DUAL; --A�� ��������� ġȯ�ض�
 SELECT REPLACE('AAAAABCD', 'AB', 'a') FROM DUAL; --A�� ��������� ġȯ�ض�
 SELECT REPLACE('AAAAABCD', 'AA', 'a') FROM DUAL; 
 
 -- TRANSLATE : ���� ġȯ
 SELECT TRANSLATE ( 'AAAAABCD', 'A', 'a') FROM DUAL; -- aaaaaBCD 
 SELECT TRANSLATE ( 'AAAAABCD', 'AB', 'a') FROM DUAL; -- aaaaaCD
 SELECT TRANSLATE ( 'AAAAABCD', 'AA', 'a') FROM DUAL; -- aaaaaBCD
 
 -- �����Լ� �ø�
 SELECT CEIL(13.1) FROM DUAL; -- result 14
 
 -- �����Լ� ����
 SELECT FLOOR(13.9) FROM DUAL;
 
 -- ���� ������
 SELECT MOD(3, 2) FROM DUAL; -- 
 
 -- �¼�
 SELECT POWER(3, 2) FROM DUAL;
 
 -- �ݿø�
 SELECT ROUND(13.5) From DUAL;
 SELECT ROUND(13.4) From DUAL;
 
 -- ��ȣ 
 SELECT SIGN(13.4) FROM DUAL;
 SELECT SIGN(0) FROM DUAL;
 SELECT SIGN(-3.4) FROM DUAL;
 
 -- ����
 SELECT TRUNC(12.3456) FROM DUAL;
 SELECT TRUNC(12.3456, 2) FROM DUAL; --
 SELECT TRUNC(12.3456, -1) FROM DUAL; -- 10 �� ��µ�.
 
 -- �ƽ�Ű �ڵ尪 ��ȯ CHR �Լ��� ���ݴ�
 SELECT ASCII('A') FROM DUAL;
 
 -- ��ȯ �Լ� DATE -> STRING ���� �߿���.
 -- ���ڰ� �ƴ϶� ���ڰ� ����.
 SELECT TO_CHAR(SYSDATE)
 FROM DUAL;
 
 SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD-HH-MI-SS')
 FROM DUAL;
 
  SELECT TO_CHAR(100000000000, '$999,999,999,999')
 FROM DUAL;
 
 -- TO_DATE
 -- ���ڸ� ���ڷ� �����ϴ°��� TO_BATE  gn
 SELECT TO_DATE('20191225')
 FROM DUAL;
 SELECT TO_DATE('20191225', 'YYYYMMDD')
 FROM DUAL;
 
 SELECT TO_DATE('12252019', 'MMDDYYYY')
 FROM DUAL;
 
 -- TO_NUMBER -> parseInt
 SELECT TO_NUMBER('112') + 24
 FROM DUAL; -- result 136
 
 -- LAST_DAY
 SELECT LAST_DAY('19/11/01')
 FROM DUAL;
 
SELECT LAST_DAY(TO_DATE('20191101', 'YYYYMMDD'))
 FROM DUAL;
 
 -- SUBSTR JAVA subString(1,3) "ABCD" -> BC
 SELECT SUBSTR('ABCDE', 3)
 FROM DUAL; -- 3��° ���� �� ����ض�.
 
 SELECT SUBSTR('ABCDE', 3,2)
 FROM DUAL; -- 3��° ���� 2���� ���ڱ���
 
 -- LENGTHB -> ������ ���� BYTE ����
 -- LENGTH -> ���ڱ���
 SELECT LENGTH('ABCDE') FROM DUAL;
 SELECT LENGTHB('ABCDE') FROM DUAL;