-module(user_default).
-compile(export_all).

hello() ->
    "hello world".

away(Time) ->
    io:format("Joe is away and will be back in ~w minutes~n",[Time]).
