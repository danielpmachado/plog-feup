
print_menu :-
  write('========================================\n'),
  write('==           Bosnian Road             ==\n'),
  write('========================================\n'),
  write('==                                    ==\n'),
  write('==          1 - Solve                 ==\n'),
  write('==          2 - Generate              ==\n'),
  write('==          3 - Generate & Solve      ==\n'),
  write('==          4 - Exit                  ==\n'),
  write('==                                    ==\n'),
  write('========================================\n').


print_board_menu :-
  write('========================================\n'),
  write('==   Bosnian Road - Choose the Board  ==\n'),
  write('========================================\n'),
  write('==                                    ==\n'),
  write('==          1 - Board 1 (4x4)         ==\n'),
  write('==          2 - Board 2 (6x6)         ==\n'),
  write('==          3 - Board 3 (8x8)         ==\n'),
  write('==          4 - Board 4 (10x10)       ==\n'),
  write('==                                    ==\n'),
  write('========================================\n').

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

print_time:-
  statistics(runtime,[_,T]),
	TS is ((T//10)*10)/1000,
  nl, nl,
  write('========= Statistics ========='), nl,
	nl, write('Time: '), write(TS), write('s'),nl.



print_stats:-
  fd_statistics(resumptions, Resumptions),
  fd_statistics(entailments, Entailments),
  fd_statistics(prunings, Prunings),
  fd_statistics(backtracks, Backtracks),
  fd_statistics(constraints, Constraints),
  write('Resumptions: '), write(Resumptions), nl,
  write('Entailments: '), write(Entailments), nl,
  write('Prunings: '), write(Prunings), nl,
  write('Backtracks: '), write(Backtracks), nl,
  write('Constraints: '), write(Constraints), nl.
