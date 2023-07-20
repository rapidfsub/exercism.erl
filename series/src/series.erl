-module(series).

-export([slices/2]).

slices(SliceLength, Series) ->
  Length = length(Series),
  if Length < SliceLength ->
       error(badarg);
     true ->
       do_slices(Length - SliceLength + 1, SliceLength, Series)
  end.

do_slices(0, _SliceLength, _Series) ->
  [];
do_slices(Count, SliceLength, [_Head | Tail] = Series) ->
  [lists:sublist(Series, SliceLength) | do_slices(Count - 1, SliceLength, Tail)].
