-module(robot1).
-export([start/0,ask/1]).


start() ->
	spawn(fun() -> restarter() end).

restarter() ->
	process_flag(trap_exit,true),
	Pid = spawn_link(fun() -> loop() end),
	register(tom, Pid),
	receive
		{'EXIT',Pid,normal} ->
			ok;
		{'EXIT',Pid,shutdown} ->
			ok;
		{'EXIT',Pid,_} ->
			restarter()
	end.

ask(Q) ->
	tom ! {self(),Q},
	Pid = whereis(tom),
	receive 
		{Pid,Reponse} ->
			if 
				is_binary(Reponse) -> io:format("~ts~n",[Reponse]);
				true -> Reponse
			end
	after 2000 ->
		timeout
	end.

loop() ->
	process_flag(trap_exit, true), 
	receive
		{From, name} -> 
			From ! {self(), <<"你好，我是机器人tom."/utf8>>  },	%%回答自己的名字
			loop();

		{From, {Num1, Symbol, Num2}} ->	%%四则运算部分
			From ! {self(), operator(Num1,Symbol,Num2)},
			loop();


		{From, time} ->
			From ! {self(),erlang:time()},
			loop();

		%{From, {multab,Num}} when is_integer(Num) ->
		%	From ! {self(),multab(Num)},
		%	loop();

		{From, {Num1, Num2}} when is_integer(Num1) andalso is_integer(Num2)-> 	%%求两个整数之间所有的整数和部分
			From ! {self(),sum_list(Num1, Num2, Num1)},
			loop();

		{From, _Other} -> 
			From ! {self(),"Sorry, I don't know."},
			loop();
		Msg ->
			Msg
	end.


%% ===================================================
%% ====            Internal Functions             ====
%% ===================================================
operator(Num1,Symbol,Num2) ->
	if 
		Symbol == '+' -> Num1+Num2;
		Symbol == '-' -> Num1-Num2;
		Symbol == '*' -> Num1*Num2;
		Symbol == '/' -> Num1/Num2
%%		case Num2 of
%%			0 -> "error!Cannot divide by 0,Num2 is 0.s";
%%			_ -> Num1/Num2
%%		end
	end.

%multab(Num) -> multab(1,1,Num).   %%打印九九乘法表部分
%multab(X,X,Num) -> 
%	if
%		X < Num -> io:format("~p*~p=~p~n",[X,X,X*X]),multab(1,X+1,Num);
%       X == Num -> io:format("~p*~p=~p~n",[X,X,X*X])
%    end;   
%multab(X,Y,Num) -> io:format("~p*~p=~p   ",[X,Y,X*Y]),multab(X+1,Y,Num).

%%sum_list(X,X+1) -> X;
sum_list(X,_N,_Y) when(_Y < _N) -> sum_list(X+_N,_N-1,_Y);
sum_list(X,_N,_Y) -> X.
