-module(robot_client).
-export([ask/1,ask/2,ask/3]).
-compile(export_all).
-define(module,robot_server).

ask(Question) -> gen_server:call(?module,{Question}).
ask(Num1, Num2) -> gen_server:call(?module,{Num1,Num2}).
ask(Num1, Symbol, Num2) -> gen_server:call(?module,{Num1, Symbol, Num2}).
