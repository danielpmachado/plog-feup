
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

        makeMove(Complete,Board,Player1,Player2,Colors,NewBoard,NewPlayer,NewColors),
        (Complete \= 1 -> makeMove(Complete,Board,Player1,Player2,Colors,NewBoard,NewPlayer,NewColors); nl).


makeMove(Complete,Board,Player1,Player2,Colors,NewBoard,NewPlayer,NewColors):-
        printMoveMenu,
        read(Option),
        (
                Option = 1 -> write(1), Complete is 0;
                Option = 2 -> write(2), Complete is 0;
                Option = 3 -> claimColor(Colors,NewColors,Player1,NewPlayer), NewBoard = Board, Complete is 0;
                Option = 4 -> halt;

                Complete is 0

        ).

normalMove(B):-
        selectPiece(B, Piece),
        write('piece - '), write(Piece),
        movePiece(B,B2,Piece),
        B = B2,
        printBoard(B).



claimColor(Colors,FinalColors,Player,NewPlayer):-
	colorsMenu(Colors,Idx),
  nth0(Idx, Colors, Color),
	select(Color,Colors,NewColors),

  length(Player,Plength),
  (
    Plength == 3 ->
    NewPlayer = Player,
    FinalColors =Colors,
    write('  You can only claim 2 colors!\n');

    append(Player,[Color],NewPlayer),
    FinalColors= NewColors
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
