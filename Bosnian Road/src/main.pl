:-use_module(library(lists)).

:-include('utils.pl').
:-include('solver.pl').
:-include('interface.pl').

start:-
  clear_screen,
  print_menu,
  read(Option),get_char(_),
  menu(Option).

menu(1):-
  clear_screen,
  print_board_menu,
  read(Option),get_char(_),
  board_menu(Option).

menu(4):-
  abort.

menu(_):-
  false.

board_menu(B):-
  clear_screen,
  board(B,Board,Size),
  init_stats,
  solve(Board,Size),
  print_time,
  print_stats.
