--------------------------------------------------------------
-- ���������� ���� ����
CREATE USER C##OHGIRAFFERS IDENTIFIED BY OHGIRAFFERS;
GRANT RESOURCE, CONNECT TO C##OHGIRAFFERS;
ALTER USER C##OHGIRAFFERS QUOTA UNLIMITED ON USERS;

-----------------------------------------------------------------------------
----------�ܼ� ���� ���α׷� ���� ����
CREATE USER C##YUMMY IDENTIFIED BY YUMMY;
GRANT RESOURCE, CONNECT TO C##YUMMY;
ALTER USER C##YUMMY QUOTA UNLIMITED ON USERS;