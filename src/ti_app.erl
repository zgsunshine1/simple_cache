%% @author guang
%% @doc @todo Add description to ti_app.


-module(ti_app).
-behaviour(application).
-export([start/2, stop/1]).
-define(DEFAULT_PORT,1155).
%% ====================================================================
%% API functions
%% ====================================================================
-export([]).



%% ====================================================================
%% Behavioural functions
%% ====================================================================

%% start/2
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/apps/kernel/application.html#Module:start-2">application:start/2</a>
-spec start(Type :: normal | {takeover, Node} | {failover, Node}, Args :: term()) ->
	{ok, Pid :: pid()}
	| {ok, Pid :: pid(), State :: term()}
	| {error, Reason :: term()}.
%% ====================================================================
start(Type, StartArgs) ->
	Port =case application:get_env(tcp_interface, port) of
			  {ok,p} -> p;
			  undefined ->?DEFAULT_PORT
		  end,
	{ok,LSock} = gen_tcp:listen(Port, [{active,true}]),
    case ti_sup:start_link(LSock) of
		{ok, Pid} ->
			{ok, Pid};
		Other ->
			{error,Other}
    end.

%% stop/1
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/apps/kernel/application.html#Module:stop-1">application:stop/1</a>
-spec stop(State :: term()) ->  Any :: term().
%% ====================================================================
stop(State) ->
    ok.

%% ====================================================================
%% Internal functions
%% ====================================================================


