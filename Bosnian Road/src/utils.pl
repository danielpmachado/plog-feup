:- use_module(library(clpfd)).

%%%%%%%%%%% STATISTICS %%%%%%%%%%%%%%
reset_timer :- statistics(walltime,_).

print_time :-
	statistics(walltime,[_,T]),
	TS is ((T//10)*10)/1000,
	nl, write('Time: '), write(TS), write('s'), nl, nl.


%%%%%%%%%%% BOARD %%%%%%%%%%%%%%

print_board(Board,Size) :-
	Total is Size*Size,
  print_row_by_row(Board,Size,Total).

print_row_by_row(_,_,0).
print_row_by_row(Board,Size,Total):-
	print_line(Board,Size,Rest),nl,
	T is Total-Size,
	print_row_by_row(Rest,Size,T).

print_line(T,0,T).
print_line([H|T],Size,Rest):-
	write(H), write(' '),
	S is Size-1,
	print_line(T,S,Rest).


number_zeros(L,N,Z):-
	L1 is L-N,
	L1 > 0,
	Z is L1.

number_zeros(L,N,0).
