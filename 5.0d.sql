--"Napisz zapytanie SQL, które wyświetli dla każdej kategorii nazwę kategorii,
--nazwę produktu, cenę jednostkową, średnią cenę produktów w tej samej kategorii,
--różnicę między ceną produktu a średnią ceną w kategorii, oraz sumę sprzedaży dla tego produktu w marcu 1997 roku."
-- srenida
--use Northwind;
--with t1 as(
--select Categories.CategoryID, avg(Products.unitprice) as av from Categories
--join Products on products.CategoryID = Categories.CategoryID
--group by Categories.CategoryID
--),
----ceny zamowien
--t2 as(
--select Products.ProductID, sum((odd.unitprice * odd.Quantity)*(1-odd.discount)) as s
--from Products
--join [Order Details] odd on products.ProductID = odd.ProductID
--join Orders on orders.orderid = odd.OrderID
--where year(orders.OrderDate)=1997 and month(orders.OrderDate)=3
--group by Products.ProductID
--)
--select distinct Products.ProductID, Products.ProductName, Products.unitprice, t1.av, (Products.unitprice-t1.av) diff, t2.s from Products
--join [Order Details] od on Products.ProductID = od.ProductID
--join t1 on t1.CategoryID = Products.CategoryID
--join t2 on t2.ProductID = Products.ProductID
--order by ProductID

--Napisz zapytanie SQL, które wyświetli imię i nazwisko każdego pracownika, a także sumę wartości sprzedaży 
--wygenerowanej przez tego pracownika 
--(uwzględniając zniżki) oraz sumę kosztów transportu przypisanych do zamówień obsługiwanych przez tego pracownika."
--dochod na pracownika
--;with t1 as
--(select orders.EmployeeID, sum((1-od.discount)*(od.Unitprice*od.Quantity)) s
--from [Order Details] od
--join Orders on od.OrderID = orders.OrderID
--group by orders.EmployeeID),
----suma kosztow transportow
--t2 as (
--select EmployeeID, sum(Freight) s from Orders 
--group by EmployeeID)
--select Employees.LastName, Employees.FirstName, t1.s + t2.s 
--from Employees
--join t1 on t1.EmployeeID = Employees.EmployeeID
--join t2 on t2.EmployeeID = Employees.EmployeeID

--"Napisz zapytanie SQL, które wyświetli nazwę firmy i adres klientów
--którzy nie złożyli żadnego zamówienia w 1997 roku,
-- operatora NOT IN"
--select Customers.CompanyName, Customers.Address, Customers.CustomerID from Customers
--where Customers.CustomerID not in (
--select orders.CustomerID from orders
--where year(orders.OrderDate) = 1997)

-- Dla każdego klienta podaj imię i nazwisko pracownika, który w 1997r obsłużył
-- najwięcej jego zamówień, podaj także liczbę tych zamówień (jeśli jest kilku takich
-- pracownikow to wystarczy podać imię nazwisko jednego nich). Za datę obsłużenia
-- zamówienia należy przyjąć orderdate. Zbiór wynikowy powinien zawierać nazwę
-- klienta, imię i nazwisko pracownika oraz liczbę obsłużonych zamówień. (baza
-- northwind)
with t1 as(select customers.CompanyName, Orders.EmployeeID,customers.CustomerID, count(orders.EmployeeID) t
from Customers
join orders on customers.customerid = orders.customerid and year(orders.OrderDate)=1997
group by customers.CustomerID, orders.EmployeeID, customers.CompanyName
),
t2 as(
select customerid, max(t) x from t1 group by customerid)
select customers.companyName, t2.x, Employees.FirstName, Employees.LastName from t2
join t1 on t2.customerid = t1.CustomerID and t2.x =t1.t
join Employees on t1.EmployeeID = Employees.EmployeeID
join Customers on t2.CustomerID = Customers.CustomerID;


WITH T1 as (
    SELECT customers.customerid, employees.employeeid, count(orders.orderid) as 'ilosc'
    from Customers
    inner join orders on orders.CustomerID = customers.customerid
    inner join Employees on Employees.EmployeeID = orders.EmployeeID
    where year(orderdate) = 1997
    group by customers.CustomerID, Employees.EmployeeID
), T2 as (
    Select customerid, max(ilosc) as 'max_ilosc'
    from T1
    group by customerid
)
SELECT companyName, firstname, LastName, ilosc
from T2
inner join T1 on T1.CustomerID = T2.CustomerID and max_ilosc = ilosc
inner join Customers on T1.customerid = customers.customerid
inner join Employees on T1.EmployeeID = Employees.EmployeeID

-- Podaj liczbę̨
--  zamówień oraz wartość zamówień (uwzględnij opłatę za przesyłkę)
-- obsłużonych przez każdego pracownika w lutym 1997. Za datę obsłużenia
-- zamówienia należy uznać datę jego złożenia (orderdate). Jeśli pracownik nie
-- obsłużył w tym okresie żadnego zamówienia, to też powinien pojawić się na liście
-- (liczba obsłużonych zamówień oraz ich wartość jest w takim przypadku równa 0).
-- Zbiór wynikowy powinien zawierać: imię i nazwisko pracownika, liczbę obsłużonych
-- zamówień, wartość obsłużonych zamówień. (baza northwind)

SELECT employees.employeeid, firstname, lastname, count(orders.orderId),
ISNULL(sum(UnitPrice*quantity*(1-discount)+orders.freight), 0)
from [Order Details] 
inner join orders on orders.OrderID = [Order Details].OrderID
right join Employees on Employees.EmployeeID = orders.EmployeeID
where year(orderDate) = 1997 and month(orderdate) = 2
group by FirstName, LastName, employees.EmployeeID

-- Podaj listę dzieci będących członkami biblioteki, które w dniu '2001-12-14'
-- zwróciły do biblioteki książkę o tytule 'Walking'. Zbiór wynikowy powinien zawierać
-- imię i nazwisko oraz dane adresowe dziecka. (baza library)
;with t1 as(select member_no from loanhist
join title on title.title_no = loanhist.title_no and title.title = 'Walking'
where in_date > '2001-12-13' and in_date < '2001-12-15'
),
t2 as(select member_no from juvenile),
t3 as(select t1.member_no from t1
intersect 
select t2.member_no from t2),
t4 as( select concat(adult.city, adult.state,adult.street) t, juvenile.member_no from adult
join juvenile on adult.member_no = juvenile.adult_member_no)
select member.firstname, member.lastname, t4.t from member
join t3 on member.member_no = t3.member_no
join t4 on t4.member_no = t3.member_no

-- Podaj tytuły książek, które nie są aktualnie zarezerwowane przez dzieci mieszkające
-- w Arizonie (AZ). (baza library)

SELECT distinct title from title
inner join item on item.title_no = title.title_no
inner join reservation on reservation.isbn = item.isbn
where reservation.member_no not in  (
    SELECT juvenile.member_no 
    from juvenile
    inner join reservation on reservation.member_no = juvenile.member_no
    inner join adult on adult.member_no = juvenile.adult_member_no
    where state = 'AZ'
)