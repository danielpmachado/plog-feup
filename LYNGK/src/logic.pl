
:-use_module(library(lists)).
:-include('board.pl').

startHvH:-
        board(B),
        createBoard(B,RandomB),
        play(RandomB,[1],[2],[ivory,blue,red,green,black]).



play(Board,Player1,Player2,Colors) :-
        turn(Board,Player1,Player2,Colors,NewBoard,P1,NewColors),
        %check end of game
        turn(NewBoard,Player2,P1,NewColors,FinalBoard,P2,FinalColors),
        %check end of game
        play(FinalBoard,P1,P2,FinalColors).


turn(Board,Player1,Player2,Colors,NewBoard,NewPlayer,NewColors):-
        clearScreen,
        printBoard(Board),
        printPlayersColors(Player1,Player2),

        printPlayer(Player1),
        moveMenu(Choice),
        (
                Choice == 1 -> write(1);
                Choice == 2 -> write(2);
                Choice == 3 -> claimColor(Colors,NewColors,Player1,NewPlayer), NewBoard = Board;

                turn(Board,Player1,Player2,Colors,NewBoard,NewPlayer,NewColors)

        ).




claimColor(Colors,FinalColors,Player,NewPlayer):-
  % select color to claim
	colorsMenu(Colors,Idx),
  nth0(Idx, Colors, Color),
	select(Color,Colors,NewColors),

  % check if player can claim color
  length(Player,Plength),
  (
    Plength == 3 -> NewPlayer = Player,FinalColors =Colors, write('  You can only claim 2 colors!\n');
    append(Player,[Color],NewPlayer),FinalColors= NewColors
  ).
