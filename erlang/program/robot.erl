-module(robot).
-export([ask/1]).

ask(name) -> io:format("~ts~n", ["你好，我是机器人tom."]);	%%回答自己的名字

ask({Num1, Symbol, Num2}) ->	%%四则运算部分
	case Symbol of
		'+' -> io:format("~p + ~p = ~p~n", [Num1,Num2,Num1+Num2]);
		'-' -> io:format("~p - ~p = ~p~n", [Num1,Num2,Num1-Num2]);
		'*' -> io:format("~p * ~p = ~p~n", [Num1,Num2,Num1*Num2]);
		'/' ->
			if
				Num2 == 0 -> io:format("error!Cannot divide by 0,Num2 is 0.~n");
				true -> io:format("~p / ~p = ~p~n", [Num1,Num2,Num1/Num2])
			end

			case Num2 of
				0 -> ok;
				_ -> ok2
			end
		end; 

ask({_Num1, _Num2}) when is_integer(_Num1) andalso is_integer(_Num2)-> 	%%求两个整数之间所有的整数和部分
	sum_list(Num1, Num2);

ask(time) ->
	io:format("Current time ~p~n",[erlang:time()]);

ask(multab, Num) when is_integer(Num) ->
	multab(Num, Num);	

ask(_Other) -> io:format("Sorry, I don't know.~n").	


%% ===================================================
%% Internal Functions
%% ===================================================

sum_list(Num1, Num2) ->
	if 
		_Num1 < _Num2 -> _Num1 + ask({_Num1+1,_Num2});
		_Num1 == _Num2 -> _Num1;
		_Num1 > _Num2 -> io:format("input error! Required conditions:Num1 =< Num2~n")
	end;

multab(print) -> multab(1,1).
multab(9,9) -> io:format("~p*~p=~p\n",[9,9,9*9]);			%%打印九九乘法表部分
multab(X,X) -> io:format("~p*~p=~p\n",[X,X,X*X]),multab(1,X+1);
multab(X,Y) -> io:format("~p*~p=~p   ",[X,Y,X*Y]),multab(X+1,Y).

