-module(passive_socket_server).
-export([start/0]).

start() ->
	{ok,Listen} = gen_tcp:listen(9999, [binary,{packet,0},{active,false}]),
	{ok,Socket} = gen_tcp:accept(Listen),
	loop(Socket).

loop(Socket) ->
	case gen_tcp:recv(Socket,0) of
		{ok,B} ->
			io:format("server recv:~p~n", [B]),
			Val = binary_to_term(B),
			io:format("trans recv:~p~n", [Val]),
			gen_tcp:send(Socket,term_to_binary("finished~n")),
			loop(Socket);
		{error, closed} ->
			io:format("server error closed!~n")
	end.
