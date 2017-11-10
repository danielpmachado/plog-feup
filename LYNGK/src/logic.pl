:-use_module(library(lists)).
:-include('board.pl').

startHvH:-
        board(B),
        createBoard(B,RandomB),
        play(RandomB,[none,none],[none,none],[ivory,blue,red,green,black]).


play(B,P1,P2,Colors) :-
        clearScreen,
        printBoard(B),
        printPlayersColors(P1,P2),

        printPlayer1,
        moveMenu(Choice),
        (
                Choice == 1 -> write(1);
                Choice == 2 -> write(2);
                Choice == 3 -> claimColor(Colors,NewColors,P1,NewP1);

                play(P1,P2,Colors)

        ).


claimColor(Colors,NewColors,Player,NewPlayer):-
	colorsMenu(Idx),
	select(Idx,Colors,NewColors),
	write(NewColors).
