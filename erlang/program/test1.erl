    -module(test1).  
    -export([start/0]).  
      
    start() ->  
        Pid = spawn(fun() ->loop() end),  
        Pid2 = spawn(fun() ->loop_link(Pid) end),  
        io:format("Pid ~p~nPid2 ~p~n", [Pid,Pid2]).  
      
    loop_link(Pid) ->  
        process_flag(trap_exit, true),  
        erlang:link(Pid),  
        receive  
            Msg ->  
                io:format("pid exit: ~p~n", [Msg])  
        end.  
      
    loop() ->  
        process_flag(trap_exit, true),  
        receive  
            Msg ->  
                io:format("pid2 exit: ~p~n", [Msg])  
        end.  