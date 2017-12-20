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
  S in (0..0) \/(1..1),
initialize_line(Es, Ss).

initialize_line([E | Es], [S | Ss]):-
  S =E,
initialize_line(Es, Ss).

get_element(Board, X, Y, E):-
  nth1(Y, Board, Row),
  nth1(X, Row, E).

get_element(Board, X, Y, Inputs, [Element | Inputs]):-
  nth1(Y, Board, Row),
  nth1(X, Row, Element).
get_element(_, _, _, Inputs, Inputs).


get_adjacent(Board, X, Y, Adjacent):-
  XPlus1 is X + 1,
  YPlus1 is Y + 1,
  XMinus1 is X - 1,
  YMinus1 is Y - 1,
  get_element(Board, XPlus1, Y, [], Tmp1),
  get_element(Board, X, YPlus1, Tmp1, Tmp2),
  get_element(Board, XMinus1, Y, Tmp2, Tmp3),
  get_element(Board, XMinus1, YMinus1, Tmp3, Tmp4),
  get_element(Board, XMinus1, YPlus1, Tmp4, Tmp5),
  get_element(Board, XPlus1, YMinus1, Tmp5, Tmp6),
  get_element(Board, XPlus1, YPlus1,Tmp6, Tmp7),
  get_element(Board, X, YMinus1, Tmp7, Adjacent).


check_surrounded(Board,X,Y):-
  get_element(Board,X,Y,E),
  E =< 8,
  E >=2,
  get_adjacent(Board, X, Y, Adjacent),
  length(Adjacent,L),
  L1 is L-E,
  global_cardinality(Adjacent,[1-E,0-L1]).
  %print_board(Board).
check_surrounded(Board,X,Y).

%check(+Size, +Board)
check(Size, Board):-
  check(Size, Board, 1, 1).

check(Size, Board, X, Y):-
  X is Size + 1,
  NextY is Y + 1,
  check(Size, Board, 1, NextY).

check(Size, _, _, Y):-
  Y is Size + 1.

check(Size, Board, X, Y):-
  get_element(Board,X,Y,E),
  var(E),
  NextX is X + 1,
  check(Size, Board, NextX, Y).

check(Size, Board, X, Y):-
  get_element(Board,X,Y,E),
  nonvar(E),
  check_surrounded(Board,X,Y),
  NextX is X + 1,
  check(Size, Board, NextX, Y).


solve(Board):-
  initialize_matrix(Board, Solution),
  check(6,Solution),
  maplist(labeling([]), Solution),
  print_board(Solution).
