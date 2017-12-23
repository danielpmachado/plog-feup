:-use_module(library(lists)).

:-include('utils.pl').
:-include('solve.pl').
:-include('interface.pl').
:-include('generate.pl').

start:-
  clear_screen,
  print_menu,
  read(Option),get_char(_),
  menu(Option).

menu(1):-
  clear_screen,
  print_board_menu,
  read(Option),get_char(_),
  board_menu(Option),
  read(X),get_char(_),
  start.

menu(2):-
  clear_screen,
  print_size_menu,
  read(Option),get_char(_),
  generate(Option,Board,Size),
  clear_screen,
  print_board(Board,Size),
  read(X),get_char(_),
  start.


menu(3):-
  clear_screen,
  print_size_menu,
  read(Option),get_char(_),
  generate(Option,Board,Size),
  init_stats,
  solve(Board,Size,Solution),
  print_time,
  print_stats,
  clear_screen,
  arrange_board(Solution,Printable),
  print_board(Printable,Size),
  read(X),get_char(_),
  start.


menu(4):-
  abort.

menu(_):-
  clear_screen,
  false.

board_menu(B):-
  clear_screen,
  board(B,Board,Size),
  init_stats,
  solve(Board,Size,Solution),
  print_time,
  print_stats,
  arrange_board(Solution,Printable),
  print_board(Printable,Size).
