-module(area_server).
-export([start/0,loop/0,area/2]).

start() -> spawn(area_server, loop, []).

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
		{From, {rectangle, Width, Height}} ->
			From ! {self(),Width * Height},
			loop();
		{From, {circle, R}} ->
			From ! {self(),3.14 * R * R},
			loop();
		{From, Other} ->
			From ! {self(),{error, Other}},
			loop()
		end.