-module(robot).
-export([ask/1]).

ask(name) -> io:format("~ts~n", ["你好，我是机器人tom."]);	%%回答自己的名字

ask({Num1, Symbol, Num2}) ->	%%四则运算部分
	case Symbol of
		'+' -> io:format("~p + ~p = ~p~n", [Num1,Num2,Num1+Num2]);
		'-' -> io:format("~p - ~p = ~p~n", [Num1,Num2,Num1-Num2]);
		'*' -> io:format("~p * ~p = ~p~n", [Num1,Num2,Num1*Num2]);
		'/' ->
		%%	if
		%%		Num2 == 0 -> io:format("error!Cannot divide by 0,Num2 is 0.~n");
		%%		true -> io:format("~p / ~p = ~p~n", [Num1,Num2,Num1/Num2])
		%%	end

			case Num2 of
				0 -> io:format("error!Cannot divide by 0,Num2 is 0.~n");
				_ -> io:format("~p / ~p = ~p~n", [Num1,Num2,Num1/Num2])
			end
		end; 

ask({Num1, Num2}) when is_integer(Num1) andalso is_integer(Num2)-> 	%%求两个整数之间所有的整数和部分
	sum_list(Num1, Num2, Num1)

ask(time) ->
	io:format("Current time ~p~n",[erlang:time()]);

ask({multab, Num}) when is_integer(Num) ->
	multab(Num);	

ask(_Other) -> io:format("Sorry, I don't know.~n").	


%% ===================================================
%% Internal Functions
%% ===================================================

%%sum_loop(Num2,Num2) -> Num2;
%%sum_loop(Num1,Num2) -> sum_loop(Num1 + 1, NUm2).

%%sum_list(Num1, Num2) ->
%%	if 
%%		_Num1 < _Num2 -> _Num1 + ask({_Num1+1,_Num2});
%%		_Num1 == _Num2 -> _Num1;
%%		_Num1 > _Num2 -> io:format("input error! Required conditions:Num1 =< Num2~n")
%%	end;

%%multab(print) -> multab(1,1).
%%multab(9,9) -> io:format("~p*~p=~p\n",[9,9,9*9]);			
multab(_Num) -> multab(1,1,_Num).%%打印九九乘法表部分
multab(X,X,_Num) when(X < _Num) ->
	io:format("~p*~p=~p\n",[X,X,X*X]),multab(1,X+1,_Num);
multab(X,X,_Num) -> io:format("~p*~p=~p\n",[X,X,X*X]);
multab(X,Y,_Num) -> io:format("~p*~p=~p   ",[X,Y,X*Y]),multab(X+1,Y,_Num).

sum_list(X,_N,_Y) when(_Y < _N) -> sum_list(X+_N,_N-1,_Y);
sum_list(X,_N,_Y) -> X.

 %<<"你好，我是机器人tom."/utf8>> 

