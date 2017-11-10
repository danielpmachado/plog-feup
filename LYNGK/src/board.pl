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

%--------------------------------%
%         Criar tabuleiro        %
%--------------------------------%


createRandomBoard(board) :- board  =  _, createBoard(9, 13, B), setPositions(B, board).

createBoard('a', _, []) :- !.
createBoard(N, M, [K|Ks]) :-
    N1 is N - 1,
    createList(M, K),
    createBoard(N1, M, Ks).

createList('a', []) :- !.
createList(M, ['a'|Ks]) :-
    M1 is M - 1,
    createList(M1, Ks).

%---------------------------------------------------
%---------------------------------------------------
%---------------------------------------------------


createEmptyLine(_, M, M).

createEmptyLine([A|B], N, M) :-
        N < M,
        N1 is N + 1,
        A = 'a',
        createEmptyLine(B, N1, M).

createEmptyBoard(_, M, M).
createEmptyBoard([BoardHead | BoardTail], N, M) :-
        N >= 1,
        N1 is N - 1,
        createEmptyLine(BoardHead, 0, M),
        createEmptyBoard(BoardTail, N1, M).

%------------------------------------------%
%       Colocar posicoes no tabuleiro  %
%------------------------------------------%


setPositions(Tabuleiro, TabuleiroFinal) :-
        Posicoes = [ [6,0], 
                     [3,1], [5,1], [7,1], [9,1], 
                     [0,2], [2,2], [4,2], [6,2], [8,2], [10,2], [12,2],
                     [1,3], [3,3], [5,3], [7,3], [9,3], [11,3],
                     [0,4], [2,4], [4,4], [6,4], [8,4], [10,4], [12,4],
                     [1,5], [3,5], [5,5], [7,5], [9,5], [11,5],
                     [0,6], [2,6], [4,6], [6,6], [8,6], [10,6], [12,6],
                     [3,7], [5,7], [7,7], [9,7], 
                     [6,8] 
                    ],
        setPositions(Tabuleiro, TabuleiroFinal ,Posicoes, 1,[e,e,e,e,e,e,e,e,
                                                             p,p,p,p,p,p,p,p,
                                                             m,m,m,m,m,m,m,m,
                                                             v,v,v,v,v,v,v,v,
                                                             a,a,a,a,a,a,a,a,
                                                             b,b,b,b,b,b,b,b]).


setPositions(Tabuleiro, TabuleiroFinal, [Cabeca| _], 43, Lista) :-
        X = _,
        L = _,
        random_select(X,Lista,L),
        colocaCasa(Tabuleiro, TabuleiroFinal, Cabeca, X).


setPositions(Tabuleiro, TabuleiroFinal, [Cabeca| Cauda], N, Lista) :-
        N1 is N+1,
        X = _,
        L = _,
        random_select(X,Lista,L),
        colocaCasa(Tabuleiro, TabuleiroTemp, Cabeca, X),
        setPositions(TabuleiroTemp, TabuleiroFinal, Cauda, N1, L).

colocaCasa(Tabuleiro, Tabuleiro2, [X | Y], Casa) :-
        colocaCasa(Tabuleiro, Tabuleiro2, X, Y, Casa).

colocaCasa(Tabuleiro, TabuleiroResultante,  X, [Y | _], Casa) :-
        colocaCasa(Tabuleiro, TabuleiroResultante,0, 0, X, Y, Casa).


colocaCasa([H | T], [H2 | T2], _, Y, XLimite, YLimite, Casa) :-
        Y == YLimite,
        Y1 is Y + 1,
        colocaCasaEmLinha(H, H2, 0, XLimite, Casa),
        colocaCasa(T, T2, 0, Y1, XLimite, YLimite, Casa).

colocaCasa([H | T], [H2 | T2], _, Y, XLimite, YLimite, Casa) :-
        Y < 9,
        Y1 is Y + 1,
        H2 = H,
        colocaCasa(T, T2, 0, Y1, XLimite, YLimite, Casa).

colocaCasa(_, _, _, _, _, _, _).


colocaCasaEmLinha([_ | T], [H2 | T2], X, XLimite, Casa) :-
        X == XLimite,
        X1 is X + 1,
        H2 = Casa ,  % [Casa | vazio]
        colocaCasaEmLinha(T, T2, X1, XLimite, Casa).

colocaCasaEmLinha([H | T], [H2 | T2], X, XLimite, Casa) :-
        X < 13,
        X1 is X + 1,
        H2 = H,
        colocaCasaEmLinha(T, T2, X1, XLimite, Casa).

colocaCasaEmLinha(_, _, _, _, _).



%---- para testar
%- colocaCasa(T, T2, [6,0], 5), board(T), printBoard(T2).
