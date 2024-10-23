--3.0 join
-- baza joindb

--select * from Produce
--select * from Sales
--select * from Buyers

--select buyer_name, sales.buyer_id, prod_id, qty from buyers, sales where  buyers.buyer_id = sales.buyer_id--select buyer_name, s.buyer_id, prod_id, qty from buyers as b, sales as s where b.buyer_id = s.buyer_id--select buyer_name, s.buyer_id, prod_id, qty from buyers b inner join sales s on b.buyer_id = s.buyer_id--select buyer_name, sales.buyer_id, prod_id, qty from buyers inner join sales on buyers.buyer_id = sales.buyer_id-- baza Northwind--select p.ProductID, s.SupplierID, p.supplierid companyname from products p inner join suppliers s on p.supplierid = s.supplierid order by p.ProductID--select * from Products where productid = 1--select * from Suppliers where supplierid = 1--select * from Products where productid = 10--select * from Suppliers where supplierid = 4--Napisz polecenie zwracające jako wynik nazwy klientów, którzy złożyli zamówienia po 01 marca 1998 (baza northwind)--select distinct customers.customerid, companyname from orders inner join customers on orders.customerid = customers.customerid where orderdate > '1998-03-01'--baza joindb--select buyer_name, s.buyer_id, qty from buyers b left outer join sales s on b.buyer_id = s.buyer_id--Napisz polecenie zwracające wszystkich klientów z datami zamówień (baza northwind).--select companyname, customers.customerid, orderdate from customers left outer join orders on customers.customerid = orders.customerid where orderid is null--1.Wybierz nazwy i ceny produktów (baza northwind) o cenie jednostkowej pomiędzy 20.00 a 30.00, dla każdego produktu podaj dane adresowe dostawcy
--select od.orderid, od.UnitPrice, orders.ShipAddress from [order details] od inner join orders on od.orderid = orders.orderid where unitprice between 20 and 30

--2. Wybierz nazwy produktów oraz inf. o stanie magazynu dla produktów dostarczanych przez firmę ‘Tokyo Tradersʼ
--select productName, Unitsinstock, CompanyName from products join suppliers on products.supplierid = Suppliers.SupplierID where Suppliers.CompanyName='Tokyo Traders'
--select * from suppliers where companyname='Tokyo Traders'
--select * from products where SupplierID=4

--3. Czy są jacyś klienci którzy nie złożyli żadnego zamówienia w 1997 roku, jeśli tak to pokaż ich dane adresowe
select CustomerID, CompanyName, Address from Customers where CustomerID not in (select distinct CustomerID from Orders where year(OrderDate) = 1997)
--select distinct CustomerID from Orders where year(OrderDate) = 1997
select customers.customerid, companyname, customers.address from customers left join orders on customers.customerid = orders.customerid and year(orderdate) = 1997 where orders.orderid is null;
--4. Wybierz nazwy i numery telefonów dostawców, dostarczających produkty, których aktualnie nie ma w magazynie.
--5. Wybierz zamówienia złożone w marcu 1997. Dla każdego takiego zamówienia wyświetl jego numer, datę złożenia zamówienia oraz nazwę i numer telefonu klienta

