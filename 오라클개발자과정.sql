/*
[1���� ����]
1. ����Ŭ ����Ʈ���� �ٿ�ε�
https://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html

2. Oracle Database 11g Release 2 Express Edition for Windows 64 (���ἳġ)

3. Oracle ��ġ(SYS, SYSTEM ������ ���� ��ȣ : 1004)

4.Sqlplus ���α׷� ����(CMD) : GUI ȯ�� �Ϲݰ����� ��� ����

5.������ Tool ��ġ ����(SqlDeveloper)  , 
                 ����(��� , ������ , SqlGate) ������Ʈ�� ��ġ Ȱ�� ^^

6. SqlDeveloper ���� ���ؼ� Oracle Server ���� ....
   >> HR ���� : ��ȣ 1004 , Unlock 2���� ��밡�� .... (������� �ǽ� ���̺�)
   >> ���ο� ���� : bituser 
   
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

7. ���� ���� ���� Ȯ�� : show user;   >> USER��(��) "BITUSER"�Դϴ�.

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

--1. ������̺��� ��� �����͸� ����ϼ���

select * from emp;    --����������  ��ҹ��ڸ� �������� �ʽ��ϴ�
SELECT * FROM DEPT; 
select * from salgrade;

--2. Ư�� �÷� ������ ����ϱ�
select empno , ename , sal from emp;

--3. �÷��� ����Ī(��Ī)(alias) �ο��ϱ�

select empno ��� , ename �̸� 
from emp;

select empno "��    ��" , ename "��     ��" 
from emp;

--����(ansi ����)
select empno as "��    ��" , ename as "��     ��" 
from emp;

--Oracle ������ ���ڿ� (���ڿ� �����ʹ� ��ҹ��� ����)
--���ڿ� ǥ��  '���ڿ�'
-- �ҹ��� : a   �빮�� : A �ٸ� ���� ���
select empno , ename from emp where ename='king';

select empno , ename from emp where ename='KING';

--Oracle SQL : ������ (���� ������( || )  �� ���������( + ) ����)
--Java :  + (���� + ����  ����)
--Java :  + (���ڿ� + ���ڿ� ����)
--TIP) ms-sql +(����, ����)


select '����� �̸���' || ename || ' �Դϴ�'  as "�������"
from emp;

--���̺� �÷��� �⺻ Ÿ��
--�÷��� Ÿ�� ���� , ���� , ��¥ ....
desc emp;  --���̺��� Ÿ�� �⺻ ���� ��ȸ

select  empno  ||  ename  -- number || varchar  ���������� ����ȯ (���� -> ����) ����
from emp;

select empno + ename   --"invalid number"  Ÿ���� ���� �ʾƼ�   ������� �Ұ�
from emp;

--����� �츮 ȸ�翡 ������ ��� �ֳ�
--distinct : �ߺ� ������ ����
--distinct ���� : grouping 
select distinct job from emp;


--��̻�Ƽ� ... (group ��  group �� ������)
select distinct  job , deptno from emp order by job ;

select distinct  deptno , job from emp order by deptno;

----------------------------------------------------------------------
--Oracle (SQL ���)
--JAVA ���( ������)
--JAVA ���� ���� ( + , * , - ....) : % ������   >>  ����Ŭ  % �˻� ����  >> ������ ���ϴ� ������ (x) : Mod() �Լ�

--������� (+ , * , - , / .....) , Mod() �Լ� �������� ���Ѵ�

--������̺��� ����� �޿��� 100�޷� �λ��� ����� ����ϼ���
desc emp; --SAL   NUMBER
select empno, sal , sal + 100 as "�λ�޿�"  from emp;

select 100 + 100 from dual;  -- dual �ӽ� ���̺� ...
select 100 || 100 from dual;  -- 100100 (����ȯ)
select '100' + 100 from dual; -- ����Ŭ����  + ������ ���  (���ڸ� ���ڷ�)
select 'A100' + 100 from dual; -- Error .......

--�񱳿�����
-- >  , < , <=
--Java ���� (==)  �Ҵ� (=)
--Oracle ����(=)   ���� �ʴ� (!=)

--�� ������
--AND , OR , NOT

--������ (���ϴ� row ������ ���ڴ�)
select *
from emp
where sal >= 3000;

select empno , ename , sal
from emp
where sal >= 3000;


--�̻� , ���� (= ����)
--�ʰ� , �̸� 

--����� 7788���� ����� ���, �̸�, ���� , �Ի����� ����ϼ���
--������� : 
select empno, ename,job,hiredate       --3
from emp                                      --1
where empno=7788;                         --2

--����� �̸��� king ����� ���, �̸�, �޿� ������ ����ϼ���
select empno , ename , sal
from emp
where ename = 'KING';

--hint) �� (AND , OR )
--AND �ΰ��� ��� �� --> ��

--�޿��� 2000�޷� �̻��̸鼭 ������ manager �� ����� ��� ������ ����ϼ���
--�ΰ��� ������ ��� ���� (�Ѵ� ����)
select *
from emp
where sal >= 2000 and job='MANAGER';

--�޿��� 2000�޷� �̻��̰ų� ������ manager �� ����� ��� ������ ����ϼ���
--�ΰ��� ������ �ϳ��� ���̿��� ���
select *
from emp
where sal >= 2000 or job='MANAGER';

--------------------------------------------------------------------------
--����Ŭ ��¥ (DB ������ ��¥)
--����Ŭ ��¥ (sysdate)
--��� �ý��� ��¥ ���� 
--�Խ��� �۾���
--insert into board(writer , title , content , regdate)  values('ȫ�浿' , '�氡' , '����Ŀ�' , sysdate)
--TIP) ms -sql : select getdate()


select  sysdate from dual;

alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';

select hiredate from emp;

--����Ŭ �ý��� ���̺� ....
select * from SYS.NLS_SESSION_PARAMETERS;   --�ý��� ȯ�� ���̺� ��ȸ Ȯ��
--NLS_DATE_FORMAT	      YYYY-MM-DD HH24:MI:SS
--NLS_DATE_LANGUAGE	    KOREAN
--NLS_TIME_FORMAT	        HH24:MI:SSXFF

--����Ŭ ��¥ ��ȸ  : '2019-12-12' 
select * from emp
where hiredate = '1980-12-17';   --  (-)

select * from emp
where hiredate = '1980/12/17';    -- (/)


select * from emp
where hiredate = '80/12/17';  --������ ������ �ȵǿ� 
--���� : RR-MM-DD  >> YYYY-MM-DD

--����� �޿��� 2000 �̻��̰� 4000 ������ ��� ����� ������ ��� �ϼ���
select *
from emp
where sal >= 2000 and sal <= 4000;
--������ : between A and B  (= ����)
--���ǻ��� : �̸� �ʰ� �� ��� ����
select * 
from emp
where sal between 2000 and 4000;

--����� �޿��� 2000 �ʰ� 4000 �̸��� ��� ����� ������ ��� �ϼ���

select *
from emp
where sal > 2000 and sal < 4000;

--�μ���ȣ�� 10 �� �Ǵ� 20�� �Ǵ� 30���� ����� ��� , �̸� , �޿�  ,�μ���ȣ�� ����ϼ���
select empno, ename, sal , deptno
from emp
where deptno=10 or  deptno=20 or deptno=30;
-- IN ������ (���� or ���� or ....)
select empno, ename, sal , deptno
from emp
where deptno in(10,20,30); --deptno=10 or  deptno=20 or deptno=30;

--�μ���ȣ�� 10 �� �Ǵ� 20���� �ƴ� ����� ��� , �̸� , �޿�  ,�μ���ȣ�� ����ϼ���

select * 
from emp
where deptno != 10 and deptno != 20; 

--NOT IN ������(������ and  ������ and ....)
select *
from emp
where deptno not in (10,20); --not in (deptno != 10 and deptno != 20; )

--POINT : Oracle ���� ����(������ ����) >> null
--null  (�ʿ��)

create table member(
  userid varchar2(20) not null,  --�ʼ��Է�
  name varchar2(20) not null,  --�ʼ��Է�
  hobby varchar2(50)           --default null (null ���� ����ϰڴ�) :  �ɼ� ...
);

desc member;
insert into member(userid,hobby) values('hong' , '��');  --���� �ȵ� (name �÷��� ....)
insert into member(userid,name) values('hong' , 'ȫ�浿'); -- hobby �÷��� ������ >> null
select * from member;
insert into member(userid,name,hobby) values('kim' , '�达', '����');
select * from member;

--�����ݿ�
commit;



--����(comm)�� ���� �ʴ� ��� ����� ������ ����ϼ���
-- 0 �� ������ ���(�޴� ���� ����)
--comm �÷��� �����Ͱ� null �ΰ͸� ����ϼ���
select * from emp where comm = null; -- (x)

--null �� �񱳴� (is null , is not null)
select * from emp where comm is null; 


--����(comm)�� �޴� ��� ����� ������ ����ϼ���
select * from emp where comm is not null; 


--������̺��� ��� , �̸� ,�޿� , ���� , �ѱ޿��� ����ϼ���
--�ѱ޿� (�޿� + ����)
select empno , ename , sal , comm , sal + comm as "�ѱ޿�"
from emp; 


select empno , ename , sal , comm , sal + nvl(comm,0) as "�ѱ޿�"
from emp; 

--POINT  null
--1. null ���� ��� ������ �� ����� : null 
--2.�� ���� �ذ� : �Լ� nvl() , nvl2()   >> TIP ms-sql : convert()  , my-sql : IFNULL()  : null �� ��ü ...

select 1000 + null from dual;

select 1000 + nvl(null,0) from dual;

select comm , nvl(comm,11111) from emp;

--����� �޿��� 1000 �̻��̰� ������ ���� �ʴ� �����  ���, �̸�, ����, �޿� , ������ ����ϼ���
select empno, ename,job,sal,comm
from emp
where sal >= 1000 and comm is null;

---------------------------------------------------------------------------
--DQL(data query language) : SELECT
--DDL(������ ���Ǿ�) : create , alter , drop ... (��ü ���� , ���� ,����)

--create Board (boardno number ...
-- JAVA : class Board { private boardno int }

create table Board (
 boardid number not null , --���� , �ʼ��Է�
 title varchar2(20) not null , --�ѱ� 10�� , ������ ,Ư������ ,���� 20�� , �ʼ��Է�
 content varchar2(2000) not null , -- �ʼ� �Է�
 hp varchar2(20)  -- default null ���  �ʼ� �Է� ���� (x)
);

desc Board;

--DML(������ ���۾�) �ݿ� ���ο��� ���� (�ǹݿ�(commit) , ���(rollback)) �ݵ�� ����
--insert , update , delete �۾�

insert into board(boardid, title , content)
values(100,'����Ŭ','�Ҹ� �ϳ�');

select * from board; 
--�ǻ���� : ���� �ݿ� �Ұž� (commit)
--�ǻ���� : ���� �ݿ� ���Ұž� (rollback)

rollback;
commit;

--begin
insert into board(boardid, title , content)
values(200,'�ڹ�','�׸���');

insert into board(boardid, title , content)
values(300,'�ڹ�2','�׸���2');

--commit �Ѵٹݿ�
--rollback �Ѵ� ���

select * from board;
commit;

select boardid , nvl(hp,'EMPTY') as "hp" from board;
--nvl �Լ��� ���� , ��¥ , ���ڿ�  ��� ���� �����ϴ� .... ^^

------------------------------------------------------------------------------------
--���ڿ� �˻�
--�ּҰ˻� : �˻��� : '����' -> ���� �ܾ �ִ� ��� ����  (LIKE �˻�)
--���ڿ� ���� �˻� ( Like ������)

--like ������ ( ���ϵ� ī�� ���� ( % : ���� ,  _ : �ѹ��� ) ���� ......

select ename
from emp
where ename like '%A%';  --ename �÷��� �����Ϳ� A ����ִ� ��� �̸� ....

select ename
from emp
where ename like '%a%';  -- ���ڿ� ������ ��ҹ��� �����ϰ� ����

select ename
from emp
where ename like 'A%'; -- �̸��� ù ���ڰ� A ����

select ename
from emp
where ename like '��%'; -- �̸��� ù ���ڰ� A ����

select ename
from emp
where ename like '���ȯ��%';


select ename
from emp
where ename like '%S';


select ename
from emp
where ename like '%LL%';



select ename
from emp
where ename like '%A%A%';  -- A �� �ΰ��� ������ ....


select ename
from emp
where ename like '_A%';  --ù���� ����� �͵� ������� �ι�° ���ڴ� A ...
--WARD
--MARTIN
--JAMES

--����Ŭ ���� (regexp_like) �� �˻�
--select * from emp where regexp_like(ename,'[A-C]');
--����ǥ����(java -> oracle -> javascript )
--���� : ���� ǥ�� ���� 5�� ����� (ī�� �÷��帮�� �ϼ���)  �߰� ������Ʈ �䱸����

---------------------------------------------------------------------------------------
--������ �����ϱ�
--order by �÷��� : ���� , ���� , ��¥ 
--�������� : asc : ������  (default)
--�������� : desc : ������ 

select * from emp order by sal;  --default asc

select * from emp order by sal asc;

--�޿��� ���� �޴� ������ �����ؼ� ����ϼ���
select * from emp order by sal desc;

select ename from emp order by ename asc; -- ���İ���

--�Ի����� ���� ���� ������ �����ؼ� ���  , �̸� , �޿� , �Ի��� �����͸� ����ϼ���
--(���� �ֱٿ� �Ի��� ������)

select empno, ename, sal, hiredate
from emp
order by hiredate desc;

/*
�������
SELECT                   3
FROM                     1
WHERE                    2
ORDER BY                4  (select ����� ����)
*/

--�ؼ� 
select empno , ename, sal , job , hiredate
from emp
where job = 'MANAGER' 
order by hiredate desc;

--order by �÷��� desc , �÷��� asc , �÷��� desc 
select job , deptno
from emp
order by job asc , deptno desc;

---------------------------------------------------------------------------------------------
--������
--������(union) : ���̺�� ���̺��� �����͸� ��ġ�� �� (�ߺ����� ����)
--������(union all) : �ߺ��� ���

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

--union ��Ģ
--1. ������� �÷��� Ÿ���� ����
select empno, ename from emp
union
select dname , deptno from dept;  --�����Ǵ� Ÿ���� Ʋ����

select empno, ename from emp
union
select deptno , dname from dept;


--�ǹ� > subquery (in line view)  TIP ....
select empno, ename
from (
          select empno, ename from emp
            union
          select deptno , dname from dept  
        ) order by empno desc;

--2. ������� �÷��� ������ ����  ( null ������)
select empno , ename , job , sal from emp
union
select deptno, dname,loc,null from dept;

--��������� �ʺ������ڰ� �ǹ������� �ؾ��ϴ� (���� ���̺�) ������� .....
-------------------------------------------------------------------------------------
--����Ŭ �Լ� ......
select * from SYS.NLS_DATABASE_PARAMETERS;
--NLS_CHARACTERSET  : 	AL32UTF8  �ѱ� 3byte �ν�
--KO16KSC5601 2Byte (���� ��ȯ�ϸ� �ѱ� �ٱ���)
select * from nls_database_parameters where parameter like '%CHAR%';



/*
1) ������ �Լ� : ���ڸ� �Է� �ް� ���ڿ� ���� �� ��θ� RETURN �� �� �ִ�.
2) ������ �Լ� : ���ڸ� �Է� �ް� ���ڸ� RETURN �Ѵ�.
3) ��¥�� �Լ� : ��¥���� ���� �����ϰ� ���ڸ� RETURN �ϴ� MONTHS_BETWEEN �Լ���
�����ϰ� ��� ��¥ ���������� ���� RETURN �Ѵ�.
4) ��ȯ�� �Լ� : � ���������� ���� �ٸ� ������������ ��ȯ�Ѵ�.
5) �Ϲ����� �Լ� : NVL, DECODE
*/
--���ڿ� ����

select length('abcd') from dual;
select length('ȫ�浿') from dual;

select 'a'||'b'||'c' as "data" from dual;

select concat(ename.job) from emp;
select ename ||'  '|| job from emp;

--�κ� ���ڿ� ����
--java(substring)
--oracle(stustr)
select substr('abcde',2,3) from dual; --bcd
select substr('abcde',1,1) from dual; 
select substr('abcde',3,3) from dual; 

select substr('abcde',3) from dual;
select substr('abcde',-2,1) from dual;
select substr('abcde',-2,2) from dual;

/*������̺��� ename ù���� �ҹ���, ������ �빮�� ��� �÷����� ���
--�÷���  ����Ī��: fullname
--ù���ڿ� ������ ���� ���� ���� ��������
ex) SMITH >> s MITH
*/
SELECT ename from emp;
select lower(substr(ename,1,1)) from emp;
select upper(substr(ename,2)) from emp;
select lower(substr(ename,1,1)) ||' '||upper(substr(ename,2)) as "fulname" from emp;

--lpad, rpad(ü���)
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
--�÷��� ����Ī "juminnumber"

select id||':'|| rpad(substr(jumin,1,7),length(jumin),'*') as "jumin" from member2;

--rtrim �Լ�
--������ ���� ������
select rtrim('MILLER', 'ER') from dual;
select ltrim('MILLLLLER', 'MIL') from dual;
--select'>'||rtrim('MILLER     ',')||'<' from dual;

--ġȯ(replace)
--select

-----------���ڿ� �Լ�(end)--------------
--ROUND ���ڸ� �ݿø�
--TRUNC ���ڸ� ����
--MOD �������� ����


select round(12.345,0) as "r" from dual; --0������
select round(12.567,0) as "r" from dual;

select round(12.345,1) as "r" from dual;
select round(12.567,1) as "r" from dual;

select round(12.345,-1) as "r" from dual; -- -1�� 10�� �ڸ�
select round(15.345,-1) as "r" from dual;
select round(15.345,-2) as "r" from dual;


--turnc(�ݿø� ���� �ʰ� ����)
select round(12.345,0) as "t" from dual; --0������
select round(12.567,0) as "t" from dual; --12

select round(12.345,1) as "t" from dual; --12.3
select round(12.567,1) as "t" from dual;

select round(12.345,-1) as "t" from dual; -- -1�� 10�� �ڸ�
select round(15.345,-1) as "t" from dual;
select round(15.345,-2) as "t" from dual;

--select trunc
--select round

--������
select 12/10 from dual; --1.2
select mod(12,10) from dual; --2
select mod(0,0) from dual; --0

----[���� �Լ� end]-----


--��¥�Լ�
select sysdate from dual;
--
--��¥ ����(����Ʈ)
--Date + Number >> Date
--Date - Number >> Date (100����)
--Date - Date >> Number (�ټ��ϼ�)

select * from SYS.NLS_SESSION_PARAMETERS;

select hiredate from emp;
select MONTHS_BETWEEN('2018-02-27, 2020-02-27') from dual; --������ �� 
--round ���
--trunc
select to_date('2019-03-20')+100 from dual; --19/06/28 --to_date
select to_date('2019-03-20')+1000 from dual;

--Q
--1.��� �Ի��Ͽ��� ���糯¥���� �ټӿ���
--�� �ټӿ����� ���κκи� ���
select trunc(months_between(sysdate,hiredate),0) as "�ټ��ϼ�" from emp;
--2.�Ѵ��� 31�� �̶�� ���ؿ��� �ټӿ����� ���ϼ���
--��/31>��
select hiredate from emp;
select trunc((sysdate-hiredate)/31) from emp;


/*
����Ŭ �⺻ ������ Ÿ��
create table ���̺��(�÷��� Ÿ��)
create table m

java: class person _ >>person p=new person(); 1��

oracle: create person

���� Ÿ��
--char(20) >> 20byte>> �ѱ�10��, ������, Ư������, ���� 20��: �������� ���ڿ�
--varchar2(20) >> 20byte >> ���� : �������� ���ڿ�, �ּ�
--������ ũ�� ��ŭ ���� Ȯ�� 

??�������� ������: ��, ��
char(2)>>
���ɻ� char()�˻� �켱
char()->varchar() �˻� �켱

�ᱹ ������ �ѱ�
������ �ѱ� ���� ���� - �ѱ�, ����1,2����Ʈ����
unicode(2byte): �ѱ�, ������, Ư������, ����>>2byte
nchar(20)>>20����>>
nvarchar
--n(������ ����)
*/

------------------------
--��ȯ�Լ�
--oracle:
--to_char(): ����->����(�߿���)
--to_date():
--to_number(): �ڵ� ����ȯ

--1. to_number: ���ڸ� ���ڷ�(�ڵ� ����ȯ�ǹǷ� ������)
select 1+1 from dual;
select '1'+1 from dual;
select TO_NUMBER('1')+1 from dual;

--2. to_char(): 
select sysdate from dual;

select TO_CHAR(SYSDATE)||'��' FROM dual;

SELECT SYSDATE, TO_CHAR(sysdate,'YYYY')||'��' AS 'YYYY',
TO_CHAR(sysdate,'YEAR'),
TO_CHAR(sysdate,'MM'),
FROM dual;

/*
�Ի����� 12����
*/

select * from emp;
select empno, ename,hiredate,TO_CHAR(hiredate,'YYYY'), TO_CHAR(hiredate, 'MM') FROM emp where TO_CHAR(hiredate, 'MM')=12;
select to_char(hiredate, 'YEAR') from emp;
--
--to_char
--
--ǥ ����Ŭ.pdf 71 page
SELECT '>'||TO_CHAR(1234,'99999')||'<'FROM dual;

select '/'||TO_CHAR(12345,'$9,999')||'<' FROM dual;

select *from employees;



------HR �������� ��ȯ--------
SELECT * FROM EMPLOYEES;
desc employees;
/*
�̸�
�Ի���
����, �λ�
���: 1000����, 2005�� ����
*/
/*
������̺�(employees)���� ����� �̸��� last_name , first_name ���ļ� fullname ��Ī �ο��ؼ� ����ϰ�
�Ի�����  YYYY-MM-DD �������� ����ϰ� ����(�޿� *12)�� ���ϰ� ������ 10%(���� * 1.1)�λ��� ���� 
����ϰ� �� ����� 1000���� �޸� ó���ؼ� ����ϼ���
�� 2005�� ���� �Ի��ڵ鸸 ����ϼ��� �׸��� ������ ���� ������  ����ϼ���
*/

select last_name,first_name,hire_date from employees;
select * from employees;
select employee_id,
       first_name||last_name as "fullname",
       to_char(hire_date, 'YYYY-MM-DD'),
       SALARY*12 as "����"
       
       from employees;
       
---�ٽ� bituser �������� ��ȯ
--to_date() ���ڸ� _> ��¥��
--select '2019-01-03'+ 100 form dual;
--select to_date(
-------------------------------------
--��ȯ�Լ�(to_char(), to_date(), to_number()
--�Ϲ��Լ�(���α׷����� ������ ���� �Լ�)
--nvl(), nvl2() >> null ó�� �Լ�
--decode() �Լ�>> java if ��
--case()�Լ� >>java switch ��

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

--2. nvl >> null�� �ƴ� ���, null�� ���
select id, job, nvl2(job, job||'�Դϴ�','empty') from t_emp;
  
select id, job, nvl2(job, 'AAA','BBB') from t_emp;

--3. decode POINT(��� ����Ÿ: if, switch)
--decode(ǥ����, ����1, ���1, ����2, ���2, ����3, ���3...)
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

emp ���̺��� �μ� ��ȣ�� 
10 > �λ��
20> ������
30�̸�> ȸ���
*/

select deptno from emp;
decode, decode(deptno,10,'�λ��',
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
t_emp2 ���̺��� id, jumin �����͸� ����ϵ� jumin �÷��� ���ڸ��� 1�̸�
'����' ��� 2�̸� '����' 3�̸� '�߼�' �׿ܴ� '��Ÿ'��� ����ϼ���
�÷����� '����'
*/
select id, jumin decode(substr(jumin,1,1),1,'����'

from t_emp2;


/*
�μ���ȣ 20�� > smith > hello
20�� > smith(x) > world
20��(x) > etc
*/
select * from emp;
select empno, ename, decode(deptno,20,decode(ename,'SMITH','HELLO','WORLD'),'ETC')
from emp;

--CASE ��
--Java: switch
/*
CASE ���ǽ� WHERE ���1 THEN ���1
           WHERE ���2 THEN ���2
           WHERE ���3 THEN CNF
           
           
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

select case zipcode when 2 then '����' 
when 31 then '���'
when 32 then '����'
when 32 then '����'
else '��Ÿ����'
end "regionname"
from f_zip;



select * from t_zip;

select 'O'||to_char(zipcode),
select case zipcode when 2 then '����' 
when 31 then '���'
when 32 then '����'
when 32 then '����'
else '��Ÿ����'
end "regionname"
from f_zip;

/*
������̺� ����޿� 1000�޷� ���ϸ� '4��'
1001�޷� 2000�޷� ���ϸ� '3��'
2001�޷� 2000�޷� ���ϸ� '2��'
3001�޷� 2000�޷� ���ϸ� '1��'
4001�޷� �̻��̸� 'Ư��'


*/
--1.case �÷��� when ��� then ��� (=) ����
--2.case when �÷��� ���� �񱳽� then
--       when �÷��� ���� �񱳽� then
         
 SELECT CASE WHEN SAL<=1000 THEN '4��'
              WHEN SAL BETWEEN 1011 AND 2000 THEN '3��'
              WHEN SAL BETWEEN 2001 AND 3000 THEN '2��'
              WHEN SAL BETWEEN 3001 AND 4000 THEN '1��'
              WHEN SAL>=4001 THEN 'Ư��'
         END AS "ȸ�����"
  FROM EMP;
 
 --------------------------
 --�����Լ�
 --����
 --��¥
 --��ȯ to_char(), to_date(), to_number()
 --�Ϲ� nvl(),decode(),case() 
         
 ---------------------------        
 --����Ŭ pdf(75 page)
 --�����Լ�--
 --1.count()>row ��, count(�÷���)>>
 --2.sum()
 --3. avg()
 --4. max()
 --5. min()
 --���
 
 1.�����Լ��� group by ���� ���� ���
 2.��� �����Լ��� null ���� ����
 3.select ���� �����Լ� �̿ܿ� �ٸ� �÷��� ���� �ݵ�� �� �÷��� group by ���� ��õǾ�� �ȴ�
 select * from emp;
 select count(*) from emp;
 select count(comm) from emp;
 select count(empno) from emp;
 
 --select count(comm) from emp; �����Ͱ� 14�� ����ϰ�
 select count(nvl(comm,0)) from emp;
 
 --�޿��� ��
 select sum(sal) as "�޿��� ��" from emp; 
 
 --��ձ޿�
 select avg(sal) as "��ձ޿�" from emp;
 
 --������� ȸ�� �� ������ �󸶳� ���޵ǳ�...(������ ���)
 select trunc(avg(comm),0) from emp; --721 --ȸ���� ������ (��ü ������� ������_309)
 select trunc(sum(comm)/6.0) from emp; 
 --
 select sum(comm) from emp;
 select trunc(sum(comm)/14) from emp;
 
select trunc(avg(nvl(comm,0)),0) from emp; --309
 --ȸ���� ������ (��ü ������� ������_309)
 --ȸ���� ������ (�޴� ������� ������_721)
 
 select count(*) from emp where comm is null; --������ ó�� null ���� ó��
 desc emp;
 
 select max(sal) from emp;
 select in(sal) from emp;
 
 --����Ʈ 
 
 select empno, count(empno) from emp; --(x) empno 14��, ���� 1��
 
 select sum(sal), avg(sal), max(sal), min(sal), count(sal), count(*) from emp;
 
--�μ��� ��� �޿��� ���ϼ���
select deptno, avg(sal)
from emp
group by deptno;

--������ ��� �޿��� ���ϼ���
select job, avg(sal)
from emp
group by job;

--������ ��ձ޿�, �޿���, �ʴ�޿�, �ʼұ޿�, �Ǽ��� ����ϼ���.
select avg(sal), sum(sal), max(sal), min(sal), count(sal)
from emp
group by job;

/*
grouping ����
distinct �÷���1, �÷���2
order by �÷���1, �÷���2
group by �÷���1, �÷���2

--�μ���, ������ �޿��� ���� ���ϼ���
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
 
 
--������ ��ձ޿��� 3000 �޷� �̻��� ����� ������ ��ձ޿��� ����ϼĿ�
select job,avg(sal) as "avgsal"
 from emp
 --where ������ group by �켱...
 group by job
 having avg(sal)>=3000;
 
 /*
 from�� ������ where
 group by ������
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
1.������̺��� ������ �޿����� ����ϵ� ������ ���� �ް� �޿��� ���� 5000 �̻��� ������� ����� ����ϼ���
--�޿��� ���� ���� ������ ����ϼ���
*/

SELECT JOB,SUM(SAL)
FROM EMP

WHERE COMM IS NOT NULL
GROUP BY JOB
HAVING SUM(SAL)>=5000
ORDER BY SUM(SAL) ASC
;


/*
2.������̺��� �μ� �ο��� 4���� ���� �μ��� �μ���ȣ ,�ο��� , �޿��� ���� ����ϼ���
*/

SELECT DEPTNO, COUNT(DEPTNO), SUM(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING COUNT(DEPTNO)>4;

/*
3.������̺��� ������ �޿��� ���� 5000�� �ʰ��ϴ� ������ �޿��� ���� ����ϼ���
�� �Ǹ�����(salesman) �� �����ϰ� �޿������� �������� �����ϼ���
*/
 
 SELECT JOB, SUM(SAL)
 FROM EMP
 GROUP BY JOB
 HAVING SUM(SAL)>5000
 ORDER BY SUM(SAL) DESC;

--1.������̺��� ������ �޿����� ����ϵ� ������ ���� �ް� �޿��� ���� 5000 �̻��� ������� ����� ����ϼ���
--�޿��� ���� ���� ������ ����ϼ���


