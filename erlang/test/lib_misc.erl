-module(lib_misc).
-export([filter/2,filter1/4]).

filter(P, [H | T]) -> filter1(P(H), H, P, T);
filter(P, [])	   -> [].

filter1(true, H, P, T)	-> [H | filter(P, T)];
filter1(false, H, P, T)	-> filter(P, T).