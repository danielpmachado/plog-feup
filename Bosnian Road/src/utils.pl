:- use_module(library(clpfd)).

%%%%%%%%%%% STATISTICS %%%%%%%%%%%%%%
reset_timer :- statistics(walltime,_).

print_time :-
	statistics(walltime,[_,T]),
	TS is ((T//10)*10)/1000,
	nl, write('Time: '), write(TS), write('s'), nl, nl.


%%%%%%%%%%% BOARD %%%%%%%%%%%%%%
  print_board(Board) :-
          print_black_line,
          print_row_by_row(Board).
          %print_black_line.

  print_black_line:-
          nl,
          write(' - - - - - -'),
          nl.

  print_row_by_row([]).
  print_row_by_row([Line|Rest]) :-
          write('|'),
          print_single_row(Line),
          print_row_by_row(Rest).

  print_single_row([Cell]):-
          write(Cell),
          write('|'),
          print_black_line.

  print_single_row([Cell|More]):-
          write(Cell),
          write('|'),
  print_single_row(More).
