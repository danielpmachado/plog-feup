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
get_element(Board,Idx,-1).


get_element(Board, Idx, Inputs, [Element | Inputs]):-
  nth1(Idx,Board,Element),
  Element #<2.
get_element(_, _, Inputs, Inputs).

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
  get_element(Board,A1,[],T1),
  get_element(Board,A2,T1,T2),
  get_element(Board,A3,T2,T3),
  get_element(Board,A4,T3,T4),
  get_element(Board,A5,T4,T5),
  get_element(Board,A6,T5,T6),
  get_element(Board,A7,T6,T7),
  get_element(Board,A8,T7,Adjacent).



check_closed(Board,Size,Counter):-
  get_element(Board,Counter,Element),
  Y is Counter mod Size,
  Z is Counter mod Size,
  A1 is Counter-Size,
  (Z = 1->A2 is -1; A2 is Counter-1),
  (Y = 0->A3 is -1;A3 is Counter+1),
  A4 is Counter+Size,
  get_element(Board,A1,E1),
  get_element(Board,A2,E2),
  get_element(Board,A3,E3),
  get_element(Board,A4,E4),
  (Element #=1 #/\ (
  (E1 #=1 #/\ E2#=1 #/\ E3#\=1 #/\ E4 #\=1) #\/
  (E1 #=1 #/\ E3#=1 #/\ E2#\=1 #/\ E4 #\=1) #\/
  (E1 #=1 #/\ E4#=1 #/\ E2#\=1 #/\ E3 #\=1) #\/
  (E2 #=1 #/\ E3#=1 #/\ E1#\=1 #/\ E4 #\=1) #\/
  (E2 #=1 #/\ E4#=1 #/\ E1#\=1 #/\ E3 #\=1) #\/
  (E3 #=1 #/\ E4#=1 #/\ E1#\=1 #/\ E2 #\=1) )) #\/
  Element #=0.
check_closed(Board,Size,Counter).




check_surrounded(Size,Board):-
  check_surrounded(Size,Board,1).


check_surrounded(Size,Board,Counter):-
  Counter =< Size*Size,
  get_element(Board,Counter,E),
  \+fd_var(E),
  E #>=2,
  get_all_adjacent(Board,Counter,Size,Adjacent),
  length(Adjacent,L),
  number_zeros(L,E,Z),
  global_cardinality(Adjacent,[1-E,0-Z]),
  C is Counter+1,
  check_surrounded(Size,Board,C).

check_surrounded(Size,Board,Counter):-
  Counter =< Size*Size,
  check_closed(Board,Size,Counter),
  C is Counter+1,
  check_surrounded(Size,Board,C).

check_surrounded(Size,Board,Counter).



solve(Board):-
  initialize(Board, Solution),
  check_surrounded(6,Solution),
/*  maplist(checkSnake(6,Solution),Solution2),*/
  labeling([], Solution),
  print_board(Solution,6).
