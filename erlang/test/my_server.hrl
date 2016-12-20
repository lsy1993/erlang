-module(my_server). 
 
-record(server_opts, 
  {port, 
  ip="127.0.0.1", 
  max_connections=10}). 
