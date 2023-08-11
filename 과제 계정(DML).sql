-- 1. �������� ���̺�(TB_CLASS_TYPE)�� �Ʒ��� ���� �����͸� �Է��Ͻÿ�.
INSERT
  INTO TB_CLASS_TYPE
(
  class_type_no
, class_type_name
)
VALUES
(
  01
, '�����ʼ�'
);
INSERT
  INTO TB_CLASS_TYPE
(
  class_type_no
, class_type_name
)
VALUES
(
  02
, '��������'
);
INSERT
  INTO TB_CLASS_TYPE
(
  class_type_no
, class_type_name
)
VALUES
(
  03
, '�����ʼ�'
);
INSERT
  INTO TB_CLASS_TYPE
(
  class_type_no
, class_type_name
)
VALUES
(
  04
, '���缱��'
);
INSERT
  INTO TB_CLASS_TYPE
(
  class_type_no
, class_type_name
)
VALUES
(
  05
, '������'
);

-- 2.  �� ������б� �л����� ������ ���ԵǾ� �ִ� �л��Ϲ����� ���̺��� ������� �Ѵ�. 
-- �Ʒ� ������ �����Ͽ� ������ SQL ���� �ۼ��Ͻÿ�. (���������� �̿��Ͻÿ�)
CREATE OR REPLACE VIEW TB_�л��Ϲ�����
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
  
-- 3. ������а� �л����� �������� ���ԵǾ� �ִ� �а����� ���̺��� ������� �Ѵ�. 
-- �Ʒ� ������ �����Ͽ� ������ SQL ���� �ۼ��Ͻÿ�. (��Ʈ : ����� �پ���, �ҽŲ�
-- �ۼ��Ͻÿ�)
CREATE OR REPLACE VIEW TB_������а�
(
  �й�
, �л��̸�
, ����⵵
, �����̸�
)
AS
SELECT
       STUDENT_NO
     , STUDENT_NAME
     , STUDENT_SSN
     , PROFESSOR_NAME
  FROM (SELECT
                         STUDENT_SSN (EXTRACT(YEAR FROM (TO_DATE(SUBSTR(STUDENT_SSN, 1, 2), 'RR')))) 
                   FROM TB_STUDENT) V                        
  JOIN TB_PROFESSOR P ON(V.DEPARTMENT = P.DEPARTMENT);
  
-- 4. �� �а����� ������ 10% ������Ű�� �Ǿ���. �̿� ����� SQL ���� �ۼ��Ͻÿ�. (��, 
--  �ݿø��� ����Ͽ� �Ҽ��� �ڸ����� ������ �ʵ��� �Ѵ�)
CREATE SEQUENCE SEQ_DEPUP
START 



