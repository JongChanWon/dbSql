'202005' -> �Ϲ����� �޷��� row, col;

SELECT deptno, SUM(sal)
FROM emp
GROUP BY ROLLUP(deptno);

SELECT deptno, SUM(sal)
FROM emp
GROUP BY deptno;

UNION ALL

SELECT NULL, SUM(sal)
FROM emp

JOIN ������ ��
CROSS JOIN : ������ ���� �� ��...

�μ���ȣ��, ��ü �� �� SAL ���� ���ϴ� 3��° ���
SELECT DECODE(lv, 1, deptno, 2, NULL) deptno, SUM(sal)sal
FROM emp, (SELECT LEVEL lv
           FROM dual
           CONNECT BY LEVEL <= 2)
GROUP BY DECODE(lv, 1, deptno, 2, NULL)
ORDER BY 1; -- 1�� �÷� ����

**��������**
���������� �ٲ𶧸��� ���谡 �ٲ�����

create table dept_h (
    deptcd varchar2(20) primary key ,
    deptnm varchar2(40) not null,
    p_deptcd varchar2(20),
    
    CONSTRAINT fk_dept_h_to_dept_h FOREIGN KEY
    (p_deptcd) REFERENCES  dept_h (deptcd) 
);

insert into dept_h values ('dept0', 'XXȸ��', '');
insert into dept_h values ('dept0_00', '�����κ�', 'dept0');
insert into dept_h values ('dept0_01', '������ȹ��', 'dept0');
insert into dept_h values ('dept0_02', '�����ý��ۺ�', 'dept0');
insert into dept_h values ('dept0_00_0', '��������', 'dept0_00');
insert into dept_h values ('dept0_01_0', '��ȹ��', 'dept0_01');
insert into dept_h values ('dept0_02_0', '����1��', 'dept0_02');
insert into dept_h values ('dept0_02_1', '����2��', 'dept0_02');
insert into dept_h values ('dept0_00_0_0', '��ȹ��Ʈ', 'dept0_01_0');
commit;

������ ����
START WITH : ���� ������ ������ ���
CONNECT BY : ����(��) �� ������� ǥ��

XXȸ�����(�ֻ��� ���) ���� ���� ��������� ���������� Ž���ϴ� ����Ŭ ������ ���� �ۼ�
1. �������� ���� : XXȸ��
2. ������(��� ��) ����� ǥ��SELECT
   PRIOR : ���� ���� �а� �ִ� ���� ǥ��
   �ƹ��͵� ������ ����: ���� ������ ���� ���� ǥ��
   
SELECT dept_h.*, LEVEL, LPAD(' ', (LEVEL-1)*3) || deptnm
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;

h_2]
SELECT LEVEL, deptcd, LPAD(' ', (LEVEL-1)*3) || deptnm deptnm, p_deptcd  
FROM dept_h
START WITH deptcd = 'dept0_02'
CONNECT BY PRIOR deptcd = p_deptcd;

�����
������ : �������� - dept0_00_0

SELECT *
FROM dept_h
START WITH deptcd = 'dept0_00_0'
CONNECT BY PRIOR p_deptcd = deptcd;

h_3]
SELECT LEVEL, deptcd, LPAD(' ', (LEVEL-1)*3) || deptnm deptnm, p_deptcd  
FROM dept_h
START WITH deptcd = 'dept0_00_0'
CONNECT BY PRIOR p_deptcd = deptcd;

create table h_sum as
select '0' s_id, null ps_id, null value from dual union all
select '01' s_id, '0' ps_id, null value from dual union all
select '012' s_id, '01' ps_id, null value from dual union all
select '0123' s_id, '012' ps_id, 10 value from dual union all
select '0124' s_id, '012' ps_id, 10 value from dual union all
select '015' s_id, '01' ps_id, null value from dual union all
select '0156' s_id, '015' ps_id, 20 value from dual union all

select '017' s_id, '01' ps_id, 50 value from dual union all
select '018' s_id, '01' ps_id, null value from dual union all
select '0189' s_id, '018' ps_id, 10 value from dual union all
select '11' s_id, '0' ps_id, 27 value from dual;

SELECT *
FROM h_sum;

h_4]
SELECT LPAD(' ', (LEVEL-1)*3) ||s_id s_id, value
FROM h_sum
START WITH s_id = '0'
CONNECT BY PRIOR s_id = ps_id;


create table no_emp(
    org_cd varchar2(100),
    parent_org_cd varchar2(100),
    no_emp number
);
insert into no_emp values('XXȸ��', null, 1);
insert into no_emp values('�����ý��ۺ�', 'XXȸ��', 2);
insert into no_emp values('����1��', '�����ý��ۺ�', 5);
insert into no_emp values('����2��', '�����ý��ۺ�', 10);
insert into no_emp values('������ȹ��', 'XXȸ��', 3);
insert into no_emp values('��ȹ��', '������ȹ��', 7);
insert into no_emp values('��ȹ��Ʈ', '��ȹ��', 4);
insert into no_emp values('�����κ�', 'XXȸ��', 1);
insert into no_emp values('��������', '�����κ�', 7);

commit;
SELECT *
FROM no_emp

SELECT LPAD(' ', (LEVEL-1)*3) || org_cd org_cd, no_emp
FROM no_emp
START WITH org_cd = 'XXȸ��'
CONNECT BY PRIOR org_cd = parent_org_cd;

**CONNECT BY ���Ŀ� �̾ PRIOR �� ���� �ʾƵ� ��� ����
PRIOR �� ���� �а� �ִ� ���� ��Ī�ϴ� Ű���� --�� �Ʒ��� �Ȱ��� ����� ����

SELECT LPAD(' ', (LEVEL-1)*3) || org_cd org_cd, no_emp
FROM no_emp
START WITH org_cd = 'XXȸ��'
CONNECT BY parent_org_cd = PRIOR org_cd;


PRUNING BRANCH : ���� ġ��
WHERE ���� ������ ��� ���� �� : ������ ������ ���� �� ���� �������� ����
CONNECT BY  ���� ��� ���� �� : 
�� ���̸� ��
*�� ������ �������� FROM -> START WITH CONNECT BY -> WHERE �� ������ ó���ȴ�

1. WHERE ���� ������ ����� ���
SELECT LEVEL, deptcd, LPAD(' ', (LEVEL-1)*3) || deptnm deptnm, p_deptcd  
FROM dept_h
WHERE deptnm != '������ȹ��'
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;

2. CONNECT BY ���� ������ ����� ��� --������ȹ���� �����μ������ ������(���� ����)
SELECT LEVEL, deptcd, LPAD(' ', (LEVEL-1)*3) || deptnm deptnm, p_deptcd  
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd AND deptnm != '������ȹ��';


������ �������� ����� �� �ִ� Ư�� �Լ�
CONNECT_BY_ROOT(column) : �ش� �÷��� �ֻ��� �����͸� ��ȸ
SYS_CONNECT_BY_PATH(column, ������) : �ش� ���� ������� ���Ŀ� ���� column ���� ǥ���ϰ� �����ڸ� ���� ����
CONNECT_BY_ISLEAF ���ڰ� ���� : �ش� ���� ������ ���̻� ���� ������ ������� (LEAF ���)
                               LEAF ��� : 1, NO LEAF ��� : 0
(�Խ���)root �� ������
������
    -���
        -���
������
    -���
    -���
SELECT LEVEL, deptcd, LPAD(' ', (LEVEL-1)*3) || deptnm deptnm, p_deptcd,
       CONNECT_BY_ROOT(deptnm) root,
       LTRIM(SYS_CONNECT_BY_PATH(deptnm, '-'), '-')TRIM,
       CONNECT_BY_ISLEAF LEAF
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;

create table board_test (
 seq number,
 parent_seq number,
 title varchar2(100) );
 
insert into board_test values (1, null, 'ù��° ���Դϴ�');
insert into board_test values (2, null, '�ι�° ���Դϴ�');
insert into board_test values (3, 2, '����° ���� �ι�° ���� ����Դϴ�');
insert into board_test values (4, null, '�׹�° ���Դϴ�');
insert into board_test values (5, 4, '�ټ���° ���� �׹�° ���� ����Դϴ�');
insert into board_test values (6, 5, '������° ���� �ټ���° ���� ����Դϴ�');
insert into board_test values (7, 6, '�ϰ���° ���� ������° ���� ����Դϴ�');
insert into board_test values (8, 5, '������° ���� �ټ���° ���� ����Դϴ�');
insert into board_test values (9, 1, '��ȩ��° ���� ù��° ���� ����Դϴ�');
insert into board_test values (10, 4, '����° ���� �׹�° ���� ����Դϴ�');
insert into board_test values (11, 10, '���ѹ�° ���� ����° ���� ����Դϴ�');
commit;

SELECT *
FROM board_test;

�ǽ� h6]
SELECT seq, LPAD(' ', (LEVEL-1)*3) || title title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq;

�ǽ� h7] �ֽű��� ���� ������ ����
������ ������ ���Ľ� ���� ������ �����ϸ鼭 ���� �ϴ� ����� ����

ORDER SIBLINGS BY

SELECT seq, parent_seq, LPAD(' ', (LEVEL-1)*3) || title title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY seq DES
C; --ORDER BY seq DESC; �̷��� �ϸ� ���������� ����

�������� �߿�!!

emp���̺��� 2�� �о ������ �޼� -> ���� �� ȿ������ ����� ������?? -> WINDOW / ANALYSIS function �� ����ؼ�,, 
SELECT ename
FROM emp
WHERE sal = (SELECT MAX(sal)
             FROM emp);
��ü �����߿� ���� ���� �޿��� �޴� ����� �޿�����
���� ���� �޿��� �޴� ����� �̸�
�ٵ� �װ� ������??
SELECT MAX(sal)
FROM emp;

�ǽ� ana0

SELECT ename, sal, deptno, ROWNUM || 'sal_rank'sal_rank
FROM emp
ORDER BY deptno, sal desc;

����Ǭ��

SELECT a.*, b.lv, ROWNUM
FROM
 (SELECT deptno, COUNT(*)cnt
  FROM emp
  GROUP BY deptno)a, (SELECT LEVEL lv, ROWNUM
                      FROM dual
                      CONNECT BY LEVEL <= 6) b
 WHERE a.cnt >= lv
 ORDER BY a.deptno, b.lv;

CALENDAR 1]
������ : �ϴ��� ����
ȭ�鿡 ��Ÿ���� �ϴ� ���� : ������

SELECT NVL(MIN(DECODE(mm, '201901',sales)), 0) jan, NVL(MIN(DECODE(mm, '201902',sales)), 0) feb, 
       NVL(MIN(DECODE(mm, '201903',sales)), 0) mar, NVL(MIN(DECODE(mm, '201904',sales)), 0) apr,
       NVL(MIN(DECODE(mm, '201905',sales)), 0) may, NVL(MIN(DECODE(mm, '201906',sales)), 0) june
FROM
(SELECT TO_CHAR(dt, 'YYYYMM')mm, SUM(sales) sales
 FROM sales
 GROUP BY TO_CHAR(dt, 'YYYYMM'))


CALENDAR 2]
202005 ==> �ش���� 1���� ���ϴ� ���� �Ͽ����� �����ΰ�?

SELECT TO_DATE('202005', 'YYYYMM'), TO_CHAR(TO_DATE('202005', 'YYYYMM'), 'D'),
       TO_DATE('202005', 'YYYYMM') - TO_CHAR(TO_DATE('202005', 'YYYYMM'), 'D') + 1
FROM dual;

202005 ==> �ش���� ������ ���ڰ� ���ϴ� ���� ������� �����ΰ�?

SELECT TO_DATE('202005', 'YYYYMM'), TO_CHAR(TO_DATE('202005', 'YYYYMM'), 'D'),
       TO_DATE('202005', 'YYYYMM') - TO_CHAR(TO_DATE('202005', 'YYYYMM'), 'D') + 1 s,
       LAST_DAY(TO_DATE('202005', 'YYYYMM')), TO_CHAR(LAST_DAY(TO_DATE('202005', 'YYYYMM')), 'D'),
       LAST_DAY(TO_DATE('202005', 'YYYYMM')) + (7- TO_CHAR(LAST_DAY(TO_DATE('202005', 'YYYYMM')), 'D')) e,
       
       (LAST_DAY(TO_DATE('202005', 'YYYYMM')) + (7- TO_CHAR(LAST_DAY(TO_DATE('202005', 'YYYYMM')), 'D'))
       - (TO_DATE('202005', 'YYYYMM') - TO_CHAR(TO_DATE('202005', 'YYYYMM'), 'D') + 1) + 1 days
FROM dual;



SELECT DECODE(d, 1, iw+1, iw),
           MIN(DECODE(d, 1, dt)) sun, MIN(DECODE(d, 2, dt)) mon, 
           MIN(DECODE(d, 3, dt)) tue, MIN(DECODE(d, 4, dt)) wed, 
           MIN(DECODE(d, 5, dt)) thu, MIN(DECODE(d, 6, dt)) fri,
           MIN(DECODE(d, 7, dt)) sat
FROM
(SELECT TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1) dt, 
        TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1), 'D') d,
        TO_CHAR(TO_DATE(:yyyymm, 'YYYYMM') + (LEVEL-1), 'iw') iw
 FROM dual
 CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:yyyymm, 'YYYYMM')), 'DD') )
GROUP BY DECODE(d, 1, iw+1, iw)
ORDER BY DECODE(d, 1, iw+1, iw);








