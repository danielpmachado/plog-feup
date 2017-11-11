
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

                play(B,P1,P2,Colors)

        ).

normalMove(B):-
        selectPiece(B, Piece),
        write('piece - '), write(Piece),
        movePiece(B,B2,Piece),
        B = B2,
        printBoard(B).

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

selectPiece(B, P):-
        write('Column number : '),
        getColumnNumber(X),nl,
        write('Line number : '),
        getLineNumber(Y),
        getPosition(B, 0, 0, X, Y, P).

movePiece(B,B2,Piece):-
        write('Column number : '),
        getColumnNumber(X),nl,
        write('Line number : '),
        getLineNumber(Y),
        setPosition(B, B2, 0, 0, X, Y, Piece).

getColumnNumber(X) :-
        X = _,
        max = _,
        read(X),
        number(X),
        X > -1 , X < 13.

getColumnNumber(X) :-
        write('Please pick a number between 0 and 13...'),
        getColumnNumber(X).


getLineNumber(X) :-
        X = _,
        max = _,
        read(X),
        number(X),
        X > -1 , X < 9.

getLineNumber(X) :-
        write('Please pick a number between 0 and 9...'),
        getLineNumber(X).
