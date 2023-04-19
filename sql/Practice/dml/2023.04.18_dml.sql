-- 2023.04.18
-- DML

--INSERT : 데이터를 행단위로 입력

create table dept01 as select* from dept where 0=1;
alter table dept01 modify(deptno number(2,0) constraint PK_DEPT01_DEPTNO primary key,
                            dname varchar2(12) constraint NOT_NULL_DEPT01_DNAME not null);


-- insert into 테이블이름(컬럼, 컬럼, 컬럼...) values(데이터, 데이터....)
insert into dept01 (deptno, dname, loc) values(10,'test','test-loc');
insert into dept01 (loc, dname, deptno) values('seoul', 'development',20);
insert into dept01 (deptno, dname) values(30,'QA');
insert into dept01 (deptno, loc) values(30,'QA');

-- 모든 컬럼에 데이터를 입력하는 경우 => 컬럼목록 생략가능
insert into dept01 values(50,'TEST',null);
insert into dept01(deptno,dname) values(60,'TEST123');

select * from dept01;
delete from dept01;
desc dept01;
drop table dept01;

create table dept02 as select* from dept where 0=1;
insert into dept02 select * from dept;
select * from dept02;

-- update : 행단위 칼럼들의 데이터를 변경 -> 해당 컬럼의 값을 입력/수정/삭제
-- update 테이블이름 set 컬럼1의 값 = 새로운 값 where 조건
update dept01 set dname = 'DESIGN', loc = 'PANGYO' where deptno = 10;

-- 모든 사원의 deptno를 30으로 변경
create table emp01 as select * from emp;

update emp01 set deptno=30;
update emp01 set sal= sal*1.1;
update emp01 set hiredate = sysdate;

-- 특정행을 수정할 경우 where 의 조건으로 행을 선택

--1. 부서번호가 10번인 사원의 부서번호를 30번으로 수정합시다.
update emp01 set deptno = 30 where deptno = 10;

--2. 급여가 3000 이상인 사원만 급여를 10% 인상합시다.
update emp01 set sal = sal*1.1 where sal >= 3000;

--3. 1987년에 입사한 사원의 입사일이 오늘로 수정합시다. 사원의 입사일을 오늘로 수정한 후에 테이블 
--내용을 살펴봅시다.
update emp01 set hiredate = sysdate where to_char(hiredate,'yyddmm') = '87%';
desc emp01;
select * from emp01;
drop table emp01;

-- 1. 20번 부서의 지역명을 40번 부서의 지역명으로 변경하기 위해서 서브 쿼리문을 사용해 봅시다
update dept02 
set loc = (select loc
            from dept02
            where deptno = 40)
where deptno = 20;

--2. 서브 쿼리를 이용해서 부서번호가 20인 부서의 부서명과 지역명을 
--부서 번호가 30번인 부서와 동일하게 변경하도록 해 봅시다.

update dept02 
set (dname, loc) = (select dname, loc
                    from dept02
                    where deptno = 30)
where deptno = 20;

drop table dept02;
create table dept02 as select *from dept;
select *from dept02;

-- delete : 테이블의 행 단위 삭제
-- delete from 테이블 이름 where 행을 선택하는 조건

-- dept01 테이블의 모든 행을 삭제 => 모든 부서정보를 삭제
delete from dept01;

-- dept02테이블에서 deptno가 30인 행만 삭제
delete from dept02 where deptno = 30;

-- 사원 테이블에서 부서명이 SALES인 사원을 모두 삭제해봅시다.

delete from emp01 where deptno = (select deptno
                                    from dept
                                    where dname = 'SALES');

drop table emp01;
create table emp01 as select* from emp;

select *from emp01;

commit;

delete from emp01;
rollback;

create sequence seq_dept_deptno start with  10 increment by 10;

select seq_dept_deptno.currval from dual;
    


