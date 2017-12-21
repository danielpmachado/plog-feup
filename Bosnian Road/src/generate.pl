:-use_module(library(clpfd)).
:-use_module(library(random)).
:-use_module(library(lists)).

:-include('solver.pl').

generate_random_element(_, []).
generate_random_element(Size, [Element | Rest]):-
  random(0, 2, Domain),
  Element is Domain,
  generate_random_element(Size, Rest).


generate_random_board(_, []).
generate_random_board(Size, [Row | Rows]):-
  length(Row, Size),
  generate_random_element(Size, Row),
/* NumColNext is NumCol + 1,
  Size > NumColNext,*/
  generate_random_board(Size, Rows).


generate_board(_, [], []).
generate_board(Size, [RLine | RRest], [Line | Rest]):-
  length(Line, Size),
  generate_line(Size, RLine, RLine, Line),
  generate_board(Size, RRest, Rest).


generate_line(_, _, [], []).
generate_line(Size, RLine, [R | Rs], [S | Ss]):-
  /*random(Probability),
  Probability < 0.2,*/
  /*random(0, Size, Position),
  nth0(Position, RLine, Equal),
  Equal \= R,
  S #= Equal,*/
  random(0,2,D),
  S #= D,
  generate_line(Size, RLine, Rs, Ss).

generate_line(Size, RLine, [R | Rs], [S | Ss]):-
  S #= R,
  generate_line(Size, RLine, Rs, Ss).



%generate main
generate(Size, Board):-
  length(RandomBoard, Size),
  generate_random_board(Size, RandomBoard),

  length(Board, Size),
  generate_board(Size, RandomBoard, Board).
/*
  checkSnake(Size,Board),

  maplist(labeling([]), Board).*/
