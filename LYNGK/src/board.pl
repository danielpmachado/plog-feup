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


printBoard([L|Ls]) :-
        printLine(L), nl,
        printBoard(Ls).
printBoard([]) :-
        nl.

printLine([X|Xs]) :-
        write(X), write(' '),
        printLine(Xs).
printLine([]).

