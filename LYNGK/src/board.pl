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


%printBoard([L|Ls]) :-
%        printLine(L), nl,
%        printBoard(Ls).
%printBoard([]) :-
%        nl.
%
%printLine([X|Xs]) :-
%        write(X), write(' '),
%        printLine(Xs).
%printLine([]).

printBoard(Board) :-
        printBlackLine,
        printRowByRow(Board),
        printBlackLine.

printBlackLine :-
        nl,
        write('---------------------------'),
        nl.

printRowByRow([]).
printRowByRow([Line|Rest]) :-
        write('|'),
        printSingleRow(Line),
        printRowByRow(Rest).

printSingleRow([Cell]):-
        write(Cell),
        write('|'),
        printBlackLine.

printSingleRow([Cell|More]):-
        write(Cell),
        write('|'),
        printSingleRow(More).

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
%       Colocar posições no tabuleiro      %
%------------------------------------------%


setPositions(Tabuleiro, TabuleiroFinal) :-
        Posicoes = [ [0,6], [4,1], [2,3] ],
        setPositions(Tabuleiro, TabuleiroFinal ,Posicoes, 1).


setPositions(Tabuleiro, TabuleiroFinal, [Cabeca| _], 3) :-
 
        colocaCasa(Tabuleiro, TabuleiroFinal, Cabeca, 5).
        

setPositions(Tabuleiro, TabuleiroFinal, [Cabeca| Cauda], N) :-
        N1 is N+1,
        colocaCasa(Tabuleiro, TabuleiroFinal, Cabeca, 5),
        setPositions(Tabuleiro, TabuleiroFinal, Cauda, N1).

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



