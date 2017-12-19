:-use_module(library(clpfd)).

  % initialize_matrix(+Board, -ConstrainedBoard).
initialize_matrix([], []).
initialize_matrix([B | Bs], [S | Ss]):-
    initialize_line(B, S),
    initialize_matrix(Bs, Ss).


% initialize_line(+BoardLine, -ConstrainedLined).
initialize_line([], []).

initialize_line([E | Es], [S | Ss]):-
  E = '.',
  S in (0..3),
initialize_line(Es, Ss).

initialize_line([E | Es], [S | Ss]):-
  S =E,
initialize_line(Es, Ss).


solve(Board):-
  initialize_matrix(Board, Solution),
  %maplist(domain(0,1),Solution),
  maplist(labeling([]), Solution),
  print_board(Solution).
