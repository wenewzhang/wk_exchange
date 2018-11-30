# An OTP application show you how to build erlang app on Mixin Network

## Required

* erlang www.erlang.org
* rebar3 https://github.com/erlang/rebar3

## Prepare 
* Mixin Network https://developers.mixin.one/dashboard  create app on Mixin Network then get client_id and client_secret

## Build steps
here suppose you install erlang and rebar3 correctly,
1.create the app
```
rebar3 new release wk_exchange
```
2.add inet,ssl support to OTP(for https access)
open wk_exchange.app.src add inets,ssl to applications block
3.define the const
```erlang
-define(CLIENT_ID,<<"21042518-85c7-4903-bb19-f311813d1f51">>).
-define(CLIENT_SECRET,<<"8cc112e77c25457e287b39c786b4e29edd2035a9deb2f658e17c99d56fdfb13a">>).
-define(SCOPE_PROFILE,<<"PROFILE:READ">>).
```
4.start the https request 
```erlang
    Oauth1 = io_lib:format(?MXN_OAUTH_STEP_ONE_URL,[?CLIENT_ID,?SCOPE_PROFILE]),
    case httpc:request(get,{Oauth1,[]},[{timeout,5000},{connect_timeout,10000}],[]) of
    {ok,{_,_,HttpData}} ->
      % {FirstJD} = JsonData,
      io:format("httpc_request_user_success:~s~n",[HttpData]),
      {ok, {{one_for_all, 0, 1}, []}};
    {error, Reason} ->
      io:format("Mixin network access error:~p~n",[Reason]),
      {ok, {{one_for_all, 0, 1}, []}}
    end.
 ```
 well done
