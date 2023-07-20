-module(custom_set).

-record(set, {bits}).

-export([add/2, contains/2, difference/2, disjoint/2, empty/1, equal/2, from_list/1,
         intersection/2, subset/2, union/2, to_bit/1]).

add(Elem, #set{bits = Bits}) ->
  #set{bits = Bits bor to_bit(Elem)}.

to_bit(Elem) when is_integer(Elem) and (Elem >= 0) ->
  trunc(math:pow(2, Elem)).

contains(Elem, #set{bits = Bits}) ->
  Bits band to_bit(Elem) > 0.

difference(#set{bits = Bits1}, #set{bits = Bits2}) ->
  #set{bits = Bits1 band (Bits1 bxor Bits2)}.

disjoint(Set1, Set2) ->
  empty(intersection(Set1, Set2)).

empty(#set{bits = Bits}) ->
  Bits == 0.

equal(#set{bits = Bits1}, #set{bits = Bits2}) ->
  Bits1 == Bits2.

from_list(List) ->
  Elems = lists:map(fun(Elem) -> to_bit(Elem) end, List),
  #set{bits = lists:foldl(fun(Elem, Acc) -> Acc bor Elem end, 0, Elems)}.

intersection(#set{bits = Bits1}, #set{bits = Bits2}) ->
  #set{bits = Bits1 band Bits2}.

subset(Set1, Set2) ->
  equal(Set1, intersection(Set1, Set2)).

union(#set{bits = Bits1}, #set{bits = Bits2}) ->
  #set{bits = Bits1 bor Bits2}.
