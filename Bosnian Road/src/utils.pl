:- use_module(library(clpfd)).


%%%%%%%%%%% STATISTICS %%%%%%%%%%%%%%
reset_timer :- statistics(walltime,_).

print_time :-
	statistics(walltime,[_,T]),
	TS is ((T//10)*10)/1000,
	nl, write('Time: '), write(TS), write('s'), nl, nl.


%%%%%%%%%%% BOARD %%%%%%%%%%%%%%

board(1,Board,6):-
  Board = [
      .,.,.,.,.,.,
      .,5,.,.,5,.,
      .,.,3,.,.,.,
      .,.,.,.,.,.,
      .,3,.,.,.,.,
      .,.,.,.,.,2
      ].

board(2,Board,8):-
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

board(3,Board,10):-
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


%%%%%%%%%%% OTHERS %%%%%%%%%%%%%%
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
