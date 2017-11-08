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


