:-use_module(library(lists)).

startHvH:-
        %createBoard
        %initBoard
        play([none,none],[none,none],[ivory,blue,red,green,black]).

                    
play(P1,P2,Colors) :-
        clearScreen,
         %printBoard
        printPlayersColors(P1,P2),

        printPlayer1,
        moveMenu(Choice),
        (
                Choice == 1 -> write(1);
                Choice == 2 -> write(2);
                Choice == 3 -> colorsMenu(Idx), select(Idx,Colors,NewColors), write(NewColors);
                
                play(P1,P2,Colors)
                      
        ).


      