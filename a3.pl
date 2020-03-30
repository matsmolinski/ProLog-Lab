:-dynamic komputer/5.
wykPrg:-
 write('1 - biezacy stan bazy danych'), nl,
 write('2 - dopisanie nowego komputera'), nl,
 write('3 - usuniecie komputera'), nl,
 write('4 - obliczenie sredniej ceny'), nl,
 write('5 - uzupelnienie bazy o dane zapisane w pliku'), nl,
 write('6 - zapisanie bazy w pliku'), nl,
 write('7 - wypisanie pc z danym procesorem'), nl,
 write('8 - wypisanie pc tanszych niz podana cena'), nl,
 write('0 - koniec programu'), nl, nl,
 read(I),
 I > 0,
 opcja(I),
 wykPrg.
wykPrg.

opcja(1) :- wyswietl.
opcja(2) :- write('Podaj nazwe procesora:'), read(Nazwaproc),
 write('Podaj typ procesora:'), read(Typproc),
 write('Podaj czestotliwosc zegara:'), read(Zegar),
 write('Podaj rozmiar HDD:'), read(Hdd),
 write('Podaj cene:'), read(Cena), nl,
 findall(Nazwaproc, komputer(Nazwaproc,Typproc,_,_,_), Lista),
 length(Lista, ListRozmiar),
 ListRozmiar = 0, !,
 assert(komputer(Nazwaproc, Typproc, Zegar, Hdd, Cena));
 write('Juz jest taki komputer'), nl.
opcja(3) :- write('Podaj nazwe procesora usuwanego:'), read(Nazwaproc),
 write('Podaj typ procesora usuwanego:'), read(Typproc),
 retract(komputer(Nazwaproc,Typproc,_,_,_)),! ;
 write('Brak takiego komputera').
opcja(4) :- sredniaCena.
opcja(5) :- write('Podaj nazwe pliku:'), read(Nazwa),
 exists_file(Nazwa), !, consult(Nazwa);
 write('Brak pliku o podanej nazwie'), nl.
opcja(6) :- write('Podaj nazwe pliku:'), read(Nazwa),
 open(Nazwa, write, X), zapis(X), close(X).
opcja(7) :- write('Podaj nazwe procesora:'), read(Nazwa),
 findall([Nazwa, Typproc,Zegar,Hdd,Cena], komputer(Nazwa,Typproc,Zegar,Hdd,Cena), Lista),
 wypiszIPolicz(Lista, LiczbaKomputerow),
 write('Liczba komputerow: '), write(LiczbaKomputerow), nl.
opcja(8) :- write('Podaj limit ceny:'), read(MaxCena),
 findall([Nazwa, Typproc,Zegar,Hdd,Cena], (komputer(Nazwa,Typproc,Zegar,Hdd,Cena), Cena < MaxCena), Lista),
 wypiszIPolicz(Lista, LiczbaKomputerow),
 write('Liczba komputerow: '), write(LiczbaKomputerow), nl.
opcja(_) :- write('Zly numer opcji'), nl.
 
wypiszIPolicz([],0).
wypiszIPolicz([G|Og], N) :- wypiszIPolicz(Og, N1),
 write(G), nl,
 N is N1+1.

czyTanszy(Nazwa, Typproc,Zegar,Hdd,Cena,MaxCena) :-
 komputer(Nazwa, Typproc, Zegar, Hdd, Cena),
 Cena < MaxCena.

wyswietl :- write('elementy bazy:'), nl,
 komputer(Nazwaproc, Typproc, Zegar, Hdd, Cena),
 write(Nazwaproc), write(' '), write(Typproc), write(' '), write(Zegar),
 write(' '), write(Hdd), write(' '), write(Cena), nl, fail.
wyswietl :- nl.

sredniaCena :- findall(Cena, komputer(_,_,_,_,Cena), Lista),
 suma(Lista, Suma, LiczbaKomputerow),
 SredniaCena is Suma / LiczbaKomputerow,
 write('Srednia cena:'), write(SredniaCena), nl, nl.

zapis(X) :- komputer(Nazwaproc, Typproc, Zegar, Hdd, Cena),
 write(X, 'komputer('),
 write(X, Nazwaproc), write(X, ','), write(X, Typproc), write(X, ','),
 write(X, Zegar), write(X, ','), write(X, Hdd), write(X, ','), write(X, Cena),
 write(X, ').'), nl(X), fail.
zapis(_) :- nl.

suma([],0,0).
suma([G|Og], Suma, N) :- suma(Og, S1, N1),
 Suma is G + S1,
 N is N1+1.

%komputer(intel, pentium, 5, 5, 400).
%komputer(amd, radeon, 6, 6, 500).
%komputer(intel, xeon, 7, 7, 600).
%komputer(intel, ipiec, 5, 5, 600).
%komputer(red, dc, 6, 6, 900).
%komputer(react, os, 9, 9, 500).
