-- 1 마당서점의고객이요구하는다음질문에대해SQL 문을작성하시오.

-- (5) 박지성이구매한도서의출판사수
select count(publisher)
from customer c, orders o, book b
where c.custid = o.custid and b.bookid = o.bookid
and c.name='박지성';

-- (6) 박지성이구매한도서의이름, 가격, 정가와판매가격의차이
select b.bookname, abs(o.saleprice-b.price)
from customer c, orders o, book b
where c.custid = o.custid and o.bookid = b.bookid
and c.name = '박지성';

--(7) 박지성이구매하지않은도서의이름
select bookname
from book
where bookname not in(select b.bookname
                    from customer c, orders o, book b
                    where c.custid = o.custid and b.bookid = o.bookid
                    and c.name='박지성');
                    
-- 2 마당서점의운영자와경영자가요구하는다음질문에대해SQL 문을작성하시오.
-- (8) 주문하지않은고객의이름(부속질의사용)
select name
from customer
where name not in(select distinct c.name
                from customer c, orders o
                where c.custid = o.custid);
                
--(9) 주문금액의총액과주문의평균금액
select avg(saleprice)
from orders;

select sum(saleprice) 
from orders;

-- (10) 고객의이름과고객별구매액
select c.name, sum(o.saleprice)
from customer c, orders o
where c.custid = o.custid 
group by c.name;

--(11) 고객의이름과고객이구매한도서목록
select c.name, b.bookname
from customer c, orders o, book b
where c.custid = o.custid and o.bookid = b.bookid
order by c.name, b.bookname;

--(12) 도서의가격(Book 테이블)과판매가격(Orders 테이블)의차이가가장많은주문
select *
from book b, orders o
where b.bookid = o.bookid
and (b.price - o.saleprice) = (select max(b.price - o.saleprice)
                                from book b, orders o
                                where b.bookid = o.bookid);
                                
--(13) 도서의판매액평균보다
-- 자신의구매액평균이더높은고객의이름
select avg(saleprice)
from orders;

select c.name, round(avg(saleprice))
from customer c, orders o
where c.custid = o.custid
group by c.name
having avg(o.saleprice) < (select avg(saleprice)
from orders);

