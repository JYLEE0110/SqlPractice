
--CROSS JOIN
-- 스키마를 붙이고 결과 행은 모든 경우의 수 => n*m
-- emp, dept => 14*4 = 56

-- equi join
select *from emp, dept
where emp.deptno = dept.deptno;

--inner join 과 equi join과 같지만 문법적으로 다름 
select *from emp inner join dept on emp.deptno = dept.deptno;
select *from emp join dept on emp.deptno = dept.deptno;


select *--e.ename, d.dname, e.deptno
from emp e, dept d
where e.deptno = d.deptno
and e.ename = 'SCOTT';

-- 관계가 없는 테이블이랑 조건으로 맺어줌
select ename, sal, grade
from emp e, salgrade s
where e.sal between s.LOSAL and s.HISAL;

--self join : 자기 자신의 테이블을 조인하는 경우
-- 각 사원의 이름과 각 사원의 메니저 이름을 출력
-- outer join :조건에 만족하지 않는 행도 출력을 하는 JOIN
select e.ename, nvl(m.ename,'EMOTE')
from emp e, emp m
where e.mgr = m.empno(+);

select * from emp e join emp m
on e.mgr = m.empno;

select * from emp e left outer join emp m
on e.mgr=m.empno;


select *from emp cross join dept;

-- 같은 컬럼의 이름이 있고 기본키 외래키 비교해서 중복되는 속성이있으면 1개만 출력
select * from emp natural join dept;
select * from emp join dept using(deptno);