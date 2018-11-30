all:
	rebar3 compile
debug:
	rebar3 as test shell
tar:
	rebar3 as prod release
	rebar3 as prod tar
run:
	rebar3 tar
	/Users/wenewzhang/Documents/sl/wk_exchange/_build/default/rel/wk_exchange/bin/wk_exchange console
