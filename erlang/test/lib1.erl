-module(lib1).
-export([odds_and_events1/1]).

odds_and_events1(L) ->
	Odds = [X || X <- L, (X rem 2) =:= 1],
	Evens = [X || X <- L, (X rem 2) =:= 0],
	{Odds,Evens}. 