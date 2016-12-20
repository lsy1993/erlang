-module(hello).
-export([start/0]).

start() ->
	io:format("hello erlang~n").