-module(abc).
-compile(export_all).
-vsn(1.0).
%%-export([a/2,b/1]).

a(X,Y) -> c(X) + a(Y).
a(X) -> 2 * X.
b(X) -> X * X.
c(X) -> 3 * X.
