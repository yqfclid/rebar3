-module(rebar_local_resource).

-behaviour(rebar_resource_v2).

-export([init/2
    ,lock/2
    ,download/4
    ,needs_update/2
    ,make_vsn/2]).

-spec init(atom(), rebar_state:t()) -> {ok, rebar_state:t()}.
init(_Dir, State) ->
    {ok, rebar_state:add_resource(State, {local, rebar_local_resource})}.

lock(_Dir, SourcePath) ->
    SourcePath.

needs_update(_Dir, {local, _SourcePath}) ->
    true.

download(Dir, {local, SourcePath}, _State, _) ->
    ok = rebar_file_utils:cp_r(filelib:wildcard(SourcePath ++ "/*"), Dir),
    {ok, undefined}.

make_vsn(_AppInfo, _Dir) ->
    {plain, "unused"}.