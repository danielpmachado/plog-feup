

start:- nl,nl,
  write('             || LYNGK ||                      '), nl,nl,
  write('                                              '), nl,
  write('   1 - Play: Human Versus Human               '), nl,
  write('   2 - Play: Human Versus Computer            '), nl,
  write('   3 - Play: Computer Versus Computer         '), nl,
  write('   4 - Exit                                   '), nl,nl,nl,nl,
  read(Option), get_char(_),
  selectCheck(Option).

selectCheck(1):- write('Option 1').
selectCheck(2):- write('Option 2').
selectCheck(3):- write('Option 3').
selectCheck(4):- abruptExit.
selectCheck(_)
        :- nl, write('Invalid option, must be a number between 1 and 5. Choose Again!'), nl, nl, false.

abruptExit :- 
        nl, write('---------------------------------------------------'), nl,
        write('Programme shutting down. Type ''start.'' to open again'),
        nl, write('---------------------------------------------------'),nl, nl, abort.
