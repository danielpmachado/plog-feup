:- use_module(library(clpfd)).


init_stats :-
 statistics(runtime,_).

add_list([H|O],O,H).

board(1,Board,4):-
	Board = [
		.,.,.,.,
		.,.,7,.,
		.,.,.,.,
		2,.,.,'.'
		 ].


board(2,Board,6):-
  Board = [
      .,.,.,.,.,.,
      .,5,.,.,5,.,
      .,.,3,.,.,.,
      .,.,.,.,.,.,
      .,3,.,.,.,.,
      .,.,.,.,.,2
      ].

board(3,Board,8):-
		Board = [
			 .,.,.,.,.,.,.,.,
			 .,7,.,4,.,3,.,.,
			 .,.,.,.,.,.,.,.,
			 .,6,.,.,.,.,.,.,
			 .,.,.,.,.,.,.,.,
			 .,.,.,.,.,.,.,.,
			 .,.,.,.,.,.,4,.,
			 .,.,.,.,.,.,.,'.'
			      ].

board(4,Board,10):-
  Board = [
			 .,.,.,.,.,.,.,.,.,2,
			 .,6,.,.,.,.,.,.,.,.,
			 .,.,.,.,.,.,5,.,.,.,
			 .,.,.,.,.,.,.,.,.,.,
			 .,.,.,.,.,.,.,.,6,.,
			 .,6,.,.,.,.,.,.,.,.,
			 .,.,.,.,.,.,4,.,.,.,
			 .,.,.,4,.,.,.,.,.,.,
			 .,.,.,.,.,.,.,.,7,.,
			 .,.,.,.,.,5,.,.,.,'.'
			          ].


board(_,_,_):-false.


clear_screen :-
  printLines(65).

printLines(N) :-
	N > 0,
	nl,
	N1 is N - 1,
	printLines(N1).
printLines(_).

number_zeros(L,N,Z):-
	L1 is L-N,
	L1 > 0,
	Z is L1.

number_zeros(L,N,0).
