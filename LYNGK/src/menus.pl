:-include('utils.pl').

%%%%%%%%%%%%%%%%% Main Menu %%%%%%%%%%%%%%%%%%%

mainMenu :-
        clearScreen,
        printMainMenu,
        get_char(Option), 
        get_char(_),
        (
                Option = '1' -> write('Chose to play\n');
                Option = '2' -> write('Chose Info\n'),infoMenu;
                Option = '3' -> write('Exit\n');
        
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

%%%%%%%%%%%%%%%%% Info Menu %%%%%%%%%%%%%%%%%%%

infoMenu :-
        clearScreen,
        printInfoMenu,
        get_char(_),   
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


