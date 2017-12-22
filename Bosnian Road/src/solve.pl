:-use_module(library(clpfd)).


initialize([], []).
initialize([B | Bs], [S | Ss]):-
  B =0,
  S in (0..0) \/ (11..11),
  initialize(Bs, Ss).

initialize([B | Bs], [S | Ss]):-
  S =B,
  initialize(Bs, Ss).


get_element(Board,Idx,Element):-
  nth1(Idx,Board,Element).
get_element(Board,Idx,-1).

get_element(Board, Idx, Inputs, [Element | Inputs]):-
  nth1(Idx,Board,Element).
get_element(_, _, Inputs, Inputs).

get_rigth(Counter,Size,R,0):-  R is -1.
get_rigth(Counter,Size,R,_):-  R is Counter + 1.

get_left(Counter,Size,L,1):-  L is -1.
get_left(Counter,Size,L,_):-  L is Counter - 1.

get_top(Counter,Size,T):-  T is Counter - Size.
get_bot(Counter,Size,B):-  B is Counter + Size.

get_diogonal1(Counter,Size,D,1):- D is -1.
get_diogonal1(Counter,Size,D,_):- D is Counter-Size-1.
get_diogonal2(Counter,Size,D,1):- D is -1.
get_diogonal2(Counter,Size,D,_):- D is Counter+Size-1.
get_diogonal3(Counter,Size,D,0):- D is -1.
get_diogonal3(Counter,Size,D,_):- D is Counter-Size+1.
get_diogonal4(Counter,Size,D,0):- D is -1.
get_diogonal4(Counter,Size,D,_):- D is Counter+Size+1.


get_adjacent(Board, Counter,Size, Adjacent):-
  M is Counter mod Size,
  get_rigth(Counter,Size,R,M),
  get_left(Counter,Size,L,M),
  get_top(Counter,Size,T),
  get_bot(Counter,Size,B),
  get_diogonal1(Counter,Size,D1,M),
  get_diogonal2(Counter,Size,D2,M),
  get_diogonal3(Counter,Size,D3,M),
  get_diogonal4(Counter,Size,D4,M),

  get_element(Board,R,[],T1),
  get_element(Board,L,T1,T2),
  get_element(Board,T,T2,T3),
  get_element(Board,B,T3,T4),
  get_element(Board,D1,T4,T5),
  get_element(Board,D2,T5,T6),
  get_element(Board,D3,T6,T7),
  get_element(Board,D4,T7,Adjacent).


check_closed(Board,Size,Counter):-
  get_element(Board,Counter,Element),
  fd_var(Element),

  M is Counter mod Size,
  get_rigth(Counter,Size,R,M),
  get_left(Counter,Size,L,M),
  get_top(Counter,Size,T),
  get_bot(Counter,Size,B),

  get_element(Board,R,E1),
  get_element(Board,L,E2),
  get_element(Board,T,E3),
  get_element(Board,B,E4),

  ((Element #=11 #/\ (
  (E1 #=11 #/\ E2#=11 #/\ E3#\=11 #/\ E4 #\=11) #\/
  (E1 #=11 #/\ E3#=11 #/\ E2#\=11 #/\ E4 #\=11) #\/
  (E1 #=11 #/\ E4#=11 #/\ E2#\=11 #/\ E3 #\=11) #\/
  (E2 #=11 #/\ E3#=11 #/\ E1#\=11 #/\ E4 #\=11) #\/
  (E2 #=11 #/\ E4#=11 #/\ E1#\=11 #/\ E3 #\=11) #\/
  (E3 #=11 #/\ E4#=11 #/\ E1#\=11 #/\ E2 #\=11) )) #\/
  Element #=0).
check_closed(Board,Size,Counter).

check_surrounded(Board,Size,Counter):-
  get_element(Board,Counter,E),
  \+fd_var(E),
  E >=2,
  get_adjacent(Board,Counter,Size,Adjacent),
  exactly(11,Adjacent,E).


restrict(Board,Size,Counter):-
  Counter =< Size*Size,
  check_surrounded(Board,Size,Counter),
  C is Counter+1,
  restrict(Board,Size,C).

restrict(Board,Size,Counter):-
  Counter =< Size*Size,
  check_closed(Board,Size,Counter),
  C is Counter+1,
  restrict(Board,Size,C).

restrict(Board,Size,Counter).


solve(Board,Size,Solution):-
  initialize(Board, Solution),
  restrict(Solution,Size,1),
  labeling([ff,bisect,down], Solution).
