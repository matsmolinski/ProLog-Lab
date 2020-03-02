silnia(0,1).
silnia(N,Nsil) :-
	N > 0,
	M is N - 1,
	silnia(M,Msil),
	Nsil is N * Msil. 