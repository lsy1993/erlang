-module(robot1_client).
-export([ask/2]).

ask(Pid, Request) ->
	Pid ! {self(),Request},
	receive 
		{Pid,Reponse} ->
			Reponse
	end.
