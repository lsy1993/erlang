-module(var_server).
-export([start/0]).

start() ->
	{ok,Listen} = gen_tcp:listen(9999, [binary,{packet,0},{active,once}]),
	{ok,Socket} = gen_tcp:accept(Listen),
	loop(Socket).

loop(Socket) ->
	receive
		{tcp,Socket,Data} ->
			io:format("sever recv:~p~n",[binary_to_term(Data)]),
			inet:setopts(Socket, [active,once]),
			gen_tcp:send(Socket, term_to_binary("finished!")),
			loop(Socket);
		{tcp_closed,Socket} ->
			void
	end.