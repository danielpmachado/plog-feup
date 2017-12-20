:-use_module(library(lists)).

:-include('utils.pl').
:-include('solver.pl').

board(Board):-
  Board = [
      [.,.,.,.,.,.],
      [.,5,.,.,5,.],
      [.,.,3,.,.,.],
      [.,.,.,.,.,.],
      [.,3,.,.,.,.],
      [.,.,.,.,.,2]
      ].


start(Board):-
  reset_timer,
  solve(Board),
  print_time.


send(Vars):-
  Vars = [A1,A2,A3,B1,B3,C1,C2,C3],
  domain(Vars,0,1),
  %all_different(Vars),
  A1 + A2 + A3 + B1 + B3 + C1 + C2 + C3 #= 5,
/*  B2 #= 5,*/
  labeling([], Vars).
