-module(socket_parallel_server).
-export([start_parallel_server/0]).

start_parallel_server() ->
	{ok,Listen} = gen_tcp:listen(9999,[binary,{packet,4},{active,true}]),
	spawn(fun() -> par_connect(Listen) end).

par_connect(Listen) ->
	{ok,Socket} = gen_tcp:accept(Listen),
	spawn(fun() -> par_connect(Listen) end),
	loop(Socket).

loop(Socket) ->
	receive
		{tcp,Socket,Bin} ->
			io:format("server recv:~p~n",[Bin]),
			Result = binary_to_term(Bin),
			io:format("server transform recv:~p~n",[Result]),
			gen_tcp:send(Socket,term_to_binary("receive finished!~n")),
			loop(Socket);
		{tcp_closed,Socket} ->
			io:format("server socket closed!~n")
	end.
