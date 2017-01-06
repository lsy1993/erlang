-module(robot).
-behaviour(gen_server).
-export([start/0]).
-export([init/1,handle_call/3,handle_cast/2,handle_info/2,terminate/2,code_change/3]).
-compile(export_all).
-define(SERVER, ?MODULE).

start() -> gen_server:start_link({local,?SERVER},?MODULE,[],[]).
stop() 	-> gen_server:call(?MODULE, stop).

ask(Question) 			-> gen_server:call(?MODULE,{Question}).
ask(Num1, Num2) 		-> gen_server:call(?MODULE,{Num1,Num2}).
ask(Num1, Symbol, Num2) -> gen_server:call(?MODULE,{Num1, Symbol, Num2}).


init([]) -> {ok, normal}.

handle_call({Question},_From,State) ->
	Reply = case Question of
			name -> "Hello, my name is tom.";
			time -> erlang:time();
			_ -> "Sorry,I don't know"	
			end,
	{reply,Reply,State};

handle_call({Num1,Symbol,Num2},_From,State) ->
	Reply = case Symbol of
			'+' -> Num1+Num2;
			'-' -> Num1-Num2;
			'*' -> Num1*Num2;
			'/' ->  
				if			
					Num2 == 0 -> "error!Cannot divide by 0,Num2 is 0.";
					true -> Num1/Num2
				end
			end,
	{reply,Reply,State};

handle_call({Num1,Num2},_From,State) ->
	Reply = case Num1 =< Num2 of
			true when is_integer(Num1) andalso is_integer(Num2)-> 	%%求两个整数之间所有的整数和部分
				sum_list(Num1, Num2, Num1);
			_ -> "Do not meet the conditions"
			end,
	{reply,Reply,State};

handle_call(stop,_From,State) 	  -> {stop,normal,stopped,State}.
handle_cast(_Msg,State)		 	  -> {noreply,State}.
handle_info(_Info,State)  	 	  -> {noreply,State}.
code_change(_OldVsn,State,_Extra) -> {ok,State}.
terminate(_Reason,_State) 	 	  -> ok.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sum_list(X,_N,_Y) when(_Y < _N) -> sum_list(X+_N,_N-1,_Y);
sum_list(X,_N,_Y) -> X.