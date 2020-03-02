fib(0,0).
fib(1,1).
fib(N,Nfib) :-
	N > 1,
	M1 is N - 1,
	M2 is N - 2,
	fib(M1, N1fib),
	fib(M2, N2fib),
	Nfib is N1fib + N2fib. 