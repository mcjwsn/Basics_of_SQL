--1. Dla ka¿dego zamówienia podaj jego wartoœæ. Posortuj wynik wg wartoœci zamówieñ(w malejêcej kolejnoœci)
--select OrderID, (unitprice*quantity)*(1-discount) as 'value' from [order details] order by value desc
--2. Zmodyfikuj zapytanie z poprzedniego punktu, tak aby zwraca³o tylko pierwszych 10wierszy
--select top 10 OrderID, (unitprice*quantity)*(1-discount) as 'value' from [order details] order by value desc
--3. Podaj nr zamówienia oraz wartoœæ zamówienia, dla zamówieñ, dla których ³¹czna liczba zamawianych jednostek produktów jest wiêksza ni¿ 250
--select orderid, sum(Quantity * UnitPrice * (1 - Discount)) AS OrderValue from[Order Details] gROUP BY OrderID HAVING SUM(Quantity) > 250;
-- 4.Podaj liczbê zamówionych jednostek produktów dla produktów, dla których productid jest mniejszy ni¿ 3--select productid,sum(Quantity) from [Order Details] group by productid having productid<3--ZMIANA BAZY--ponizsze zadanie jest zepsute--1. Ilu jest doros³ych czytekników
--select count(member_no) as 'Liczba' from juvenile where AGE(birthdate)>=INTERVAL '18 years'  --postregsql
--select count(member_no) as 'Liczba' from juvenile where MONTHS_BETWEEN(SYSDATE, BirthDate) / 12 >= 18 --oracle
--SELECT COUNT(member_no) AS AdultReadersCount FROM juvenile WHERE DATEDIFF(YEAR, Birth_Date, GETDATE())  - CASE WHEN MONTH(Birth_Date) > MONTH(GETDATE()) OR (MONTH(Birth_Date) = MONTH(GETDATE()) AND DAY(Birth_Date) > DAY(GETDATE())) THEN 1 ELSE 0 END >= 18;
--2. Ile jest dzieci zapisanych do biblioteki
--3. Ilu z doros³ych czytelników mieszka w Kaliforni (CA)
--4. Dla ka¿dego doros³ego czytelnika podaj liczbê jego dzieci.
--5. Dla ka¿dego doros³ego czytelnika podaj liczbê jego dzieci urodzonych przed 1998r



--1. Dla ka¿dego czytelnika podaj liczbê zarezerwowanych przez niego ksi¹¿ek
--select member_no, count(isbn) from reservation group by member_no
--2. Dla ka¿dego czytelnika podaj liczbê wypo¿yczonych przez niego ksi¹¿ek
--select member_no, count(isbn) from loan group by member_no
--3. Dla ka¿dego czytelnika podaj liczbê ksi¹¿ek zwróconych przez niego w 2001r.
--select member_no, count(isbn) from (select member_no, isbn, in_date from loanhist where year(in_date)=2001) as subquery group by member_no
--4. Dla ka¿dego czytelnika podaj sumê kar jakie zap³aci³ w 2001r
select member_no, sum(fine_paid) from (select member_no, fine_paid from loanhist where year(in_date)=2001 and fine_paid is not null) as subquery group by member_no
--5. Ile ksi¹¿ek wypo¿yczono w maju 2001
--6. Na jak d³ugo œrednio by³y wypo¿yczane ksi¹¿ki w maju 2001--1. Dla ka¿dego pracownika podaj liczbê obs³ugiwanych przez niego zamówieñ w 1997r
--2. Dla ka¿dego pracownika podaj ilu klientów (ró¿nych klientów) obs³ugiwa³ ten pracownik w 1997r
--3. Dla ka¿dego spedytora/przewoŸnika podaj ³¹czn¹ wartoœæ "op³at za przesy³kê" dla przewo¿onych przez niego zamówieñ
--4. Dla ka¿dego spedytora/przewoŸnika podaj ³¹czn¹ wartoœæ "op³at za przesy³kê" przewo¿onych przez niego zamówieñ w latach od 1996 do 1997--1. Dla ka¿dego pracownika podaj liczbê obs³ugiwanych przez niego zamówieñ z podzia³em na lata
--2. Dla ka¿dego pracownika podaj liczbê obs³ugiwanych przez niego zamówieñ z podzia³em na lata i miesi¹ce.