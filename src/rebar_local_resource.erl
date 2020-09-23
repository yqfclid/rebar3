-module(rebar_local_resource).

-behaviour(rebar_resource_v2).

-export([init/2
    ,lock/2
    ,download/4
    ,needs_update/2
    ,make_vsn/2]).

-spec init(atom(), rebar_state:t()) -> {ok, rebar_state:t()}.
init(Type, _State) ->
    Resource = rebar_resource_v2:new(Type, ?MODULE, #{}),
    {ok, Resource}.

lock(_Dir, SourcePath) ->
    SourcePath.

needs_update(_Dir, {local, _SourcePath}) ->
    true.

download(Dir, AppInfo, _State, _) ->
    {local, SourcePath} = rebar_app_info:source(AppInfo),
    ok = rebar_file_utils:cp_r(filelib:wildcard(SourcePath ++ "/*"), Dir),
    ok.

make_vsn(_AppInfo, _Dir) ->
    {plain, "unused"}.