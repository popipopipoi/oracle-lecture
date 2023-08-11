-- 1. 4�� ���̺� ���Ե� ������ �� ���� ���ϴ� SQL ������ ����� SQL ������ �ۼ��Ͻÿ�
SELECT
       'SELECT COUNT(*) FROM '||TABLE_NAME||';'
    FROM USER_TABLES;

SELECT
    'TB_BOOK' AS ���̺�,
    COUNT(*) AS "������ �� ��"
FROM
    TB_BOOK
UNION ALL
SELECT
    'TB_BOOK_AUTHOR' AS ���̺�,
    COUNT(*) AS "������ �� ��"
FROM
    TB_BOOK_AUTHOR
UNION ALL
SELECT
    'TB_PUBLISHER' AS ���̺�,
    COUNT(*) AS "������ �� ��"
FROM
    TB_PUBLISHER
UNION ALL
SELECT
    'TB_WRITER' AS ���̺�,
    COUNT(*) AS "������ �� ��"
FROM
    TB_WRITER;
    
    select 
    (select count(*) from tb_book) as "�����������̺�",
    (select count(*) from tb_book_author)as "���ڰ������̺�",
    (select count(*) from tb_publisher)as "���ǻ�������̺�",
    (select count(*) from tb_writer) as "�۰��������̺�"
from dual;
    
-- 2. 4�� ���̺��� ������ �ľ��Ϸ��� �Ѵ�. ���õ� ���ó�� TABLE_NAME, COLUMN_NAME, DATA_TYPE,
-- DATA_DEFAULT, NULLABLE, CONSTRAINT_NAME, CONSTRAINT_TYPE, R_CONSTRAINT_NAME ����
-- ��ȸ�ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT 
       UCT.TABLE_NAME
     , UCT.COLUMN_NAME
     , UCT.DATA_TYPE
     , UCT.DATA_DEFAULT
     , UCT.NULLABLE
     , UC.CONSTRAINT_NAME
     , UC.CONSTRAINT_TYPE
     , UC.R_CONSTRAINT_NAME
 FROM USER_TAB_COLUMNS UCT
 JOIN USER_CONSTRAINTS UC
   ON UCT.TABLE_NAME = UC.TABLE_NAME
  AND CONSTRAINT_NAME = (
  SELECT R_CONSTRAINT_NAME
  FROM USER_CONSTRAINTS
   WHERE ROWNUM = 1)
 ORDER BY 2;
 
 
SELECT * FROM USER_TAB_COLUMNS;
SELECT * FROM USER_CONSTRAINTS;
 
-- 3. �������� 25�� �̻��� å ��ȣ�� �������� ȭ�鿡 ����ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT
       BOOK_NO
     , BOOK_NM
  FROM TB_BOOK
 WHERE LENGTH(BOOK_NM) >= 25;
 
-- 4. �޴��� ��ȣ�� ��019���� �����ϴ� �达 ���� ���� �۰��� �̸������� �������� �� ���� ���� ǥ�õǴ� �۰�
-- �̸��� �繫�� ��ȭ��ȣ, �� ��ȭ��ȣ, �޴��� ��ȭ��ȣ�� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT
       WRITER_NM
     , OFFICE_TELNO
     , HOME_TELNO
     , MOBILE_NO
  FROM (SELECT
               WRITER_NM
             , OFFICE_TELNO
             , HOME_TELNO
             , MOBILE_NO
          FROM TB_WRITER
         WHERE MOBILE_NO LIKE '019%'
           AND WRITER_NM LIKE '��%'
         ORDER BY 1)
 WHERE ROWNUM = 1 ;
 
-- 5. ���� ���°� ���ű衱�� �ش��ϴ� �۰����� �� �� ������ ����ϴ� SQL ������ �ۼ��Ͻÿ�. (��� �����
-- ���۰�(��)������ ǥ�õǵ��� �� ��) 
SELECT
       COUNT(*) "�۰�(��)"
  FROM TB_BOOK_AUTHOR
 WHERE COMPOSE_TYPE = '�ű�';
 
-- 6. 300�� �̻� ��ϵ� ������ ���� ���� �� ��ϵ� ���� ������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.(����
-- ���°� ��ϵ��� ���� ���� ������ ��)
SELECT
       COMPOSE_TYPE
     , COUNT(*)
  FROM TB_BOOK_AUTHOR
  JOIN TB_BOOK USING(BOOK_NO)
  WHERE COMPOSE_TYPE IS NOT NULL
  GROUP BY COMPOSE_TYPE
  HAVING
    COUNT(*) >= 300;
    
-- 7. ���� �ֱٿ� �߰��� �ֽ��� �̸��� ��������, ���ǻ� �̸��� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT 
       
       BOOK_NM
     , ISSUE_DATE
     , PUBLISHER_NM
  FROM (SELECT
       BOOK_NM
     , ISSUE_DATE
     , PUBLISHER_NM
     FROM TB_BOOK
     ORDER BY ISSUE_DATE DESC)  
 WHERE ROWNUM = 1 ;
 
-- 8. ���� ���� å�� �� �۰� 3���� �̸��� ������ ǥ���ϵ�, ���� �� ������� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
-- ��, ��������(��٣���) �۰��� ���ٰ� �����Ѵ�. (��� ����� ���۰� �̸���, ���� ������ ǥ�õǵ��� ��
-- ��)
SELECT
       "�۰� �̸�" 
     , "�� ��"
  FROM (SELECT
               WRITER_NM "�۰� �̸�"
             , COUNT(*) "�� ��"
          FROM TB_WRITER 
          JOIN TB_BOOK_AUTHOR USING(WRITER_NO)
        GROUP BY WRITER_NM
        ORDER BY COUNT(*) DESC
      ) 
      WHERE ROWNUM BETWEEN 1 AND 3;
      
-- 9. �۰� ���� ���̺��� ��� ������� �׸��� �����Ǿ� �ִ� �� �߰��Ͽ���. ������ ������� ���� �� �۰���
-- ������ ���ǵ����� �����ϰ� ������ ��¥���� �����Ű�� SQL ������ �ۼ��Ͻÿ�. (COMMIT ó���� ��)
COMMIT;
UPDATE TB_WRITER
   SET REGIST_DATE = NULL
   WHERE ISSUE_DATE =(SELECT
               WRITER_NM "�۰� �̸�"
             , BOOK_NM
             , ISSUE_DATE
          FROM TB_WRITER W
         JOIN TB_BOOK_AUTHOR USING(WRITER_NO)
         JOIN TB_BOOK B USING(BOOK_NO)
        ORDER BY ISSUE_DATE);

UPDATE TB_WRITER AS a
SET a.REGIST_DATE = p.
FROM (
  SELECT �۰�ID, MIN(���ǵ���������) AS �������ǵ���������
  FROM �۰��������̺�
  GROUP BY �۰�ID
) AS p
WHERE a.�۰�ID = p.�۰�ID;


--   SELECT
--     A.WRITER_NO
--    , A.WRITER_NM
--    ,MIN(B.ISSUE_DATE) " ���� ������"
-- FROM TB_WRITER A
-- JOIN TB_BOOK_AUTHOR BA ON A.WRITER_NO = BA.WRITER_NO


  



     
    
   
     

