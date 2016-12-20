-module(attrs).
-vsn(123.0).
-author({lsy, liu}).
-purpose("test").
-export([fac/1]).

fac(1) -> 1;
fac(N) -> N * fac(N - 1).