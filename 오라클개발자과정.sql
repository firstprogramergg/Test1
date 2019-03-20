/*
[1일차 수업]
1. 오라클 소프트웨어 다운로드
https://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html

2. Oracle Database 11g Release 2 Express Edition for Windows 64 (무료설치)

3. Oracle 설치(SYS, SYSTEM 계정의 대한 암호 : 1004)

4.Sqlplus 프로그램 제공(CMD) : GUI 환경 일반개발자 사용 불편

5.별도의 Tool 설치 무료(SqlDeveloper)  , 
                 유료(토드 , 오렌지 , SqlGate) 프로젝트시 설치 활용 ^^

6. SqlDeveloper 툴을 통해서 Oracle Server 접속 ....
   >> HR 계정 : 암호 1004 , Unlock 2가지 사용가능 .... (사원관리 실습 테이블)
   >> 새로운 계정 : bituser 
   
-- USER SQL
CREATE USER bituser IDENTIFIED BY 1004 
DEFAULT TABLESPACE "USERS"
TEMPORARY TABLESPACE "TEMP";

-- QUOTAS
ALTER USER bituser QUOTA UNLIMITED ON USERS;

-- ROLES
GRANT "CONNECT" TO bituser WITH ADMIN OPTION;
GRANT "RESOURCE" TO bituser WITH ADMIN OPTION;
ALTER USER bituser DEFAULT ROLE "CONNECT","RESOURCE";

-- SYSTEM PRIVILEGES   

7. 현재 접속 계정 확인 : show user;   >> USER이(가) "BITUSER"입니다.

CREATE TABLE EMP
(EMPNO number not null,
ENAME VARCHAR2(10),
JOB VARCHAR2(9),
MGR number ,
HIREDATE date,
SAL number ,
COMM number ,
DEPTNO number );
--alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';

INSERT INTO EMP VALUES
(7369,'SMITH','CLERK',7902,'1980-12-17',800,null,20);
INSERT INTO EMP VALUES
(7499,'ALLEN','SALESMAN',7698,'1981-02-20',1600,300,30);
INSERT INTO EMP VALUES
(7521,'WARD','SALESMAN',7698,'1981-02-22',1250,200,30);
INSERT INTO EMP VALUES
(7566,'JONES','MANAGER',7839,'1981-04-02',2975,30,20);
INSERT INTO EMP VALUES
(7654,'MARTIN','SALESMAN',7698,'1981-09-28',1250,300,30);
INSERT INTO EMP VALUES
(7698,'BLAKE','MANAGER',7839,'1981-04-01',2850,null,30);
INSERT INTO EMP VALUES
(7782,'CLARK','MANAGER',7839,'1981-06-01',2450,null,10);
INSERT INTO EMP VALUES
(7788,'SCOTT','ANALYST',7566,'1982-10-09',3000,null,20);
INSERT INTO EMP VALUES
(7839,'KING','PRESIDENT',null,'1981-11-17',5000,3500,10);
INSERT INTO EMP VALUES
(7844,'TURNER','SALESMAN',7698,'1981-09-08',1500,0,30);
INSERT INTO EMP VALUES
(7876,'ADAMS','CLERK',7788,'1983-01-12',1100,null,20);
INSERT INTO EMP VALUES
(7900,'JAMES','CLERK',7698,'1981-10-03',950,null,30);
INSERT INTO EMP VALUES
(7902,'FORD','ANALYST',7566,'1981-10-3',3000,null,20);
INSERT INTO EMP VALUES
(7934,'MILLER','CLERK',7782,'1982-01-23',1300,null,10);

COMMIT;

CREATE TABLE DEPT
(DEPTNO number,
DNAME VARCHAR2(14),
LOC VARCHAR2(13) );

INSERT INTO DEPT VALUES (10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES (30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES (40,'OPERATIONS','BOSTON');

COMMIT;



CREATE TABLE SALGRADE
( GRADE number,
LOSAL number,
HISAL number );

INSERT INTO SALGRADE VALUES (1,700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);
COMMIT;

*/
/*
SELECT [DISTINCT] {*, column [alias], . . .}
FROM table_name
[WHERE condition]
[ORDER BY {column, expression} [ASC | DESC]];
*/
select * from emp;
select * from dept;
select * from salgrade;

--1. 사원테이블에서 모든 데이터를 출력하세요

select * from emp;    --쿼리문장은  대소문자를 구분하지 않습니다
SELECT * FROM DEPT; 
select * from salgrade;

--2. 특정 컬럼 데이터 출력하기
select empno , ename , sal from emp;

--3. 컬럼에 가명칭(별칭)(alias) 부여하기

select empno 사번 , ename 이름 
from emp;

select empno "사    번" , ename "이     름" 
from emp;

--정식(ansi 문법)
select empno as "사    번" , ename as "이     름" 
from emp;

--Oracle 데이터 문자열 (문자열 데이터는 대소문자 구문)
--문자열 표기  '문자열'
-- 소문자 : a   대문자 : A 다른 문자 취급
select empno , ename from emp where ename='king';

select empno , ename from emp where ename='KING';

--Oracle SQL : 연산자 (결합 연산자( || )  와 산술연산자( + ) 구분)
--Java :  + (숫자 + 숫자  연산)
--Java :  + (문자열 + 문자열 결합)
--TIP) ms-sql +(연산, 결합)


select '사원의 이름은' || ename || ' 입니다'  as "사원정보"
from emp;

--테이블 컬럼은 기본 타입
--컬럼의 타입 숫자 , 문자 , 날짜 ....
desc emp;  --테이블의 타입 기본 정보 조회

select  empno  ||  ename  -- number || varchar  내부적으로 형변환 (숫자 -> 문자) 결합
from emp;

select empno + ename   --"invalid number"  타입이 맞지 않아서   산술연산 불가
from emp;

--사장님 우리 회사에 직종이 몇개나 있나
--distinct : 중복 데이터 제거
--distinct 원리 : grouping 
select distinct job from emp;


--재미삼아서 ... (group 에  group 의 데이터)
select distinct  job , deptno from emp order by job ;

select distinct  deptno , job from emp order by deptno;

----------------------------------------------------------------------
--Oracle (SQL 언어)
--JAVA 언어( 연산자)
--JAVA 거의 동일 ( + , * , - ....) : % 나머지   >>  오라클  % 검색 패턴  >> 나머지 구하는 연산자 (x) : Mod() 함수

--산술연사 (+ , * , - , / .....) , Mod() 함수 나머지를 구한다

--사원테이블에서 사원의 급여를 100달러 인상한 결과를 출력하세요
desc emp; --SAL   NUMBER
select empno, sal , sal + 100 as "인상급여"  from emp;

select 100 + 100 from dual;  -- dual 임시 테이블 ...
select 100 || 100 from dual;  -- 100100 (형변환)
select '100' + 100 from dual; -- 오라클에서  + 무조건 산술  (문자를 숫자로)
select 'A100' + 100 from dual; -- Error .......

--비교연산자
-- >  , < , <=
--Java 같다 (==)  할당 (=)
--Oracle 같다(=)   같지 않다 (!=)

--논리 연산자
--AND , OR , NOT

--조건절 (원하는 row 가지고 오겠다)
select *
from emp
where sal >= 3000;

select empno , ename , sal
from emp
where sal >= 3000;


--이상 , 이하 (= 포함)
--초과 , 미만 

--사번이 7788번인 사원의 사번, 이름, 직종 , 입사일을 출력하세요
--실행순서 : 
select empno, ename,job,hiredate       --3
from emp                                      --1
where empno=7788;                         --2

--사원의 이름이 king 사원의 사번, 이름, 급여 정보를 출력하세요
select empno , ename , sal
from emp
where ename = 'KING';

--hint) 논리 (AND , OR )
--AND 두개의 모든 참 --> 참

--급여가 2000달러 이상이면서 직종이 manager 인 사원은 모든 정보를 출력하세요
--두개의 조건을 모든 만족 (둘다 참인)
select *
from emp
where sal >= 2000 and job='MANAGER';

--급여가 2000달러 이상이거나 직종이 manager 인 사원은 모든 정보를 출력하세요
--두개의 조건중 하나면 참이여도 출력
select *
from emp
where sal >= 2000 or job='MANAGER';

--------------------------------------------------------------------------
--오라클 날짜 (DB 서버의 날짜)
--오라클 날짜 (sysdate)
--모든 시스템 날짜 정보 
--게시판 글쓰기
--insert into board(writer , title , content , regdate)  values('홍길동' , '방가' , '배고파요' , sysdate)
--TIP) ms -sql : select getdate()


select  sysdate from dual;

alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';

select hiredate from emp;

--오라클 시스템 테이블 ....
select * from SYS.NLS_SESSION_PARAMETERS;   --시스템 환경 테이블 조회 확인
--NLS_DATE_FORMAT	      YYYY-MM-DD HH24:MI:SS
--NLS_DATE_LANGUAGE	    KOREAN
--NLS_TIME_FORMAT	        HH24:MI:SSXFF

--오라클 날짜 조회  : '2019-12-12' 
select * from emp
where hiredate = '1980-12-17';   --  (-)

select * from emp
where hiredate = '1980/12/17';    -- (/)


select * from emp
where hiredate = '80/12/17';  --형식은 인정이 안되요 
--형식 : RR-MM-DD  >> YYYY-MM-DD

--사원의 급여가 2000 이상이고 4000 이하인 모든 사원의 정보를 출력 하세요
select *
from emp
where sal >= 2000 and sal <= 4000;
--연산자 : between A and B  (= 포함)
--주의사항 : 미만 초과 의 사용 금지
select * 
from emp
where sal between 2000 and 4000;

--사원의 급여가 2000 초과 4000 미만인 모든 사원의 정보를 출력 하세요

select *
from emp
where sal > 2000 and sal < 4000;

--부선번호가 10 번 또는 20번 또는 30번인 사원의 사번 , 이름 , 급여  ,부서번호를 출력하세요
select empno, ename, sal , deptno
from emp
where deptno=10 or  deptno=20 or deptno=30;
-- IN 연산자 (조건 or 조건 or ....)
select empno, ename, sal , deptno
from emp
where deptno in(10,20,30); --deptno=10 or  deptno=20 or deptno=30;

--부선번호가 10 번 또는 20번이 아닌 사원의 사번 , 이름 , 급여  ,부서번호를 출력하세요

select * 
from emp
where deptno != 10 and deptno != 20; 

--NOT IN 연산자(부정값 and  부정값 and ....)
select *
from emp
where deptno not in (10,20); --not in (deptno != 10 and deptno != 20; )

--POINT : Oracle 값이 없다(데이터 없다) >> null
--null  (필요악)

create table member(
  userid varchar2(20) not null,  --필수입력
  name varchar2(20) not null,  --필수입력
  hobby varchar2(50)           --default null (null 값을 허용하겠다) :  옵션 ...
);

desc member;
insert into member(userid,hobby) values('hong' , '농구');  --실행 안됨 (name 컬럼에 ....)
insert into member(userid,name) values('hong' , '홍길동'); -- hobby 컬럼의 데이터 >> null
select * from member;
insert into member(userid,name,hobby) values('kim' , '김씨', '게임');
select * from member;

--실제반영
commit;



--수당(comm)을 받지 않는 모든 사원의 정보를 출력하세요
-- 0 도 데이터 취급(받는 조건 포함)
--comm 컬럼에 데이터가 null 인것만 출력하세요
select * from emp where comm = null; -- (x)

--null 의 비교는 (is null , is not null)
select * from emp where comm is null; 


--수당(comm)을 받는 모든 사원의 정보를 출력하세요
select * from emp where comm is not null; 


--사원테이블에서 사번 , 이름 ,급여 , 수당 , 총급여를 출력하세요
--총급여 (급여 + 수당)
select empno , ename , sal , comm , sal + comm as "총급여"
from emp; 


select empno , ename , sal , comm , sal + nvl(comm,0) as "총급여"
from emp; 

--POINT  null
--1. null 과의 모든 연산은 그 결과가 : null 
--2.위 문제 해결 : 함수 nvl() , nvl2()   >> TIP ms-sql : convert()  , my-sql : IFNULL()  : null 값 대체 ...

select 1000 + null from dual;

select 1000 + nvl(null,0) from dual;

select comm , nvl(comm,11111) from emp;

--사원의 급여가 1000 이상이고 수당을 받지 않는 사원의  사번, 이름, 직종, 급여 , 수당을 출력하세요
select empno, ename,job,sal,comm
from emp
where sal >= 1000 and comm is null;

---------------------------------------------------------------------------
--DQL(data query language) : SELECT
--DDL(데이터 정의어) : create , alter , drop ... (객체 생성 , 수정 ,삭제)

--create Board (boardno number ...
-- JAVA : class Board { private boardno int }

create table Board (
 boardid number not null , --숫자 , 필수입력
 title varchar2(20) not null , --한글 10자 , 영문자 ,특수문자 ,공백 20자 , 필수입력
 content varchar2(2000) not null , -- 필수 입력
 hp varchar2(20)  -- default null 허용  필수 입력 사항 (x)
);

desc Board;

--DML(데이터 조작어) 반영 여부에서 결정 (실반영(commit) , 취소(rollback)) 반드시 수행
--insert , update , delete 작업

insert into board(boardid, title , content)
values(100,'오라클','할만 하네');

select * from board; 
--의사결정 : 실제 반영 할거야 (commit)
--의사결정 : 실제 반영 안할거야 (rollback)

rollback;
commit;

--begin
insert into board(boardid, title , content)
values(200,'자바','그립다');

insert into board(boardid, title , content)
values(300,'자바2','그립다2');

--commit 둘다반영
--rollback 둘다 취소

select * from board;
commit;

select boardid , nvl(hp,'EMPTY') as "hp" from board;
--nvl 함수는 숫자 , 날짜 , 문자열  모두 적용 가능하다 .... ^^

------------------------------------------------------------------------------------
--문자열 검색
--주소검색 : 검색어 : '역삼' -> 역삼 단어가 있는 모든 문장  (LIKE 검색)
--문자열 패턴 검색 ( Like 연산자)

--like 연산자 ( 와일드 카드 문자 ( % : 모든것 ,  _ : 한문자 ) 결합 ......

select ename
from emp
where ename like '%A%';  --ename 컬럼에 데이터에 A 들어있는 모든 이름 ....

select ename
from emp
where ename like '%a%';  -- 문자열 데이터 대소문자 엄격하게 구분

select ename
from emp
where ename like 'A%'; -- 이름의 첫 글자가 A 시작

select ename
from emp
where ename like '김%'; -- 이름의 첫 글자가 A 시작

select ename
from emp
where ename like '김수환무%';


select ename
from emp
where ename like '%S';


select ename
from emp
where ename like '%LL%';



select ename
from emp
where ename like '%A%A%';  -- A 가 두개만 있으면 ....


select ename
from emp
where ename like '_A%';  --첫글자 어떤것이 와도 상관없고 두번째 글자는 A ...
--WARD
--MARTIN
--JAMES

--오라클 과제 (regexp_like) 상세 검색
--select * from emp where regexp_like(ename,'[A-C]');
--정규표현식(java -> oracle -> javascript )
--과제 : 정규 표현 예제 5개 만들기 (카페 올려드리면 하세요)  중간 프로젝트 요구사항

---------------------------------------------------------------------------------------
--데이터 정렬하기
--order by 컬럼명 : 문자 , 숫자 , 날짜 
--오름차순 : asc : 낮은순  (default)
--내림차순 : desc : 높은순 

select * from emp order by sal;  --default asc

select * from emp order by sal asc;

--급여를 많이 받는 순으로 정렬해서 출력하세요
select * from emp order by sal desc;

select ename from emp order by ename asc; -- 정렬가능

--입사일이 가장 늦은 순으로 정렬해서 사번  , 이름 , 급여 , 입사일 데이터를 출력하세요
--(가장 최근에 입사한 순으로)

select empno, ename, sal, hiredate
from emp
order by hiredate desc;

/*
실행순서
SELECT                   3
FROM                     1
WHERE                    2
ORDER BY                4  (select 결과를 정렬)
*/

--해석 
select empno , ename, sal , job , hiredate
from emp
where job = 'MANAGER' 
order by hiredate desc;

--order by 컬럼명 desc , 컬럼명 asc , 컬럼명 desc 
select job , deptno
from emp
order by job asc , deptno desc;

---------------------------------------------------------------------------------------------
--연산자
--합집합(union) : 테이블과 테이블의 데이터를 합치는 것 (중복값은 배제)
--합집합(union all) : 중복값 허용

create table uta (name varchar2(20));

insert into uta(name) values('AAA');
insert into uta(name) values('BBB');
insert into uta(name) values('CCC');
insert into uta(name) values('DDD');
commit;

select * from uta;

create table ut(name varchar2(20));

insert into ut(name) values('AAA');
insert into ut(name) values('BBB');
insert into ut(name) values('CCC');
commit;

select * from ut;

--union
select * from ut
union
select * from uta;

select * from ut
union all
select * from uta;

--union 규칙
--1. 대응대는 컬럼의 타입이 동일
select empno, ename from emp
union
select dname , deptno from dept;  --대응되는 타입이 틀린다

select empno, ename from emp
union
select deptno , dname from dept;


--실무 > subquery (in line view)  TIP ....
select empno, ename
from (
          select empno, ename from emp
            union
          select deptno , dname from dept  
        ) order by empno desc;

--2. 대응대는 컬럼의 개수가 동일  ( null 착한일)
select empno , ename , job , sal from emp
union
select deptno, dname,loc,null from dept;

--여기까지가 초보개발자가 의무적으로 해야하는 (단일 테이블) 대상으로 .....
-------------------------------------------------------------------------------------
--오라클 함수 ......
select * from SYS.NLS_DATABASE_PARAMETERS;
--NLS_CHARACTERSET  : 	AL32UTF8  한글 3byte 인식
--KO16KSC5601 2Byte (현재 변환하면 한글 다깨짐)
select * from nls_database_parameters where parameter like '%CHAR%';



/*
1) 문자형 함수 : 문자를 입력 받고 문자와 숫자 값 모두를 RETURN 할 수 있다.
2) 숫자형 함수 : 숫자를 입력 받고 숫자를 RETURN 한다.
3) 날짜형 함수 : 날짜형에 대해 수행하고 숫자를 RETURN 하는 MONTHS_BETWEEN 함수를
제외하고 모두 날짜 데이터형의 값을 RETURN 한다.
4) 변환형 함수 : 어떤 데이터형의 값을 다른 데이터형으로 변환한다.
5) 일반적인 함수 : NVL, DECODE
*/
--문자열 개수

select length('abcd') from dual;
select length('홍길동') from dual;

select 'a'||'b'||'c' as "data" from dual;

select concat(ename.job) from emp;
select ename ||'  '|| job from emp;

--부분 문자열 추출
--java(substring)
--oracle(stustr)
select substr('abcde',2,3) from dual; --bcd
select substr('abcde',1,1) from dual; 
select substr('abcde',3,3) from dual; 

select substr('abcde',3) from dual;
select substr('abcde',-2,1) from dual;
select substr('abcde',-2,2) from dual;

/*사원테이블에서 ename 첫글자 소문자, 나머지 대문자 출력 컬럼으로 출력
--컬럼의  가명칭은: fullname
--첫글자와 나머지 문자 사이 공백 넣으세요
ex) SMITH >> s MITH
*/
SELECT ename from emp;
select lower(substr(ename,1,1)) from emp;
select upper(substr(ename,2)) from emp;
select lower(substr(ename,1,1)) ||' '||upper(substr(ename,2)) as "fulname" from emp;

--lpad, rpad(체우기)
select lpad('ABC',10,'%') from dual;

select rpad(substr('hong1006',1,2), length('hong1006'),'*') as "password" from dual;
select rpad(substr('1004',1,2), length('1004'),'*') as "password" from dual;

create table member2(
  id number,
  jumin varchar2(14)
);
insert into member2(id, jumin) values(100,'123456-1234567');
insert into member2(id, jumin) values(200,'23456-1234567');
commit;

select * from member2;

--100: 123456-****
--200: 234567-****
--컬럼의 가명칭 "juminnumber"

select id||':'|| rpad(substr(jumin,1,7),length(jumin),'*') as "jumin" from member2;

--rtrim 함수
--오른쪽 문자 지워라
select rtrim('MILLER', 'ER') from dual;
select ltrim('MILLLLLER', 'MIL') from dual;
--select'>'||rtrim('MILLER     ',')||'<' from dual;

--치환(replace)
--select

-----------문자열 함수(end)--------------
--ROUND 숫자를 반올림
--TRUNC 숫자를 절삭
--MOD 나머지를 구함


select round(12.345,0) as "r" from dual; --0정수부
select round(12.567,0) as "r" from dual;

select round(12.345,1) as "r" from dual;
select round(12.567,1) as "r" from dual;

select round(12.345,-1) as "r" from dual; -- -1은 10의 자리
select round(15.345,-1) as "r" from dual;
select round(15.345,-2) as "r" from dual;


--turnc(반올림 하지 않고 버림)
select round(12.345,0) as "t" from dual; --0정수부
select round(12.567,0) as "t" from dual; --12

select round(12.345,1) as "t" from dual; --12.3
select round(12.567,1) as "t" from dual;

select round(12.345,-1) as "t" from dual; -- -1은 10의 자리
select round(15.345,-1) as "t" from dual;
select round(15.345,-2) as "t" from dual;

--select trunc
--select round

--나머지
select 12/10 from dual; --1.2
select mod(12,10) from dual; --2
select mod(0,0) from dual; --0

----[숫자 함수 end]-----


--날짜함수
select sysdate from dual;
--
--날짜 연수(포인트)
--Date + Number >> Date
--Date - Number >> Date (100일전)
--Date - Date >> Number (근속일수)

select * from SYS.NLS_SESSION_PARAMETERS;

select hiredate from emp;
select MONTHS_BETWEEN('2018-02-27, 2020-02-27') from dual; --개월의 차 
--round 사용
--trunc
select to_date('2019-03-20')+100 from dual; --19/06/28 --to_date
select to_date('2019-03-20')+1000 from dual;

--Q
--1.사원 입사일에서 현재날짜까지 근속월수
--단 근속월수는 정부부분만 출력
select trunc(months_between(sysdate,hiredate),0) as "근속일수" from emp;
--2.한달이 31일 이라는 기준에서 근속월수를 구하세요
--일/31>월
select hiredate from emp;
select trunc((sysdate-hiredate)/31) from emp;


/*
오라클 기본 데이터 타입
create table 테이블명(컬러명 타입)
create table m

java: class person _ >>person p=new person(); 1건

oracle: create person

문자 타입
--char(20) >> 20byte>> 한글10자, 영문자, 특수문자, 공백 20자: 고정길이 문자열
--varchar2(20) >> 20byte >> 동일 : 가변길이 문자열, 주소
--데이터 크기 만큼 공간 확보 

??고정길이 데이터: 남, 여
char(2)>>
성능상 char()검색 우선
char()->varchar() 검색 우선

결국 문제는 한글
웹에서 한글 깨는 문제 - 한글, 영어1,2바이트때문
unicode(2byte): 한글, 영문자, 특수문자, 공백>>2byte
nchar(20)>>20글자>>
nvarchar
--n(문자의 개수)
*/

------------------------
--변환함수
--oracle:
--to_char(): 숫자->문자(중요함)
--to_date():
--to_number(): 자동 형변환

--1. to_number: 문자를 숫자로(자동 형변환되므로 원리만)
select 1+1 from dual;
select '1'+1 from dual;
select TO_NUMBER('1')+1 from dual;

--2. to_char(): 
select sysdate from dual;

select TO_CHAR(SYSDATE)||'알' FROM dual;

SELECT SYSDATE, TO_CHAR(sysdate,'YYYY')||'년' AS 'YYYY',
TO_CHAR(sysdate,'YEAR'),
TO_CHAR(sysdate,'MM'),
FROM dual;

/*
입사일이 12월인
*/

select * from emp;
select empno, ename,hiredate,TO_CHAR(hiredate,'YYYY'), TO_CHAR(hiredate, 'MM') FROM emp where TO_CHAR(hiredate, 'MM')=12;
select to_char(hiredate, 'YEAR') from emp;
--
--to_char
--
--표 오라클.pdf 71 page
SELECT '>'||TO_CHAR(1234,'99999')||'<'FROM dual;

select '/'||TO_CHAR(12345,'$9,999')||'<' FROM dual;

select *from employees;



------HR 계정으로 전환--------
SELECT * FROM EMPLOYEES;
desc employees;
/*
이름
입사일
연봉, 인상값
결과: 1000단위, 2005년 이후
*/
/*
사원테이블(employees)에서 사원의 이름은 last_name , first_name 합쳐서 fullname 별칭 부여해서 출력하고
입사일은  YYYY-MM-DD 형식으로 출력하고 연봉(급여 *12)을 구하고 연봉의 10%(연봉 * 1.1)인상한 값을 
출력하고 그 결과는 1000단위 콤마 처리해서 출력하세요
단 2005년 이후 입사자들만 출력하세요 그리고 연봉이 높은 순으로  출력하세요
*/

select last_name,first_name,hire_date from employees;
select * from employees;
select employee_id,
       first_name||last_name as "fullname",
       to_char(hire_date, 'YYYY-MM-DD'),
       SALARY*12 as "연봉"
       
       from employees;
       
---다시 bituser 계정으로 전환
--to_date() 문자를 _> 날짜로
--select '2019-01-03'+ 100 form dual;
--select to_date(
-------------------------------------
--변환함수(to_char(), to_date(), to_number()
--일반함수(프로그램적인 성격이 강한 함수)
--nvl(), nvl2() >> null 처리 함수
--decode() 함수>> java if 문
--case()함수 >>java switch 문

SELECT comm, NVL(comm,0) from emp;
CREATE TABLE t_emp(
  id NUMBER(6),
  job VARCHAR2(20)
  );
SELECT * FROM t_emp;
  INSERT INTO t_emp(id, job) VALUES(100,'IT);
  INSERT INTO t_emp(id, job) VALUES(200,'SALES);
  INSERT INTO t_emp(id, job) VALUES(300,'MGR');
  INSERT INTO t_emp(id) VALUES(400);
  INSERT INTO t_emp(id, job) VALUES(500,'DD');
  COMMIT;
/*  
--1. nvl
select id,job, nvl(job,'Empty...) as "job" FROM T_EMP;

--2. nvl >> null이 아닌 경우, null인 경우
select id, job, nvl2(job, job||'입니다','empty') from t_emp;
  
select id, job, nvl2(job, 'AAA','BBB') from t_emp;

--3. decode POINT(통계 데이타: if, switch)
--decode(표현식, 조건1, 결과1, 조건2, 결과2, 조건3, 결과3...)
select id, job, 
          decode(id,100,'it...',
          200,'sales...',
          300,'mgr...'etc)
          'etc'
from t_emp;

select job, decode(job,'it',1) from t_emp;
select count(decode(job,'it',1)) as "it",
       count(decode(job,'it',1)) as "it",
       count(decode(job,'it',1)) as "it",       
from t_emp; 
       
*/

emp 테이블에서 부서 번호개 
10 > 인사부
20> 관리부
30이면> 회계부
*/

select deptno from emp;
decode, decode(deptno,10,'인사부',
                                20, )
from emp;

--Quiz
CREATE TABLE t_emp2(
id NUMBER(2),
jumin CHAR(7)
);
INSERT INTO t_emp2(id, jumin) VALUES(1,'1234567');
INSERT INTO t_emp2(id, jumin) VALUES(2,'2234567');
INSERT INTO t_emp2(id, jumin) VALUES(3,'3234567');
INSERT INTO t_emp2(id, jumin) VALUES(4,'4234567');
INSERT INTO t_emp2(id, jumin) VALUES(5,'5234567');
COMMIT;
SELECT * FROM t_emp2;

/*
t_emp2 테이블에서 id, jumin 데이터를 출력하되 jumin 컬럼의 앞자리가 1이면
'남성' 출력 2이면 '여성' 3이면 '중성' 그외는 '기타'라고 출력하세요
컬럼면은 '성별'
*/
select id, jumin decode(substr(jumin,1,1),1,'남성'

from t_emp2;


/*
부서번호 20번 > smith > hello
20번 > smith(x) > world
20번(x) > etc
*/
select * from emp;
select empno, ename, decode(deptno,20,decode(ename,'SMITH','HELLO','WORLD'),'ETC')
from emp;

--CASE 문
--Java: switch
/*
CASE 조건식 WHERE 결과1 THEN 출력1
           WHERE 결과2 THEN 출력2
           WHERE 결과3 THEN CNF
           
           
*/

CREATE TABLE t_zip(
zipcode number(10)
);
insert into t_zip(zipcode) values(2);
insert into t_zip(zipcode) values(31);
insert into t_zip(zipcode) values(32);
insert into t_zip(zipcode) values(33);
insert into t_zip(zipcode) values(41);
commit;
select * from t_zip;

select case zipcode when 2 then '서울' 
when 31 then '경기'
when 32 then '강원'
when 32 then '제주'
else '기타지역'
end "regionname"
from f_zip;



select * from t_zip;

select 'O'||to_char(zipcode),
select case zipcode when 2 then '서울' 
when 31 then '경기'
when 32 then '강원'
when 32 then '제주'
else '기타지역'
end "regionname"
from f_zip;

/*
사원테이블 사원급여 1000달러 이하면 '4급'
1001달러 2000달러 이하면 '3급'
2001달러 2000달러 이하면 '2급'
3001달러 2000달러 이하면 '1급'
4001달러 이상이면 '특급'


*/
--1.case 컬럼명 when 결과 then 출력 (=) 조건
--2.case when 컬럼명 조건 비교신 then
--       when 컬럼명 조건 비교식 then
         
 SELECT CASE WHEN SAL<=1000 THEN '4급'
              WHEN SAL BETWEEN 1011 AND 2000 THEN '3급'
              WHEN SAL BETWEEN 2001 AND 3000 THEN '2급'
              WHEN SAL BETWEEN 3001 AND 4000 THEN '1급'
              WHEN SAL>=4001 THEN '특급'
         END AS "회원등급"
  FROM EMP;
 
 --------------------------
 --문자함수
 --숫자
 --날짜
 --변환 to_char(), to_date(), to_number()
 --일반 nvl(),decode(),case() 
         
 ---------------------------        
 --오라클 pdf(75 page)
 --집계함수--
 --1.count()>row 수, count(컬럼명)>>
 --2.sum()
 --3. avg()
 --4. max()
 --5. min()
 --등등
 
 1.집계함수는 group by 절과 같이 사용
 2.모든 집계함수는 null 값을 무시
 3.select 절에 집계함수 이외에 다른 컬럼이 오면 반드시 그 컬럼은 group by 절에 명시되어야 된다
 select * from emp;
 select count(*) from emp;
 select count(comm) from emp;
 select count(empno) from emp;
 
 --select count(comm) from emp; 데이터가 14건 출력하게
 select count(nvl(comm,0)) from emp;
 
 --급여의 합
 select sum(sal) as "급여의 합" from emp; 
 
 --평균급여
 select avg(sal) as "평균급여" from emp;
 
 --사장님이 회사 총 수당이 얼마나 지급되나...(수당의 평균)
 select trunc(avg(comm),0) from emp; --721 --회사의 규정이 (전체 사원수로 나눈다_309)
 select trunc(sum(comm)/6.0) from emp; 
 --
 select sum(comm) from emp;
 select trunc(sum(comm)/14) from emp;
 
select trunc(avg(nvl(comm,0)),0) from emp; --309
 --회사의 규정이 (전체 사원수로 나눈다_309)
 --회사의 규정이 (받는 사원수로 나눈다_721)
 
 select count(*) from emp where comm is null; --데이터 처리 null 검증 처리
 desc emp;
 
 select max(sal) from emp;
 select in(sal) from emp;
 
 --포인트 
 
 select empno, count(empno) from emp; --(x) empno 14건, 집계 1건
 
 select sum(sal), avg(sal), max(sal), min(sal), count(sal), count(*) from emp;
 
--부서별 평균 급여를 구하세요
select deptno, avg(sal)
from emp
group by deptno;

--직종별 평균 급여를 구하세요
select job, avg(sal)
from emp
group by job;

--직종별 평균급여, 급여합, 초대급여, 초소급여, 건수를 출력하세요.
select avg(sal), sum(sal), max(sal), min(sal), count(sal)
from emp
group by job;

/*
grouping 원리
distinct 컬럼명1, 컬럼명2
order by 컬럼명1, 컬럼명2
group by 컬럼명1, 컬럼명2

--부서별, 직종별 급여의 합을 구하세요
*/

select deptno, job, sum(sal), count(sal)
from emp
group by deptno, job
order by deptno;

 /*
 select
 from
 where
 group by
 order by
 >>4-1-2-3-5
 
 
 */
 
 
--직종별 평균급여가 3000 달러 이상인 사원의 직종과 평균급여를 출력하셍요
select job,avg(sal) as "avgsal"
 from emp
 --where 순서상 group by 우선...
 group by job
 having avg(sal)>=3000;
 
 /*
 from의 조건절 where
 group by 조건절
 */
 
 /*
 select
 from
 where
 group by
 haveing
 order by
 5-1-2-3-4-6
 f-w, g-h
*/

/*
1.사원테이블에서 직종별 급여합을 출력하되 수당은 지급 받고 급여의 합이 5000 이상인 사원들의 목록을 출력하세요
--급여의 합이 낮은 순으로 출력하세요
*/

SELECT JOB,SUM(SAL)
FROM EMP

WHERE COMM IS NOT NULL
GROUP BY JOB
HAVING SUM(SAL)>=5000
ORDER BY SUM(SAL) ASC
;


/*
2.사원테이블에서 부서 인원이 4명보다 많은 부서의 부서번호 ,인원수 , 급여의 합을 출력하세요
*/

SELECT DEPTNO, COUNT(DEPTNO), SUM(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING COUNT(DEPTNO)>4;

/*
3.사원테이블에서 직종별 급여의 합이 5000를 초과하는 직종과 급여의 합을 출력하세요
단 판매직종(salesman) 은 제외하고 급여합으로 내림차순 정렬하세요
*/
 
 SELECT JOB, SUM(SAL)
 FROM EMP
 GROUP BY JOB
 HAVING SUM(SAL)>5000
 ORDER BY SUM(SAL) DESC;

--1.사원테이블에서 직종별 급여합을 출력하되 수당은 지급 받고 급여의 합이 5000 이상인 사원들의 목록을 출력하세요
--급여의 합이 낮은 순으로 출력하세요


