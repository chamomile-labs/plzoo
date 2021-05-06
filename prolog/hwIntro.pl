%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% NB: Some of the below predicates fall into an infinite recursion    %
% after the first result. I tried to fix this with the 'cut' feature, %
% but to no avail. There are no meaningful results lost, ideally the  %
% predicates would just evaluate the first result and terminate.      %
% I will say that some of the predicates we defined in class (such as %
% find/3) also suffer from this ailment, so perhaps this is normal.   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%
% merge(?L1,?L2,?L3)
%
% merge/3 succeeds if L3 consists of the merged alternating elements
% of L1 and L2, where L1 and L2 are of the same length
%
merge([],[],[]).
merge([X|XS],[Y|YS],[X|[Y|Z]]) :-
  merge(XS,YS,Z).

%
% mergepad(?L1,?L2,?L3)
%
% mergepad/3 succeeds if L3 consists of the merged alternating elements
% of L1, and, L2 padded to the length of L1 with the first element of L1
%
%
mergepad([],_,[]).
mergepad([X|XS],YS,ZS) :-
  mergepadHelper([X|XS],YS,ZS,Pad),
  Pad is X.

%
% mergepadHelper(?L1,?L2,?L3,?Pad)
%
mergepadHelper([],[],[],_).
mergepadHelper([X|XS],[Y|YS],[X|[Y|Z]],Pad) :-
  mergepadHelper(XS,YS,Z,Pad).
mergepadHelper([X|XS],[],[X|[Pad|Z]],Pad) :-
  mergepadHelper(XS,[],Z,Pad).
mergepadHelper([],[Y|YS],[Pad|[Y|Z]],Pad) :-
  mergepadHelper([],YS,Z,Pad).

%
% legal(?L)
%
% legal/1 succeeds if list L has length at least 3, the second element
% of L is a list with length at most 2, and the first and third elements
% of L are the same
%
legal([A|[[]|[A|_]]]).
legal([A|[[_]|[A|_]]]).
legal([A|[[_|[_]]|[A|_]]]).

%
% keyRecord(+DB,?Record,?Key)
%
% keyRecord/3 succeeds if the structure rec(Key,Record)
% is in the database DB
%
keyRecord(DB,Record,Key) :-
  member(rec(Key,Record),DB).

%
% lafk(+L1,+Key,-L2)
%
% lafk/3 succeeds if L2 is a list containing all elements of L1 that occur
% after the final occurence of Key. Or, if Key is not in L1, lafk/3 suceeds
% if L2 is the empty list.
%
lafk(L1,Key,[]) :-
  not(member(Key,L1)).
lafk(L1,Key,L2) :-
  rev(L1,ReverseL1), % rev to get the _last_ instance of Key
  append(Left,[Key],Temp),
  append(Temp,_,ReverseL1),
  rev(Left,L2).

%
% lafk2(+L1,+Key,-L2)
%
% lafk2/3 succeeds if L2 is a list containing all elements of L1 that occur
% after the final occurence of Key. Or, if Key is not in L1, lafk2/3 suceeds
% if L2 is L1.
%
lafk2(L1,Key,L1) :-
  not(member(Key,L1)).
lafk2(L1,Key,L2) :-
  lafk(L1,Key,L2).

%
% Adapted from: Prolog, A Tutorial Introduction. By Lu & Mead.
% Example 5, Page 14
%
% rev(?L1,?L2)
%
% rev/2 succeeds if L2 consists of the elements of L1 in reverse order
%
rev([],[]).
rev([H|Tail],Result) :-
  rev(Tail,ReverseTail),
  append(ReverseTail,[H],Result).

%
% incSubseq(+L1,?L2)
%
% incSubseq/2 succeeds if L2 is a strictly increasing [contiguous]
% sublist of L1
%
incSubseq(L1,L2) :-
  sublist(L2,L1),
  inc(L2).

%
% inc(+L)
%
% inc/1 succeeds if the contents of L are in strictly increasing order
%
inc([_]).
inc([H1|[H2|Tail]]) :-
  H2 > H1,
  inc([H2|Tail]).

%
% sublist(+L1,+L2)
%
% sublist/2 succeeds if L1 is a [contiguous] sublist of L2
%
sublist([],_).
sublist(L1,L2)       :- prefix(L1,L2).
sublist(L1,[_|Tail]) :- sublist(L1,Tail).

%
% prefix(?L1, ?L2)
%
% prefix/2 succeeds if L1 is a prefix of L2.
%
prefix(L1,L2) :-
  append(L1,_,L2).

%
% hill(+L)
%
% hill/1 succeeds if L is a list of strictly increasing integers followed
% by strictly decreasing integers
%
hill([A|[B|C]]) :-
  B > A,
  hillHelper([B|C]).

%
% hillHelper(+L)
%
hillHelper([A|[B|C]]) :-
  B > A,
  hillHelper([B|C]).
hillHelper([A|[B|C]]) :-
  B < A,
  dec([B|C]).

%
% dec(+L)
%
% dec/1 succeeds if the contents of L are in strictly decreasing order
%
dec([_]).
dec([H1|[H2|Tail]]) :-
  H2 < H1,
  dec([H2|Tail]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% I thought I had a beautiful declarative solution to hill/1, but alas...  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% hill(L) :-                                                               %
%   incSubseq(L,Increasing),                                               %
%   append(Increasing,Rest,L),                                             %
%   decSubseq(L,Rest).                                                     %
% decSubseq(L1,L2) :-                                                      %
%   sublist(L2,L1),                                                        %
%   dec(L2).                                                               %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
