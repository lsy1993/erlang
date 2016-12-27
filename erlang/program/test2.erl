    -module(test2).  
      
    -export([start/0]).  
      
    start() ->  
        Pid = spawn(fun() ->loop() end),  
        Pid3 = spawn(fun() ->loop_monitor(Pid) end),  
        io:format("Pid ~p~nPid3 ~p~n", [Pid,Pid3]).  
          
    loop_monitor(Pid) ->  
        _MonitorRef = erlang:monitor(process, Pid),  
        receive  
            Msg ->  
                io:format("pid exit: ~p~n", [Msg])  
        end.  
      
    loop() ->  
        receive  
            Msg ->  
                io:format("pid3 exit: ~p~n", [Msg])  
        end.      