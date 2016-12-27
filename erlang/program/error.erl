-module(error).
-export([keep_alive/0,on_exit/2,rpc/2]).

keep_alive() ->
	register(tom, Pid = spawn(fun() -> loop() end)),
	on_exit(Pid, fun(_Why) -> keep_alive() end).

on_exit(Pid, Fun) ->
	spawn(fun() ->
		Ref = monitor(process, Pid),
		receive
			{'Down',Ref,process,Pid,_Why} ->
				Fun(_Why)
		end
	end).

rpc(tom, Ask) ->
	tom ! {self(),Ask},
	receive 
		{tom,Reponse} ->
			Reponse
	end.

loop() ->
	receive
		{From, {Num1, Symbol, Num2}} ->	%%四则运算部分
			From ! {tom, operator(Num1,Symbol,Num2)},
			loop()
	end.

operator(Num1,Symbol,Num2) ->
	if 
		Symbol == '+' -> Num1+Num2;
		Symbol == '-' -> Num1-Num2;
		Symbol == '*' -> Num1*Num2;
		Symbol == '/' -> Num1/Num2
	end.

