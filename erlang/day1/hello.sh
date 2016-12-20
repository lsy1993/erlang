#!/bin/sh
erl -noshell -pa /home/dev/lsy/erlang/day1 \
	     -s hello start -s init stop
