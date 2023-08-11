-- 05.SUBQUERY

-- ���������� �ʿ��� ��

-- ���ö ����� ���� �μ��� �Ҽ� �� ��� ��ȸ

-- ������� ���ö�� ����� �μ� ��ȸ
SELECT
       DEPT_CODE
  FROM EMPLOYEE
 WHERE EMP_NAME = '���ö';
 
-- �μ��ڵ尡 D9�� ���� ��ȸ
SELECT
       EMP_NAME
  FROM EMPLOYEE
 WHERE DEPT_CODE = 'D9';
 
-- ���� �� ������ �ϳ��� �ۼ��Ѵ�.
SELECT
       EMP_NAME
  FROM EMPLOYEE
 WHERE DEPT_CODE = (SELECT
                           DEPT_CODE
                      FROM EMPLOYEE
                     WHERE EMP_NAME = '���ö');
                     
-- �� ������ ��� �޿����� ���� �޿��� �ް� �ִ� ������ ���, �̸�, ���� �ڵ�, �޿� ��ȸ
SELECT
       EMP_ID
     , EMP_NAME
     , JOB_CODE
     , SALARY
  FROM EMPLOYEE
 WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEE);
 
-- SUBQUERY�� ����
-- ������ �������� : ��� ���� 1���� ���������� �Ϲ� �� ������ ���

-- ���ö ����� �޿����� ���� �޴� ������ ���, �̸�, �μ�, ����, �޿� ��ȸ
SELECT
       EMP_ID
     , EMP_NAME
     , DEPT_CODE
     , JOB_CODE
     , SALARY
  FROM EMPLOYEE
 WHERE SALARY > (SELECT SALARY
                   FROM EMPLOYEE
                  WHERE EMP_NAME = '���ö');
                  
-- ���� ���� �޿��� �޴� ������ ���, �̸�, �޿� ��ȸ
SELECT
       EMP_ID
     , EMP_NAME
     , SALARY
  FROM EMPLOYEE
 WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE); 
 
-- WHERE�� �Ӹ� �ƴ϶� HAVING������ ��� �����ϴ�.
-- �μ��� �޿��� �հ� �� �հ谡 ���� ū �μ��� �μ���, �޿� �հ� ��ȸ
SELECT
       DEPT_TITLE
     , SUM(SALARY)
  FROM EMPLOYEE
  LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
 GROUP BY DEPT_TITLE
HAVING SUM(SALARY) = (SELECT
                             MAX(SUM(SALARY))
                        FROM EMPLOYEE
                       GROUP BY DEPT_CODE);
                       
-- ������ �������� : ��� ���� ���� ���� ��������, �Ϲ� �� �����ڸ� ����� �� ����. 

-- �μ��� �ְ� �޿��� ���� �޿��� �޴� ������ �̸�, �μ�, �޿���ȸ
SELECT
       EMP_NAME
     , DEPT_CODE
     , SALARY
  FROM EMPLOYEE
 WHERE SALARY IN (SELECT MAX(SALARY) FROM EMPLOYEE GROUP BY DEPT_CODE);
 
-- �븮 ������ ������ �߿��� ���� ������ �ּ� �޿����� ���� �޴� ���� ��ȸ
-- > ANY / < ANY : ������ ���������� ���� �� ����ϴ� ������
-- > ANY : ���� ���� ����� �ּ� ������ ū ���� ��
-- < ANY : ���� ���� ����� �ִ� ������ ���� ���� ��
SELECT
       EMP_ID
     , EMP_NAME
     , JOB_NAME
     , SALARY
  FROM EMPLOYEE
  JOIN JOB USING(JOB_CODE)
 WHERE JOB_NAME = '�븮'
   AND SALARY > ANY (SELECT
                        SALARY
                   FROM EMPLOYEE
                   JOIN JOB USING(JOB_CODE)
                  WHERE JOB_NAME = '����');
                  
-- ���� ������ �޿��� ���� ū ������ ���� �޴� ���� ������ ��� ��ȸ
-- > ALL : ���������� ��� �� �ִ� ������ ū �� ��
-- < ALL : ���������� ��� �� �ּ� ������ ���� �� ��
SELECT
       EMP_ID
     , EMP_NAME
     , JOB_NAME
     , SALARY
  FROM EMPLOYEE
  JOIN JOB USING(JOB_CODE)
 WHERE JOB_NAME = '����'
   AND SALARY > ALL (SELECT
                        SALARY
                   FROM EMPLOYEE
                   JOIN JOB USING(JOB_CODE)
                  WHERE JOB_NAME = '����');
                  
-- ���߿� �������� : ��� ���� ���߿��� ��������
-- ������ ������� ���� �μ�, ���� ���޿� �ش��ϴ� ��� ��ȸ
SELECT
       EMP_NAME
     , DEPT_CODE
     , JOB_CODE
  FROM EMPLOYEE
 WHERE DEPT_CODE = (SELECT DEPT_CODE  -- �μ�Ȯ��
                      FROM EMPLOYEE
                     WHERE SUBSTR(EMP_NO, 8, 1) = '2'
                       AND ENT_YN = 'Y'
                    )
   AND JOB_CODE = (SELECT  JOB_CODE -- ����Ȯ��
                      FROM EMPLOYEE
                     WHERE SUBSTR(EMP_NO, 8, 1) = '2'
                       AND ENT_YN = 'Y'
                    );
                    
-- ���߿� ���������� �����Ѵ�.
SELECT
       EMP_NAME
     , DEPT_CODE
     , JOB_CODE
  FROM EMPLOYEE
 WHERE (DEPT_CODE, JOB_CODE) = (SELECT DEPT_CODE, JOB_CODE  
                                  FROM EMPLOYEE
                                 WHERE SUBSTR(EMP_NO, 8, 1) = '2'
                                   AND ENT_YN = 'Y'
                                );
                                
-- �ζ��� ��(Inline View) : FROM ������ ��� �Ǵ� ���� ����
-- ���޺� ��� �޿��� ����� ���̺��� ����� EMPLOYEE�� JOIN��
-- ��� �޿��� ������ �޿��� �����ϸ� �����ϰ� ������ �༭
-- ���޺� ��� �޿��� �´� �޿��� �ް� �ִ� ������ ��ȸ�ϴ� ����
SELECT
       E.EMP_NAME
     , J.JOB_NAME
     , E.SALARY
  FROM (SELECT
               JOB_CODE
             , TRUNC(AVG(SALARY), -5) AS JOBAVG
          FROM EMPLOYEE
         GROUP BY JOB_CODE) V
    JOIN EMPLOYEE E ON (V.JOBAVG = E.SALARY AND V.JOB_CODE = E.JOB_CODE)
    JOIN JOB J ON (E.JOB_CODE = J.JOB_CODE)
   ORDER BY J.JOB_NAME;
   
-- �ζ��� �� ��� �� ������ ��
-- �ζ��� ���� ������� ���������Ƿ� ���� �������� ��ȸ�� ������� ���� �÷��� ��ȸ �Ұ�
-- ��Ī�� ����ߴٸ� ��Ī���� ����� �� ����!
SELECT
       EMP_NAME
     , �μ���
     , ���޸�
   --, SALARY
  FROM (SELECT
               EMP_NAME
             , DEPT_TITLE �μ���
             , JOB_NAME ���޸�
          FROM EMPLOYEE
          LEFT JOIN DEPARTMENT ON(DEPT_CODE = DEPT_ID)
          JOIN JOB USING(JOB_CODE))
 WHERE �μ��� = '�λ������';

-- �ζ��� �並 ����� TOP-N �м�

-- ROWNUM Ȯ��
-- SALARY ���� �������� ����
-- ����� WHERE������ ROWNUM�� �����Ǿ� �޿��� ���� �޴� ���� ���� ���� ��ȣ�� ������.
SELECT
       ROWNUM
     , EMP_NAME
     , SALARY
  FROM EMPLOYEE
 ORDER BY SALARY DESC;

-- ���� ���ϴ� ������ ROWNUM�� �ٰ� �Ϸ��� �ζ��� �並 Ȱ���ؾ� �Ѵ�.
SELECT
       ROWNUM
     , V.EMP_NAME
     , V.SALARY
  FROM (SELECT E.*
          FROM EMPLOYEE E
         ORDER BY E.SALARY DESC
        ) V
 WHERE ROWNUM <= 5;
 
-- 6������ 10������ ��ȸ
-- WHERE������ ROWNUM�� 1�� �ο� �ǰ� �ش� ���� ���� �� FALSE�� �Ǿ� ���� �࿡ �ٽ�
-- ROWNUM�� 1�� �ο��� �ǹǷ� ��� ���� 6~10 ���̶�� ������ ������ �� ���� ����� 0���� �ȴ�.
SELECT
       ROWNUM
     , V.EMP_NAME
     , V.SALARY
  FROM (SELECT E.*
          FROM EMPLOYEE E
         ORDER BY E.SALARY DESC
        ) V
 WHERE ROWNUM BETWEEN 6 AND 10;
 
 -- 6������ 10������ ��ȸ ���� ����
 SELECT
       V2.RNUM
     , V2.EMP_NAME
     , V2.SALARY
  FROM (SELECT
               ROWNUM RNUM
             , V.EMP_NAME
             , V.SALARY
          FROM (SELECT E.*
                  FROM EMPLOYEE E
                 ORDER BY E.SALARY DESC
                ) V
    ) V2
 WHERE RNUM BETWEEN 6 AND 10;
-- STOP KEY ���
 SELECT
       V2.RNUM
     , V2.EMP_NAME
     , V2.SALARY
  FROM (SELECT
               ROWNUM RNUM
             , V.EMP_NAME
             , V.SALARY
          FROM (SELECT E.*
                  FROM EMPLOYEE E
                 ORDER BY E.SALARY DESC
                ) V
         WHERE ROWNUM < 11   --STOP KEY
    ) V2
 WHERE RNUM BETWEEN 6 AND 10;
 
-- �޿� ��� 3�� �ȿ� ��� �μ��� �μ��ڵ�, �μ���, ��� �޿� ��ȸ
SELECT
       ROWNUM
     , V.DEPT_CODE
     , V.DEPT_TITLE
     , V.��ձ޿�
  FROM (SELECT
               E.DEPT_CODE
             , D.DEPT_TITLE
             , AVG(E.SALARY) ��ձ޿�
          FROM EMPLOYEE E
          JOIN DEPARTMENT D ON (E.DEPT_CODE = D.DEPT_ID)
         GROUP BY E.DEPT_CODE, D.DEPT_TITLE
         ORDER BY 3 DESC
        ) V
 WHERE ROWNUM <= 3;
 
-- RANK() OVER : ������ ���� ������ ����� �ο�����ŭ �ǳʶٰ� ���� ������ ���
-- DENSE_RANK() OVER : ������ ���� ������ ����� ���� ����� ���
SELECT
       EMP_NAME
     , SALARY
     , RANK() OVER(ORDER BY SALARY DESC) ����
  FROM EMPLOYEE;
  
SELECT
       EMP_NAME
     , SALARY
     , DENSE_RANK() OVER(ORDER BY SALARY DESC) ����
  FROM EMPLOYEE;
  
-- SALARY ���� 5������ ��ȸ
SELECT
       V.*
  FROM (SELECT
                EMP_NAME
              , SALARY
              , RANK() OVER(ORDER BY SALARY DESC) ����
           FROM EMPLOYEE) V
 WHERE V.���� <= 5;
 
-- WITH
-- ���������� �̸��� �ٿ��ְ� ���� �� �� �ִ�.
WITH
       TOPN_SAL
    AS (SELECT
               EMP_ID
             , EMP_NAME
             , SALARY
          FROM EMPLOYEE
         ORDER BY SALARY DESC
        )
SELECT
       ROWNUM
     , T.EMP_NAME
     , T.SALARY
  FROM TOPN_SAL T;
  
-- ��� ����Ŀ��
-- ������ ����� EMPLOYEE ���̺� �����ϴ� ������ ���� ��ȸ
SELECT
       E.EMP_ID
     , E.EMP_NAME
     , E.DEPT_CODE
     , E.MANAGER_ID
  FROM EMPLOYEE E
 WHERE EXISTS (SELECT
                      E2.EMP_ID
                 FROM EMPLOYEE E2
                WHERE E.MANAGER_ID = E2.EMP_ID
);

-- ���� ������ �޿� ��պ��� �޿��� ���� �ް� �ִ� ������ ������, �����ڵ�, �޿� ��ȸ
SELECT
       EMP_NAME
     , JOB_CODE
     , SALARY
  FROM EMPLOYEE E
 WHERE SALARY > (SELECT
                             TRUNC(AVG(E2.SALARY), -5)
                        FROM EMPLOYEE E2
                       WHERE E.JOB_CODE = E2.JOB_CODE
);

SELECT
       EMP_ID
     , EMP_NAME
     , MANAGER_ID
     , NVL((SELECT EMP_NAME
              FROM EMPLOYEE E2
             WHERE E.MANAGER_ID = E2.EMP_ID
            ), '����') �����ڸ�
  FROM EMPLOYEE E
 ORDER BY 1;






