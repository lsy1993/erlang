-module(robot1_server).
-export([start/0,loop/0]).

start() -> spawn(robot1, loop, []). %%创建进程

loop() ->
	receive
		{From, name} -> 
			From ! {self(),io:format("~ts~n", ["你好，我是机器人tom."])},	%%回答自己的名字
			loop();

		{From, {Num1, Symbol, Num2}} ->	%%四则运算部分
			From ! {self(), operator(Num1,Symbol,Num2)},
			loop();


		{From, time} ->
			From ! {self(),io:format("Current time ~p~n",[erlang:time()])},
			loop();

		{From, {multab,Num}} when is_integer(Num) ->
			From ! {self(),multab(Num)},
			loop();

		{From, {Num1, Num2}} when is_integer(Num1) andalso is_integer(Num2)-> 	%%求两个整数之间所有的整数和部分
			From ! {self(),sum_list(Num1, Num2, Num1)},
			loop();

		{From, _Other} -> 
			From ! {self(),io:format("Sorry, I don't know.~n")},
			loop()
	end.


%% ===================================================
%% Internal Functions
%% ===================================================
operator(Num1,Symbol,Num2) ->
	if 
		Symbol == '+' -> io:format("~p + ~p = ~p~n", [Num1,Num2,Num1+Num2]);
		Symbol == '-' -> io:format("~p - ~p = ~p~n", [Num1,Num2,Num1-Num2]);
		Symbol == '*' -> io:format("~p * ~p = ~p~n", [Num1,Num2,Num1*Num2]);
		Symbol == '/' ->
		case Num2 of
			0 -> io:format("error!Cannot divide by 0,Num2 is 0.~n");
			_ -> io:format("~p / ~p = ~p~n", [Num1,Num2,Num1/Num2])
		end
	end.

multab(Num) -> multab(1,1,Num).   %%打印九九乘法表部分
multab(X,X,Num) -> 
	if
		X < Num -> io:format("~p*~p=~p\n",[X,X,X*X]),multab(1,X+1,Num);
        X == Num -> io:format("~p*~p=~p\n",[X,X,X*X])
    end;   
multab(X,Y,Num) -> io:format("~p*~p=~p   ",[X,Y,X*Y]),multab(X+1,Y,Num).

%%sum_list(X,X+1) -> X;
sum_list(X,_N,_Y) when(_Y < _N) -> sum_list(X+_N,_N-1,_Y);
sum_list(X,_N,_Y) -> X.
