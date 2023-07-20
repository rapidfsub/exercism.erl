-module(collatz_conjecture).

-export([steps/1]).

steps(N) when N > 1 ->
  case N rem 2 of
    0 ->
      steps(N div 2);
    _ ->
      steps(3 * N + 1)
  end
  + 1;
steps(1) ->
  0;
steps(_N) ->
  error(badarg).
