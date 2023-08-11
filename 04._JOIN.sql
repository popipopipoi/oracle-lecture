-- 04. JOIN

-- ����Ŭ ���� ����

-- ���ῡ ����� �� �÷����� �ٸ� ���
SELECT
       EMP_ID
     , EMP_NAME
     , DEPT_CODE
     , DEPT_TITLE
  FROM EMPLOYEE
     , DEPARTMENT
WHERE DEPT_CODE = DEPT_ID; --DEPT_CODE�� NULL�� �������� �ʾҴ�.

-- ���ῡ ����� �� �÷����� ���� ���
-- ���̺���� �������� ������ ���� ���ǰ� �ָ��ϴٴ� ������ �߻��Ѵ�!
SELECT
       EMPLOYEE.EMP_ID
     , EMPLOYEE.EMP_NAME
     , EMPLOYEE.JOB_CODE
     , JOB.JOB_NAME
  FROM EMPLOYEE
     , JOB
 WHERE EMPLOYEE.JOB_CODE = JOB.JOB_CODE;
 
 -- ���̺�� ��Ī�� ����� �� �ִ�.
SELECT
       E.EMP_ID
     , E.EMP_NAME
     , E.JOB_CODE
     , J.JOB_NAME
  FROM EMPLOYEE E
     , JOB J
 WHERE E.JOB_CODE = J.JOB_CODE; 

-- ANSI ǥ�� ����

-- ���ῡ ����� �� �÷����� ���� ���
SELECT
       EMP_ID
     , EMP_NAME
     , JOB_CODE
     , JOB_NAME
  FROM EMPLOYEE
  JOIN JOB USING(JOB_CODE);
  
-- ���ῡ ����� �� �÷����� �ٸ� ���
SELECT
       EMP_ID
     , EMP_NAME
     , DEPT_CODE
     , DEPT_TITLE
  FROM EMPLOYEE
  JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID);
  
-- �÷����� ���� ��쿡�� ON���� �ۼ��� �� �ִ�.
SELECT
       E.EMP_ID
     , E.EMP_NAME
     , E.JOB_CODE
     , J.JOB_NAME
  FROM EMPLOYEE E
  JOIN JOB J ON(E.JOB_CODE = J.JOB_CODE);

-- DEPARTMENT ���̺�� LOCATION ���̺��� �����Ͽ� ��� �÷� ��ȸ
-- ORACLE ����
SELECT
       *
  FROM DEPARTMENT
     , LACATION
WHERE LOCATION_ID = LOCAL_CODE;

-- ANSI ǥ��
SELECT
       *
  FROM DEPARTMENT 
  JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE);
  
-- ������ �⺻������ ��ġ�ϴ� �ุ ����� �����ϴ� INNER JOIN���� ����ȴ�.
-- ��ġ�ϴ� ���� ��� ����� ���Խ�Ű�� ���� ��� OUTER JOIN�� ��������� �ؾ� �Ѵ�.

-- LEFT OUTER JOIN
-- ANSI ǥ��
SELECT
       EMP_NAME
     , DEPT_TITLE
  FROM EMPLOYEE
  LEFT /*OUTER*/ JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- ORACLE ����
SELECT
       EMP_NAME
     , DEPT_TITLE
  FROM EMPLOYEE
     , DEPARTMENT
 WHERE DEPT_CODE = DEPT_ID(+);
 
-- RIGHT OUTER JOIN
-- ANSI ǥ��
SELECT
       EMP_NAME
     , DEPT_TITLE
  FROM EMPLOYEE
  RIGHT /*OUTER*/ JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- ORACLE ����
SELECT
       EMP_NAME
     , DEPT_TITLE
  FROM EMPLOYEE
     , DEPARTMENT
 WHERE DEPT_CODE(+) = DEPT_ID;
 
-- FULL OUTER JOIN
-- ANSI ǥ��
SELECT
       EMP_NAME
     , DEPT_TITLE
  FROM EMPLOYEE
  FULL /*OUTER*/ JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

-- ORACLE ����
-- FULL OUTER JOIN�� ���� ���Ѵ�.
SELECT
       EMP_NAME
     , DEPT_TITLE
  FROM EMPLOYEE
     , DEPARTMENT
 WHERE DEPT_CODE(+) = DEPT_ID(+);
 
-- CROSS JOIN
SELECT
       EMP_NAME
     , DEPT_TITLE
  FROM EMPLOYEE
 CROSS JOIN DEPARTMENT;
 
SELECT
       EMP_NAME
     , DEPT_TITLE
  FROM EMPLOYEE
     , DEPARTMENT;
     
-- NON EQUAL JOIN
-- ��ȣ �̿��� �񱳿����ڸ� ����Ͽ� �����ϴ� ��

-- ANSI ǥ��
SELECT
       EMP_NAME
     , SALARY
     , E.SAL_LEVEL "EMPLOYEE�� SAL_LEVEL"
     , S.SAL_LEVEL "SAL_GRADE�� SAL_LEVEL"
  FROM EMPLOYEE E
  JOIN SAL_GRADE S ON(SALARY BETWEEN MIN_SAL AND MAX_SAL);
  
-- ORACLE ����
SELECT
       EMP_NAME
     , SALARY
     , E.SAL_LEVEL "EMPLOYEE�� SAL_LEVEL"
     , S.SAL_LEVEL "SAL_GRADE�� SAL_LEVEL"
  FROM EMPLOYEE E
     , SAL_GRADE S 
 WHERE SALARY BETWEEN MIN_SAL AND MAX_SAL;
 
-- SELF JOIN
-- ANSI ǥ��
SELECT
       E1.EMP_ID ���
     , E1.EMP_NAME ������
     , E1.MANAGER_ID �����ڻ��
     , E2.EMP_NAME �����ڸ�
  FROM EMPLOYEE E1
  JOIN EMPLOYEE E2 ON(E1.MANAGER_ID = E2.EMP_ID);
  
-- ORACLE ����
SELECT
       E1.EMP_ID ���
     , E1.EMP_NAME ������
     , E1.MANAGER_ID �����ڻ��
     , E2.EMP_NAME �����ڸ�
  FROM EMPLOYEE E1
     , EMPLOYEE E2 
 WHERE E1.MANAGER_ID = E2.EMP_ID;
 
-- ���� JOIN : �� �� �̻��� ���̺� JOIN
-- ANSI
-- ���� ���� ���� ������ �����ؾ� �Ѵ�!
SELECT
       EMP_NAME
     , DEPT_TITLE
     , LOCAL_NAME
  FROM EMPLOYEE
  JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
  JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE);
  
-- ORACLE ����
-- ���̺���� ���� ������ ���� ����!
SELECT
       EMP_NAME
     , DEPT_TITLE
     , LOCAL_NAME
  FROM EMPLOYEE
     , DEPARTMENT
     , LOCATION
 WHERE DEPT_CODE = DEPT_ID
   AND LOCATION_ID = LOCAL_CODE;
   
--������ �븮�̸鼭 �ƽþ� ������ �ٹ��ϴ� ������
-- �̸�, ���޸�, �μ���, �ٹ������� ��ȸ

-- ANSI ǥ��
SELECT
       EMP_NAME
     , JOB_NAME
     , DEPT_TITLE
     , LOCAL_NAME
  FROM EMPLOYEE
  JOIN JOB USING(JOB_CODE)
  JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
  JOIN LOCATION ON(LOCATION_ID = LOCAL_CODE)
 WHERE JOB_NAME = '�븮'
   AND LOCAL_NAME LIKE 'ASIA%';
   
-- ORACLE ����
SELECT
       E.EMP_NAME
     , J.JOB_NAME
     , D.DEPT_TITLE
     , L.LOCAL_NAME
  FROM EMPLOYEE E
     , JOB J
     , DEPARTMENT D
     , LOCATION L
 WHERE E.JOB_CODE = J.JOB_CODE
   AND E.DEPT_CODE = D.DEPT_ID
   AND D.LOCATION_ID = L.LOCAL_CODE
   AND JOB_NAME = '�븮'
   AND LOCAL_NAME LIKE 'ASIA%';
   

 



 
