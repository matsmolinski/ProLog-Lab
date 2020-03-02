% opis działania bramki AND – metodą zerojedynkową
brAnd(0,0,0).
brAnd(1,0,0).
brAnd(0,1,0).
brAnd(1,1,1).
%opis układu
uklad(A,B,C,D,E,F,G) :-
 brAnd(A,B,E),
 brAnd(C,D,F),
 brAnd(E,F,G). 