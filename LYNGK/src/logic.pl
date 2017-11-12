
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
                          nth0(0,InitPos,Top),
                          append(FinalPos,[Top],Final),
                          setPosition(B, NewBoard, 0, 0, X2, Y2, Final);
                          NewBoard = Board
                       ).


checkValidMove(Complete,Board,P1,P2,X1,Y1,X2,Y2):-
        (
          checkTopPiece(Board,P2,X1,Y1), write(' -> valid top piece color\n'),
          checkPosition(X1,X2,Y1,Y2),write(' -> valid diagonal\n'),
          checkPosition(Board,X1,Y1),write(' -> valid initial position\n'),
          checkPosition(Board,X2,Y2),write(' -> valid final position\n'),
          checkFinalStack(Board,X1,Y1,X2,Y2), write(' -> valid final stack\n'),Complete is 1;
          nl,write(' || Invalid Move ||'),nl,nl,Complete is 0
        ).

checkFinalStack(Board,X1,Y1,X2,Y2):-
        index(Board,Y1,X1,Piece1),
        index(Board,Y2,X2,Piece2),
        (is_list(Piece1) ->length(Piece1,L1);L1 is 1),
        (is_list(Piece2) ->length(Piece2,L2);L2 is 1),
        Total is L1 + L2,
        Total =< 5.

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
        A == B.
        

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
