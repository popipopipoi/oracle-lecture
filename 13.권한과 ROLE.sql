-- 13. ���Ѱ� ROLE

-- 1. �ý��� ����

-- <�ý��� �������� ����>
CREATE USER C##SAMPLE IDENTIFIED BY SAMPLE;

-- ������ �������� ���� �õ� �� ���� ����(CREATE SESSION)�� ��� ���� �Ұ�
-- <�ý��� �������� ����>
GRANT CREATE SESSION TO C##SAMPLE;

-- <���� �������� ����>
CREATE TABLE TEST_TABLE(
  COL1 VARCHAR2(20),
  COL2 NUMBER
);

-- ���̺� ���� ������ ���� ���� �Ұ�
-- <�ý��� �������� ����>
GRANT CREATE TABLE TO C##SAMPLE;

-- WITH ADMIN OPTION : ����ڿ��� �ý��� ������ �ο��� �� ����ϴ� �ɼ�
-- ������ �ο����� ����ڴ� �ٸ� ����ڿ��� ������ ������ �� �ִ�.

-- <�ý��� �������� ����>
GRANT CREATE SESSION TO C##SAMPLE
WITH ADMIN OPTION;
-- <�ý��� �������� ����>
CREATE USER C##SAMPLE2 IDENTIFIED BY SAMPLE2;

-- <���� �������� ����>
-- WITH ADMIN OPTION���� �ο����� CREATE SESSION ������ �ٸ� ����ڿ��� �ο� �����ϳ�
-- �� ���� ������ �ο��� �� �ִ� ������ ���� �Ұ����ϴ�.
GRANT CREATE SESSION TO C##SAMPLE2;
GRANT CREATE TABLE TO C##SAMPLE2;

-- 2. ��ü ����

-- WITH GRANT OPTION : ����ڰ� Ư�� ��ü�� �����ϰų� ������ �� �ִ� ������ �ο� �����鼭
-- �� ������ �ٸ� ����ڿ��� �ٽ� �ο��� �� �ִ� ���� �ɼ�

-- <�ý��� �������� ����>
GRANT SELECT ON C##EMPLOYEE.EMPLOYEE TO C##SAMPLE
WITH GRANT OPTION;

-- <���� �������� ����>
-- ��ȸ ������ �ο� �޾ұ� ������ SAMPLE ������ ���� EMPLOYEE ���̺� ��ȸ�� �����ϴ�.
-- �� ���� DEPARTMENT ���̺� ���� SAMPLE �������� ��ȸ �� �� ����.
SELECT
       EE.*
  FROM C##EMPLOYEE.EMPLOYEE EE;
  
SELECT
       ED.*
  FROM C##EMPLOYEE.DEPARTMENT ED;
  
-- <���� �������� ����>
-- WITH GRANT OPTION���� �ο� ���� SELECT ������ �ٸ� �������� �ο� �����ϳ�
-- �� ���� INSERT�� ���� ������ �ο��� �� ����.
GRANT SELECT ON C##EMPLOYEE.EMPLOYEE TO C##SAMPLE2;
GRANT INSERT ON C##EMPLOYEE.EMPLOYEE TO C##SAMPLE2;

-- <�ý��� �������� ����>
-- REVOKE : ���� öȸ
REVOKE SELECT ON C##EMPLOYEE.EMPLOYEE FROM C##SAMPLE;

-- <���� �������� ����>
-- ��ȸ ������ öȸ �Ǿ� ��ȸ �Ұ���
SELECT
       EE.*
  FROM C##EMPLOYEE.EMPLOYEE EE;
  
-- ����) WITH GRANT OPTION�� REVOKE�� �ٸ� ����ڿ��� �ο��� ���ѵ� �Բ� ȸ���Ѵ�.
-- WITH SAMIN OPTION�� Ư�� ������� ���Ѹ� ȸ�� �ǰ� ������ ����ڿ��� �ο��� ������
-- ȸ�� ���� �ʴ´�.

-- ROLE : ���� ���� ������ ��� ����ϴ� ��
-- ����ڿ��� �ο��� ������ �����ϰ��� �� ���� �� �Ѹ� �����ϸ� �ش� ���� ������ �ο� ����
-- ����ڵ��� ������ �ڵ����� ���� �ȴ�.

-- 1. ���� ���� �� �� : ����Ŭ ��ġ �� �ý��ۿ��� �⺻������ ����
SELECT
       GRANTEE
     , PRIVILEGE
  FROM DBA_SYS_PRIVS
 WHERE GRANTEE = 'RESOURCE'
    OR GRANTEE = 'CONNECT';
    
-- 2. ����ڰ� �����ϴ� ��
CREATE ROLE C##MYROLE; -- �� �̸��� �����ؼ� ����
GRANT CREATE VIEW, CREATE SEQUENCE TO C##MYROLE; -- ���� �� �ѿ� ���ϴ� ���ѵ��� �߰�
GRANT C##MYROLE TO C##SAMPLE; --����ڿ��� �� �ο�

-- C##MYROLE�� ���� Ȯ��
SELECT
       GRANTEE
     , PRIVILEGE
  FROM DBA_SYS_PRIVS
 WHERE GRANTEE = 'C##MYROLE';
 
-- C##SAMPLE ������ �� ���� Ȯ��
SELECT
       DRP.*
  FROM DBA_ROLE_PRIVS DRP
 WHERE GRANTEE = 'C##SAMPLE';
 
-- <���� �������� ����>
CREATE SEQUENCE SEQ_TEST;