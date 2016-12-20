-module(area_server1).
-export([loop/0,rpc/2]).

rpc(Pid, Request) ->
	Pid ! {self(), Request},
	receive
		{Pid,Response} ->
			Response
	end.

loop() ->
	receive
		{Form, {rectangle, Width, Height}} ->
			Form ! {self(),Width * Height},
			loop();
		{Form, {circle, R}} ->
			Form ! {self(),3.14159 * R * R},
			loop();
		{Form, Other} ->
			Form ! {self(),error, Other},
			loop()
	end.