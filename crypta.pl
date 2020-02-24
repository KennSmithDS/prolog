% logic program to solve the cryptarithmetic problem of "TWO + TWO = FOUR"

% create constants for each integer possible
num(0).
num(1).
num(2).
num(3).
num(4).
num(5).
num(6).
num(7).
num(8).
num(9).

% function to solve the cryptarithmetic problem
solve_crypta :-
	% instantiate variables for each position in the problem
	num(T), num(W), num(O), num(F), num(U), num(R),
	
	% check that each of the six variables store different values
	all_different([T, W, O, F, U, R]),
	\+ F is 0,
	
	% establish digit rules for each position of FOUR with carry over C1, C2
	R is (O + O) mod 10,
	C1 is (O + O) // 10,
	U is (W + W + C1) mod 10,
	C2 is (W + W + C1) // 10,
	O is (T + T + C2) mod 10,
	F is (T + T + C2) // 10,
	
	% print out the results of what each letter is to solve the problem
	nl,
	write('  '), write(T), write(W), write(O), nl,
	write('+ '), write(T), write(W), write(O), nl,
	write('------'), nl,
	write(' '), write(F), write(O), write(U), write(R), nl,
	
	nl,
	write('T is '), write(T), nl,
	write('W is '), write(W), nl,
	write('O is '), write(O), nl,
	write('F is '), write(F), nl,
	write('U is '), write(U), nl,
	write('R is '), write(R), nl.
	
% Succeeds if all elements of the argument list are bound and different.
% Fails if any elements are unbound or equal to some other element.
all_different([H | T]) :- member(H, T), !, fail.
all_different([_ | T]) :- all_different(T).
all_different([_]).