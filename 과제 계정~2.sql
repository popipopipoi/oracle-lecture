-- 1. ������а�(�а��ڵ� 002) �л����� �й��� �̸�, ���� �⵵�� ���� �⵵�� ����
-- ������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.( ��, ����� "�й�", "�̸�", "���г⵵" ��
-- ǥ�õǵ��� ����.)
SELECT
       STUDENT_NO �й�
     , STUDENT_NAME �̸�
     , ENTRANCE_DATE ���г⵵
     
  FROM TB_STUDENT
 WHERE DEPARTMENT_NO = '002'
 ORDER BY ENTRANCE_DATE;
 
-- 2. �� ������б��� ���� �� �̸��� �� ���ڰ� �ƴ� ������ �Ѹ� �ִٰ� �Ѵ�. �� ������
-- �̸��� �ֹι�ȣ�� ȭ�鿡 ����ϴ� SQL ������ �ۼ��� ����. (* �̶� �ùٸ��� �ۼ��� SQL 
-- ������ ��� ���� ����� �ٸ��� ���� �� �ִ�. ������ �������� �����غ� ��)
SELECT
       PROFESSOR_NAME
     , PROFESSOR_SSN

  FROM TB_PROFESSOR
 WHERE PROFESSOR_NAME NOT LIKE '___';
 
-- 3. �� ������б��� ���� �������� �̸��� ���̸� ����ϴ� SQL ������ �ۼ��Ͻÿ�. ��
-- �̶� ���̰� ���� ������� ���� ��� ������ ȭ�鿡 ��µǵ��� ����ÿ�. (��, ���� ��
-- 2000 �� ���� ����ڴ� ������ ��� ����� "�����̸�", "����"�� �Ѵ�. ���̴� ����������
-- ����Ѵ�.)
SELECT
       PROFESSOR_NAME �����̸�
 --     , EXTRAT(YEAR FROM SYSDATE) -  TO_DATE((SUBSTR(PROFESSOR_SSN, 1,2)), 'RR') ����
   -- , FLOOR(MONTHS_BETWEEN(SYSDATE,(TO_DATE((SUBSTR(PROFESSOR_SSN, 1,2)), 'RR')) )) ����
     --, SUBSTR(PROFESSOR_SSN, 1,6) ����
   -- , TO_DATE((SUBSTR(PROFESSOR_SSN, 1,6)), 'RRMMDD') ����
  , FLOOR(MONTHS_BETWEEN(SYSDATE, TO_DATE('19'||SUBSTR(PROFESSOR_SSN, 1, 6), 'RRRRMMDD')) / 12) ����
  FROM TB_PROFESSOR
 WHERE SUBSTR(PROFESSOR_SSN, 8, 1) = '1'
 ORDER BY 2, PROFESSOR_NAME;
 
-- 4. �������� �̸� �� ���� ������ �̸��� ����ϴ� SQL ������ �ۼ��Ͻÿ�. ��� �����
-- ?�̸�? �� �������� �Ѵ�. (���� 2 ���� ���� ������ ���ٰ� �����Ͻÿ�)
SELECT
      SUBSTR(PROFESSOR_NAME, 2 ,2) �̸�
  FROM TB_PROFESSOR;
  
-- 5. �� ������б��� ����� �����ڸ� ���Ϸ��� �Ѵ�. ��� ã�Ƴ� ���ΰ�? �̶�, 
-- 19 �쿡 �����ϸ� ����� ���� ���� ������ �����Ѵ�.
SELECT
       STUDENT_NO
     , STUDENT_NAME
  FROM TB_STUDENT
 WHERE EXTRACT(YEAR FROM ENTRANCE_DATE) - EXTRACT(YEAR FROM (TO_DATE(SUBSTR(STUDENT_SSN, 1, 2), 'RR'))) > 19;
 
 -- 6. 2020�� ũ���������� ���� �����ΰ�?

  


  


  
  