-- 06. ���̺� ���� �� ���� ����

-- ���̺� ����
CREATE TABLE MEMBER(
  MEMBER_ID VARCHAR2(20),
  MEMBER_PWD VARCHAR2(20),
  MEMBER_NAME VARCHAR2(20) DEFAULT 'ȫ�浿'
);

-- �÷��� �ּ� �ޱ�
COMMENT ON COLUMN MEMBER.MEMBER_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN MEMBER.MEMBER_PWD IS 'ȸ����й�ȣ';
COMMENT ON COLUMN MEMBER.MEMBER_NAME IS 'ȸ���̸�';

-- ���̺� ��ȸ
SELECT
       *
  FROM MEMBER;
  
-- �ش� ������ �����ϰ� �ִ� ���̺�, �÷� ��ȸ ����
SELECT
       UT.*
  FROM USER_TABLES UT;
  
SELECT
       UTC.*
  FROM USER_TAB_COLUMNS UTC
 WHERE TABLE_NAME = 'MEMBER';
 
-- ���� ����

-- �ش� ������ �����ϰ� �ִ� ���� ���� ��ȸ ����
SELECT
       UC.*
  FROM USER_CONSTRAINTS UC;
  
SELECT
       UCC.*
  FROM USER_CONS_COLUMNS UCC;
  
-- NOT NULL �׽�Ʈ

-- ���� ������ ���� USER_NOCONS ���̺� ����
CREATE TABLE USER_NOCONS (
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30),
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
);

-- �˸°� ������ �Է� �� ������
INSERT 
INTO USER_NOCONS
(
USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
)
VALUES
(
1
, 'user01'
, 'pass01'
, 'ȫ�浿'
, '��'
, '010-1234-5678'
, 'hong123@greedy.com'
);
-- �ƹ��� ���� ���� ���� ���̺��� �����ϸ� �ʼ� ������ NULL�� ���� �Ǿ ���� ���� ����
INSERT
INTO USER_NOCONS
(
USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
)
VALUES
(
2
, NULL
, NULL
, NULL
, '��'
, '010-1234-5678'
, 'hong123@greedy.com'
);

-- ���̺� ��ȸ
SELECT
       *
  FROM USER_NOCONS;

-- "�÷� ����"�� NOT NULL ���� ������ �����Ͽ� USER_NOTNULL ���̺� ����
CREATE TABLE USER_NOTNULL (
    USER_NO NUMBER NOT NULL,
    USER_ID VARCHAR2(20) NOT NULL,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30) NOT NULL,
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
);

-- USER_NOTNULL ���̺��� ���� ���� �˻�
SELECT
       UC.*
     , UCC.*
  FROM USER_CONSTRAINTS UC
  JOIN USER_CONS_COLUMNS UCC ON(UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME)
 WHERE UC.TABLE_NAME = 'USER_NOTNULL';
 
-- USER_NOTNULL ���̺� ���� ���� ���� �׽�Ʈ
-- �˸°� ������ �Է� �� ������
INSERT
INTO USER_NOTNULL
(
USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
)
VALUES
(
1
, 'user01'
, 'pass01'
, 'ȫ�浿'
, '��'
, '010-1234-5678'
, 'hong123@greedy.com'
);
-- �˸����ʰ� �Է��� ������
INSERT
INTO USER_NOTNULL
(
USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
)
VALUES
(
 2
NULL
, 'user02'
, 'pass02'
, NULL
, '��'
, '010-1234-5678'
, 'hong123@greedy.com'
);

-- UNIQUE ���� ����

-- UNIQUE ���� ������ ���� USER_NOCONS���� ������ ������ ���� �����ص� ������ ����.
-- ���̵� ���� �÷��� �ߺ��� ����ϸ� �ȵǹǷ� UNIQUE ���������� �ʿ��ϴ�.
INSERT
INTO USER_NOCONS
(
USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
)
VALUES
(
1
, 'user01'
, 'pass01'
, 'ȫ�浿'
, '��'
, '010-1234-5678'
, 'hong123@greedy.com'
);

-- UNIQUE ���� ������ "�÷� ����"���� ������ USER_UNIQUE ���̺� ����
CREATE TABLE USER_UNIQUE (
    USER_NO NUMBER,
    USER_ID VARCHAR2(20) UNIQUE NOT NULL,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
);

-- USER_UNIQUE ���̺� ���� USER_ID ���� �Ұ� �׽�Ʈ
INSERT
INTO USER_UNIQUE
(
USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
)
VALUES
(
1
, 'user01'
, 'pass01'
, 'ȫ�浿'
, '��'
, '010-1234-5678'
, 'hong123@greedy.com'
);

-- "�������Ǹ�"�� �̿��ؼ� ���� ���� �˻�
SELECT
       UCC.TABLE_NAME
     , UCC.COLUMN_NAME
     , UC.CONSTRAINT_TYPE
  FROM USER_CONSTRAINTS UC
     , USER_CONS_COLUMNS UCC
 WHERE UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME
   AND UCC.CONSTRAINT_NAME = 'SYS_C007353'; -- ������ �߻��� ���� ���� �̸��� ���

-- "���̺� ����"���� UNIQUE ���� ������ �����ϴ� USER_UNIQUE2 ���̺� ����
CREATE TABLE USER_UNIQUE2 (
    USER_NO NUMBER,
    USER_ID VARCHAR2(20) NOT NULL,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    UNIQUE(USER_ID)
);

-- USER_UNIQUE2�� USER_ID �ߺ� ���� �Ұ� �׽�Ʈ
INSERT
INTO USER_UNIQUE2
(
USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
)
VALUES
(
1
, 'user01'
, 'pass01'
, 'ȫ�浿'
, '��'
, '010-1234-5678'
, 'hong123@greedy.com'
);

-- "�������Ǹ�"�� �̿��ؼ� ���� ���� �˻�
SELECT
       UCC.TABLE_NAME
     , UCC.COLUMN_NAME
     , UC.CONSTRAINT_TYPE
  FROM USER_CONSTRAINTS UC
     , USER_CONS_COLUMNS UCC
 WHERE UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME
   AND UCC.CONSTRAINT_NAME = 'SYS_C007356';
   
-- 2�� �̻��� �÷��� ��� �ϳ��� UNIQUE ���� ���� ����
-- �� ���� ���̺� �������� �ۿ� ������ �� ����.
CREATE TABLE USER_UNIQUE3 (
    USER_NO NUMBER,
    USER_ID VARCHAR2(20) NOT NULL,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    UNIQUE(USER_NO, USER_ID)
);

--
-- USER_UNIQUE3�� USER_NO, USER_ID�� ���� �ߺ� �� �Է� �Ұ����� �׽�Ʈ
INSERT
INTO USER_UNIQUE3
(
USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
)
VALUES
(
1
, 'user01'
, 'pass01'
, 'ȫ�浿'
, '��'
, '010-1234-5678'
, 'hong123@greedy.com'
);
INSERT
INTO USER_UNIQUE3
(
USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
)
VALUES
(
1
, 'user02'
, 'pass01'
, 'ȫ�浿'
, '��'
, '010-1234-5678'
, 'hong123@greedy.com'
);
INSERT
INTO USER_UNIQUE3
(
USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
)
VALUES
(
2
, 'user01'
, 'pass01'
, 'ȫ�浿'
, '��'
, '010-1234-5678'
, 'hong123@greedy.com'
);
-- USER_NO�� USER_ID�� ��� ������ ��쿡�� �������� ����
INSERT
INTO USER_UNIQUE3
(
USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
)
VALUES
(
1
, 'user01'
, 'pass01'
, 'ȫ�浿'
, '��'
, '010-1234-5678'
, 'hong123@greedy.com'
);

-- "�������Ǹ�"�� �̿��ؼ� ���� ���� �˻�
SELECT
       UCC.TABLE_NAME
     , UCC.COLUMN_NAME
     , UC.CONSTRAINT_TYPE
  FROM USER_CONSTRAINTS UC
     , USER_CONS_COLUMNS UCC
 WHERE UC.CONSTRAINT_NAME = UCC.CONSTRAINT_NAME
   AND UCC.CONSTRAINT_NAME = 'SYS_C007359';
   
-- �������Ǹ� �ٿ��� ���̺� ����
CREATE TABLE CONS_NAME(
  TEST_DATA1 VARCHAR2(20) CONSTRAINT NN_TEST_DATA1 NOT NULL,
  TEST_DATA2 VARCHAR2(20) CONSTRAINT UN_TEST_DATA2 UNIQUE,
  TEST_DATA3 VARCHAR2(30),
  CONSTRAINT UN_TEST_DATA3 UNIQUE(TEST_DATA3)
);

-- CONS_NAME ���̺��� ���� ���� �˻�
SELECT
       UC.*
  FROM USER_CONSTRAINTS UC
 WHERE TABLE_NAME = 'CONS_NAME';
 
-- CHECK ���� ����

-- USER_CHECK ���̺� ����
CREATE TABLE USER_CHECK (
    USER_NO NUMBER,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
);

-- USER_CHECK�� GENDER�� ���� '��' OR '��' �ܿ� �Է� �Ұ����� �׽�Ʈ
INSERT
INTO USER_CHECK
(
USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
)
VALUES
(
3
, 'user03'
, 'pass03'
, '������'
, '����'
, '010-1234-5678'
, 'hong123@greedy.com'
);

-- ���̺� �������� CHECK ���� ���� ����
CREATE TABLE TEST_CHECK(
  TEST_NUMBER NUMBER,
  CONSTRAINT CK_TEST_NUMBER CHECK(TEST_NUMBER > 0)
);

-- TEST_CHECK ���̺� ���� �׽�Ʈ
INSERT
  INTO TEST_CHECK
(
  TEST_NUMBER
)
VALUES
(
  -10
);

-- PRIMARY KEY ���� ����

-- "�÷� ����"���� PK �����Ͽ� USER_PRIMARYKEY ���̺� ����
CREATE TABLE USER_PRIMARYKEY (
    USER_NO NUMBER CONSTRAINT PK_USER_NO PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
);

-- PRIMARY KEY�� NOT NULL, UNIQUE �׽�Ʈ
INSERT
INTO USER_PRIMARYKEY
(
USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
)
VALUES
(
  1
, 'user01'
, 'pass01'
, 'ȫ�浿'
, '��'
, '010-1234-5678'
, 'hong123@greedy.com'
);

-- "���̺� ����"���� PK ����(����Ű�� ����)
-- ���̺� �������� PK ����(����Ű�� ����)
CREATE TABLE USER_PRIMARYKEY2 (
    USER_NO NUMBER,
    USER_ID VARCHAR2(20),
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    CONSTRAINT PK_USER_NO2 PRIMARY KEY(USER_NO, USER_ID)
);

-- PRIMARY KEY�� NOT NULL, UNIQUE �׽�Ʈ
INSERT
INTO USER_PRIMARYKEY2
(
USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
)
VALUES
(
  1
, 'USER01'
, 'pass01'
, 'ȫ�浿'
, '��'
, '010-1234-5678'
, 'hong123@greedy.com'
);

-- FOREIGN KEY ���� ����

-- �θ� ���̺� ���� �� ������ ����
CREATE TABLE USER_GRADE(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT
INTO USER_GRADE
(
GRADE_CODE
, GRADE_NAME
)
VALUES
(
10
, '�Ϲ�ȸ��'
);

INSERT
INTO USER_GRADE
(
GRADE_CODE
, GRADE_NAME
)
VALUES
(
20
, '���ȸ��'
);

INSERT
INTO USER_GRADE
(
GRADE_CODE
, GRADE_NAME
)
VALUES
(
30
, 'Ư��ȸ��'
);

SELECT
UG.*
FROM USER_GRADE UG;

-- �ڽ� ���̺� USER_FOREIGNKEY ����
CREATE TABLE USER_FOREIGNKEY (
USER_NO NUMBER PRIMARY KEY,
USER_ID VARCHAR2(20) UNIQUE,
USER_PWD VARCHAR2(30) NOT NULL,
USER_NAME VARCHAR2(30),
GENDER VARCHAR2(10) CHECK(GENDER IN ('��', '��')),
PHONE VARCHAR2(30),
EMAIL VARCHAR2(50),
GRADE_CODE NUMBER,
CONSTRAINT FK_GRADE_CODE FOREIGN KEY(GRADE_CODE) REFERENCES USER_GRADE(GRADE_CODE)
);

INSERT
INTO USER_FOREIGNKEY
(
USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
, GRADE_CODE
)
VALUES
(
1
, 'user01'
, 'pass01'
, 'ȫ�浿'
, '��'
, '010-1234-5678'
, 'hong123@greedy.com'
, 10
);

INSERT
INTO USER_FOREIGNKEY
(
USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
, GRADE_CODE
)
VALUES
(
2
, 'user02'
, 'pass02'
, '������'
, '��'
, '010-1111-2222'
, 'yoo123@greedy.com'
, 10
);

INSERT
INTO USER_FOREIGNKEY
(
USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
, GRADE_CODE
)
VALUES
(
3
, 'user03'
, 'pass03'
, '������'
, '��'
, '010-1234-5678'
, 'yoon123@greedy.com'
, 30
);

-- FK�� NULL ���� ����Ѵ�.
INSERT
INTO USER_FOREIGNKEY
(
USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
, GRADE_CODE
)
VALUES
(
4
, 'user04'
, 'pass04'
, '��������'
, '��'
, '010-1234-5678'
, 'sun123@greedy.com'
, NULL
);

-- �θ� Ű�� ���� �ܷ�Ű ���� ���� ����
INSERT
INTO USER_FOREIGNKEY
(
USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
, GRADE_CODE
)
VALUES
(
5
, 'user05'
, 'pass05'
, '�Ż��Ӵ�'
, '��'
, '010-1234-5678'
, 'shin123@greedy.com'
, 50
);

-- �� ���̺��� �����Ͽ� ��ȸ
SELECT
       UF.USER_ID
     , UF.GENDER
     , UF.PHONE
     , UG.GRADE_NAME
  FROM USER_FOREIGNKEY UF
  LEFT JOIN USER_GRADE UG ON (UF.GRADE_CODE = UG.GRADE_CODE);
  
-- ���� �ɼ� : �θ� ���̺��� ������ ���� �� �ڽ� ���̺��� �����͸� ��� ó���� �������� ����

-- ON DELETE RESTRICT : ���� �⺻ ���� ��(���� �Ұ�)

-- FK�� ������ �÷����� ����ϰ� �����Ƿ� ���� �Ұ�
DELETE
FROM USER_GRADE
WHERE GRADE_CODE = 10;
-- �ڽ� ���ڵ�� ������ �ʴ� ���� ���� ����
DELETE
FROM USER_GRADE
WHERE GRADE_CODE = 20;

-- ON DELETE SET NULL : �θ� Ű ���� �� �ڽ� Ű�� NULL�� �����ϴ� �ɼ�

-- USER_GRADE2 ���̺� ����
CREATE TABLE USER_GRADE2(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT
INTO USER_GRADE2
(
GRADE_CODE
, GRADE_NAME
)
VALUES
(
10
, '�Ϲ�ȸ��'
);

INSERT
INTO USER_GRADE2
(
GRADE_CODE
, GRADE_NAME
)
VALUES
(
20
, '���ȸ��'
);

INSERT
INTO USER_GRADE2
(
GRADE_CODE
, GRADE_NAME
)
VALUES
(
30
, 'Ư��ȸ��'
);

SELECT
UG.*
FROM USER_GRADE2 UG;

-- USER_FOREIGNKEY2 ���̺� ����
CREATE TABLE USER_FOREIGNKEY2 (
USER_NO NUMBER PRIMARY KEY,
USER_ID VARCHAR2(20) UNIQUE,
USER_PWD VARCHAR2(30) NOT NULL,
USER_NAME VARCHAR2(30),
GENDER VARCHAR2(10) CHECK(GENDER IN ('��', '��')),
PHONE VARCHAR2(30),
EMAIL VARCHAR2(50),
GRADE_CODE NUMBER,
CONSTRAINT FK_GRADE_CODE2 FOREIGN KEY(GRADE_CODE) REFERENCES USER_GRADE2(GRADE_CODE) ON DELETE SET NULL
);

INSERT
INTO USER_FOREIGNKEY2
(
USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
, GRADE_CODE
)
VALUES
(
1
, 'user01'
, 'pass01'
, 'ȫ�浿'
, '��'
, '010-1234-5678'
, 'hong123@greedy.com'
, 10
);

INSERT
INTO USER_FOREIGNKEY2
(
USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
, GRADE_CODE
)
VALUES
(
2
, 'user02'
, 'pass02'
, '������'
, '��'
, '010-1111-2222'
, 'yoo123@greedy.com'
, 10
);

INSERT
INTO USER_FOREIGNKEY2
(
USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
, GRADE_CODE
)
VALUES
(
3
, 'user03'
, 'pass03'
, '������'
, '��'
, '010-1234-5678'
, 'yoon123@greedy.com'
, 30
);

-- FK�� NULL ���� ����Ѵ�.
INSERT
INTO USER_FOREIGNKEY2
(
USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
, GRADE_CODE
)
VALUES
(
4
, 'user04'
, 'pass04'
, '��������'
, '��'
, '010-1234-5678'
, 'sun123@greedy.com'
, NULL
);

-- �θ� Ű�� ���� �ܷ�Ű ���� ���� ����
INSERT
INTO USER_FOREIGNKEY2
(
USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
, GRADE_CODE
)
VALUES
(
5
, 'user05'
, 'pass05'
, '�Ż��Ӵ�'
, '��'
, '010-1234-5678'
, 'shin123@greedy.com'
, 50
);
-- ���� ������ �ɷ� ���� �ʾ� �ڽ� ���ڵ尡 �����ϴ��� ������ ����ȴ�.
DELETE
  FROM USER_GRADE2
 WHERE GRADE_CODE = 10;
 
SELECT
       *
  FROM USER_GRADE2;
-- ��, ���� �� ���� ������ ���� �����Ƿ� NULL ������ ���� �ȴ�.
SELECT
       *
  FROM USER_FOREIGNKEY2;
  
-- ON DELETE CASCADE : �θ� Ű ���� �� �ڽ� Ű�� ���� �൵ ����
-- USER_GRADE3 ���̺� ����
CREATE TABLE USER_GRADE3(
    GRADE_CODE NUMBER PRIMARY KEY,
    GRADE_NAME VARCHAR2(30) NOT NULL
);

INSERT
INTO USER_GRADE3
(
GRADE_CODE
, GRADE_NAME
)
VALUES
(
10
, '�Ϲ�ȸ��'
);

INSERT
INTO USER_GRADE3
(
GRADE_CODE
, GRADE_NAME
)
VALUES
(
20
, '���ȸ��'
);

INSERT
INTO USER_GRADE3
(
GRADE_CODE
, GRADE_NAME
)
VALUES
(
30
, 'Ư��ȸ��'
);

SELECT
UG.*
FROM USER_GRADE3 UG;

-- USER_FOREIGNKEY3 ���̺� ����
CREATE TABLE USER_FOREIGNKEY3 (
    USER_NO NUMBER PRIMARY KEY,
    USER_ID VARCHAR2(20) UNIQUE,
    USER_PWD VARCHAR2(30) NOT NULL,
    USER_NAME VARCHAR2(30),
    GENDER VARCHAR2(10) CHECK(GENDER IN ('��', '��')),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50),
    GRADE_CODE NUMBER,
    CONSTRAINT FK_GRADE_CODE3 FOREIGN KEY(GRADE_CODE) REFERENCES USER_GRADE3(GRADE_CODE) ON DELETE CASCADE
);

INSERT
INTO USER_FOREIGNKEY3
(
USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
, GRADE_CODE
)
VALUES
(
1
, 'user01'
, 'pass01'
, 'ȫ�浿'
, '��'
, '010-1234-5678'
, 'hong123@greedy.com'
, 10
);

INSERT
INTO USER_FOREIGNKEY3
(
USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
, GRADE_CODE
)
VALUES
(
2
, 'user02'
, 'pass02'
, '������'
, '��'
, '010-1111-2222'
, 'yoo123@greedy.com'
, 10
);

INSERT
INTO USER_FOREIGNKEY3
(
USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
, GRADE_CODE
)
VALUES
(
3
, 'user03'
, 'pass03'
, '������'
, '��'
, '010-1234-5678'
, 'yoon123@greedy.com'
, 30
);

-- FK�� NULL ���� ����Ѵ�.
INSERT
INTO USER_FOREIGNKEY3
(
USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
, GRADE_CODE
)
VALUES
(
4
, 'user04'
, 'pass04'
, '��������'
, '��'
, '010-1234-5678'
, 'sun123@greedy.com'
, NULL
);

-- �θ� Ű�� ���� �ܷ�Ű ���� ���� ����
INSERT
INTO USER_FOREIGNKEY3
(
USER_NO
, USER_ID
, USER_PWD
, USER_NAME
, GENDER
, PHONE
, EMAIL
, GRADE_CODE
)
VALUES
(
5
, 'user05'
, 'pass05'
, '�Ż��Ӵ�'
, '��'
, '010-1234-5678'
, 'shin123@greedy.com'
, 50
);
-- ���� ������ �ɷ� ���� �ʾ� �ڽ� ���ڵ尡 �����ص� ���� ����
DELETE
  FROM USER_GRADE3
 WHERE GRADE_CODE = 10;

SELECT
       *
  FROM USER_GRADE3;
-- ��, CASCADE ������ ��� �ڽ� ���̺��� �ش� �൵ �Բ� �����Ѵ�.  
SELECT
       *
  FROM USER_FOREIGNKEY3;

-- ���������� �̿��� ���̺� ����
CREATE TABLE EMPLOYEE_COPY
AS
SELECT
       E.*
  FROM EMPLOYEE E;
-- �÷���, ������ Ÿ��, �� ���� �ǰ�, ���� ������ NOT NULL�� ���� �ȴ�.
SELECT
       *
  FROM EMPLOYEE_COPY;
  
-- ȸ�� ���Կ� ���̺� ����(USER_TEST)---------------------------------------------
-- �÷��� : USER_NO(ȸ����ȣ)- PK ����
--         USER_ID(ȸ�����̵�) -- �ߺ� ����, NULL�� ��� ����
--         USER_PWD(ȸ����й�ȣ) -- NULL�� ��� ����
--         GENDER(����) -- '��' �Ǵ� '��'�� �Է�
--         PHONE(����ó) 
--         ADDRESS(�ּ�)
--         STATUS(Ż�𿩺�) -- NOT NULL, 'Y' Ȥ�� 'N'���� �Է�
-- �� ���� ���ǿ� ��� �������Ǹ� �ο�
-- �� �÷����� �ڸ�Ʈ ����
-- 5�� �̻� ȸ�� ���� INSERT  



CREATE TABLE USER_TEST (
    USER_NO NUMBER CONSTRAINT PK1_USER_NO PRIMARY KEY,
    USER_ID VARCHAR2(20) CONSTRAINT UN_USER_ID UNIQUE CONSTRAINT UK_USER_ID NOT NULL,
    USER_PWD VARCHAR2(20) CONSTRAINT NU_USER_PWD NOT NULL,
    GENDER VARCHAR2(3) CONSTRAINT CC_GENDER CHECK(GENDER IN('��', '��')),
    PHONE NUMBER(20),
    ADDRESS VARCHAR(100),
    STATUS VARCHAR2(3) CONSTRAINT NN_STATUS NOT NULL,
      CONSTRAINT CN_STATUS CHECK(STATUS IN('Y', 'N')) 
);

COMMENT ON COLUMN USER_TEST.USER_NO IS 'ȸ����ȣ';
COMMENT ON COLUMN USER_TEST.USER_ID IS 'ȸ�����̵�';
COMMENT ON COLUMN USER_TEST.USER_PWD IS 'ȸ����й�ȣ';
COMMENT ON COLUMN USER_TEST.GENDER IS '����';
COMMENT ON COLUMN USER_TEST.PHONE IS '����ó';
COMMENT ON COLUMN USER_TEST.ADDRESS IS '�ּ�';
COMMENT ON COLUMN USER_TEST.STATUS IS 'Ż�𿩺�';

INSERT 
  INTO USER_TEST
(
  USER_NO, USER_ID, USER_PWD
, GENDER, PHONE
, ADDRESS, STATUS
)
VALUES
(
  1, 'user01', 'pass01'
, '��', '010-1234-5678'
, '����� ������ ���ﵿ', 'N'
);

INSERT 
  INTO USER_TEST
(
  USER_NO, USER_ID, USER_PWD
, GENDER, PHONE
, ADDRESS, STATUS
)
VALUES
(
  2, 'user02', 'pass02'
, '��', '010-1234-5679'
, '����� ������ ���ﵿ', 'N'
);

INSERT 
  INTO USER_TEST
(
  USER_NO, USER_ID, USER_PWD
, GENDER, PHONE
, ADDRESS, STATUS
)
VALUES
(
  3, 'user03', 'pass03'
, '��', '010-1234-5670'
, '����� ������ ���ﵿ', 'Y'
);

INSERT 
  INTO USER_TEST
(
  USER_NO, USER_ID, USER_PWD
, GENDER, PHONE
, ADDRESS, STATUS
)
VALUES
(
  4, 'user04', 'pass04'
, '��', '010-1234-5671'
, '����� ������ ���ﵿ', 'N'
);

INSERT 
  INTO USER_TEST
(
  USER_NO, USER_ID, USER_PWD
, GENDER, PHONE
, ADDRESS, STATUS
)
VALUES
(
  5, 'user05', 'pass05'
, '��', '010-1234-5672'
, '����� ������ ���ﵿ', 'N'
);

SELECT
       *
  FROM USER_TEST;


