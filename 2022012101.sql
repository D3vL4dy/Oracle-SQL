2022-0121-01)
 
 ��뿹)��� �μ��� �ο����� ��ȸ�Ͻÿ�.
       Alias �μ��ڵ�,�μ���,�ο���
       --�Ϲ� �ܺ������̳� ANSI �ܺ��������� �� �� ���� ���� FULL OUTER ���� ���
       (�ܺ� ����)
       SELECT NVL(TO_CHAR(B.DEPARTMENT_ID),'�̹���') AS �μ��ڵ�,
              NVL(B.DEPARTMENT_NAME,'��������') AS �μ���,
              COUNT(EMPLOYEE_ID) AS �ο��� --�÷����� ����ϸ� NULL�� ī��Ʈ���� ����.
              --COUNT(�⺻Ű) ���
         FROM HR.EMPLOYEES A --�μ��ڵ�:11�� (DEPART�� ���� �μ��ڵ� �� 17�� ����)
             -- HR.DEPARTMENTS B --�μ��ڵ�:27�� (EMP�� ���� NULL 1��)
         FULL OUTER JOIN HR.DEPARTMENTS B
              ON(A.DEPARTMENT_ID = B.DEPARTMENT_ID)
        GROUP BY B.DEPARTMENT_ID, B.DEPARTMENT_NAME
        ORDER BY B.DEPARTMENT_ID;
              
         
 (EMPLOYEES���̺��� ���� �μ�) --��ü 12��(NULL ����)
   SELECT DISTINCT DEPARTMENT_ID --EMP ���̺��� �ִ� �μ��ڵ带 �ߺ����� �ʰ� ���
     FROM HR.EMPLOYEES
    ORDER BY 1;  
    
 ��뿹)2005�� ��� ��ǰ�� ����/��Ǯ������ �����Ͻÿ�. --�������� ���
       Alias ��ǰ�ڵ�,��ǰ��,���Լ���,�������
       
  (2005�� ���Լ��� ����)      
   SELECT B.PROD_ID AS ��ǰ�ڵ�,
          B.PROD_NAME AS ��ǰ��,
          SUM(A.BUY_QTY) AS ���Լ���
     FROM BUYPROD A
     RIGHT OUTER JOIN PROD B ON(A.BUY_PROD = B.PROD_ID AND
           A.BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20051231'))
     GROUP BY B.PROD_ID, B.PROD_NAME   
     ORDER BY 1;
     
  (2005�� ������� ����)      
   SELECT B.PROD_ID AS ��ǰ�ڵ�,
          B.PROD_NAME AS ��ǰ��,
          SUM(A.CART_QTY) AS �������
     FROM CART A
     RIGHT OUTER JOIN PROD B ON(A.CART_PROD = B.PROD_ID AND
           A.CART_NO LIKE '2005%')
     GROUP BY B.PROD_ID, B.PROD_NAME   
     ORDER BY 1;     
           
  (�ѹ������� ����)--���� 2���� ���ÿ� �����ϸ� ������ ���� ���� > �������� ���
   SELECT B.PROD_ID AS ��ǰ�ڵ�,
          B.PROD_NAME AS ��ǰ��,
          SUM(A.BUY_QTY) AS ���Լ���,
          SUM(C.CART_QTY) AS �������
     FROM BUYPROD A
    RIGHT OUTER JOIN PROD B ON(A.BUY_PROD = B.PROD_ID AND
           A.BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20051231'))
    LEFT OUTER JOIN CART C ON(C.CART_PROD = B.PROD_ID AND
           C.CART_NO LIKE '2005%')           
    GROUP BY B.PROD_ID, B.PROD_NAME   
    ORDER BY 1;
 
  (SUBQUERY ���)
   SELECT A.PROD_ID AS ��ǰ�ڵ�,
          A.PROD_NAME AS ��ǰ��,
           AS ���Լ���,
           AS �������
     FROM PROD A,
          (2005�� ��ǰ�� ���Լ�������) B,
          (2005�� ��ǰ�� �����������) C
    WHERE A.PROD_ID = B.��ǰ�ڵ�(+) --A�� �������� B�� Ȯ��
      AND A.PROD_ID = C.��ǰ�ڵ�(+) --A�� �������� C�� Ȯ��
    ORDER BY 1;  
 
 
   SELECT A.PROD_ID AS ��ǰ�ڵ�,
          A.PROD_NAME AS ��ǰ��,
          NVL(B.BSUM,0) AS ���Լ���,
          NVL(C.CSUM,0) AS �������
     FROM PROD A,
          (SELECT BUY_PROD AS BID,
                  SUM(BUY_QTY) AS BSUM
             FROM BUYPROD
            WHERE BUY_DATE BETWEEN TO_DATE('20050101') AND ('20051231')
            GROUP BY BUY_PROD) B,
          (SELECT CART_PROD AS CID,
                  SUM(CART_QTY) AS CSUM
             FROM CART
            WHERE CART_NO LIKE '2005%'
            GROUP BY CART_PROD) C
    WHERE A.PROD_ID = B.BID(+) --A�� �������� B�� Ȯ��
      AND A.PROD_ID = C.CID(+) --A�� �������� C�� Ȯ��
    ORDER BY 1; 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 