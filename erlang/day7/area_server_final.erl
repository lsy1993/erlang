-module(area_server_final).
-export([start/0,area/2,loop/0]).

start() -> spawn(area_server_final, loop, []).

area(Pid, What) ->
	rpc(Pid, What).
rpc(Pid, Request) ->
	Pid ! {self(), Request},
	receive
		{Pid, Reponse} ->
			Reponse
	end.

loop() ->
	receive
		{Form, {rectangle, Width, Height}} ->
		Form ! {self(), Width * Height},
		loop();
		{Form, {circle, R}} ->
		Form ! {self(), 3.1415 * R * R},
		loop();
		{Form, Other} ->
			Form ! {self(), {error,Other}},
			loop()
	end.