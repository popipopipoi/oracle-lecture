-- 1. �迭 ������ ������ ī�װ� ���̺��� ������� �Ѵ�. ������ ���� ���̺���
-- �ۼ��Ͻÿ�.
CREATE TABLE TB_CATEGORY (
   NAME VARCHAR2(10)
 , USE_YN CHAR(1)DEFAULT 'Y'
); 

-- 2.���� ������ ������ ���̺��� ������� �Ѵ�. ������ ���� ���̺��� �ۼ��Ͻÿ�.
CREATE TABLE TB_CLASS_TYPE(
    NO VARCHAR2(5) PRIMARY KEY
  , NAME VARCHAR2(10)
);

-- 3. TB_CATAGORY ���̺��� NAME �÷��� PRIMARY KEY �� �����Ͻÿ�.
-- (KEY �̸��� �������� �ʾƵ� ������. ���� KEY �̸� �����ϰ��� �Ѵٸ� �̸��� ������
-- �˾Ƽ� ������ �̸��� ����Ѵ�.)
ALTER TABLE TB_CATEGORY 
ADD CONSTRAINT PK_NAME PRIMARY KEY(NAME);

-- 4. TB_CLASS_TYPE ���̺��� NAME �÷��� NULL ���� ���� �ʵ��� �Ӽ��� �����Ͻÿ�
ALTER TABLE TB_CLASS_TYPE
MODIFY NAME CONSTRAINT NN_NAME NOT NULL;

-- 5. �� ���̺��� �÷� ���� NO �� ���� ���� Ÿ���� �����ϸ鼭 ũ��� 10 ����, �÷�����
-- NAME �� ���� ���������� ���� Ÿ���� �����ϸ鼭 ũ�� 20 ���� �����Ͻÿ�.
ALTER TABLE TB_CATEGORY
MODIFY NAME VARCHAR2(20);

ALTER TABLE TB_CLASS_TYPE
MODIFY NO VARCHAR2(10)
MODIFY NAME VARCHAR2(20);

-- 6. �� ���̺��� NO �÷��� NAME �÷��� �̸��� �� �� TB_ �� ������ ���̺� �̸��� �տ�
-- ���� ���·� �����Ѵ�.
ALTER TABLE TB_CATEGORY
RENAME COLUMN NAME TO CATEGORY_NAME;

ALTER TABLE TB_CLASS_TYPE
RENAME COLUMN NO TO CLASS_TYPE_NO;

ALTER TABLE TB_CLASS_TYPE
RENAME COLUMN NAME TO CLASS_TYPE_NAME;

-- 7. TB_CATAGORY ���̺�� TB_CLASS_TYPE ���̺��� PRIMARY KEY �̸��� ������ ����
-- �����Ͻÿ�.
-- Primary Key �� �̸��� ?PK_ + �÷��̸�?���� �����Ͻÿ�. (ex. PK_CATEGORY_NAME )
ALTER TABLE TB_CATEGORY
RENAME CONSTRAINT PK_NAME TO PK_CATEGORY_NAME; 

ALTER TABLE TB_CLASS_TYPE
RENAME CONSTRAINT SYS_C007503 TO PK_CLASS_TYPE_NEME;

-- 8. ������ ���� INSERT ���� �����Ѵ�.
INSERT INTO TB_CATEGORY VALUES ('����','Y');
INSERT INTO TB_CATEGORY VALUES ('�ڿ�����','Y');
INSERT INTO TB_CATEGORY VALUES ('����','Y');
INSERT INTO TB_CATEGORY VALUES ('��ü��','Y');
INSERT INTO TB_CATEGORY VALUES ('�ι���ȸ','Y');
COMMIT; 

-- 9.TB_DEPARTMENT �� CATEGORY �÷��� TB_CATEGORY ���̺��� CATEGORY_NAME �÷��� �θ�
-- ������ �����ϵ��� FOREIGN KEY �� �����Ͻÿ�. �� �� KEY �̸���
-- FK_���̺��̸�_�÷��̸����� �����Ѵ�. (ex. FK_DEPARTMENT_CATEGORY )
ALTER TABLE TB_DEPARTMENT
ADD CONSTRAINT FK_DEPARTMENT_CATEGORY
FOREIGN KEY (CATEGORY) REFERENCES TB_CATEGORY(CATEGORY_NAME);

-- 10.�� ������б� �л����� �������� ���ԵǾ� �ִ� �л��Ϲ����� VIEW �� ������� �Ѵ�. 
-- �Ʒ� ������ �����Ͽ� ������ SQL ���� �ۼ��Ͻÿ�.
GRANT CREATE VIEW TO C##HOMEWORK;
CREATE OR REPLACE VIEW VW_�л��Ϲ�����
(
  �й�
, �л��̸�
, �ּ�
)
AS
SELECT
       STUDENT_NO
     , STUDENT_NAME
     , STUDENT_ADDRESS
  FROM TB_STUDENT;
  
-- 11. �� ������б��� 1 �⿡ �� ���� �а����� �л��� ���������� ���� ����� �����Ѵ�. 
-- �̸� ���� ����� �л��̸�, �а��̸�, ��米���̸� ���� �����Ǿ� �ִ� VIEW �� ����ÿ�.
-- �̶� ���� ������ ���� �л��� ���� �� ������ ����Ͻÿ� (��, �� VIEW �� �ܼ� SELECT 
-- ���� �� ��� �а����� ���ĵǾ� ȭ�鿡 �������� ����ÿ�.)
CREATE OR REPLACE VIEW VW_�������
(
  �л��̸�
, �а��̸�
, ���������̸�
)
AS
SELECT
       S.STUDENT_NAME
     , D.DEPARTMENT_NAME
     , P.PROFESSOR_NAME
  FROM TB_STUDENT S
  LEFT JOIN TB_PROFESSOR P ON (P.DEPARTMENT_NO = D.DEPARTMENT_NO)
  LEFT JOIN TB_DEPARTMENT D ON (S.DEPARTMENT_NO = D.DEPARTMENT_NO)
  ORDER BY D.DEPARTMENT_NAME;
  
SELECT
       V.*
  FROM VW_������� V;
  
CREATE OR REPLACE VIEW VW_�������
(
  �л��̸�
, �а��̸�
, ���������̸�
)
AS 
SELECT 
       S.STUDENT_NAME
     , D.DEPARTMENT_NAME
     , NVL(P.PROFESSOR_NAME, '�������� ����')
  FROM 
       TB_STUDENT S
     , TB_DEPARTMENT D
     , TB_PROFESSOR P
 WHERE S.DEPARTMENT_NO = D.DEPARTMENT_NO
   AND S.COACH_PROFESSOR_NO = P.PROFESSOR_NO(+)
 ORDER BY 2;

       
-- 12. ��� �а��� �а��� �л� ���� Ȯ���� �� �ֵ��� ������ VIEW �� �ۼ��� ����.
CREATE OR REPLACE VIEW VW_�а����л���
AS
SELECT
       D.DEPARTMENT_NAME "DEPARTMENT_NAME"
     , STUDENT_COUNT
  FROM (SELECT
            DEPARTMENT_NO
         , COUNT(*) "STUDENT_COUNT"
         FROM TB_STUDENT
         GROUP BY DEPARTMENT_NO) S
  JOIN TB_DEPARTMENT D ON(D.DEPARTMENT_NO = S.DEPARTMENT_NO);
  
CREATE OR REPLACE VIEW VW_�а����л���
(
  DEPARTMENT_NAME
, STUDENT_COUNT
)
AS 
SELECT 
       D.DEPARTMENT_NAME
     , COUNT(*)
  FROM TB_DEPARTMENT D
     , TB_STUDENT S
 WHERE D.DEPARTMENT_NO = S.DEPARTMENT_NO
 GROUP BY D.DEPARTMENT_NAME;
 
  
-- 13.������ ������ �л��Ϲ����� View �� ���ؼ� �й��� A213046 �� �л��� �̸��� ����
-- �̸����� �����ϴ� SQL ���� �ۼ��Ͻÿ�.
UPDATE
       VW_�л��Ϲ�����
   SET �л��̸� = '���μ�'
 WHERE �й� = 'A213046';

SELECT
    �л��̸�
 ,  �й�
 FROM VW_�л��Ϲ�����
 WHERE �й� = 'A213046';
 
-- 14. 13�������� ���� VIEW �� ���ؼ� �����Ͱ� ����� �� �ִ� ��Ȳ�� �������� VIEW ��
-- ��� �����ؾ� �ϴ��� �ۼ��Ͻÿ�.

-- WITH READ ONLY�� �����

GRANT CREATE VIEW TO C##HOMEWORK;
CREATE OR REPLACE VIEW VW_�л��Ϲ�����
(
  �й�
, �л��̸�
, �ּ�
)
AS
SELECT
       STUDENT_NO
     , STUDENT_NAME
     , STUDENT_ADDRESS
  FROM TB_STUDENT
  WITH READ ONLY;







       

       




 
