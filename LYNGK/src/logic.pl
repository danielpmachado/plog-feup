
:-use_module(library(lists)).

:-include('board.pl').

startHvH:-
        board(B),
        createBoard(B,RandomB),
        random(0,2,R),
        (
          R = 0 -> play(RandomB,[1],[2],[ivory,blue,red,green,black]);
          play(RandomB,[2],[1],[ivory,blue,red,green,black])
        ).



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

        makeMove(Complete,0,Board,Player1,Player2,Colors,NewBoard,NewPlayer,NewColors).



makeMove(Complete,Claimed,Board,Player1,Player2,Colors,NewBoard,NewPlayer,NewColors):-
        printMoveMenu,
        read(Option),
        (
                Option = 1 -> write(1), normalMove(Board,NewBoard),NewPlayer = Player1,NewColors =Colors, Complete is 1;
                Option = 2 -> write(2), Complete is 1;
                Option = 3 -> Complete is 0,
                              (Claimed \= 1  -> claimColor(Colors,NewColors,Player1,NewPlayer), NewBoard = Board, Claimed1 is 1;
                              write(' || You have already claimed a color this turn ||'),nl,nl, Claimed1 is Claimed);
                Option = 4 -> halt;

                write(' || Please choose a valid option. ||'),nl,nl,Complete is 0
        ),
        (Complete \= 1 -> makeMove(Complete1,Claimed1,Board,Player1,Player2,Colors,NewBoard,NewPlayer,NewColors); nl).


normalMove(B,B2):-
        selectPiece(B,Bt,X),
        write('piece - '), write(X),
        movePiece(Bt,B2,X),
        printBoard(B2).



claimColor(Colors,FinalColors,Player,NewPlayer):-
	colorsMenu(Colors,Idx),
  nth0(Idx, Colors, Color),
	select(Color,Colors,NewColors),

  length(Player,Plength),
  (
    Plength == 3 ->
    NewPlayer = Player,
    FinalColors =Colors,
    write('  || You can only claim 2 colors ||'),nl,nl;

    append(Player,[Color],NewPlayer),
    FinalColors= NewColors
  ).

selectPiece(B,B2,P):-
        nl,write('Select initial position'),nl,
        write('Column number : '),
        getColumnNumber(X),
        write('Line number : '),
        getLineNumber(Y),
        getPosition(B, 0, 0, X, Y, P),
        setPosition(B, B2, 0, 0, X, Y, x).

movePiece(B,B2,Piece):-
        nl,write('Select final position'),nl,
        write('Column number : '),
        getColumnNumber(X),
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
