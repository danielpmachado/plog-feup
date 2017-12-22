:-use_module(library(clpfd)).
:-use_module(library(random)).

random_numbers([],0).
random_numbers([H|T],N):-
  random(1,8,H),
  N1 is N-1,
  random_numbers(T,N1).



generate(Option,Board,Size):-
  Option >0,
  Option <5,
  Size is Option+3,
  Total is Size*Size,
  N is floor(Size*0.7),
  Z is Total-N,
  length(Zeros,Z),
  domain(Zeros,0,0),
  labeling([],Zeros),
  random_numbers(Numbers,N),
  append(Zeros,Numbers,Tmp),
  random_permutation(Tmp,Board).

generate(_,_,_):-
  clear_screen,
  false.
