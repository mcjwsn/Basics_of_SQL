--3.1
--Æwiczenie 1 # baza Northwind ctrc+k,ctrl+c to comment, ctrl+k, ctrl+u to uncomment
--1. Dla ka¿dego zamówienia podaj ³¹czn¹ liczbê zamówionych jednostek towaru oraz nazwê klienta.
--select orders.orderid, customers.CompanyName, sum([Order Details].Quantity) as 'Suma zamowien' from Orders
--join [Order Details] on Orders.OrderID = [Order Details].OrderID
--join Customers on orders.CustomerID = Customers.CustomerID
--group by orders.OrderID, Customers.CompanyName

--2. Dla ka¿dego zamówienia podaj ³¹czn¹ wartoœæ zamówionych produktów (wartoœæ zamówienia bez op³aty za przesy³kê) oraz nazwê klienta.
--select orders.orderid, customers.CompanyName, sum((1-[order details].Discount)*[Order Details].UnitPrice*[Order Details].Quantity) as 'cena zamowien' from Orders
--join [Order Details] on Orders.OrderID = [Order Details].OrderID
--join Customers on orders.CustomerID = Customers.CustomerID
--group by orders.OrderID, Customers.CompanyName

--3. Dla ka¿dego zamówienia podaj ³¹czn¹ wartoœæ tego zamówienia (wartoœæ zamówienia wraz z op³at¹ za przesy³kê) oraz nazwê klienta.
--select orders.orderid, customers.CompanyName, sum((1-[order details].Discount)*[Order Details].UnitPrice*[Order Details].Quantity) + orders.Freight as 'cena zamowien' from Orders
--join [Order Details] on Orders.OrderID = [Order Details].OrderID
--join Customers on orders.CustomerID = Customers.CustomerID
--group by orders.OrderID, orders.Freight, Customers.CompanyName

--4. Zmodyfikuj poprzednie przyk³ady tak ¿eby dodaæ jeszcze imiê i nazwisko pracownika obs³uguj¹cego zamówieñ
--select orders.orderid, customers.CompanyName,
--sum((1-[order details].Discount)*[Order Details].UnitPrice*[Order Details].Quantity) + orders.Freight as 'cena zamowien',
--concat(Employees.Firstname, ' ', Employees.LastName) as employee from Orders
--join [Order Details] on Orders.OrderID = [Order Details].OrderID
--join Customers on orders.CustomerID = Customers.CustomerID
--join Employees on orders.EmployeeID = Employees.EmployeeID
--group by orders.OrderID, orders.Freight, Customers.CompanyName, Employees.FirstName, Employees.LastName

--Æwiczenie 2.
--1. Podaj nazwy przewoŸników, którzy w marcu 1998 przewozili produkty z kategorii 'Meat/Poultry'
--select distinct Shippers.CompanyName from Orders
--join Shippers on orders.ShipVia = Shippers.ShipperID
--join [Order Details] od on od.OrderID = orders.OrderID
--join Products on od.ProductID = products.ProductID
--join categories on products.CategoryID = Categories.CategoryID
--where Categories.CategoryName = 'Meat/Poultry'
--and year(orders.OrderDate) = 1998 and month(orders.OrderDate) = 3

--2. Podaj nazwy przewoŸników, którzy w marcu 1997r nie przewozili produktów z kategorii 'Meat/Poultry'
--select Shippers.CompanyName from Shippers 
--where Shippers.ShipperID not in (
--select distinct orders.ShipVia from Orders
--join Shippers on orders.ShipVia = Shippers.ShipperID
--join [Order Details] od on od.OrderID = orders.OrderID
--join Products on od.ProductID = products.ProductID
--join categories on products.CategoryID = Categories.CategoryID
--where Categories.CategoryName = 'Meat/Poultry'
--and year(orders.OrderDate) = 1997 and month(orders.OrderDate) = 3)

--3. Dla ka¿dego przewoŸnika podaj wartoœæ produktów z kategorii 'Meat/Poultry' które ten przewoŸnik przewióz³ w marcu 1997
--select distinct Shippers.CompanyName, isnull(sum(od.Quantity * od.UnitPrice*(1-od.discount)),0) as 'wartosc' from Orders
--left join Shippers on orders.ShipVia = Shippers.ShipperID
--left join [Order Details] od on od.OrderID = orders.OrderID
--left join Products on od.ProductID = products.ProductID
--left join categories on products.CategoryID = Categories.CategoryID
--and Categories.CategoryName = 'Meat/Poultry'
--where year(orders.OrderDate) = 1997 and month(orders.OrderDate) = 3
--group by shippers.CompanyName


--Æwiczenie 3
--1. Dla ka¿dej kategorii produktu (nazwa), podaj ³¹czn¹ liczbê zamówionych przez klientów jednostek towarów z tej kategorii.
--select Categories.CategoryName, sum(od.Quantity) as 'l.jednostek towarow' from Categories
--join Products on Products.CategoryID = Categories.CategoryID
--join [Order Details] od on od.ProductID = Products.ProductID
--group by Categories.CategoryName

--2. Dla ka¿dej kategorii produktu (nazwa), podaj ³¹czn¹ liczbê zamówionych w 1997r jednostek towarów z tej kategorii.
--select Categories.CategoryName, sum(od.Quantity) as 'l.jednostek towarow' from Categories
--join Products on Products.CategoryID = Categories.CategoryID
--join [Order Details] od on od.ProductID = Products.ProductID
--join orders on od.OrderID = orders.OrderID
--where year(orders.OrderDate) = 1997
--group by Categories.CategoryName

--3. Dla ka¿dej kategorii produktu (nazwa), podaj ³¹czn¹ wartoœæ zamówionych towarów z tej kategorii.
--select Categories.CategoryName, sum(od.Quantity*od.UnitPrice) as 'value' from Categories
--join Products on Products.CategoryID = Categories.CategoryID
--join [Order Details] od on od.ProductID = Products.ProductID
--group by Categories.CategoryName

--Æwiczenie 4
--1. Dla ka¿dego przewoŸnika (nazwa) podaj liczbê zamówieñ które przewieŸli w 1997r
--select Shippers.CompanyName,count(orders.orderid) as ' liczba zamowien' from Shippers 
--left join orders on shippers.ShipperID = orders.ShipVia
--and year(orders.orderdate)=1997
--group by shippers.CompanyName

--2. Który z przewoŸników by³ najaktywniejszy (przewióz³ najwiêksz¹ liczbê zamówieñ) w 1997r, podaj nazwê tego przewoŸnika
--select top 1 Shippers.CompanyName from Shippers 
--join orders on shippers.ShipperID = orders.ShipVia
--where year(orders.orderdate)=1997
--group by shippers.CompanyName
--order by count(orders.orderid) desc

--3. Dla ka¿dego przewoŸnika podaj ³¹czn¹ wartoœæ "op³at za przesy³kê" przewo¿onych przez niego zamówieñ od '1998-05-03' do '1998-05-29'
--select Shippers.CompanyName,COALESCE(SUM(Orders.Freight), 0) as 'shipping' from Shippers
--left join orders on shippers.ShipperID = orders.shipvia
--and orders.OrderDate between '1998-05-03' and '1998-05-29'
--group by shippers.CompanyName

--4. Dla ka¿dego pracownika (imiê i nazwisko) podaj ³¹czn¹ wartoœæ zamówieñ obs³u¿onych przez tego pracownika w maju 1996
-- nie ma zamowien w tej dacie robie dla 1997
--select Employees.FirstName, Employees.LastName, sum(od.unitprice * od.quantity) from Employees
--left join orders on Employees.EmployeeID = orders.EmployeeID
--left join [Order Details] od on orders.orderid = od.OrderID
--where year(orders.orderdate) = 1997 and month(orders.orderdate) = 5
--group by Employees.FirstName, Employees.LastName


--5. Który z pracowników obs³u¿y³ najwiêksz¹ liczbê zamówieñ w 1996r, podaj imiê i nazwisko takiego pracownika
--select top 1 Employees.FirstName, Employees.LastName from Employees
--join orders on Orders.employeeid = employees.employeeid
--where year(orders.OrderDate) = 1996
--group by Employees.FirstName, Employees.LastName
--order by count(orders.orderid) desc

--6. Który z pracowników by³ najaktywniejszy (obs³u¿y³ zamówienia o najwiêkszej wartoœci) w 1996r, podaj imiê i nazwisko takiego pracownika

--select top 1 Employees.FirstName, Employees.LastName from Employees
--join orders on Orders.employeeid = employees.employeeid
--join [Order Details] od on od.OrderID = orders.OrderID
--where year(orders.OrderDate) = 1996
--group by Employees.FirstName, Employees.LastName
--order by count(od.Quantity*od.UnitPrice) desc

--2. Napisz polecenie, które wyœwietla klientów z Francji którzy w 1998r z³o¿yli wiêcej ni¿
--dwa zamówienia oraz klientów z Niemiec którzy w 1997r z³o¿yli wiêcej ni¿ trzy zamówienia
--SELECT c.CustomerID, c.CompanyName, c.Country, COUNT(o.OrderID)
--FROM Customers c
--JOIN Orders o ON c.CustomerID = o.CustomerID
--WHERE (c.Country = 'France' AND YEAR(o.OrderDate) = 1998)
--   OR (c.Country = 'Germany' AND YEAR(o.OrderDate) = 1997)
--GROUP BY c.CustomerID, c.CompanyName, c.Country
--HAVING (c.Country = 'France' AND COUNT(o.OrderID) > 2)
--   OR (c.Country = 'Germany' AND COUNT(o.OrderID) > 3);
