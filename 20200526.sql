트리거 : 방아쇠
특정 이벤트가 발생 했을 때 어떤 로직을 추가적으로 실행
(웹 브라우저에 표현되 있는 페이지에서 마우스 (좌)클릭 ==> 클릭 이벤트 발생
개발자들이 작성해 놓은 이벤트 핸들러(로직)가 실행)

EX : 특정 테이블에 데이터가 신규로 입력될때 추가적인 로직을 실행
    USERS 테이블에 비밀번호가 변경이 되면 users_history 테이블에 기존 비밀번호를 백업하는
    로직을 추가
    
    users 테이블에 update만 하더라도 트리거에 의하여 users_history테이블에 데이터가 입력
    ==> 직접 users 테이블과 users_ history 테이블에 개발자가 작업을 해도 된다
    
트리거가 갖는 장점
데이터 무결성을 지켜주면서 가장 빠르게 데이터를 입력, 변경할 수 있다.

트리거가 갖는 단점
유지보수
다른 누군가가 작성한 코드를 확인 했을 때 users 테이블에만 데이터를 신규 입력하는 로직 밖에 없는데
이상하게도 users_history 테이블에도 데이터가 생성되는 결과

코드랑 결과가 다르다

SI 개발자가 트리거를 선호한다 ==> 자기가 개발 해놓은 소스를 본인이 유지보수 할일이 별로없음
                               신규 개발이 끝나면 보통 다른 곳으로 감
                               
트리거를 비선호 : 유지보수, 시스템의 전체관점에서 보는 사람들

users 테이블에 비밀번호가 컬럼값이 변경되었을 때 users_history 테이블에 기존
비밀번호를 백업하는 트리거 실습

1. users_history 테이블 생성
2. 트리거 생성
3. users 테이블에 비밀번호를 변경
4. 트리거에 의해 users_history 테이블에 데이터가 쌓이는지 확인

1. users_history 테이블 생성
CREATE TABLE users_history(
    userid VARCHAR2(20), --ID
    pass VARCHAR2(100), --PASSWORD
    mod_dt DATE
);

select *
from users_history

2. trigger 생성
CREATE OR REPLACE TRIGGER make_history
    --대상, 타이밍
    BEFORE UPDATE ON users
    
    --매 행마다 이벤트를 실행
    FOR EACH ROW
    
    --로직작성(PL/SQL 블록)
    BEGIN
       -- 신규 입력되는 데이터 : NEW.컬럼, 기존데이터 : OLD.컬럼명
       -- users 테이블의 비밀번호컬럼이 변경되었을 때 ==> users_history 테이블에 기존 비밀번호를 저장
        
        IF :NEW.pass != :OLD.pass THEN
        INSERT INTO users_history VALUES (:NEW.userid, :OLD.pass, SYSDATE);
        END IF;
    END;
/

3. users 테이블에 비밀번호를 변경
user





brown의 비밀번호를 변경

UPDATE USERS SET PASS = 'brownpass'
WHERE userid = 'brown';

select name, value
from users;


**모델링 구분 **
개념 -> 논리 -> 물리
개념 : 대략적으로 그린거
       인사시스템
       1.급여, 직원, 근태, 평가
            ==> 직원마스터, 직원발령, 직원정보, 직원이력
       2.엔터티의 식별자 까지만 미리 그려 보는것(일반속성이 추가 되면 논리 모델)
         전반적인 시스템의 윤곽을 잡는데 도움
         너무 작은 시스템이면 생략하는 경우도 많음
논리 모델: 물리적인 속성을 배제 하고 시스템에서 필요로 하는 요구사항을 모델링 표기법을 이용하여
          설계한 것
          (dbms 의 특성을 고려하지 않은 상황에서 설계
           dbms 사용하지 않고 파일 시스템으로도 활용 될 수도 있다)
           
물리 모델: 논리 모델을 시스템에서 사용할 db 시스템으로 변경하는 작업

논리모델링이 물리 모델로 1:1 매칭이 된다고 생각하는 경우가 많지만
반드시 그런 것은 아님

예)
논리 모델: 해당 시스템과 관련된 사람들 ==> 전사 관련자 라고하는 엔터티도 생성
물리 모델: 성능을 고려해서 회원, 직원, 외부직원 등으로 여러개의 테이블로 나누어 생성 가능
논리모델        물리모델
 엔터티          table
 속성            column
 관계            제약조건(fk)

게시판 요구사항 분석
엔터티, 엔터티 속성 분석 ==> 요구사항, 인터뷰, 서류 에서 자주 등장 하는 명사를 파악

게시판, 게시글, 답글, 댓글, 작성자, 번호, 제목, 내용, 첨부파일, 사용자, 작성일(일자)
삭제여부

엔터티
게시판 - 이름, 사용여부
게시글 - 번호, 제목, 내용, 작성자, 작성일시


SELECT emp.empno, emp.ename, emp.sal, salgrade.grade
FROM emp JOIN salgrade ON (emp.sal BETWEEN salgrade.losal AND salgrade.hisal);
1.
SELECT e.empno, e.ename, e.sal, s.grade
FROM emp e, salgrade s
WHERE e.sal BETWEEN s.losal AND s.hisal;

2.
SELECT e.empno, e.ename, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno;

ANSI
SELECT e.empno, e.ename, d.deptno, d.dname
FROM emp e JOIN dept d ON e.deptno = d.deptno;

3.
SELECT e.empno, e.ename, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno
  AND d.deptno IN(10,30);

ANSI 
SELECT e.empno, e.ename, d.deptno, d.dname
FROM emp e JOIN dept d ON e.deptno = d.deptno AND d.deptno IN(10,30);
  
4.
SELECT e.empno, e.ename, e.sal, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno
  AND e.sal > 2500;

ANSI  
SELECT e.empno, e.ename, e.sal, d.deptno, d.dname
FROM emp e JOIN dept d ON e.deptno = d.deptno AND e.sal > 2500
  
  
5.
SELECT e.empno, e.ename, e.sal, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno
  AND e.sal>2500
  AND e.empno > 7600;
  
ANSI  
SELECT e.empno, e.ename, e.sal, d.deptno, d.dname
FROM emp e JOIN dept d ON e.deptno = d.deptno AND e.sal>2500 AND e.empno>7600;
 
 
  
6.
SELECT e.empno, e.ename, e.sal, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno
  AND e.sal>2500
  AND e.empno > 7600
  AND d.dname = 'RESEARCH';
  
ANSI  
SELECT e.empno, e.ename, e.sal, d.deptno, d.dname
FROM emp e JOIN dept d ON (e.deptno = d.deptno AND e.sal>2500 AND e.empno > 7600 AND d.dname = 'RESEARCH');