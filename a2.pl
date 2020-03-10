%opis grafu
gallery(entry,monsters,2).
gallery(entry,fountain,3).
gallery(fountain,hell,4).
gallery(fountain,food,5).
gallery(exit,gold_treasure,6).
gallery(fountain,mermaid,7).
gallery(robbers,gold_treasure,8).
gallery(fountain,robbers,9).
gallery(food,gold_treasure,10).
gallery(mermaid,exit,11).
gallery(monsters,gold_treasure,12).

% graf nieskierowany
neighborroom(X, Y, Dist) :- gallery(X, Y, Dist).
neighborroom(X, Y, Dist) :- gallery(Y, X, Dist).

%lista wêz³ów zakazanych
avoid([monsters,robbers]).
go(Here,There) :- route(Here, There,[Here],0). 

%rekurencyjne poszukiwanie drogi
route(Exit,Eyit,VisitedRooms,Dist) :-
member(gold_treasure,VisitedRooms), write(VisitedRooms), write(Dist), nl.

route(Room,Way_out,VisitedRooms,Dist) :-
neighborroom(Room,NextRoom, DistNext),
avoid(DangerousRooms),
\+ member(NextRoom,DangerousRooms),
\+ member(NextRoom,VisitedRooms),
M is Dist + DistNext,
route(NextRoom,Way_out,[NextRoom|VisitedRooms],M).


%sprawdzenie, czy element wystêpuje w liœcie
member(X,[X|_]).
member(X,[_|H]) :- member(X,H). 