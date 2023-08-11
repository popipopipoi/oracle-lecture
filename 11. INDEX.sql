-- 12.. INDEX

--ROWID
SELECT
       ROWID
     , EMP_ID
     , EMP_NAME
  FROM EMPLOYEE;
  
-- USER_INDEXES
SELECT * FROM USER_INDEXES;
SELECT * FROM USER_IND_COLUMNS;

-- �ε��� ��Ʈ
-- ���ϴ� ���̺��� �ε����� ����� �� �ֵ��� ������ ���� ����
SELECT /*+ INDEC(E ����Ű1_PK)*/
       E.*
  FROM EMPLOYEE E;

SELECT /*+ INDEC_DESE(E ����Ű1_PK)*/
       E.*
  FROM EMPLOYEE E;
  
-- ���� �ε���
-- �ߺ� ���� ���� �÷��� UNIQUE �ε����� ������ �� �ִ�.
CREATE UNIQUE INDEX IDX_EMPNO
ON EMPLOYEE(EMP_NO);
-- �ߺ� ���� �ִ� �÷��� UNIQUE �ε����� ������ �� ����.
CREATE UNIQUE INDEX IDX_DEPT_CODE
ON EMPLOYEE(DEPT_CODE);

-- ����� �ε���
-- WHERE������ ����ϰ� ��� �Ǵ� �Ϲ� �÷��� ������� ������ �� �ִ�.
CREATE INDEX IDX_DEPT_CODE
ON EMPLOYEE(DEPT_CODE);

-- ���� �ε���
-- ���� �ε����� �ߺ� ���� ���� ���� ���� ���� ���� �˻� �ӵ��� ��� ��Ų��.
CREATE INDEX IDX_DEPT
ON DEPARTMENT (DEPT_ID, DEPT_TITLE);

SELECT /*+ INDEX_DESC(D IDX_DEPT)*/
       D.DEPT_ID
  FROM DEPARTMENT D
 WHERE D.DEPT_ID > '0'
   AND D.DEPT_TITLE > '0';
   
-- �Լ� ��� �ε���
-- �������� �˻��ϴ� ��찡 ���ٸ�, �����̳� �Լ������� �̷���� �÷��� �ε����� ���� �� �ִ�.
CREATE INDEX IDX_EMP_SALCALC
ON EMPLOYEE((SALARY + (SALARY * NVL(BONUS, 0))) * 12);

SELECT /*+ INDEX_DESC(E IDX_EMP_SALCALC)*/
       E.EMP_ID
     , E.EMP_NAME
     , (E.SALARY + (E.SALARY * NVL(E.BONUS,0))) * 12 ����
  FROM EMPLOYEE E
 WHERE (E.SALARY + (E.SALARY * NVL(E.BONUS,0))) * 12 > 1000000;