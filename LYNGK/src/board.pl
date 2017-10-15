board([   [.,.,x,.,x,.,x,.,.],
          [.,.,.,x,.,x,.,.,.],
          [.,.,x,.,x,.,x,.,.],
          [.,x,.,x,.,x,.,x,.],
          [.,.,x,.,x,.,x,.,.],
          [.,x,.,x,.,x,.,x,.],
          [x,.,x,.,x,.,x,.,x],
          [.,x,.,x,.,x,.,x,.],
          [.,.,x,.,x,.,x,.,.],
          [.,x,.,x,.,x,.,x,.],
          [.,.,x,.,x,.,x,.,.],
          [.,.,.,x,.,x,.,.,.],
          [.,.,x,.,x,.,x,.,.]   
      ]).

board2([  [.,.,e,.,p,.,a,.,.],
          [.,.,.,e,.,m,.,.,.],
          [.,.,v,.,m,.,p,.,.],
          [.,v,.,b,.,a,.,a,.],
          [.,.,p,.,m,.,v,.,.],
          [.,a,.,v,.,e,.,b,.],
          [m,.,p,.,a,.,e,.,m],
          [.,p,.,m,.,p,.,v,.],
          [.,.,e,.,m,.,a,.,.],
          [.,a,.,b,.,e,.,v,.],
          [.,.,m,.,e,.,p,.,.],
          [.,.,.,p,.,v,.,.,.],
          [.,.,e,.,v,.,a,.,.]   
      ]).

board3([  [.,.,e,.,p,.,a,.,.],
          [.,.,.,e,.,m,.,.,.],
          [.,.,v,.,[v,a,m],.,p,.,.],
          [.,v,.,b,.,x,.,a,.],
          [.,.,x,.,m,.,x,.,.],
          [.,a,.,[b,v],.,e,.,[v,b],.],
          [m,.,p,.,[b,a],.,x,.,m],
          [.,p,.,m,.,x,.,v,.],
          [.,.,e,.,x,.,a,.,.],
          [.,a,.,[m,b],.,e,.,v,.],
          [.,.,m,.,e,.,p,.,.],
          [.,.,.,[v,p],.,v,.,.,.],
          [.,.,e,.,x,.,a,.,.]   
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
        write('-------------------'),
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


