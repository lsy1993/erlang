-module(socket_example).
-export([html_data/0]).

html_data() ->
	get_url("www.baidu.com").

get_url(Host) ->
	{ok, Socket} = gen_tcp:connect(Host,80,[binary,{packet,0}]),
	ok = gen_tcp:send(Socket, "GET / HTTP/1.0\r\n\r\n"),
	receive_data(Socket, []).

receive_data(Socket, SoFor) ->
	receive
		{tcp,Socket,Bin} ->
			receive_data(Socket, [SoFor | Bin]);
		{tcp_closed, Socket} ->
			%list_to_binary(SoFor)
			list_to_binary(lists:reverse(SoFor))
	end.