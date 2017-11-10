:-include('utils.pl').


%%%%%%%%%%%%%%%%% Main Menu %%%%%%%%%%%%%%%%%%%

mainMenu :-
        clearScreen,
        printMainMenu,
        read(Option),
        (
                Option = 1 -> playMenu;
                Option = 2 -> infoMenu;
                Option = 3 -> halt;

                mainMenu
        ).


printMainMenu :-
        write('========================================\n'),
        write('==                LYNGK               ==\n'),
        write('========================================\n'),
        write('==                                    ==\n'),
        write('==             1 - Play               ==\n'),
        write('==             2 - Info               ==\n'),
        write('==             3 - Exit               ==\n'),
        write('==                                    ==\n'),
        write('========================================\n').

%%%%%%%%%%%%%%%%% Play Menu %%%%%%%%%%%%%%%%%%%

playMenu :-
        clearScreen,
        printPlayMenu,
        read(Option),
        (
                Option = 1 -> startHvH;
                Option = 2 -> playMenu;
                Option = 3 -> playMenu;
                Option = 4 -> mainMenu;

                playMenu
        ).

printPlayMenu :-
        write('=================================================================\n'),
        write('==                LYNGK - Choose the type of game              ==\n'),
        write('==                        you wish to play                     ==\n'),
        write('=================================================================\n'),
        write('==                                                             ==\n'),
        write('==                   1 - Human vs Human                        ==\n'),
        write('==                   2 - Human vs PC                           ==\n'),
        write('==                   3 - PC vs PC                              ==\n'),
        write('==                   4 - Go back                               ==\n'),
        write('==                                                             ==\n'),
        write('=================================================================\n').

%%%%%%%%%%%%%%%%% Info Menu %%%%%%%%%%%%%%%%%%%

infoMenu :-
        clearScreen,
        printInfoMenu,
        read(_),
        mainMenu.

printInfoMenu :-
        write('======================================================================\n'),
        write('==                           LYNGK - Info                           ==\n'),
        write('======================================================================\n'),
        write('==                                                                  ==\n'),
        write('==  This is a project done in the subject of Logical Programming    ==\n'),
        write('==  at MIEIC course in FEUP.                                        ==\n'),
        write('==                                                                  ==\n'),
        write('==           Authors:                                               ==\n'),
        write('==                      Daniel Machado - 201506365                  ==\n'),
        write('==                      Sofia Alves    - 201504570                  ==\n'),
        write('==                                                                  ==\n'),
        write('======================================================================\n').


%%%%%%%%%%%%%%%%% Players %%%%%%%%%%%%%%%%%%%

printPlayer1 :-
        printLines(2),
        write('=================================================================\n'),
        write('==                        PLAYER 1`s turn                      ==\n'),
        write('=================================================================\n').


printPlayer2 :-
        printLines(2),
        write('=================================================================\n'),
        write('==                        PLAYER 2`s turn                      ==\n'),
        write('=================================================================\n').

%%%%%%%%%%%%%%%%% Colors %%%%%%%%%%%%%%%%%%%

printPlayersColors([C11,C12],[C21,C22]) :-
        write(' Claimed Colors\n'),
        write(' -> Player 1: '), write(C11), write(' - '), write(C12), nl,
        write(' -> Player 2: '), write(C21), write(' - '), write(C22), nl.

colorsMenu(Idx):-
        printColorsMenu,
        read(Option),
        (
                Option = 1 -> Idx = ivory;
                Option = 2 -> Idx = blue;
                Option = 3 -> Idx = red;
                Option = 4 -> Idx = green;
                Option = 5 -> Idx = black;
                Option = 6 -> Idx = exit;

                colorsMenu(Idx)
        ).

printColorsMenu:-
        write(' Claim Color            \n'),
        write('   1 - Ivory            \n'),
        write('   2 - Blue             \n'),
        write('   3 - Red              \n'),
        write('   4 - Green            \n'),
        write('   5 - Black            \n'),
        write('   6 - Go back          \n').


%%%%%%%%%%%%%%%%% Move Menu %%%%%%%%%%%%%%%%%%

moveMenu(MoveType) :-
        printMoveMenu,
        read(Option)
        (
                Option = 1 -> MoveType is 1;
                Option = 2 -> MoveType is 2;
                Option = 3 -> MoveType is 3;
                Option = 4 -> halt

        ).

printMoveMenu :-
        write(' Choose your move       \n'),
        write('   1 - Normal           \n'),
        write('   2 - LYNGK            \n'),
        write('   3 - Claim Color      \n'),
        write('   4 - Exit             \n'),
        write('                        \n').
