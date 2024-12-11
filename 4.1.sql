--�wiczenie 1

--Podaj ��czn� warto�� zam�wienia o numerze 10250 (uwzgl�dnij cen� za przesy�k�)
--select orders.orderid,sum(d.price + orders.Freight) 'price'
--from orders 
--join (select od.orderid, (1-od.Discount)*od.Quantity*od.UnitPrice price
--from [Order Details] od
--where orderid = 10250) d
--on orders.orderid = d.orderid and orders.orderid = 10250
--group by orders.orderid
--Podaj ��czn� warto�� ka�dego zam�wienia (uwzgl�dnij cen� za przesy�k�)

--select orders.orderid,sum(d.price + orders.Freight) 'price'
--from orders 
--join (select od.orderid, (1-od.Discount)*od.Quantity*od.UnitPrice price
--from [Order Details] od) d
--on orders.orderid = d.orderid
--group by orders.orderid

--Dla ka�dego produktu podaj maksymaln� warto�� zakupu tego produktu
--with t1 as 
--( select od.productid, max((1-od.Discount)*od.Quantity*od.UnitPrice) t
--from [Order Details] od
--group by od.ProductID
--),
--t2 as
--(select ProductName, ProductId from Products),
--t3 as(
--select t1.t,t2.ProductName from t1
--join t2 on t1.ProductID = t2.ProductID)
--select t3.ProductName,t3.t from t3;


--Dla ka�dego produktu podaj maksymaln� warto�� zakupu tego produktu w 1997r
--with t1 as 
--( select od.productid,year(o.orderdate) y, max((1-od.Discount)*od.Quantity*od.UnitPrice) t
--from [Order Details] od
--join orders o on o.OrderID = od.OrderID and year(o.orderdate)=1997
--group by od.ProductID,year(o.orderdate)
--),
--t2 as
--(select ProductName, ProductId from Products),
--t3 as(
--select t1.t,t2.ProductName from t1
--join t2 on t1.ProductID = t2.ProductID)
--select t3.ProductName,t3.t from t3


--�w2
--Dla ka�dego klienta podaj ��czn� warto�� 
--jego zam�wie� (bez op�aty za przesy�k�) z 1996r
--SELECT 
--    CustomerID, 
--    (SELECT isnull(SUM(UnitPrice * Quantity * (1 - Discount)),0) 
--     FROM "Order Details" 
--     WHERE OrderID IN (SELECT OrderID FROM Orders WHERE CustomerID = o.CustomerID AND YEAR(OrderDate) = 1996)) AS t
--FROM Customers o
--order by t;



--Dla ka�dego klienta podaj ��czn� warto�� 
--jego zam�wie� (uwzgl�dnij op�at� za przesy�k�) z 1996r
--SELECT 
--    CustomerID, Freight + 
--    (SELECT isnull(SUM(UnitPrice * Quantity * (1 - Discount)),0) 
--     FROM "Order Details" 
--     WHERE OrderID IN (SELECT OrderID FROM Orders WHERE CustomerID = o.CustomerID AND YEAR(OrderDate) = 1996)) AS t
--FROM orders o
--order by t;



--Dla ka�dego klienta podaj maksymaln� warto�� 
--zam�wienia z�o�onego przez tego klienta w 1997r

--SELECT 
--    CustomerID, 
--    (SELECT isnull(MAX(UnitPrice * Quantity * (1 - Discount)),0) 
--     FROM "Order Details" 
--     WHERE OrderID IN (SELECT OrderID FROM Orders WHERE CustomerID = o.CustomerID AND YEAR(OrderDate) = 1996)) AS t
--FROM Customers o
--order by t;

--dla kazdego klienta podaj wartosc zamowien w 1997
--with t1 as(select customers.companyName,customers.customerid,
--isnull(sum(od.unitprice * od.quantity * (1-od.discount)),0) 'bez_wysylki',
--sum(Case WheN YEAR(o.OrderDate) = 1997 then o.Freight else 0 end) z
--from customers
--left join orders o on o.customerid = customers.customerid
--left join [Order Details] od on od.orderid = o.orderid and year(o.orderdate)=1997
--group by customers.customerid,customers.CompanyName)
--select companyName, customerid, bez_wysylki + z 'suma' from t1
--order by suma



--select sum(od.unitprice * od.quantity * (1-od.discount)) from [Order Details] od 
--join orders o on o.orderid = od.orderid and year(o.orderdate)=1997
--where o.CustomerID = 'SPECD'

--SELECT 
--   c.CompanyName,
--   c.CustomerID, 
--   ISNULL(SUM(od.UnitPrice * od.Quantity * (1-od.Discount)), 0) AS ProductValue,
--   SUM(CASE WHEN YEAR(o.OrderDate) = 1997 THEN o.Freight ELSE 0 END) AS FreightValue
--FROM Customers c
--LEFT JOIN Orders o ON o.CustomerID = c.CustomerID
--LEFT JOIN [Order Details] od ON od.OrderID = o.OrderID AND YEAR(o.OrderDate) = 1997
--GROUP BY c.CustomerID, c.CompanyName
--ORDER BY ProductValue


--�wiczenie 3
--1Dla ka�dego doros�ego cz�onka biblioteki podaj jego imi�, nazwisko oraz liczb� jego dzieci.
--2Dla ka�dego doros�ego cz�onka biblioteki podaj jego imi�, nazwisko, liczb� jego dzieci, liczb� zarezerwowanych ksi��ek oraz liczb� wypo�yczonych ksi��ek.
--3Dla ka�dego doros�ego cz�onka biblioteki podaj jego imi�, nazwisko, liczb� jego dzieci, oraz liczb� ksi��ek zarezerwowanych i wypo�yczonych przez niego i jego dzieci.
--4Dla ka�dego tytu�u ksi��ki podaj ile razy ten tytu� by� wypo�yczany w 2001r
--5Dla ka�dego tytu�u ksi��ki podaj ile razy ten tytu� by� wypo�yczany w 2002r
