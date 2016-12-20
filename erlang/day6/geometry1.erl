-module(geometry1).
-export([area/1]).

area({circle, Radius}) ->
    io:format("circle area is ~p~n", [3.14*Radius*Radius]);
area({triangle, W, H}) ->
    io:format("triangle area is ~p~n", [W*H]).
