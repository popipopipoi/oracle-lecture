- 1. 4�� ���̺� ���Ե� ������ �� ���� ���ϴ� SQL ������ ����� SQL ������ �ۼ��Ͻÿ�
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

```
select
(select count(*) from tb_book) as "�����������̺�",
(select count(*) from tb_book_author)as "���ڰ������̺�",
(select count(*) from tb_publisher)as "���ǻ�������̺�",
(select count(*) from tb_writer) as "�۰��������̺�"

```

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

- - 3. �������� 25�� �̻��� å ��ȣ�� �������� ȭ�鿡 ����ϴ� SQL ���� �ۼ��Ͻÿ�.
SELECT
BOOK_NO
, BOOK_NM
FROM TB_BOOK
WHERE LENGTH(BOOK_NM) >= 25;
- - 4. �޴��� ��ȣ�� ��019���� �����ϴ� �达 ���� ���� �۰��� �̸������� �������� �� ���� ���� ǥ�õǴ� �۰�
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
- - 5. ���� ���°� ���ű衱�� �ش��ϴ� �۰����� �� �� ������ ����ϴ� SQL ������ �ۼ��Ͻÿ�. (��� �����
-- ���۰�(��)������ ǥ�õǵ��� �� ��)
SELECT
COUNT(*) "�۰�(��)"
FROM TB_BOOK_AUTHOR
WHERE COMPOSE_TYPE = '�ű�';
- - 6. 300�� �̻� ��ϵ� ������ ���� ���� �� ��ϵ� ���� ������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.(����
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

- - 8. ���� ���� å�� �� �۰� 3���� �̸��� ������ ǥ���ϵ�, ���� �� ������� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
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

UPDATE TB_WRITER TW
   SET(TW.REGIST_DATE) = (SELECT MIN(ISSUE_DATE)
                         FROM TB_BOOK TB
                         JOIN TB_BOOK_AUTHOR TBA USING(BOOK_NO)
                        WHERE TW.WRITER_NO = TBA.WRITER_NO);
                       
COMMIT;         
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

- - SELECT
-- A.WRITER_NO
-- , A.WRITER_NM
-- ,MIN(B.ISSUE_DATE) " ���� ������"
-- FROM TB_WRITER A
-- JOIN TB_BOOK_AUTHOR BA ON A.WRITER_NO = BA.WRITER_NO

-- 10.���� �������� ���� ���̺��� ������ �������� ���� ���� �����ϰ� �ִ�. �����δ� �������� ���� �����Ϸ�
-- �Ѵ�. ���õ� ���뿡 �°� ��TB_BOOK_ TRANSLATOR�� ���̺��� �����ϴ� SQL ������ �ۼ��Ͻÿ�. 
-- Primary Key ���� ���� �̸��� ��PK_BOOK_TRANSLATOR���� �ϰ�, Reference ���� ���� �̸���
-- ��FK_BOOK_TRANSLATOR_01��, ��FK_BOOK_TRANSLATOR_02���� �� ��)
CREATE TABLE TB_BOOK_TRANSLATOR(
  BOOK_NO VARCHAR2(10) CONSTRAINT FK_BOOK_TRANSLATOR_01  REFERENCES TB_BOOK(BOOK_NO) NOT NULL,
  WRITER_NO VARCHAR2(10) CONSTRAINT FK_BOOK_TRANSLATOR_02 REFERENCES TB_WRITER(WRITER_NO) NOT NULL,
  TRANS_LANG VARCHAR2(60),
  CONSTRAINT PK_BOOK_TRANSLATOR PRIMARY KEY(BOOK_NO, WRITER_NO)
);
COMMIT;
-- 11. ���� ���� ����(compose_type)�� '�ű�', '����', '��', '����'�� �ش��ϴ� �����ʹ�
-- ���� ���� ���� ���̺��� ���� ���� ���� ���̺�(TB_BOOK_ TRANSLATOR)�� �ű�� SQL 
-- ������ �ۼ��Ͻÿ�. ��, ��TRANS_LANG�� �÷��� NULL ���·� �ε��� �Ѵ�. (�̵��� �����ʹ� ��
-- �̻� TB_BOOK_AUTHOR ���̺� ���� ���� �ʵ��� ������ ��)
                              
INSERT 
  INTO TB_BOOK_TRANSLATOR (BOOK_NO, WRITER_NO)
SELECT BOOK_NO, WRITER_NO
  FROM TB_BOOK_AUTHOR
WHERE COMPOSE_TYPE IN ('�ű�', '����', '��', '����');

COMMENT;

DELETE FROM TB_BOOK_AUTHOR WHERE BOOK_NO IN(SELECT BOOK_NO FROM TB_BOOK_TRANSLATOR);
DELETE FROM TB_BOOK_AUTHOR WHERE WRITER_NO IN(SELECT WRITER_NO FROM TB_BOOK_TRANSLATOR);
-- 12. 2007�⵵�� ���ǵ� ������ �̸��� ������(����)�� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT
       BOOK_NM
     , WRITER_NM
  FROM TB_BOOK
   JOIN TB_BOOK_TRANSLATOR USING(BOOK_NO)
   JOIN TB_WRITER USING(WRITER_NO)
 WHERE SUBSTR(ISSUE_DATE, 1,2) = '07';
 
-- 13. 12�� ����� Ȱ���Ͽ� ��� ���������� �������� ������ �� ������ �ϴ� �並 �����ϴ� SQL
-- ������ �ۼ��Ͻÿ�. (�� �̸��� ��VW_BOOK_TRANSLATOR���� �ϰ� ������, ������, ��������
-- ǥ�õǵ��� �� ��)
GRANT CREATE VIEW TO C##FINAL;
CREATE OR REPLACE VIEW VW_BOOK_TRANSLATOR
AS
  SELECT
         BOOK_NM
       , WRITER_NM
       , ISSUE_DATE
   FROM TB_BOOK
   JOIN TB_BOOK_TRANSLATOR USING(BOOK_NO)
   JOIN TB_WRITER USING(WRITER_NO)
 WHERE SUBSTR(ISSUE_DATE, 1,2) = '07'
 WITH READ ONLY;
 
COMMENT ON COLUMN VW_BOOK_TRANSLATOR.BOOK_NM IS '������';

-- 14. ���ο� ���ǻ�(�� ���ǻ�)�� �ŷ� ����� �ΰ� �Ǿ���. ���õ� ���� ������ �Է��ϴ� SQL
-- ������ �ۼ��Ͻÿ�.(COMMIT ó���� ��)
INSERT
  INTO TB_PUBLISHER
(
PUBLISHER_NM,
PUBLISHER_TELNO
)
VALUES
('�� ���ǻ�',
'02-6710-3737'
);
COMMIT;

-- 15.��������(��٣���) �۰��� �̸��� ã������ �Ѵ�. �̸��� �������� ���ڸ� ǥ���ϴ� SQL ������
-- �ۼ��Ͻÿ�.
SELECT
      WRITER_NM
    , COUNT(*) "�������� ����"
  FROM TB_WRITER 
  GROUP BY WRITER_NM
  HAVING COUNT(*) > 1;
  
-- 16. ������ ���� ���� �� ���� ����(compose_type)�� ������ �����͵��� ���� �ʰ� �����Ѵ�. �ش� �÷���
-- NULL�� ��� '����'���� �����ϴ� SQL ������ �ۼ��Ͻÿ�.(COMMIT ó���� ��)
UPDATE TB_BOOK_AUTHOR
  SET COMPOSE_TYPE = '����'
 WHERE COMPOSE_TYPE IS NULL;
 
-- 17. �������� �۰� ������ �����Ϸ��� �Ѵ�. �繫���� �����̰�, �繫�� ��ȭ ��ȣ ������ 3�ڸ��� �۰���
-- �̸��� �繫�� ��ȭ ��ȣ�� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT
       WRITER_NM
     , OFFICE_TELNO
  FROM TB_WRITER
  WHERE OFFICE_TELNO LIKE '02_%';
  
-- 18. 2006�� 1�� �������� ��ϵ� �� 31�� �̻� �� �۰� �̸��� �̸������� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�.
SELECT
       WRITER_NM
    , REGIST_DATE
  FROM TB_WRITER
 WHERE ADD_MONTHS(REGIST_DATE, 372) <= DATE '2006-01-01'
 ORDER BY 1;
  
-- 19. ���� ��� �ٽñ� �α⸦ ��� �ִ� 'Ȳ�ݰ���' ���ǻ縦 ���� ��ȹ���� ������ �Ѵ�. 'Ȳ�ݰ���' 
-- ���ǻ翡�� ������ ���� �� ��� ������ 10�� �̸��� ������� ����, �����¸� ǥ���ϴ� SQL ������
-- �ۼ��Ͻÿ�. ��� ������ 5�� �̸��� ������ ���߰��ֹ��ʿ䡯��, �������� ���ҷ��������� ǥ���ϰ�, 
-- �������� ���� ��, ������ ������ ǥ�õǵ��� �Ѵ�.
SELECT
       BOOK_NM
     , PRICE
     , CASE
        WHEN STOCK_QTY < 5 THEN '�߰��ֹ��ʿ�'
        ELSE '�ҷ�����'
        END "��� ����"
  FROM TB_BOOK
 WHERE PUBLISHER_NM = 'Ȳ�ݰ���'
   AND STOCK_QTY < 10;
   
-- 20. '��ŸƮ��' ���� �۰��� ���ڸ� ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�. (��� �����
-- ��������,�����ڡ�,�����ڡ��� ǥ���� ��)
SELECT
       BOOK_NM ������
     , WRITER_NM ����
     , TRANS_LANG ����
  FROM TB_BOOK_TRANSLATOR
  JOIN TB_WRITER USING(WRITER_NO)
  JOIN TB_BOOK USING(BOOK_NO)
 WHERE BOOK_NM = '��ŸƮ��';
 
-- 21. ���� �������� ���� �����Ϸκ��� �� 30���� ����ǰ�, ��� ������ 90�� �̻��� ������ ���� ������, ���
-- ����, ���� ����, 20% ���� ������ ǥ���ϴ� SQL ������ �ۼ��Ͻÿ�. (��� ����� ��������, �����
-- ������, ������(Org)��, ������(New)���� ǥ���� ��. ��� ������ ���� ��, ���� ������ ���� ��, ������
-- ������ ǥ�õǵ��� �� ��)

SELECT
       BOOK_NM "������"
     , STOCK_QTY "������"
     , PRICE "����(Org)"
     , PRICE * 0.8 "����(New)"
  FROM TB_BOOK
 WHERE ADD_MONTHS(ISSUE_DATE, 30*12) <= SYSDATE
   AND STOCK_QTY >= 90
 ORDER BY STOCK_QTY DESC, PRICE * 0.8, BOOK_NM;


