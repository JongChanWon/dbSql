 ����¡ ó��
    . ROWNUM
    . INLINE-VIEW(����Ŭ ����)
    . ����¡ ����
    . ���ε� ����
    . 

�Լ� : ������ ���ȭ �� �ڵ�
==> ���� ���(ȣ��) �ϴ� ���� �Լ��� �����Ǿ��ִ� �κ��� �и� ==> ���������� ���̼��� ����
  �Լ��� ������� ���� ���
   ȣ���ϴ� �κп� �Լ� �ڵ带 ���� ����ؾ� �ϹǷ�, �ڵ尡 ������� ==> �������� ��������
   
 ����Ŭ �Լ��� ����
 �Է� ���� :
 . single row function
 . multi row function
 
 ������ ���� :
  . ���� �Լ� : ����Ŭ���� �������ִ� �Լ�
  . ����� ���� �Լ� : �����ڰ� ���� ������ �Լ�(pl/sql ��� ��)
  
  
  ���α׷��־��, �ĺ��̸� �ο�... �߿��� ��Ģ --���α׷��ӷν��� �߿��� ��Ģ �ĺ��̸��ο�!!
  
  DUAL TABLE
  SYS ������ ���� �ִ� ���̺�
  ����Ŭ�� ��� ����ڰ� �������� ����� �� �ִ� ���̺�
  
  �Ѱ��� ��, �ϳ��� �÷�(dummy) - ���� 'X';
  
  ��� �뵵
  1. �Լ��� �׽�Ʈ �� ����
  2. merge ����
  3. ������ ����
  
  ����Ŭ ���� �Լ� �׽�Ʈ (��ҹ��� ����)
  LOWER, UPPER, INITCAP : ���ڷ� ���ڿ� �ϳ��� �޴´�.
  -- lower �ҹ��ڷ� �ٱ���, upper �빮�ڷ� �ٱ���, initcap �տ��� �빮�ڷ� �ٱ���
  SELECT LOWER('Hello, World'), UPPER('Hello, World'), INITCAP('hello, world')
  FROM dual;
  
  SELECT empnom, 'test', LOWER('Hello, World'), UPPER('Hello, World'), INITCAP('hello, world') --�÷��� �޸��� ����
  FROM emp;
  
  �Լ��� where�� ������ ����� �����ϴ�.
  emp���̺��� SMITH ����� �̸��� �빮�ڷ� ����Ǿ� ����
  
  'smith' --�����ʹ� ��ҹ��� ����, Ű����� �Ȱ���
  
  SELECT *
  FROM emp
  
  WHERE LOWER(ename) = 'smith'; �̷������� �ۼ��ϸ� �ȵȴ�
  WHERE ename = UPPER('smith'); �ΰ��� ����߿��� �������ٴ� �Ʒ������ �ùٸ���. --�º��� �����ؼ��� �ȵȴ�.(rule)
  
  
  WHERE ename = 'smith'; ���̺��� ������ ���� �빮�ڷ� ����Ǿ� �����Ƿ� ��ȸ�Ǽ� 0
  WHERE ename = 'SMITH'; �������
  
  
  ���ڿ� ���� �Լ�
  CONCAT : 2���� ���ڿ��� �Է����� �޾�, ������ ���ڿ��� ��ȯ�Ѵ�
  SELECT CONCAT('start', 'end') -- ����� srartend
  FROM dual;
  
  SELECT table_name, tablespace_name, CONCAT('start', 'end')
       
        
  FROM user_tables;
  
  --concat �Լ��� �ۼ��ϱ�
  ==> 'SELECT * FROM ' || table_name || ';',
  
  SELECT CONCAT(CONCAT('SELECT * FROM',empno),';') id
  FROM emp;
  
  SUBSTR(���ڿ�, ���� �ε���, ���� �ε���) : ���ڿ��� �����ε��� ����.... �����ε��� ������ �κ� ���ڿ�
  �����ε����� 1���� (*java�� ���� 0����)
  
  LENGTH(���ڿ�) :  ���ڿ��� ���̸� ��ȯ
  
  INSTR(���ڿ�, ã�� ���ڿ�, [�˻� ���� �ε���]) : ���ڿ����� ã�� ���ڿ��� �����ϴ���, ������ ��� ã�� ���ڿ��� �ε���(��ġ) ��ȯ
  
  LPAD, RPAD(���ڿ�, ���߰� ���� ��ü ���ڿ� ����, [�е� ���ڿ� - �⺻ ���� ����])
  
  TRIM(���ڿ�) : ���ڿ��� �� ���� �����ϴ� ������ ����, ���ڿ� �߰��� �ִ� ������ ���� ����� �ƴ�
  
  REPLACE(���ڿ�, �˻��� ���ڿ�, ������ ���ڿ�) : ���ڿ����� �˻��� ���ڿ� ã�� ������ ���ڿ� ����� ����
  
  SELECT SUBSTR('Hello, World', 1, 8) sub,
         LENGTH('Hello, World') len,
         INSTR('Hello, World', 'o') ins,
         INSTR('Hello, World', 'o', 7) ins2, -- ó�� �����ϴ� o�� �˻��ؼ� ó������ ���° �ִ��� ��Ÿ����
         INSTR('Hello, World', 'o', INSTR('Hello, World', 'o')+1) ins3,
         LPAD('hello', 15, 'a') lp,
         RPAD('hello', 15, '*') rp,
         LPAD('hello', 15) lp, --������ ��
         RPAD('hello', 15) rp, --������ ��
         REPLACE('Hello, World', 'll', 'LL') rep,  -- �ҹ��� ll �� �빮�� LL�� �ٲ���
         TRIM('    Hello    ') tr, -- ������ ������
         TRIM('H' FROM 'Hello')tr2 -- ������ ���� �� �������� Ư�� ���ڸ� �������ش�.
  FROM dual;
  
  
  NUMBER ���� �Լ�
  ROUND(����, �ݿø� ��ġ) : �ݿø�
   ROUND(105.54, 1) : �Ҽ��� ù��° �ڸ����� ����� ���� ==> �Ҽ��� �ι�° �ڸ����� �ݿø�
    : 105.5
  TRUNC(����, ���� ��ġ) : ����
  MOD(������, ����) ������ ���� -- 10 / 2 �����⸦ ���� �� ������ ���ϴ� ��(������) ���⼭�� '10' 
  
  SELECT ROUND(105.54, 1) round, -- 105.5
         ROUND(105.55, 1) round2, -- 105.6
         ROUND(105.55, 0) round3, -- 106
         ROUND(105.55, -1) round4 -- 1�� �ڸ��� �������� ������ - �������� +
  FROM dual;
  
  
  SELECT TRUNC(105.54, 1) trunc, -- 
         TRUNC(105.55, 1) trunc2, -- 
         TRUNC(105.55, 0) trunc3, -- 
         TRUNC(105.55, -1) trunc4 -- 
  FROM dual;
  
  SELECT MOD(10, 3), sal, MOD(sal, 1000) md  --����Ʈ �������� ������ �ȵǰ� ���� �Ѵ�
  FROM emp;
  
  SELECT MOD(10, 3), sal, MOD(sal, 1000) md -- �����Ұ��� ��� ����
  FROM dual;
  
  
  SELECT *
  FROM emp;
  DESC emp;
  
  ��¥ ���� �Լ�
  SYSDATE : ������� ����Ŭ �����ͺ��̽� ������ ���� �ð�, ��¥�� ��ȯ�Ѵ�.
            �Լ������� ���ڰ� ���� �Լ�
            (���ڰ� ���� ���  JAVA : �޼ҵ�()
                             SQL  : �Լ���; --��ȣ�� ��������
 
 date type +- ���� : ���� ���ϱ� ����
 ���� 1 = �Ϸ�
 1/24 = �ѽð�
 1/24/60 = �Ϻ�
 
 ���ͷ�
  ���� : ...
  ���� : ''
  ��¥ : TO_DATE('��¥ ���ڿ�', '����')
 
 SELECT *
 FROM emp
 WHERE hiredate < TO_DATE('199001', 'YYYYMM');
 
 SELECT SYSDATE, SYSDATE +5 --5�� �� ��¥�� ����
 FROM dual;
  
 SELECT *
 FROM emp
 WHERE hiredate = TO_DATE('1980/12/17', 'YYYY-MM-DD');
 
 fn1]
 SELECT TO_DATE('2019-12-31', 'YYYY/MM/DD') LASTDAY,
        TO_DATE('2019-12-31', 'YYYY/MM/DD') -5 LASTDAY_BEFORE5
        SYSDATE now, SYSDATE-3 NOW_BEFORE3
 FROM dual;
 
 
 
 TO_DATE(���ڿ�, ����) : ���ڿ��� ���˿� �°� �ؼ��Ͽ� ��¥ Ÿ������ ����ȯ
 TO_CHAR(��¥, ����) : ��¥ Ÿ���� ���˿� �°� ���ڿ��� ��ȯ
 YYYY : �⵵
 MM : ��
 DD : ����
 D : �ְ�����(1~7, 1-�Ͽ���, 2-������ ..... 7-�����)
 IW : ���� (52~53) ��¥�� ������ �������� ���ϴ��� �� �� ����
 HH : �ð�(12�ð�)
 HH24 : 24�ð� ǥ��
 MI : ��
 SS : ��
 
 ����ð�(SYSDATE) �ú��� �������� ǥ�� ==> TO_CHAR�� �̿��Ͽ� ����ȯ
 SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') now,
        TO_CHAR(SYSDATE, 'D') day,
        TO_CHAR(SYSDATE-3, 'YYYY/MM/DD HH24:MI:SS') now_before3, --������
        TO_CHAR(SYSDATE-1/24, 'YYYY/MM/DD HH24:MI:SS') now_before_hour --�ѽð���
        
 FROM dual;
 
 fn2]
 SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') dt_dash,
        TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24-MI-SS') dt_dash_with_time,
        TO_CHAR(SYSDATE, 'DD-MM-YYYY') dt_dd_mm_yyyy --(date, format) �������� �������
 FROM dual;
 
 *MONTHS_BETWEEN(DATE1, DATE2): DATE1�� DATE2 ������ �������� ��ȯ
 4���� ��¥���� �Լ��߿��� ��� �󵵰� ����
 SELECT MONTHS_BETWEEN(TO_DATE('2020/04/21', 'YYYY/MM/DD'), TO_DATE('2020/03/21', 'YYYY/MM/DD')),
        MONTHS_BETWEEN(TO_DATE('2020/04/22', 'YYYY/MM/DD'), TO_DATE('2020/03/21', 'YYYY/MM/DD'))
 FROM dual;
 
 *ADD_MONTHS(DATE1, ������ ������) : DATE1 �� ���� �ι�° �Էµ� ������ ��ŭ ������  DATE
 ���� ��¥�κ��� 5���� �� ��¥
 SELECT ADD_MONTHS(SYSDATE, 5) dt1, 
        ADD_MONTHS(SYSDATE, -5) dt2
 FROM dual;
 
 *NEXT_DAY(DATE1, �ְ�����- (1~7)) DATE1 ���� �����ϴ� ù��° �ְ������� ��¥�� ��ȯ
 SELECT NEXT_DAY(SYSDATE, 7)
 FROM dual;
 
 *LAST_DAY(DATE1) DATE1 �� ���� ���� ������ ��¥�� ��ȯ
 ++������ ��¥�� ���ϴ°�++ �߿�!
 SYSDATE: 2020/04/21 ==> 2020/04/30
 SELECT LAST_DAY(SYSDATE)
 FROM dual;
 
 ��¥�� ���� ���� ù��° ��¥ ���ϱ�(1��)
 SYSDATE : 2020/04/21 ==> 2020/04/01; --���ϰ���� ��¥
 
 SYSDATE�� ���� ��������� ���ڿ� ���ϱ� 202004
 SELECT SYSDATE, LAST_DAY(SYSDATE), LAST_DAY(SYSDATE)+1,
        ADD_MONTHS(LAST_DAY(SYSDATE+1), -1),
        TO_DATE(TO_CHAR(SYSDATE, 'YYYYMM') || '01', 'YYYYMMDD') --�ش���� ������
 FROM dual;
 
 
 SELECT TO_DATE(SYSDATE, 'YYYY-MM-DD') param
 FROM dual;
 
 
 
  
  
  
  
  