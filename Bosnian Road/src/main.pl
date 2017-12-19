:-use_module(library(lists)).

:-include('utils.pl').

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
  %solve(Board,Solution),
  print_board(Board),
  print_time.
