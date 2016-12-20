-module(area_server).
-export([loop/0]).

loop() ->
	receive
		{Form,{rectangle,Width,Hight}} ->
			Form ! Width * Hight,
			loop();
		{Form,{square,Side}} ->
			Form ! Side * Side,
			loop()
	end.

