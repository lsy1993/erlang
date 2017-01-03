-module(socket_client).
-export([start/1]).

start(Str) ->
	{ok,Socket} = gen_tcp:connect(localhost,9999,[binary,{packet,0}]),
	ok = gen_tcp:send(Socket,term_to_binary(Str)),
	receive
		{tcp,Socket,Bin} ->
			io:format("client recv:~p~n",[Bin]),
			Val = binary_to_term(Bin),
			io:format("client trans:~p~n",[Val]),
			gen_tcp:close(Socket)
	end.