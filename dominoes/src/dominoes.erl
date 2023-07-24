-module(dominoes).

-export([can_chain/1]).

can_chain([]) ->
  true;
can_chain(Dominoes) ->
  Enumerate = lists:enumerate(0, Dominoes),
  DominoMap = maps:from_list(Enumerate),
  lists:foldl(fun({Index, Domino}, Acc) ->
                 Acc or can_chain(Domino, maps:remove(Index, DominoMap), [Domino])
              end,
              false,
              Enumerate).

can_chain({_, LastLower} = Last, Dominoes, [{FirstUpper, _} | _] = Chain) ->
  case map_size(Dominoes) of
    0 ->
      FirstUpper =:= LastLower;
    _ ->
      maps:fold(fun(Index, {Upper, Lower}, Acc) ->
                   NextDominoes = maps:remove(Index, Dominoes),
                   Acc
                   or if Lower =:= FirstUpper ->
                           can_chain(Last, NextDominoes, [{Upper, Lower} | Chain]);
                         true -> false
                      end
                   or if Upper =:= FirstUpper ->
                           can_chain(Last, NextDominoes, [{Lower, Upper} | Chain]);
                         true -> false
                      end
                end,
                false,
                Dominoes)
  end.
