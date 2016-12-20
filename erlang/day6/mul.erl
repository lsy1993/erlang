-module(mul).
-export([multab/0]).

multab() -> multab(1,1).
multab(9,9) -> io:format("~p*~p=~p\n",[9,9,9*9]);
multab(X,X) -> io:format("~p*~p=~p\n",[X,X,X*X]),multab(1,X+1);
multab(X,Y) -> io:format("~p*~p=~p   ",[X,Y,X*Y]),multab(X+1,Y).
    
