-module(sumnum).
-export([sum/1]).

sum(0) -> 0;
sum(X) ->
    X + sum(X - 1).
