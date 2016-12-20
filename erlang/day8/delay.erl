-module(delay).
-export([sleep/0]).

sleep() ->
	io:format("hello erlang~n"),
	receive
		after 1000 -> true
	end,
	sleep().
	
