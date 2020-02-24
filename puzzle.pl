% fruits eaten
fruit(apple).
fruit(banana).
fruit(mango).
fruit(apricot).
fruit(pear).

% nuts eaten
nut(almonds).
nut(peanuts).
nut(cashews).
nut(pecans).
nut(walnuts).

% days of the week
days(1).
days(2).
days(3).
days(4).
days(5).

% sequence eaten
after(apple, mango).
after(banana, almonds).
after(banana, peanuts).
after(pear, banana).
after(banana, cashews).
after(apricot, cashews).

% apple eaten after the mango 
% banana eaten after almonds & peanuts
% pear eaten after banana
% banana & apricot eaten after cashews
% cashews eaten after peanuts
% pecans eaten not evening after almonds <- this will be more tricky
% walnuts eaten a night

% Succeeds if all elements of the argument list are bound and different.
% Fails if any elements are unbound or equal to some other element.
all_different([H | T]) :- member(H, T), !, fail.
all_different([_ | T]) :- all_different(T).
all_different([_]).

% helper function to check if fruit/nut eaten after another
is_after(X, Y) :- after(X, Y).
is_after(X, Z) :- after(X, Y), is_after(Y, Z).

eaten_after_check([First, Second | Rest]) :- is_after(First, Second), !, fail.
eaten_after_check([_|Tail]) :- eaten_after_check(Tail).
eaten_after_check([_]).

% will be used to check that pecans not eaten evening after almonds
next_to(X, Y, [X, Y|_]).
next_to(X, Y, [_|Z]) :- next_to(X, Y, Z).

% helper function to guess a fruit/snack combination for a day of the week
guess_snack(Fruit, Nut) :-
	fruit(Fruit), nut(Nut).

% function to solve the snack problem
solve_snack :-

	% check that all days have a different fruit and nut consumed
	fruit(MonFruit), fruit(TuesFruit), fruit(WedFruit), fruit(ThurFruit), fruit(FriFruit),
	all_different([MonFruit, TuesFruit, WedFruit, ThurFruit, FriFruit]),
	
	nut(MonNut), nut(TuesNut), nut(WedNut), nut(ThurNut), nut(FriNut),
	all_different([MonNut, TuesNut, WedNut, ThurNut, FriNut]),
	
	SnackTriples = [[1, MonFruit, MonNut],
					[2, TuesFruit, TuesNut],
					[3, WedFruit, WedNut],
					[4, ThurFruit, ThurNut],
					[5, FriFruit, FriNut]],
	
	member([MangoDay, mango, _], SnackTriples),
	member([AppleDay, apple, _], SnackTriples),
	member([PearDay, pear, _], SnackTriples),
	member([ApricotDay, apricot, _], SnackTriples),
	member([BananaDay, banana, _], SnackTriples),
	member([AlmondDay, _, almonds], SnackTriples),
	member([PeanutDay, _, peanuts], SnackTriples),
	member([CashewDay, _, cashews], SnackTriples),
	member([PecanDay, _, pecans], SnackTriples),
	member([WalnutDay, _, walnuts], SnackTriples),
	
	MangoDay < AppleDay,
	AlmondDay < BananaDay,
	PeanutDay < BananaDay,
	CashewDay < ApricotDay,
	CashewDay < BananaDay,
	CashewDay > PeanutDay,
	ApricotDay < BananaDay,
	BananaDay < PearDay,
	PecanDay - AlmondDay \= 1,
	
	% check conditions of fruit/nuts eaten in order
	% not working because not all fruit/nut have a specified condition
	% is_after(FriFruit, MonFruit),
	% is_after(FriNut, MonNut),
	% \+ is_after(pecans, almonds),
	
	%eaten_after_check([MonFruit, TuesFruit, WedFruit, ThurFruit, FriFruit]),
	%eaten_after_check([MonNut, TuesNut, WedNut, ThurNut, FriNut]),
	%eaten_after_check([MonFruit, TuesFruit, WedFruit, ThurFruit, FriFruit], [MonNut, TuesNut, WedNut, ThurNut, FriNut]),
	
	% writing the results of the solver
	result_report('monday', MonFruit, MonNut), nl,
	result_report('tuesday', TuesFruit, TuesNut), nl,
	result_report('wednesday', WedFruit, WedNut), nl,
	result_report('thursday', ThurFruit, ThurNut), nl,
	result_report('friday', FriFruit, FriNut), nl.

% helper function to output what fruit/nut was eaten on which days
result_report(Day, Fruit, Nut) :- 
	write('Solution: '), write('('), write(Day), write(', '), write(Fruit), write(', '), write(Nut), write(')'), nl,
	write('English: '), write('On '), write(Day), write(', Bill ate '), write(Fruit), write(' and '), write(Nut).