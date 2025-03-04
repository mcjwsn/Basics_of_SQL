﻿--select top 5 orderid, productid, quantity from [order details] order by quantity desc
--select top 5 with ties orderid, productid, quantity from [order details] order by quantity desc
--select count (*) from employees
--select avg(unitprice) from products
--select sum(quantity) from [order details] where productid = 1


--1. Podaj liczbę produktów o cenach mniejszych niż 10 lub większych niż 20
--select count(unitprice) from Products where Unitprice>20 or Unitprice<10

--2. Podaj maksymalną cenę produktu dla produktów o cenach poniżej 20
--select max(unitprice) from Products where unitprice<20
--select top 1 with ties unitprice, productname from products where unitprice < 20 order by unitprice desc

--3. Podaj maksymalną i minimalną i średnią cenę produktu dla produktów o produktach sprzedawanych w butelkach (‘bottleʼ)
--select max(unitprice) as 'max',min(unitprice) as 'min',avg(unitprice) as 'avg' from Products where QuantityPerUnit like '%bottle%'

--4. Wypisz informację o wszystkich produktach o cenie powyżej średniej
--select unitprice from Products where Unitprice> (select avg(unitprice) from products)

--5. Podaj sumę/wartość zamówienia o numerze 10250
--select round(sum((unitprice*(1-discount))*quantity),2) as 'Final Price' from [Order Details] where orderid = 10250

--select cast(0.1 as float) + cast(0.1 as float) +cast(0.1 as float) - cast(0.3 as float) !
--select * from orderhist


--1. Podaj maksymalną cenę zamawianego produktu dla każdego zamówienia
--select orderid,max(unitprice) from [Order Details] group by orderid

--2. Posortuj zamówienia wg maksymalnej ceny produktu
--select orderid,max(unitprice) from [Order Details] group by orderid order by max(unitprice) desc

--3. Podaj maksymalną i minimalną cenę zamawianego produktu dla każdego zamówienia
--select orderid,max(unitprice) as 'max',min(unitprice) as 'min' from [Order Details] group by orderid

--4. Podaj liczbę zamówień dostarczanych przez poszczególnych spedytorów (przewoźników)
--select shipvia, count(shipvia) from orders group by shipvia

--5. Który ze spedytorów był najaktywniejszy w 1997 roku
--select top 1 ShipVia, count(ShipVia) as cnt from Orders where YEAR(OrderDate) = 1997 group by ShipVia order by cnt desc

--1. Wyświetl zamówienia dla których liczba pozycji zamówienia jest większa niż 5
--select *  from (select orderid,count(orderid) as 'cnt' from [Order Details] group by orderid) as subquery  where cnt>5
--2. Wyświetl klientów dla których w 1998 roku zrealizowano więcej niż 8 zamówień
--select * from (select customerid,count(customerid) as 'cnt_of_zamowien', sum(freight) as 'sum_of_freight' from orders where year(shippeddate)=1998 group by customerid) as subquery where cnt_of_zamowien>8 order by sum_of_freight
--(wyniki posortuj malejąco wg łącznej kwoty za dostarczenie zamówień dla każdego z klientów)
