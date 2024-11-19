--3.1
--�wiczenie 1 # baza Northwind ctrc+k,ctrl+c to comment, ctrl+k, ctrl+u to uncomment
--1. Dla ka�dego zam�wienia podaj ��czn� liczb� zam�wionych jednostek towaru oraz nazw� klienta.
--select orders.orderid, customers.CompanyName, sum([Order Details].Quantity) as 'Suma zamowien' from Orders
--join [Order Details] on Orders.OrderID = [Order Details].OrderID
--join Customers on orders.CustomerID = Customers.CustomerID
--group by orders.OrderID, Customers.CompanyName

--2. Dla ka�dego zam�wienia podaj ��czn� warto�� zam�wionych produkt�w (warto�� zam�wienia bez op�aty za przesy�k�) oraz nazw� klienta.
--select orders.orderid, customers.CompanyName, sum((1-[order details].Discount)*[Order Details].UnitPrice*[Order Details].Quantity) as 'cena zamowien' from Orders
--join [Order Details] on Orders.OrderID = [Order Details].OrderID
--join Customers on orders.CustomerID = Customers.CustomerID
--group by orders.OrderID, Customers.CompanyName

--3. Dla ka�dego zam�wienia podaj ��czn� warto�� tego zam�wienia (warto�� zam�wienia wraz z op�at� za przesy�k�) oraz nazw� klienta.
--select orders.orderid, customers.CompanyName, sum((1-[order details].Discount)*[Order Details].UnitPrice*[Order Details].Quantity) + orders.Freight as 'cena zamowien' from Orders
--join [Order Details] on Orders.OrderID = [Order Details].OrderID
--join Customers on orders.CustomerID = Customers.CustomerID
--group by orders.OrderID, orders.Freight, Customers.CompanyName

--4. Zmodyfikuj poprzednie przyk�ady tak �eby doda� jeszcze imi� i nazwisko pracownika obs�uguj�cego zam�wie�
--select orders.orderid, customers.CompanyName,
--sum((1-[order details].Discount)*[Order Details].UnitPrice*[Order Details].Quantity) + orders.Freight as 'cena zamowien',
--concat(Employees.Firstname, ' ', Employees.LastName) as employee from Orders
--join [Order Details] on Orders.OrderID = [Order Details].OrderID
--join Customers on orders.CustomerID = Customers.CustomerID
--join Employees on orders.EmployeeID = Employees.EmployeeID
--group by orders.OrderID, orders.Freight, Customers.CompanyName, Employees.FirstName, Employees.LastName

--�wiczenie 2.
--1. Podaj nazwy przewo�nik�w, kt�rzy w marcu 1998 przewozili produkty z kategorii 'Meat/Poultry'
--select distinct Shippers.CompanyName from Orders
--join Shippers on orders.ShipVia = Shippers.ShipperID
--join [Order Details] od on od.OrderID = orders.OrderID
--join Products on od.ProductID = products.ProductID
--join categories on products.CategoryID = Categories.CategoryID
--where Categories.CategoryName = 'Meat/Poultry'
--and year(orders.OrderDate) = 1998 and month(orders.OrderDate) = 3

--2. Podaj nazwy przewo�nik�w, kt�rzy w marcu 1997r nie przewozili produkt�w z kategorii 'Meat/Poultry'
--select Shippers.CompanyName from Shippers 
--where Shippers.ShipperID not in (
--select distinct orders.ShipVia from Orders
--join Shippers on orders.ShipVia = Shippers.ShipperID
--join [Order Details] od on od.OrderID = orders.OrderID
--join Products on od.ProductID = products.ProductID
--join categories on products.CategoryID = Categories.CategoryID
--where Categories.CategoryName = 'Meat/Poultry'
--and year(orders.OrderDate) = 1997 and month(orders.OrderDate) = 3)

--3. Dla ka�dego przewo�nika podaj warto�� produkt�w z kategorii 'Meat/Poultry' kt�re ten przewo�nik przewi�z� w marcu 1997
--select distinct Shippers.CompanyName, isnull(sum(od.Quantity * od.UnitPrice*(1-od.discount)),0) as 'wartosc' from Orders
--left join Shippers on orders.ShipVia = Shippers.ShipperID
--left join [Order Details] od on od.OrderID = orders.OrderID
--left join Products on od.ProductID = products.ProductID
--left join categories on products.CategoryID = Categories.CategoryID
--and Categories.CategoryName = 'Meat/Poultry'
--where year(orders.OrderDate) = 1997 and month(orders.OrderDate) = 3
--group by shippers.CompanyName


--�wiczenie 3
--1. Dla ka�dej kategorii produktu (nazwa), podaj ��czn� liczb� zam�wionych przez klient�w jednostek towar�w z tej kategorii.
--select Categories.CategoryName, sum(od.Quantity) as 'l.jednostek towarow' from Categories
--join Products on Products.CategoryID = Categories.CategoryID
--join [Order Details] od on od.ProductID = Products.ProductID
--group by Categories.CategoryName

--2. Dla ka�dej kategorii produktu (nazwa), podaj ��czn� liczb� zam�wionych w 1997r jednostek towar�w z tej kategorii.
--select Categories.CategoryName, sum(od.Quantity) as 'l.jednostek towarow' from Categories
--join Products on Products.CategoryID = Categories.CategoryID
--join [Order Details] od on od.ProductID = Products.ProductID
--join orders on od.OrderID = orders.OrderID
--where year(orders.OrderDate) = 1997
--group by Categories.CategoryName

--3. Dla ka�dej kategorii produktu (nazwa), podaj ��czn� warto�� zam�wionych towar�w z tej kategorii.
--select Categories.CategoryName, sum(od.Quantity*od.UnitPrice) as 'value' from Categories
--join Products on Products.CategoryID = Categories.CategoryID
--join [Order Details] od on od.ProductID = Products.ProductID
--group by Categories.CategoryName

--�wiczenie 4
--1. Dla ka�dego przewo�nika (nazwa) podaj liczb� zam�wie� kt�re przewie�li w 1997r
--select Shippers.CompanyName,count(orders.orderid) as ' liczba zamowien' from Shippers 
--left join orders on shippers.ShipperID = orders.ShipVia
--and year(orders.orderdate)=1997
--group by shippers.CompanyName

--2. Kt�ry z przewo�nik�w by� najaktywniejszy (przewi�z� najwi�ksz� liczb� zam�wie�) w 1997r, podaj nazw� tego przewo�nika
--select top 1 Shippers.CompanyName from Shippers 
--join orders on shippers.ShipperID = orders.ShipVia
--where year(orders.orderdate)=1997
--group by shippers.CompanyName
--order by count(orders.orderid) desc

--3. Dla ka�dego przewo�nika podaj ��czn� warto�� "op�at za przesy�k�" przewo�onych przez niego zam�wie� od '1998-05-03' do '1998-05-29'
--select Shippers.CompanyName,COALESCE(SUM(Orders.Freight), 0) as 'shipping' from Shippers
--left join orders on shippers.ShipperID = orders.shipvia
--and orders.OrderDate between '1998-05-03' and '1998-05-29'
--group by shippers.CompanyName

--4. Dla ka�dego pracownika (imi� i nazwisko) podaj ��czn� warto�� zam�wie� obs�u�onych przez tego pracownika w maju 1996
-- nie ma zamowien w tej dacie robie dla 1997
--select Employees.FirstName, Employees.LastName, sum(od.unitprice * od.quantity) from Employees
--left join orders on Employees.EmployeeID = orders.EmployeeID
--left join [Order Details] od on orders.orderid = od.OrderID
--where year(orders.orderdate) = 1997 and month(orders.orderdate) = 5
--group by Employees.FirstName, Employees.LastName


--5. Kt�ry z pracownik�w obs�u�y� najwi�ksz� liczb� zam�wie� w 1996r, podaj imi� i nazwisko takiego pracownika
--select top 1 Employees.FirstName, Employees.LastName from Employees
--join orders on Orders.employeeid = employees.employeeid
--where year(orders.OrderDate) = 1996
--group by Employees.FirstName, Employees.LastName
--order by count(orders.orderid) desc

--6. Kt�ry z pracownik�w by� najaktywniejszy (obs�u�y� zam�wienia o najwi�kszej warto�ci) w 1996r, podaj imi� i nazwisko takiego pracownika

--select top 1 Employees.FirstName, Employees.LastName from Employees
--join orders on Orders.employeeid = employees.employeeid
--join [Order Details] od on od.OrderID = orders.OrderID
--where year(orders.OrderDate) = 1996
--group by Employees.FirstName, Employees.LastName
--order by count(od.Quantity*od.UnitPrice) desc

--2. Napisz polecenie, kt�re wy�wietla klient�w z Francji kt�rzy w 1998r z�o�yli wi�cej ni�
--dwa zam�wienia oraz klient�w z Niemiec kt�rzy w 1997r z�o�yli wi�cej ni� trzy zam�wienia
--SELECT c.CustomerID, c.CompanyName, c.Country, COUNT(o.OrderID)
--FROM Customers c
--JOIN Orders o ON c.CustomerID = o.CustomerID
--WHERE (c.Country = 'France' AND YEAR(o.OrderDate) = 1998)
--   OR (c.Country = 'Germany' AND YEAR(o.OrderDate) = 1997)
--GROUP BY c.CustomerID, c.CompanyName, c.Country
--HAVING (c.Country = 'France' AND COUNT(o.OrderID) > 2)
--   OR (c.Country = 'Germany' AND COUNT(o.OrderID) > 3);
