
print_menu :-
  write('========================================\n'),
  write('==           Bosnian Road             ==\n'),
  write('========================================\n'),
  write('==                                    ==\n'),
  write('==          1 - Solve                 ==\n'),
  write('==          2 - Generate & Solve      ==\n'),
  write('==          3 - Exit                  ==\n'),
  write('==                                    ==\n'),
  write('========================================\n').


print_board_menu :-
  write('========================================\n'),
  write('==   Bosnian Road - Choose the Board  ==\n'),
  write('========================================\n'),
  write('==                                    ==\n'),
  write('==          1 - Board 1 (6x6)         ==\n'),
  write('==          2 - Board 2 (8x8)         ==\n'),
  write('==          3 - Board 3 (10x10)       ==\n'),
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
