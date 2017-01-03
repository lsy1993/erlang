-module(socket_seq_server).
-export([start_seq_server/0]).

start_seq_server() ->
	{ok,Listen} = gen_tcp:listen(9999,[binary,{packet,4},{active,true}]),
	seq_loop(Listen).
	
seq_loop(Listen) ->
	{ok,Socket} = gen_tcp:accept(Listen),
	loop(Socket),
	seq_loop(Listen).

loop(Socket) ->
	receive
		{tcp,Socket,Bin} ->
			io:format("recv:~p~n",[Bin]),
			Reply = binary_to_term(Bin),
			io:format("recv trans:~p~n",[Reply]),
			gen_tcp:send(Socket, term_to_binary("receive finished!"));
		{tcp_closed,Socket} ->
			io:format("Server Socket closed!~n")
	end.

