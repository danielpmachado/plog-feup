:-use_module(library(lists)).

:-include('utils.pl').
:-include('solver.pl').

board(Board):-
  Board = [
      .,.,.,.,.,.,
      .,5,.,.,5,.,
      .,.,3,.,.,.,
      .,.,.,.,.,.,
      .,3,.,.,.,.,
      .,.,.,.,.,2
      ].


start(Board):-
  reset_timer,
  solve(Board),
  print_time.
