%%%-------------------------------------------------------------------
%% @doc wk_exchange top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(wk_exchange_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).
-define(CLIENT_ID,<<"21042518-85c7-4903-bb19-f311813d1f51">>).
-define(CLIENT_SECRET,<<"8cc112e77c25457e287b39c786b4e29edd2035a9deb2f658e17c99d56fdfb13a">>).
-define(SCOPE_PROFILE,<<"PROFILE:READ">>).
-define(MXN_OAUTH_STEP_ONE_URL,<<"https://mixin.one/oauth/authorize?client_id=~s&scope=~s">>).
%%====================================================================
%% API functions
%%====================================================================

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%%====================================================================
%% Supervisor callbacks
%%====================================================================

%% Child :: #{id => Id, start => {M, F, A}}
%% Optional keys are restart, shutdown, type, modules.
%% Before OTP 18 tuples must be used to specify a child. e.g.
%% Child :: {Id,StartFunc,Restart,Shutdown,Type,Modules}
init([]) ->
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

%%====================================================================
%% Internal functions
%%====================================================================
