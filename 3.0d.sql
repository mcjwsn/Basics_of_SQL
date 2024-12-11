--3.0 join
-- baza joindb

--select * from Produce
--select * from Sales
--select * from Buyers

--select buyer_name, sales.buyer_id, prod_id, qty from buyers, sales where  buyers.buyer_id = sales.buyer_id
--select buyer_name, s.buyer_id, prod_id, qty from buyers as b, sales as s where b.buyer_id = s.buyer_id

--select buyer_name, s.buyer_id, prod_id, qty from buyers b inner join sales s on b.buyer_id = s.buyer_id
--select buyer_name, sales.buyer_id, prod_id, qty from buyers inner join sales on buyers.buyer_id = sales.buyer_id


-- baza Northwind

--select p.ProductID, s.SupplierID, p.supplierid companyname from products p inner join suppliers s on p.supplierid = s.supplierid order by p.ProductID
--select * from Products where productid = 1
--select * from Suppliers where supplierid = 1
--select * from Products where productid = 10
--select * from Suppliers where supplierid = 4


--Napisz polecenie zwracające jako wynik nazwy klientów, którzy złożyli zamówienia po 01 marca 1998 (baza northwind)

--select distinct customers.customerid, companyname from orders inner join customers on orders.customerid = customers.customerid where orderdate > '1998-03-01'

--baza joindb

--select buyer_name, s.buyer_id, qty from buyers b left outer join sales s on b.buyer_id = s.buyer_id

--Napisz polecenie zwracające wszystkich klientów z datami zamówień (baza northwind).
--select companyname, customers.customerid, orderdate from customers left outer join orders on customers.customerid = orders.customerid where orderid is null

--1.Wybierz nazwy i ceny produktów (baza northwind) o cenie jednostkowej pomiędzy 20.00 a 30.00, dla każdego produktu podaj dane adresowe dostawcy
--select od.orderid, od.UnitPrice, orders.ShipAddress from [order details] od inner join orders on od.orderid = orders.orderid where unitprice between 20 and 30

--2. Wybierz nazwy produktów oraz inf. o stanie magazynu dla produktów dostarczanych przez firmę ‘Tokyo Tradersʼ
--select productName, Unitsinstock, CompanyName from products join suppliers on products.supplierid = Suppliers.SupplierID where Suppliers.CompanyName='Tokyo Traders'
--select * from suppliers where companyname='Tokyo Traders'
--select * from products where SupplierID=4

--3. Czy są jacyś klienci którzy nie złożyli żadnego zamówienia w 1997 roku, jeśli tak to pokaż ich dane adresowe
--select CustomerID, CompanyName, Address from Customers where CustomerID not in (select distinct CustomerID from Orders where year(OrderDate) = 1997)
--select distinct CustomerID from Orders where year(OrderDate) = 1997
--select customers.customerid, companyname, customers.address from customers left join orders on customers.customerid = orders.customerid and year(orderdate) = 1997 where orders.orderid is null;
--select customers.CompanyName,address,max(country) -- count(1) jesli wiemy ze nie bedzie zlych
--from customers left join orders on customers.CustomerID = orders.CustomerID and year(orders.orderdate) = 1997
--group by customers.CompanyName, customers.CustomerID,address-- musi byc klucz zeby nie nadpisaly sie powtorzeniahaving count(orderid) = 0

--select customers.CompanyName, orders.orderid from customers left join orders on customers.CustomerID = orders.CustomerID and year(orderdate)=1997
--where orders.orderid is null



--4. Wybierz nazwy i numery telefonów dostawców, dostarczających produkty, których aktualnie nie ma w magazynie.
--select CompanyName, Phone from suppliers join products on suppliers.SupplierID = PRODUCTs.supplierid  where products.unitsinstock = 0
--select supplierid from products where UnitsInStock=0
--select supplierid,CompanyName from suppliers

--5. Wybierz zamówienia złożone w marcu 1997. Dla każdego takiego zamówienia wyświetl jego numer, datę złożenia zamówienia oraz nazwę i numer telefonu klienta
--select customers.customerid, companyname,phone, orders.OrderDate,orderid from customers join orders on customers.CustomerID = orders.CustomerID WHERE year(orders.OrderDate) = 1997 and month(orders.OrderDate) = 3

--baza library
--1. Napisz polecenie, które wyświetla listę dzieci będących członkami biblioteki (baza library). Interesuje nas imię, nazwisko i data urodzenia dziecka.
--select birth_date, member.lastname, member.firstname from juvenile join member on member.member_no = juvenile.member_no

--2. Napisz polecenie, które podaje tytuły aktualnie wypożyczonych książek
--select title from title join loan on loan.title_no = title.title_no

--3. Podaj informacje o karach zapłaconych za przetrzymywanie książki o tytule ‘Tao TehKingʼ. Interesuje nas data oddania książki, ile dni była przetrzymywana i jaką zapłacono karę
--select in_date, day(in_date-due_date), fine_assessed from loanhist join title on loanhist.title_no = title.title_no where title.title = 'Tao Teh King'
--select in_date, month(in_date)-month(due_date), fine_assessed from loanhist join title on loanhist.title_no = title.title_no where title.title = 'Tao Teh King'
--4. Napisz polecenie które podaje listę książek (mumery ISBN) zarezerwowanych przezosobę o nazwisku: Stephen A. Graff
--select isbn from reservation join member on member.member_no = reservation.member_no where member.lastname = 'Graff' and member.firstname = 'Stephen' and member.middleinitial = 'A'
--select * from member

--baza Northwind
--1. Wybierz nazwy i ceny produktów (baza northwind) o cenie jednostkowej pomiędzy 20.00 a 30.00, dla każdego produktu podaj dane adresowe dostawcy, interesują nas tylko produkty z kategorii ‘Meat/Poultryʼ
--select productName, UnitPrice, Suppliers.CompanyName, Suppliers.Address from Products join Categories on Products.CategoryID = Categories.CategoryID join Suppliers on Products.SupplierID = Suppliers.SupplierID where Categories.CategoryName = 'Meat/Poultry' and Products.UnitPrice between 20 and 30

--2. Wybierz nazwy i ceny produktów z kategorii ‘Confectionsʼ dla każdego produktu podaj nazwę dostawcy.
--select productName, UnitPrice, Suppliers.CompanyName, categories.categoryName from Products join Categories on Products.CategoryID = Categories.CategoryID join Suppliers 
--on Products.SupplierID = Suppliers.SupplierID where Categories.CategoryName = 'Confections'

--3. Dla każdego klienta podaj liczbę złożonych przez niego zamówień. Zbiór wynikowy powinien zawierać nazwę klienta, oraz liczbę zamówień
select customers.CompanyName,count(orderid) from customers
join orders on customers.CustomerID = orders.CustomerID group by customers.CompanyName

--4. Dla każdego klienta podaj liczbę złożonych przez niego zamówień w marcu 1997r
select customers.CompanyName,count(orderid) from customers
join orders on customers.CustomerID = orders.CustomerID where year(orders.orderdate) = 1997
group by customers.CompanyName

--1. Który ze spedytorów był najaktywniejszy w 1997 roku, podaj nazwę tego spedytora

--select top 1 count(ShipVia),ShipVia  from Orders group by ShipVia order by count(ShipVIa) desc


--2. Dla każdego zamówienia podaj wartość zamówionych produktów w 1997. Zbiór wynikowy powinien zawierać nr zamówienia, datę zamówienia, nazwę klienta oraz wartość zamówionych produktów
select orders.orderid, orders.OrderDate, Customers.CompanyName, sum(od.quantity*od.unitPrice) as 'val' from orders 
join Customers on orders.CustomerID = customers.CustomerID
join [Order Details] od on orders.orderid = od.OrderID
where year(orders.OrderDate)=1997
group by orders.OrderID, orders.OrderDate, customers.CompanyName
order by orders.OrderId

--3. Dla każdego zamówienia podaj jego pełną wartość (wliczając opłatę za przesyłkę). Zbiór wynikowy powinien zawierać nr zamówienia, datę zamówienia, nazwę klienta oraz pełną wartość zamówienia
--select orders.orderid, orders.OrderDate, Customers.CompanyName, sum(od.quantity*od.unitPrice*(1-od.discount)+orders.Freight) as 'price' from orders 
--join Customers on orders.CustomerID = customers.CustomerID
--join [Order Details] od on orders.orderid = od.OrderID
--group by orders.OrderID, orders.OrderDate, customers.CompanyName
--order by orders.OrderId


--3. Wybierz nazwy i numery telefonów klientów, którzy kupowali produkty z kategorii‘Confectionsʼ

--select distinct Customers.CompanyName, Customers.Phone from Customers
--join orders on customers.customerid = orders.customerid
--join [Order details] od on od.Orderid = oRDERs.orderid
--join Products on Products.Productid = Od.Productid
--join Categories on categories.CategoryID = Products.CategoryID
--where Categories.CategoryName = 'Confections'

--. Wybierz nazwy i numery telefonów klientów, którzy nie kupowali produktów z kategorii‘Confectionsʼ
--select Customers.CompanyName, Customers.Phone from Customers
--except
--select distinct Customers.CompanyName, Customers.Phone from Customers
--join orders on customers.customerid = orders.customerid
--join [Order details] od on od.Orderid = oRDERs.orderid
--join Products on Products.Productid = Od.Productid
--join Categories on categories.CategoryID = Products.CategoryID
--and Categories.CategoryName = 'Confections'
--. Wybierz nazwy i numery telefonów klientów, którzy w 1997r nie kupowali produktów zkategorii ‘Confectionsʼ
--select Customers.CompanyName, Customers.Phone from Customers
--except
--select distinct Customers.CompanyName, Customers.Phone from Customers
--join orders on customers.customerid = orders.customerid
--join [Order details] od on od.Orderid = oRDERs.orderid
--join Products on Products.Productid = Od.Productid
--join Categories on categories.CategoryID = Products.CategoryID
--where Categories.CategoryName = 'Confections' and year(orders.orderdate)=1997

--SELECT c.CompanyName, c.Phone
--FROM Customers c
--LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
--LEFT JOIN [Order Details] od ON o.OrderID = od.OrderID
--LEFT JOIN Products p ON od.ProductID = p.ProductID
--LEFT JOIN Categories cat ON p.CategoryID = cat.CategoryID
--WHERE (cat.CategoryName = 'Confections' OR YEAR(o.OrderDate) = 1997)
--GROUP BY c.CompanyName, c.Phone;


--1. Napisz polecenie, które wyświetla listę dzieci będących członkami biblioteki (bazalibrary). Interesuje nas imię, nazwisko, data urodzenia dziecka i adres zamieszkaniadziecka.
--select juvenile.member_no, concat(firstname,' ',lastname) imie_nazw, birth_date, concat(city,' ', street) adres, adult.state, adult.street from juvenile join member on juvenile.member_no = member.member_no    join adult on juvenile.adult_member_no = adult.member_no;
--2. Napisz polecenie, które wyświetla listę dzieci będących członkami biblioteki (bazalibrary). Interesuje nas imię, nazwisko, data urodzenia dziecka, adres zamieszkaniadziecka oraz imię i nazwisko rodzica
--select juvenile.member_no, birth_date, d.firstname, d.lastname, concat(city,' ', street) adres, m.firstname, m.lastname from juvenile join member d on juvenile.member_no = d.member_no  join adult on juvenile.adult_member_no = adult.member_no join member m on adult.member_no = m.member_no order by m.member_no




--1. Napisz polecenie, które wyświetla pracowników oraz ich podwładnych (bazanorthwind)
--select employees.Lastname,employees.firstname,e.FirstName,e.LastName from employees
--join employees e on employees.EmployeeID = e.ReportsTo
--2. Napisz polecenie, które wyświetla pracowników, którzy nie mają podwładnych (bazanorthwind)
--select Employees.LastName, Employees.FirstName from Employees
--except
--select employees.Lastname,employees.firstname from employees
--join employees e on employees.EmployeeID = e.ReportsTo

--3. Napisz polecenie, które wyświetla pracowników, którzy mają podwładnych (bazanorthwind)
--select distinct employees.Lastname,employees.firstname from employees
--join employees e on employees.EmployeeID = e.ReportsTo








--1. Podaj listę członków biblioteki mieszkających w Arizonie (AZ) mają
--więcej niż dwoje dzieci zapisanychdo biblioteki
--SELECT a.member_no, m.lastname, m.firstname
--FROM Adult a
--JOIN Member m ON a.member_no = m.member_no
--JOIN Juvenile j ON j.adult_member_no = a.member_no
--WHERE a.state = 'AZ'
--GROUP BY a.member_no, m.lastname, m.firstname
--HAVING COUNT(j.member_no) > 2;

--2. Podaj listę członków biblioteki mieszkających w Arizonie (AZ) którzy mają więcej niż
--dwoje dzieci zapisanych do biblioteki oraz takich którzy mieszkają w Kaliforni (CA) i
--mają więcej niż troje dzieci zapisanych do biblioteki
--SELECT a.member_no, m.lastname, m.firstname, a.state
--FROM Adult a
--JOIN Member m ON a.member_no = m.member_no
--JOIN Juvenile j ON j.adult_member_no = a.member_no
--WHERE a.state IN ('AZ', 'CA')
--GROUP BY a.member_no, m.lastname, m.firstname, a.state
--HAVING 
--    (a.state = 'AZ' AND COUNT(j.member_no) > 2) 
--    OR (a.state = 'CA' AND COUNT(j.member_no) > 3);


--dla kazdego klienta podaj liczbe zamowien w 1997
--select customers.CompanyName,count(orderid) as 'Liczba zamowien w 1997' -- count(1) jesli wiemy ze nie bedzie zlych
--from customers left join orders on customers.CustomerID = orders.CustomerID 
--and year(orders.orderdate) = 1997
--group by customers.CompanyName, customers.CustomerID-- musi byc klucz zeby nie nadpisaly sie powtorzenia
--having count(orderid) = 0

--dla kazdego klienta podaj wartosc zamowien w 1997 dodaj oplaty za przesylke
--select customers.CompanyName,count(orderid) as 'Liczba zamowien w 1997' 
--from customers left join orders on customers.CustomerID = orders.CustomerID  and year(orders.orderdate) = 1997 
--group by customers.CompanyName, customers.CustomerID
-- dla kazdego klienta podja wartosc zakupioncyh przez niego produktow z kategorii confections
select Customers.CustomerID, customers.companyName, isnull(sum(od.unitprice * od.quantity * (1-od.discount)),0) t from Customers
left join orders on orders.CustomerID = Customers.CustomerID
left join [order details] od on od.orderid = orders.orderid
left join products on od.productid =products.productid
left join categories on categories.categoryid = products.categoryid and categories.categoryname = 'Confections'
--zapytac czym sie rozni uzywanie where i warunku w joinie
group by customers.customerid, customers.companyname
order by t

select * from customers

-- dla kazdego klienta podaj liczbe roznych prod z kategorii confections zakupioncyh przez niego w 1997
select customers.CustomerID, customers.companyName, isnull(count(distinct PRODUCTs.productid),0) t from customers
left join orders on orders.CustomerID = Customers.CustomerID and year(orders.OrderDate)=1997
left join [order details] od on od.orderid = orders.orderid 
left join products on od.productid =products.productid
left join categories on categories.categoryid = products.categoryid and  categories.categoryname = 'Confections'
group by customers.customerid, customers.companyname
HAVING iSNULL(COUNT(DISTINCT Products.ProductID), 0) = 0 OR ISNULL(COUNT(DISTINCT Products.ProductID), 0) > 0
ORDER BY t DESC