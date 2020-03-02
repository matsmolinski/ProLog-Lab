% opis działania bramki AND
brAnd(0,0,0).
brAnd(1,0,0).
brAnd(0,1,0).
brAnd(1,1,1).
% opis działania bramki OR
brOr(0,0,0).
brOr(1,0,1).
brOr(0,1,1).
brOr(1,1,1).
% opis działania bramki XOR
brXor(0,0,0).
brXor(1,0,1).
brXor(0,1,1).
brXor(1,1,0).

%opis układu
uklad(A,B,C,D,E,F,G,H,I,J) :-
 brAnd(A,B,F),
 brOr(C,D,G),
 brAnd(F,G,H),
 brAnd(A,E,I),
 brXor(H,I,J). 