-- 2023.04.19

-- VIEW : 가상테이블
-- view 객체는 sql을 가진다. => sql 실행결과를 가상의 테이블로 사용
create or replace view emp_view30
as
select empno, ename, deptno
from emp
where deptno = 30;

select *
from emp_view30;

-- 주문정보 : orders, book, customer
create or replace view order_info
as
select o.orderid, c.name, b.bookname, b.price, o.saleprice, o.orderdate, c.phone
from orders o, book b, customer c
where o.bookid = b.bookid and o.custid = c.custid;

select * from order_info;

select bookname from order_info where name='박지성';

select view_name, text from user_views;

-- view 삭제
drop view emp_view30;

--사원 중에서 입사일이 빠른 사람 5명(TOP-5)만을 얻어 오는 질의문을 작성해 봅시다.

create or replace view fast_hiredate
as
select ename, hiredate
from emp
order by hiredate;

select rownum, ename, hiredate
from fast_hiredate
where rownum < 6;

select rownum, ename, hiredate
from fast_hiredate;

select * from dept;