�Լ���?
-�Լ��� ������ ���ȭ �� �ڵ��̴�.

�Լ��� ����ϴ� ����
-���� ����ϴ� ���� �Լ��� �����Ǿ� �ִ� �κ��� �и��Ͽ� 
 ���������� ���̼��� �����ϱ� �����̴�.
 
 �Լ��� ����
 1.(single-row function) - �ѹ��� �ϳ��� ó���ϴ� �Լ�
 2.(multi-row function) - �ѹ��� ������ ó���ϴ� �Լ�
 
 single row function �ȿ���
 
 LENGTH
 SUBSTR
 LPAD, RPAD
 REPLACE
 TRIM
 MOD()
 ROUND()
 
 Dual ���̺� 
 1. ����Ŭ ��ü���� �����Ǵ� ���̺�(����� ��� �������� ��밡��)
 2. dual ���̺��� ����ڰ� �Լ�(���) �� ������ �� �ӽ÷� ����ϴµ� �����ϴ�.
    -�Լ��� ���� ������ �˰� ���� �� Ư�� ���̺��� ������ �ʿ� ���� dual ���̺��� �̿��Ͽ� 
     �Լ� ���� ���� ���� �� �ִ�.
     
*����Ŭ �����Լ�*

*��ҹ��� ���� �Լ�
-���ڷ� ���ڿ� �ϳ��� �޴´�.
lower : �ҹ��ڷ� �ٲ���
upper : �빮�ڷ� �ٲ���
initcap : �� �� ���ڸ� �빮�ڷ� �ٲ���

SELECT LOWER('I wanna Going home') hm,
       UPPER('i wanna going home') hm1,
       INITCAP('hARD') hm2
FROM dual;

�Լ��� WHERE�� ������ ��� �����ϴ�
ex)

SELECT *
FROM emp
WHERE LOWER(ename) = 'smith'
WHERE ename = UPPER('smith');

���� �� where�� ���� �ι�° where���� �ùٸ� ����̴�.
=�����ڷμ� ���Ѿ��ϴ� ���߿� �ϳ�? ���ʿ��ִ� �÷����� �ٲٸ� �ȵȴ�

*���ڿ� ���� �Լ�
1. CONCAT : 2���� ���ڿ��� �Է����� �޾� ������ ���ڿ��� ��ȯ�ϴ� �Լ�

SELECT CONCAT('coding', 'Is...')cd
FROM dual;

'select' || 'from' || 'where' concat���� �����
SELECT CONCAT(CONCAT('select', 'from'), 'where')sfw  
FROM dual;
-CONCAT �� �ΰ��� ���ڿ��� ���� �� ������ ���� ����ó�� CONCANT�ȿ� �ִ� 
 �ΰ��� ���ڿ��� �ϳ��� ���ڿ��� �޾Ƽ� 3���� ���ڿ��� �ѹ��� ���� �� �� �ִ�.
 

2. SUBSTR(���ڿ�, �����ε���, �����ε���) : ���ڿ��� �����ε��� ���� �����ε��� ������ ���ڿ�
    -�����ε����� 1���� (JAVA�� ���� 0���� ����)
    
   LENGTH(���ڿ�) : ���ڿ��� ���̸� ��ȯ
   INSTR(���ڿ�, ã�����ڿ�, [�˻� ���� �ε���]) : ���ڿ����� ã�� ���ڿ��� �����ϴ���, ������ ���
                                               ã�� ���ڿ��� �ε���(��ġ) ��ȯ
   LPAD, RPAD(���ڿ�, ���߰� ���� ��ü ���ڿ� ����, [�е����ڿ� - �⺻ ���� ����])
   TRIM(���ڿ�) : ���ڿ� �� ���� �����ϴ� ������ ����, ���ڿ� �߰��� �ִ� ������ ���� ����� �ƴ�
   REPLACE(���ڿ�, �˻��� ���ڿ�, ������ ���ڿ�) : ���ڿ����� �˻��� ���ڿ��� ã�� ������ ���ڿ��� ����
    
 SELECT SUBSTR('Halo, coding', 1, 5)sub,
        LENGTH('Halo, coding')len,
        INSTR('Halo, coding', 'o')ins,
        INSTR('Halo, coding', 'o', 2)ins2,
        INSTR('Halo, coding', 'o',INSTR('Halo, coding', 'o')) ins3,
        LPAD('Halo, coding', 18, 'dirty ')lp,
        RPAD('Halo, coding', 17, ' coco')rp,
        REPLACE('halo, coding', 'halo', 'pro')rep,
        TRIM('   Halo, coding   ') tr,
        TRIM('c' FROM 'coding')tr2 --������ ���� �� �������� Ư�� ����(��,��) �� �������ش�
 FROM dual;
 
 *NUMBER ���� �Լ�
  ROUND(����, �ݿø� ��ġ) :  �ݿø�
   ROUND(105.54, 1) : �Ҽ��� ù��° �ڸ����� ����� ���� ==> �Ҽ��� �ι�°���� �ݿø�
    ==>4�� ������ �ǹǷ� 105.5 ���ȴ�
  TRUNC(����, ���� ��ġ) : ����
  MOD(������, ����) ������ ����; -- 10 / 2 �����⸦ ���� �� ������ ���ϴ� ��(������) ���⼭�� '10' 
  
 SELECT ROUND(123.44, 1) rd,
        ROUND(123.45, 1) rd1,
        ROUND(123.45, 0) rd2, --123���� 1�� �ڸ� ���� ����� ����, �Ҽ��� ù��°���� �ݿø� 123
        ROUND(123.45, -1) rd3, --123���� 10�� �ڸ� ���� ����� ����, 1�� �ڸ� ���� �ݿø� 120
 FROM dual;
 
 SELECT TRUNC(1871.897, 2) tr,
        TRUNC(1871.897, 1) tr1,
        TRUNC(1871.896, 0) tr2,
        TRUNC(1871.896, -1) tr3
 FROM dual;
 
 SELECT MOD(15, 3), sal, MOD(sal, 1000) md  --����Ʈ �������� ������ �ȵǰ� ���� �Ѵ�
  FROM emp;
  
  SELECT MOD(20, 3), sal, MOD(sal, 1000) md -- �����Ұ��� ��� ����
  FROM dual;

 *��¥ ���� �Լ�
  SYSDATE : ������� ������ ���� �ð�, ��¥�� ��ȯ (���ڰ� ���� �Լ�)
            �Լ���; --��ȣ �Ⱦ�
  date type +- ���� : ���ڸ� ���ϰ� ��
  ���� 1 = �Ϸ�
  1/24 = 1�ð�
  1/24/60 = 1��

 SELECT SYSDATE sy, SYSDATE -1/24 sy_5 --5���� ��¥
 FROM dual;
 
 TO_DATE(���ڿ�, ����) : ���ڿ��� ���˿� �°� �ؼ��Ͽ� ��¥ Ÿ������ ����ȯ
 TO_CHAR(��¥, ����) : ��¥ Ÿ���� ���˿� �°� ���ڿ��� ��ȯ
 
 MM : ��
 DD : ����
 D : �ְ�����(1~7, 1-�Ͽ���, 2-������ ..... 7-�����)
 IW : ���� (52~53) ��¥�� ������ �������� ���ϴ��� �� �� ����
 HH : �ð�(12�ð�)
 HH24 : 24�ð� ǥ��
 MI : ��
 SS : ��
 
==(date, format)����
 SELECT TO_CHAR(SYSDATE -1/24/60, 'YYYY/MM/DD/D/IW HH24:MI:SS') ch -- �ڹٶ� �����Ҷ� �������̶� ��Ī�̶� �����ϴ°� ����
 FROM dual;
 
SELECT TO_CHAR(ADD_MONTHS(TO_DATE('20200421', 'YYYYMMDD'), 1), 'YYYYMM')
FROM dual;
SELECT ADD_MONTHS(SYSDATE-2, 1)as a,
       ADD_MONTHS(TO_DATE('2020-01-02', 'YYYY-MM-DD'),1) as b, --todate���� �������� �ٲܾ�?
       TRUNC((TO_DATE('20200302', 'YYYYMMDD')- TO_DATE('20200304', 'YYYYMMDD'))*24,2) TR
FROM dual;

