-module(lib_misc).
-export([for/3]).

for(M,M,F) -> [F(M)];
for(I,M,F) ->
    [F(I) | for(I+1,M,F)]. 
