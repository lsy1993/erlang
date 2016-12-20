-module(case1).
-export([filter/2]).

filter(P, [H | T]) ->
	case P(H) of
		true  -> [H | filter(P, T)];
		false -> filter(P, T)
	end.

