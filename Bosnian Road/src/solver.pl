:-use_module(library(clpfd)).

  % initialize(+Board, -ConstrainedBoard).
initialize([], []).
initialize([B | Bs], [S | Ss]):-
  B = '.',
  S in (0..0) \/ (1..1),
  initialize(Bs, Ss).

initialize([B | Bs], [S | Ss]):-
  S =B,
  initialize(Bs, Ss).

get_element(Board,Idx,Element):-
  nth1(Idx,Board,Element).

get_element(_,Size,Idx,Inputs,Inputs):-
  Idx > Size*Size.

get_element(Board,Size, Idx, Inputs, [Element | Inputs]):-
  nth1(Idx,Board,Element),
  fd_var(Element).
get_element(_, _,_, Inputs, Inputs).

get_all_adjacent(Board, Counter,Size, Adjacent):-
  Y is Counter mod Size,
  A1 is Counter-Size-1,
  A2 is Counter-Size,
  (Y = 0->A3 is -1;A3 is Counter-Size+1),
  A4 is Counter-1,
  (Y = 0->A5 is -1;A5 is Counter+1),
  A6 is Counter+Size-1,
  A7 is Counter+Size,
  (Y = 0->A8 is -1;A8 is Counter+Size+1),
  get_element(Board,Size,A1,[],T1),
  get_element(Board,Size,A2,T1,T2),
  get_element(Board,Size,A3,T2,T3),
  get_element(Board,Size,A4,T3,T4),
  get_element(Board,Size,A5,T4,T5),
  get_element(Board,Size,A6,T5,T6),
  get_element(Board,Size,A7,T6,T7),
  get_element(Board,Size,A8,T7,Adjacent).

get_adjacent(Board, Counter,Size, Adjacent):-
  A1 is Counter-Size,
  A2 is Counter-1,
  Y is Counter mod Size,
  (Y = 0->A3 is -1;A3 is Counter+1),
  A4 is Counter+Size,
  get_element(Board,Size,A1,[],T1),
  get_element(Board,Size,A2,T1,T2),
  get_element(Board,Size,A3,T2,T3),
  get_element(Board,Size,A4,T3,Adjacent).

check_surrounded(Size,Board):-
  check_surrounded(Size,Board,1).

check_surrounded(Size,Board,Counter):-
  Counter =< Size*Size,
  get_element(Board,Counter,E),
  \+fd_var(E),
  get_all_adjacent(Board,Counter,Size,Adjacent),
  length(Adjacent,L),
  number_zeros(L,E,Z),
  global_cardinality(Adjacent,[1-E,0-Z]),
  C is Counter+1,
  check_surrounded(Size,Board,C).

check_surrounded(Size,Board,Counter):-
  Counter =< Size*Size,
  C is Counter+1,
  check_surrounded(Size,Board,C).

check_surrounded(Size,Board,Counter).


solve(Board):-
  initialize(Board, Solution),
  check_surrounded(6,Solution),
  print_board(Solution,6),
/*  maplist(checkSnake(6,Solution),Solution2),*/
  labeling([], Solution),
  print_board(Solution,6).
