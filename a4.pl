:- dynamic xpositive/2.
:- dynamic xnegative/2.
 
%1. Opis obiektów (ich cech charakterystycznych)
 
town_is(castle) :-
    it_is(humans),
    positive(has,two_range_units),
    negative(has,mage_guild_lvl_5).

town_is(rampart) :-
    it_is(good),
    negative(has, two_range_units),
    positive(has, dragons),
    positive(has,mage_guild_lvl_5).
    
town_is(tower) :-
    it_is(good),
    positive(has, two_range_units),
    positive(has,mage_guild_lvl_5).

town_is(necropolis) :-
    it_is(evil),
    positive(has,dragons),
    negative(has,two_range_units).
    
town_is(dungeon) :-
    it_is(evil),
    positive(has,dragons),
    positive(has,two_range_units).
    
town_is(inferno) :-
    it_is(evil),
    negative(has,dragons).
    
town_is(conflux) :-
    it_is(neutral),
    positive(has,mage_guild_lvl_5).

town_is(stronghold) :-
    it_is(neutral),
    positive(is,in_Restoration_of_Erathia),
    negative(has,mage_guild_lvl_5),
    positive(has,two_range_units),
    negative(is,from_hota).

town_is(fortress) :-
    it_is(neutral),
    positive(is,in_Restoration_of_Erathia),
    negative(has,mage_guild_lvl_5),
    negative(has,two_range_units).

town_is(cove) :-
    it_is(neutral),
    negative(has, mage_guild_lvl_5),
    positive(has,two_range_units),
    positive(is,from_hota). 

%2. Opis cech charakterystycznych dla klas obiektów 
 

it_is(good) :-
    positive(is,in_Restoration_of_Erathia),
    positive(does,get_boost_on_holy_ground).

it_is(evil) :-
    positive(is, in_Restoration_of_Erathia),
    positive(does,get_boost_on_evil_fog).

it_is(neutral) :-
    positive(does,get_boost_on_clover_field).

it_is(humans) :-
    it_is(good),
    positive(has,angels).
    


%3. Szukanie potwierdzenia cechy obiektu w dynamicznej bazie

positive(X,Y) :-
    xpositive(X,Y),!.   

positive(X,Y) :-
    not(xnegative(X,Y)),
    ask(X,Y,yes).

negative(X,Y) :-
xnegative(X,Y),!.

negative(X,Y) :-
    not(xpositive(X,Y)),
    ask(X,Y,no). 
 
%4. Zadawanie pytań użytkownikowi 
 
ask(X,Y,yes) :-
    write(X), write(' it '), write(Y), write('\n'),
    read(Reply),
    sub_string(Reply,0,1,_,'y'),!,
    remember(X,Y,yes).     
 
ask(X,Y,yes):- remember(X,Y,no), fail.

ask(X,Y,no) :-
    write(X), write(' it '), write(Y), write('\n'),
    read(Reply),
    sub_string(Reply,0,1,_, 'n'),!,
    remember(X,Y,no).

ask(X,Y,no):- remember(X,Y,yes), fail.

%5. Zapamiętanie odpowiedzi w dynamicznej bazie 
 
remember(X,Y,yes) :-
    asserta(xpositive(X,Y)).

remember(X,Y,no) :-
    asserta(xnegative(X,Y)). 
 
%6. Uruchomienie programu 
 
run :-
    town_is(X),!,
    write('\nYour town may be a(n) '), write(X), nl, nl,
    clear_facts.

run :-
    write('\nUnable to determine what'),
    write('your town is.\n\n'),
    clear_facts. 
 
%7. Wyczyszczenie zawartości dynamicznej bazy 
 
clear_facts :-
    retract(xpositive(_,_)), fail.

clear_facts :-
    retract(xnegative(_,_)), fail.

clear_facts :-
    write('\n\nPlease press the space bar to exit\n'). 