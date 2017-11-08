
printLines(N) :-
        N > 0,
        nl,
        N1 is N - 1,
        printLines(N1).
        
printLines(_).

clearScreen :-
        printLines(65).
