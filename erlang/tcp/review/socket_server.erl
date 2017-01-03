-module(socket_server).
-export([start/0]).

start() -> 
	{ok,Listen} = gen_tcp:listen(9999,[binary,{packet,0},{active,true}]),
	seq_loop(Listen).

seq_loop(Listen) ->
	{ok,Socket} = gen_tcp:accept(Listen),
%	gen_tcp:close(Listen),
	loop(Socket),
	seq_loop(Listen).

loop(Socket) ->
	receive
		{tcp,Socket,Bin} ->
			io:format("recv binary:~p~n",[Bin]),
			Str = binary_to_term(Bin),
			io:format("trans str:~p~n", [Str]),
			gen_tcp:send(Socket, term_to_binary("receive finished!"));
		{tcp_closed,Socket} ->
			io:format("Server socket closed!~n")
	end.