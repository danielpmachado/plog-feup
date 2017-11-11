:- use_module(library(random)).

board([
         [.,.,.,.,.,.,x,.,.,.,.,.,.],
         [.,.,.,x,.,x,.,x,.,x,.,.,.],
         [x,.,x,.,x,.,x,.,x,.,x,.,x],
         [.,x,.,x,.,x,.,x,.,x,.,x,.],
         [x,.,x,.,x,.,x,.,x,.,x,.,x],
         [.,x,.,x,.,x,.,x,.,x,.,x,.],
         [x,.,x,.,x,.,x,.,x,.,x,.,x],
         [.,.,.,x,.,x,.,x,.,x,.,.,.],
         [.,.,.,.,.,.,x,.,.,.,.,.,.]

      ]).



board2([
         [.,.,.,.,.,.,p,.,.,.,.,.,.],
         [.,.,.,e,.,m,.,v,.,a,.,.,.],
         [m,.,e,.,a,.,e,.,e,.,b,.,a],
         [.,v,.,p,.,b,.,m,.,v,.,m,.],
         [b,.,b,.,a,.,e,.,p,.,b,.,p],
         [.,p,.,v,.,m,.,v,.,a,.,b,.],
         [e,.,v,.,a,.,e,.,e,.,m,.,b],
         [.,.,.,m,.,p,.,a,.,p,.,.,.],
         [.,.,.,.,.,.,v,.,.,.,.,.,.]

      ]).


printBoard(Board) :-
        nl,write('-------------------------------------------------------'),nl,
        printRowByRow(Board,0), nl,
        write('-------------------------------------------------------'),nl,
        write(' | A | B | C | D | E | F | G | H | I | J | K | L | M | '),
        printBlackLine.

printBlackLine :-
        nl,
        write('-------------------------------------------------------'),
        nl.

printRowByRow([],9).
printRowByRow([Line|Rest], N) :-
        write(' | '),
        printSingleRow(Line, N),
        N1 is N+1,
        printRowByRow(Rest, N1).

printSingleRow([Cell], N):-
        write(Cell),
        write(' |      '),
        write(' | '),
        write(N),
        write(' | '),
        printBlackLine.

printSingleRow([Cell|More],N):-
        write(Cell),
        write(' | '),
        printSingleRow(More,N).


%-------------------------------------------------%
%      Cria tabuleiro com posicoes aleatorias
%-------------------------------------------------%


createBoard(Board, FinalBoard) :-
        Positions = [ [6,0], 
                     [3,1], [5,1], [7,1], [9,1], 
                     [0,2], [2,2], [4,2], [6,2], [8,2], [10,2], [12,2],
                     [1,3], [3,3], [5,3], [7,3], [9,3], [11,3],
                     [0,4], [2,4], [4,4], [6,4], [8,4], [10,4], [12,4],
                     [1,5], [3,5], [5,5], [7,5], [9,5], [11,5],
                     [0,6], [2,6], [4,6], [6,6], [8,6], [10,6], [12,6],
                     [3,7], [5,7], [7,7], [9,7], 
                     [6,8] 
                    ],
        createBoard(Board, FinalBoard ,Positions, 1,[e,e,e,e,e,e,e,e,
                                                      p,p,p,p,p,p,p,p,
                                                      m,m,m,m,m,m,m,m,
                                                      v,v,v,v,v,v,v,v,
                                                      a,a,a,a,a,a,a,a,
                                                      b,b,b,b,b,b,b,b]).


createBoard(Board, FinalBoard, [Head| _], 43, List) :-
        X = _,
        L = _,
        random_select(X,List,L),
        setPosition(Board, FinalBoard, Head, X).


createBoard(Board, FinalBoard, [Head| Tail], N, List) :-
        N1 is N+1,
        X = _,
        L = _,
        random_select(X,List,L),
        setPosition(Board, TabuleiroTemp, Head, X),
        createBoard(TabuleiroTemp, FinalBoard, Tail, N1, L).

setPosition(Board, FinalBoard, [X | Y], Cell) :-
        setPosition(Board, FinalBoard, X, Y, Cell).

setPosition(Board, FinalBoard,  X, [Y | _], Cell) :-
        setPosition(Board, FinalBoard,0, 0, X, Y, Cell).


setPosition([H | T], [H2 | T2], _, Y, XLimit, YLimit, Cell) :-
        Y == YLimit,
        Y1 is Y + 1,
        setLinePosition(H, H2, 0, XLimit, Cell),
        setPosition(T, T2, 0, Y1, XLimit, YLimit, Cell).

setPosition([H | T], [H2 | T2], _, Y, XLimit, YLimit, Cell) :-
        Y < 9,
        Y1 is Y + 1,
        H2 = H,
        setPosition(T, T2, 0, Y1, XLimit, YLimit, Cell).

setPosition(_, _, _, _, _, _, _).


setLinePosition([_ | T], [H2 | T2], X, XLimit, Cell) :-
        X == XLimit,
        X1 is X + 1,
        H2 = Cell ,  % [Casa | vazio]
        setLinePosition(T, T2, X1, XLimit, Cell).

setLinePosition([H | T], [H2 | T2], X, XLimit, Cell) :-
        X < 13,
        X1 is X + 1,
        H2 = H,
        setLinePosition(T, T2, X1, XLimit, Cell).

setLinePosition(_, _, _, _, _).

getPosition([H | T], _, Y, XLimit, YLimit, Cell) :-
        Y == YLimit,
        Y1 is Y + 1,
        getLinePosition(H, 0, XLimit, Cell),
        getPosition(T,0, Y1, XLimit, YLimit, Cell).

getPosition([H | T], _, Y, XLimit, YLimit, Cell) :-
        Y < 9,
        Y1 is Y + 1,
        getPosition(T, 0, Y1, XLimit, YLimit, Cell).

getPosition(_, _, _, _, _, _).


getLinePosition([H | T], X, XLimit, Cell) :-
        X == XLimit,
        X1 is X + 1,
        Cell = H ,  % [Casa | vazio]
        getLinePosition(T, X1, XLimit, Cell).

getLinePosition([H | T], X, XLimit, Cell) :-
        X < 13,
        X1 is X + 1,
        getLinePosition(T, X1, XLimit, Cell).

getLinePosition(_, _, _, _).

%---- para testar
%- colocaCasa(T, T2, [6,0], 5), board(T), printBoard(T2).
