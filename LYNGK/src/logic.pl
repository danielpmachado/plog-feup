:-include('board.pl').
:-use_module(library(lists)).

startHvH:-
        board(B),
        setPositions(B,RandomB),
        play(RandomB,[red,blue],[],[ivory,blue,red,green,black]).


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

                play(B,P1,P2,Colors)

        ).


claimColor(Colors,NewColors,Player,NewPlayer):-
  %select color to claim
	colorsMenu(Colors,Idx),
  nth0(Idx, Colors, Color),
	select(Color,Colors,NewColors),

  %check is player can claim color
  length(Player,Plength),
  (
    Plength == 2 -> NewPlayer = Player, write('  You can only claim 2 colors!\n');
    append(Player,Color,NewPlayer)
  ).
