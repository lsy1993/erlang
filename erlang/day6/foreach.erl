-module(foreach).
-export([for/3]).

for(M,M,F) -> io:format("~p~n", F(M));
for(I,M,F) ->
    io:format("~p ", F(I)), F(I+1,M,F). 
