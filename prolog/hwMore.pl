%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   ____        __
%  / __ \      /_ |
% | |  | |      | |
% | |  | |      | |
% | |__| |  _   | |
%  \___\_\ (_)  |_|
%
% wolf goat cabbage farmer puzzle
%
% problem: transfer w, g, c, f from east to west bank of river using a
% boat with capacity f + 1 object
% constraints: wolf eats goat, goat eats cabbage (unless the farmer is
% there)
%
% represent state of puzzle:
%   [f,w,g,c] where each can be either e or w (east or west bank)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Represent unsafe states
unsafe([B1,B2,B2,_]) :- B1 \= B2.
unsafe([B1,_,B2,B2]) :- B1 \= B2.

% Represent state transitions (and puzzle)
solve(Path) :- move([e,e,e,e],[w,w,w,w],[],Path).

move(State1,State2,_,[State2]) :-
  moveone(State1,State2), !.
move(State1,State2,Visited,[State3|Path]) :-
  moveone(State1,State3),
  not(member(State3,Visited)),
  not(unsafe(State3)),
  move(State3,State2,[State3|Visited],Path).

moveone([B,B,Bg,Bc],[B2,B2,Bg,Bc]) :- otherbank(B,B2). % move wolf
moveone([B,Bw,B,Bc],[B2,Bw,B2,Bc]) :- otherbank(B,B2). % move goat
moveone([B,Bw,Bg,B],[B2,Bw,Bg,B2]) :- otherbank(B,B2). % move cabbage
moveone([B,Bw,Bg,Bc],[B2,Bw,Bg,Bc]) :- otherbank(B,B2). % move self only

otherbank(e,w).
otherbank(w,e).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   ____        ___
%  / __ \      |__ \
% | |  | |        ) |
% | |  | |       / /
% | |__| |  _   / /_
%  \___\_\ (_) |____|
%
% f(0) = f(1) = f(2) = 1
% f(n) = f(n-2) + 2f(n-3), for n>2
%
% +----+---------------+---------------+
% | N  | f1 inferences | f2 inferences |
% +----+---------------+---------------+
% | 2  | 0             | 0             |
% | 3  | 4             | 3             |
% | 4  | 4             | 6             |
% | 5  | 8             | 9             |
% | 6  | 12            | 12            |
% | 8  | 24            | 19            |
% | 10 | 44            | 24            |
% | 15 | 192           | 39            |
% | 20 | 796           | 54            |
% | 25 | 3,260         | 69            |
% | 30 | 13,312        | 84            |
% | 40 | 221,616       | 114           |
% | 45 | 904,116       | 129           |
% | 50 | 3,688,440     | 144           |
% +----+---------------+---------------+
%
% Based on these profiling results, f2 is clearly more efficient
% (no surprise). f1 follows the pattern of most exponentially growing
% functions -- the number of inferences starts as smaller than f2 but
% quickly overtakes it, compounding on itself. So, f1 has a time
% complexity of O(2^N). f2 on the other hand does not experience any
% significant increase in inferences as N increases, rather the number
% of inferences seems to grow in direction proportion with N
% (multiplied by a constant factor somewhere between 2 and 3 ish). f2
% has a time complexity of O(N). f1 begins to be infeasible with N > 45,
% while f2 chugs along happily with N up to 99999 and up.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% f1(+N,?X)
%
% f1/2 succeeds if X is the Nth value of the recurrence relation f1
%
f1(0,1).
f1(1,1).
f1(2,1).
f1(N,X) :-
  N>2,
  Prev1 is N-2,
  Prev2 is N-3,
  f1(Prev1, A),
  f1(Prev2, B),
  X is A + (B * 2).

%
% f2(+N,?X)
%
% f2/2 succeeds if X is the Nth value of the recurrence relation f2
%
f2(0,1).
f2(1,1).
f2(2,1).
f2(N,X) :-
  N>1,
  f2(N,X,1,1,1).
f2(3,X,_,Acc2,Acc3) :-
  X is Acc2 + (2 * Acc3).
f2(N,X,Acc1,Acc2,Acc3) :-
  N>3,
  Temp is Acc2 + (2 * Acc3),
  Prev is N-1,
  f2(Prev,X,Temp,Acc1,Acc2).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   ____        ____
%  / __ \      |___ \
% | |  | |       __) |
% | |  | |      |__ <
% | |__| |  _   ___) |
%  \___\_\ (_) |____/
%
% NB: For some predicates, I chose to base some rules arbitrarily on
% the father. There are times where either a mother or father will fulfill
% the constraint, and listing both as separate rules (like an 'or') yields
% duplicate results when querying with variables. A simple example of this
% is the sibling/2 predicate -- P1 and P2 are siblings if they share a
% parent; in this world with no step-parents it is enough to establish that
% they share any one parent, which may be the father or mother. I have
% arbitrarily chosen to only check for a father, rather than only a mother.
% The corollary of this is that people in the family database must not only
% have a mother listed, as then the predicates in question will not detect
% them as [siblings, etc].
%
% Here are the rules I removed that also checked mothers:
%
% nthGrandparent(Person,1,Grandparent) :-
%   father(F,Person), mother(Grandparent,F).
% nthGrandparent(Person,1,Grandparent) :-
%   mother(M,Person), mother(Grandparent,M).
%
% nthGrandparent(Person,N,Grandparent) :-
%   N>1,
%   mother(M,Person),
%   N2 is N-1,
%   nthGrandparent(M,N2,Grandparent).
%
% sibling(Person1,Person2) :-
%   mother(M1,Person1),
%   mother(M2,Person2),
%   M1 == M2,
%   Person1 \= Person2.
%
% onlyChild(Person) :-
%   mother(Mother,Person),
%   findall(Kid,mother(Mother,Kid),Kids),
%   singleElement(Kids).
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

father(yulian,yasha).    father(yulian,zhenya).  father(taurus,marina).
father(zhenya,fyodor).   father(zhenya,yefim).   father(fyodor,alyosha).
father(fyodor,sasha).    father(fyodor,inna).    father(yefim,masha).
father(yefim,katya).     father(yuri,liza).      father(edik,sveta).
father(edik,yulia).      father(dima,aronchik).  father(sasha,evan).
father(yasha,vovik).     father(vovik,murzik).   father(vasya,dima).
mother(karina,yasha).    mother(karina,zhenya).  mother(fabrice,marina).
mother(marina,fyodor).   mother(marina,yefim).   mother(natasha,masha).
mother(natasha,katya).   mother(liza,sveta).     mother(liza,yulia).
mother(sveta,alyosha).   mother(sveta,sasha).    mother(sveta,inna).
mother(yulia,aronchik).  mother(ira,evan).       mother(katya,dima).
mother(musya,murzik).

%
% onlyChild(?Person)
%
% onlyChild/1 succeeds if Person is an only child.
onlyChild(Person) :-
  father(Father,Person),
  findall(Kid,father(Father,Kid),Kids),
  singleElement(Kids).
singleElement([_]).

%
% cousin(?Person,+N,+M,?Cousin)
%
% cousin/4 succeeds if Cousin is Person's Nth cousin M removed.
%
cousin(Person,N,0,Cousin) :- nthCousin(Person,N,Cousin).
cousin(Person,N,1,Cousin) :- father(F,Person), nthCousin(F,N,Cousin).
cousin(Person,N,1,Cousin) :- mother(M,Person), nthCousin(M,N,Cousin).
cousin(Person,N,M,Cousin) :-
  M>1,
  father(F,Person),
  M2 is M-1,
  cousin(F,N,M2,Cousin).
cousin(Person,N,M,Cousin) :-
  M>1,
  mother(Mother,Person),
  M2 is M-1,
  cousin(Mother,N,M2,Cousin).

%
% nthCousin(?Person,+N,?Cousin)
%
% nthCousin/3 succeeds if Cousin is Person's Nth cousin
%
nthCousin(Person,N,Cousin) :-
  nthGrandparent(Person,N,G),
  nthGrandparent(Cousin,N,G),
  not(sibling(Person,Cousin)),
  N2 is N-1,
  not(nthCousin(Person,N2,Cousin)),
  Person \= Cousin.

%
% sibling(?Person1,?Person2)
%
% sibling/2 succeeds if Person1 and Person2 share a parent
%
sibling(Person1,Person2) :-
  father(F1,Person1),
  father(F2,Person2),
  F1 == F2,
  Person1 \= Person2.

%
% nthGrandparent(?Person,+N,?Grandparent)
%
% nthGrandparent/3 succeeds if Grandparent is Person's Nth grandparent
%
nthGrandparent(Person,1,Grandparent) :-
  father(F,Person), father(Grandparent,F).
nthGrandparent(Person,1,Grandparent) :-
  mother(M,Person), father(Grandparent,M).
nthGrandparent(Person,N,Grandparent) :-
  N>1,
  father(F,Person),
  N2 is N-1,
  nthGrandparent(F,N2,Grandparent).

%
% cousins(?Person,?Cousins)
%
% cousins/2 succeeds if Cousins is the list of all first cousins
% (not removed) of Person.
%
cousins(Person,Cousins) :-
  setof(Cousin,nthCousin(Person,1,Cousin),Cousins).

%
% grandparent(?People)
%
% grandparent/1 succeeds if People is a list of every person
% who is a grandparent.
%
grandparent(People) :-
  findall(Person,nthGrandparent(_,1,Person),Temp),
  unique(Temp,People).

%
% unique(+List,?UniqueList)
%
% unique/2 succeeds if UniqueList is the set of elements in List with no
% duplicates
%
unique([],[]).
unique([X],[X]).
unique([A,B|List],Result) :-
  uniqueHelper([A,B|List],Result,[]).
uniqueHelper([],Accum,Accum).
uniqueHelper([H|Tail],Result,Accum) :-
  not(member(H,Accum)),
  uniqueHelper(Tail,Result,[H|Accum]).
uniqueHelper([H|Tail],Result,Accum) :-
  member(H,Accum),
  uniqueHelper(Tail,Result,Accum).

