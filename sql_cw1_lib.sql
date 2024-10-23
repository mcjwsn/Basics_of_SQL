--cw1.1
--1. Napisz polecenie select za pomocą którego uzyskasz identyfikator/numer tytułu oraz tytuł książki
--select title_no, title from title

--2. Napisz polecenie, które wybiera tytuł o numerze/identyfikatorze 10
--select title from title where title_no = 10

--3. Napisz polecenie select, za pomocą którego uzyskasz numer książki (nr tyułu) i autora dla wszystkich książek, których autorem jest Charles Dickens lub Jane Austen
--select title_no,author from title where author in ('Charles Dickens', 'Jane Austen')


--1. Napisz polecenie, które wybiera numer tytułu i tytuł dla wszystkich książek, których tytuły zawierających słowo 'adventure'
--select title, title_no from title where title like '%adventure%'

--2. Napisz polecenie, które wybiera numer czytelnika, oraz zapłaconą karę dla wszystkich książek, ktore zostały zwrócone w listopadzie 2001
--select member_no,sum(fine_paid) as 'suma' from loanhist where year(in_date) = 2001 and month(in_date) = 11 and fine_paid is not null order by suma desc

--3. Napisz polecenie, które wybiera wszystkie unikalne pary miast i stanów z tablicy adult .
--select distinct city,state from adult

--4. Napisz polecenie, które wybiera wszystkie tytuły z tablicy title i wyświetla je w porządku alfabetycznym.
--select title from title order by (title)


--1. Napisz polecenie, które: wybiera numer członka biblioteki ( member_no ), isbn książki ( isbn ) i wartość naliczonej kary (fine_assessed) z tablicy loanhist dla wszystkich
--wypożyczeń/zwrotów, dla których naliczono karę (wartość nie NULL w kolumnie fine_assessed ) stwórz kolumnę wyliczeniową zawierającą podwojoną wartość kolumny fine_assessed
--stwórz alias double_fine dla tej kolumny (zmień nazwą kolumny na double_fine ) stwórz kolumnę o nazwie diff , zawierającą różnicę wartości w kolumnach double_fine i fine_assessed
--wybierz wiersze dla których wartość w kolumnie diff jest większa niż 3

--select distinct member_no, isbn, fine_assessed from loanhist  where fine_assessed is not null
--select distinct member_no, fine_assessed, 2*fine_assessed double_fine,2*fine_assessed - fine_assessed diff from loanhist where fine_assessed is not null and fine_assessed>0
--select member_no, out_date diff from(select member_no, out_date,fine_assessed, 2*fine_assessed double_fine,2*fine_assessed - fine_assessed diff from loanhist where fine_assessed is not null and fine_assessed>0) as subquery where diff>3;


-- 1.Napisz polecenie, które generuje pojedynczą kolumnę, która zawiera kolumny: firstname (imię członka biblioteki), middleinitial (inicjał drugiego imienia) i lastname (nazwisko) z
--tablicy member dla wszystkich członków biblioteki, którzy nazywają się Anderson nazwij tak powstałą kolumnę email_name (użyj aliasu email_name dla kolumny)
--zmodyfikuj polecenie, tak by zwróciło 'listę proponowanych loginów e-mail' utworzonych przez połączenie imienia członka biblioteki, z inicjałem drugiego imienia i
--pierwszymi dwoma literami nazwiska (wszystko małymi małymi literami). wykorzystaj funkcję SUBSTRING do uzyskania części kolumny znakowej oraz LOWER do zwrócenia wyniku małymi literami.
--wykorzystaj operator (+) do połączenia napisów.

--select firstname + ' ' + middleinitial + ' ' + lastname from member where lastname like '%Anderson%'
--select firstname + ' ' + middleinitial + ' ' + lastname as email_name from member where lastname like '%Anderson%'
--select LOWER(replace(firstname +  middleinitial + substring(lastname,1,2),' ','')) as email_name from member where lastname like '%Anderson%' order by email_name


--1. Napisz polecenie, które wybiera title i title_no z tablicy title . wynikiem powinna być pojedyncza kolumna o formacie jak w przykładzie poniżej:The title is: Poems, title number 7
--czyli zapytanie powinno zwracać pojedynczą kolumnę w oparciu o wyrażenie, które łączy 4 elementy: stała znakowa ‘The title is:ʼ wartość kolumny title stała znakowa ‘title numberʼ wartość kolumny title_no

--select 'The title is: ' + title + ', title number ' + cast(title_no as varchar) from title
