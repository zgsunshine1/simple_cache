%% @author guang
%% @doc @todo Add description to ti_sup.


-module(ti_sup).
-behaviour(supervisor).
-export([init/1]).

%% ====================================================================
%% API functions
%% ====================================================================
-export([start_link/1,start_child/0]).
-define{SERVER,?MODULE}.


%% ====================================================================
%% Behavioural functions
%% ====================================================================

%% init/1
%% ====================================================================
%% @doc <a href="http://www.erlang.org/doc/man/supervisor.html#Module:init-1">supervisor:init/1</a>
-spec init(Args :: term()) -> Result when
	Result :: {ok, {SupervisionPolicy, [ChildSpec]}} | ignore,
	SupervisionPolicy :: {RestartStrategy, MaxR :: non_neg_integer(), MaxT :: pos_integer()},
	RestartStrategy :: one_for_all
					 | one_for_one
					 | rest_for_one
					 | simple_one_for_one,
	ChildSpec :: {Id :: term(), StartFunc, RestartPolicy, Type :: worker | supervisor, Modules},
	StartFunc :: {M :: module(), F :: atom(), A :: [term()] | undefined},
	RestartPolicy :: permanent
				   | transient
				   | temporary,
	Modules :: [module()] | dynamic.
%% ====================================================================
init[LSock]) ->
    Server = {'AName',{'AModule',start_link,[]},
	      permanent,2000,worker,['AModule']},
    Children =[Server],
    Strategy = {one_for_all,0,1},
    {ok,{Strategy,Children}}.

%% ====================================================================
%% Internal functions
%% ====================================================================

start_link(LSock)->
	supervisor:start_link({local, ?SERVER},?MODULE,[LSock]).
start_child()->
	supervisor:start_child(?SERVER, []).
