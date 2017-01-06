-module(my_bank_client).
-export([new_account/1,deposit/2,withdraw/2]).
-compile(export_all).
-define(module,my_bank_server).

new_account(Who)     -> gen_server:call(?module,{new,Who}).
deposit(Who,Amount)  -> gen_server:call(?module,{add,Who,Amount}).
withdraw(Who,Amount) -> gen_server:call(?module,{remove,Who,Amount}).

