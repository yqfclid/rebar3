-module(rebar_local_resource).

-behaviour(rebar_resource).

-export([init/1
    ,lock/2
    ,download/3
    ,needs_update/2
    ,make_vsn/1]).

-spec init(rebar_state:t()) -> {ok, rebar_state:t()}.
init(State) ->
    {ok, rebar_state:add_resource(State, {local, rebar_local_resource})}.

lock(_Dir, SourcePath) ->
    SourcePath.

needs_update(_Dir, {local, _SourcePath}) ->
    true.

download(Dir, {local, SourcePath}, _State) ->
    ok = rebar_file_utils:cp_r(filelib:wildcard(SourcePath ++ "/*"), Dir),
    {ok, undefined}.

make_vsn(_Dir) ->
    {plain, "unused"}.