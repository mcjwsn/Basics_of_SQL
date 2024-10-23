--1. Dla ka�dego zam�wienia podaj jego warto��. Posortuj wynik wg warto�ci zam�wie�(w malej�cej kolejno�ci)
--select OrderID, (unitprice*quantity)*(1-discount) as 'value' from [order details] order by value desc
--2. Zmodyfikuj zapytanie z poprzedniego punktu, tak aby zwraca�o tylko pierwszych 10wierszy
--select top 10 OrderID, (unitprice*quantity)*(1-discount) as 'value' from [order details] order by value desc
--3. Podaj nr zam�wienia oraz warto�� zam�wienia, dla zam�wie�, dla kt�rych ��czna liczba zamawianych jednostek produkt�w jest wi�ksza ni� 250
--select orderid, sum(Quantity * UnitPrice * (1 - Discount)) AS OrderValue from[Order Details] gROUP BY OrderID HAVING SUM(Quantity) > 250;
-- 4.Podaj liczb� zam�wionych jednostek produkt�w dla produkt�w, dla kt�rych productid jest mniejszy ni� 3--select productid,sum(Quantity) from [Order Details] group by productid having productid<3--ZMIANA BAZY--ponizsze zadanie jest zepsute--1. Ilu jest doros�ych czyteknik�w
--select count(member_no) as 'Liczba' from juvenile where AGE(birthdate)>=INTERVAL '18 years'  --postregsql
--select count(member_no) as 'Liczba' from juvenile where MONTHS_BETWEEN(SYSDATE, BirthDate) / 12 >= 18 --oracle
--SELECT COUNT(member_no) AS AdultReadersCount FROM juvenile WHERE DATEDIFF(YEAR, Birth_Date, GETDATE())  - CASE WHEN MONTH(Birth_Date) > MONTH(GETDATE()) OR (MONTH(Birth_Date) = MONTH(GETDATE()) AND DAY(Birth_Date) > DAY(GETDATE())) THEN 1 ELSE 0 END >= 18;
--2. Ile jest dzieci zapisanych do biblioteki
--3. Ilu z doros�ych czytelnik�w mieszka w Kaliforni (CA)
--4. Dla ka�dego doros�ego czytelnika podaj liczb� jego dzieci.
--5. Dla ka�dego doros�ego czytelnika podaj liczb� jego dzieci urodzonych przed 1998r



--1. Dla ka�dego czytelnika podaj liczb� zarezerwowanych przez niego ksi��ek
--select member_no, count(isbn) from reservation group by member_no
--2. Dla ka�dego czytelnika podaj liczb� wypo�yczonych przez niego ksi��ek
--select member_no, count(isbn) from loan group by member_no
--3. Dla ka�dego czytelnika podaj liczb� ksi��ek zwr�conych przez niego w 2001r.
--select member_no, count(isbn) from (select member_no, isbn, in_date from loanhist where year(in_date)=2001) as subquery group by member_no
--4. Dla ka�dego czytelnika podaj sum� kar jakie zap�aci� w 2001r
select member_no, sum(fine_paid) from (select member_no, fine_paid from loanhist where year(in_date)=2001 and fine_paid is not null) as subquery group by member_no
--5. Ile ksi��ek wypo�yczono w maju 2001
--6. Na jak d�ugo �rednio by�y wypo�yczane ksi��ki w maju 2001--1. Dla ka�dego pracownika podaj liczb� obs�ugiwanych przez niego zam�wie� w 1997r
--2. Dla ka�dego pracownika podaj ilu klient�w (r�nych klient�w) obs�ugiwa� ten pracownik w 1997r
--3. Dla ka�dego spedytora/przewo�nika podaj ��czn� warto�� "op�at za przesy�k�" dla przewo�onych przez niego zam�wie�
--4. Dla ka�dego spedytora/przewo�nika podaj ��czn� warto�� "op�at za przesy�k�" przewo�onych przez niego zam�wie� w latach od 1996 do 1997--1. Dla ka�dego pracownika podaj liczb� obs�ugiwanych przez niego zam�wie� z podzia�em na lata
--2. Dla ka�dego pracownika podaj liczb� obs�ugiwanych przez niego zam�wie� z podzia�em na lata i miesi�ce.