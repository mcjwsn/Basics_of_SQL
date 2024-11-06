--Podzapytania
--select t.orderid, t.customerid
--from (select orderid, customerid
--from orders) as t


--select productname, unitprice
--, (select avg(unitprice) from products) as average
--from products;


--select *, unitPrice - average as diff
--from
--(select productname, unitprice
--, (select avg(unitprice) from products) as average
--from products) t
--where unitPrice > average;


--select productname, categoryid, unitprice
--,( select avg(unitprice)
--from products as p_in
--where p_in.categoryid = p_out.categoryid ) as average
--from products as p_out

--;with t as (
--select productname, categoryid, unitprice
--,( select avg(unitprice)
--from products as p_in
--where p_in.categoryid = p_out.categoryid ) as average
--from products as p_out
--)
--select *, UnitPrice - average as diff from t--select p.ProductName, p.CategoryID, p.UnitPrice,
--p.UnitPrice - av.avegage as diff
--from products p
--join (select categoryid, avg(unitprice) avegage
--from products
--group by categoryid) av
--on p.CategoryID = av.CategoryID--;WITH av AS (
--    SELECT categoryid, AVG(unitprice) AS avegage
--    FROM products
--    GROUP BY categoryid
--)
--SELECT p.ProductName, p.CategoryID, p.UnitPrice, p.UnitPrice - av.avegage AS diff
--FROM products p
--JOIN av ON p.CategoryID = av.categoryid;


--select o.orderid, o.customerid, c.companyname
--from customers c join orders o
--on c.customerid = o.customerid