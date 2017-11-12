
:-use_module(library(lists)).

:-include('board.pl').

startHvH:-
        board4(B),
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
        printBoard(Board),nl,
        printPlayersColors(Player1,Player2),
        printPlayer(Player1),

        makeMove(Complete,0,Board,Player1,Player2,Colors,NewBoard,NewPlayer,NewColors).



makeMove(Complete,Claimed,Board,P1,P2,Colors,NewBoard,NewPlayer,NewColors):-
        printMoveMenu,
        read(Option),
        (
                Option = 1 -> normalMove(Complete,Board,P1,P2,Colors,NewBoard),NewPlayer = P1,NewColors = Colors;
                Option = 2 -> write(2), Complete is 1;
                Option = 3 -> Complete is 0,
                              (Claimed \= 1  -> claimColor(Colors,NewColors,P1,NewPlayer), NewBoard = Board, Claimed1 is 1;
                              write(' || You have already claimed a color this turn ||'),nl,nl, Claimed1 is Claimed);
                Option = 4 -> halt;

                write(' || Please choose a valid option. ||'),nl,nl,Complete is 0
        ),
        (Complete \= 1 -> makeMove(Complete1,Claimed1,NewBoard,NewPlayer,P2,NewColors,NewBoard1,NewPlayer1,NewColors1); nl).


normalMove(Complete,Board,P1,P2,Colors,NewBoard):-
        getInitialPos(X1,Y1),
        getFinalPos(X2,Y2),
        checkValidMove(Complete,Board,P1,P2,X1,Y1,X2,Y2),
        (Complete = 1 ->  setPosition(Board, B, 0, 0, X1, Y1, [x]),
                          index(Board,Y1,X1,InitPos),
                          index(Board,Y2,X2,FinalPos),
                          append(InitPos,FinalPos,Final),
                          setPosition(B, NewBoard, 0, 0, X2, Y2, Final);
                          NewBoard = Board
                       ).


checkValidMove(Complete,Board,P1,P2,X1,Y1,X2,Y2):-
        (

          checkTopPiece(Board,P2,X1,Y1), nl,write(' -> valid top piece color\n'),

          checkDiagonal(X1,X2,Y1,Y2),write(' -> valid diagonal\n'),
          checkDiagonalPositions(Board,X1,X2,Y1,Y2), write(' -> valid diagonal positions\n'),
          checkPosition(Board,X1,Y1),write(' -> valid initial position\n'),
          checkPosition(Board,X2,Y2),write(' -> valid final position\n'),
          checkNeutralTop(Board,P1,X1,Y1,X2,Y2), write(' -> valid neutral move\n'),
          checkFinalStack(Board,X1,Y1,X2,Y2), write(' -> valid final stack\n'),Complete is 1;
          nl,write(' || Invalid Move ||'),nl,nl,Complete is 0
        ).

checkNeutralTop(Board,P1,X1,Y1,X2,Y2):-
        index(Board,Y1,X1,Piece1),
        nth0(0,Piece1,Top),
        (
          \+(member(Top,P1))-> index(Board,Y2,X2,Piece2),
                               (is_list(Piece1) ->length(Piece1,L1);L1 is 1),
                               (is_list(Piece2) ->length(Piece2,L2);L2 is 1),
                               L2 =< L1;
                               yes
        ).

checkFinalStack(Board,X1,Y1,X2,Y2):-
        index(Board,Y1,X1,Piece1),
        index(Board,Y2,X2,Piece2),
        (is_list(Piece1) ->length(Piece1,L1);L1 is 1),
        (is_list(Piece2) ->length(Piece2,L2);L2 is 1),
        Total is L1 + L2,
        Total =< 5,
        append(Piece1,Piece2,Final),
        delete(Final,white,F1),
        delete(F1,white,F2),
        is_set(F2).

checkPosition(Board,X,Y):-
        index(Board,Y,X,Piece),
        nth0(0,Piece,Top),
        \+(Top = '.'),
        \+(Top = x).

checkTopPiece(Board,P2,X,Y):-
        index(Board,Y,X,Piece),
        nth0(0,Piece,Top),
        \+(member(Top,P2)),
        \+(Top = white).

checkDiagonal(X1,X2,Y1,Y2):-
        abs(X1,X1abs), abs(X2,X2abs),
        A is X1abs - X2abs,
        abs(Y1,Y1abs), abs(Y2,Y2abs),
        B is Y1abs - Y2abs,
        abs(A,Aabs),abs(B,Babs),
        Aabs == Babs.

checkDiagonalPositions(Board,X1,X2,Y1,Y2):-
        A is X2-X1,
        B is Y2-Y1,
        ( A >= 0 -> Dx is 1 ; Dx is -1 ),
        ( B >= 0 -> Dy is 1 ; Dy is -1 ),
        X is X1+Dx,
        Y is Y1+Dy,
        checkCell(Board, X,Y,Dx,Dy,X2).

checkCell(Board, X1,Y1,Dx,Dy,X2):-
        X1==X2,
        Top = _,
        index(Board,Y1,X1,Piece),
        nth0(0,Piece,Top),
        \+(Top = x).

checkCell(Board, X1,Y1,Dx,Dy,X2):-
        Top = _,
        index(Board,Y1,X1,Piece),
        nth0(0,Piece,Top),
        Top == x,
        X is X1+Dx,
        Y is Y1+Dy,
        checkCell(Board, X,Y,Dx,Dy,X2).



getInitialPos(X,Y):-
        nl,write(' Select initial position'),nl,
        write(' Column number '),
        getColumnNumber(X),
        write(' Line number '),
        getLineNumber(Y).

getFinalPos(X,Y):-
        nl,write(' Select final position'),nl,
        write(' Column number '),
        getColumnNumber(X),
        write(' Line number '),
        getLineNumber(Y).


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


test(Complete,Board,P1,P2,X1,Y1,X2,Y2,L,L1):-
        Y1 == 9,
        Y is Y1+1.

test(Complete,Board,P1,P2,X1,Y1,X2,Y2,L,L1):-
        Y1 < 9,
        forX1(Complete,Board,P1,P2,X1,Y1,X2,Y2,L,L1),
        Y is Y1+1,
        test(Complete,Board,P1,P2,X1,Y,X2,Y2,L,L1).


forX1(Complete,Board,P1,P2,X1,Y1,X2,Y2,L,L1):-
        X1 == 13,
        X is X1+1.

forX1(Complete,Board,P1,P2,X1,Y1,X2,Y2,L,L1):-
        X1 < 13,
        forY2(Complete,Board,P1,P2,X1,Y1,X2,Y2,L,L1),
        X is X1+1,
        forX1(Complete,Board,P1,P2,X,Y1,X2,Y2,L,L1).



forY2(Complete,Board,P1,P2,X1,Y1,X2,Y2,L,L1):-
        Y2 == 9,
        Y is Y2+1.


forY2(Complete,Board,P1,P2,X1,Y1,X2,Y2,L,L1):-
        Y2 < 9,
        forX2(Complete,Board,P1,P2,X1,Y1,X2,Y2,L,L1),
        Y is Y2+1,
        forY2(Complete,Board,P1,P2,X1,Y1,X2,Y,L,L1).


forX2(Complete,Board,P1,P2,X1,Y1,X2,Y2,L,L1):-
        X2 == 13,
        X is X2+1,
        forX2(Complete,Board,P1,P2,X1,Y1,X,Y2,L,L1).


forX2(Complete,Board,P1,P2,X1,Y1,X2,Y2,L,L1):-
        X2 < 13,
        write(' X1-'),write(X1), write(' Y1-'),write(Y1),write(' X2-'),write(X2),write(' Y2-'),write(Y2),nl,
        %checkMove(Complete,Board,P1,P2,X1,Y1,X2,Y2,L,L1),
        X is X2+1,
        forX2(Complete,Board,P1,P2,X1,Y1,X,Y2,L1,_).

forX2(_,_,_,_,_,_,_,_,_,_).

checkMove(Complete,Board,P1,P2,X1,Y1,X2,Y2,L,L1):-
        (checkValidMove(Complete,Board,P1,P2,X1,Y1,X2,Y2) ->  append([X1,Y1,X2,Y2],L,L1);
         write('falhou')).
