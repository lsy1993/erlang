-module(m1).
-export([loopl/1]).

-ifdef(debug_flag).
-define(DEBUG(X), io:format("DEBUG ~p:~p ~p~n", [?MODULE, ?LINE, X])).
-else.
-define(DEBUG(X), void).
-endif.

loopl(0) ->
    done;
loopl(N) ->
    ?DEBUG(N),
    loopl(N -1).
