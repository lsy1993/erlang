-module(socket_seq_client).
-export([start_seq_client/0]).

start_seq_client() ->
	{ok,Socket} = gen_tcp:connect(localhost,9999,[binary,{packet,4}]),
	ok = gen_tcp:send(Socket, term_to_binary("hello erlang!")),
	receive
		{tcp,Socket,Bin} ->
			io:format("client_recv:~p~n",[Bin]),
			Val = binary_to_term(Bin),
			io:format("client_recv trans:~p~n",[Val]),
			gen_tcp:close(Socket)
	end.