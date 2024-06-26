% 15.
% a. Define a predicate to determine the predecessor of a number represented as digits in a list.
%    Eg.: [1 9 3 6 0 0] => [1 9 3 5 9 9]


% myCarry(a,b,c) =
% = 1, if a - b - c < 0
% = 0, otherwise

% myCarry(A:number, B:number, C:number, R:number)
% (i,i,i,o)

myCarry(A,B,C,1):-
    A - B - C < 0,
    !.
myCarry(_,_,_,0).


% myDigit(a,b,c) =
% = 10 - b - c + a, if a - b - c < 0
% = a - b - c, otherwise

% myDigit(A:number, B:number, C:number, R:number)
% (i,i,i,o)
%

myDigit(A,B,C,R):-
    A - B - C < 0,
    !,
    R is 10 - B - C + A.
myDigit(A,B,C,R):-
	R is A - B - C.


% myAppend(l1l2...ln,e) =
% = [e], if n = 0
% = {l1} U myAppend(l2...ln), otherwise

% myAppend(L:list, E:number, R:list)
% (i,i,o)

myAppend([],E,[E]).
myAppend([H|T],E,[H|R]):-
    myAppend(T,E,R).

% myReverse(l1l2...ln) =
% = [], if n = 0
% = myAppend(myReverse(l2...ln),l1), otherwise

% myReverse(L:list, R:list)
% (i,o)

myReverse([],[]).
myReverse([H|T],NR):-
    myReverse(T,R),
    myAppend(R,H,NR).

% we assume that we can't obtain a negative result
% mySubtraction(l1l2...ln, p1p2...pm, c) =
% = r, if n = 0 and m = 0
% = mySubtraction([],[],c), if m = 0 and n = 1 and myDigit(l1,0,c) = 0
% = myDigit(l1,0,c) U mySubtraction(l2...ln, [], myCarry(l1,0,c)), if m = 0
% = myDigit(l1,p1,c) U mySubtraction(l2...ln, p2...pm, myCarry(l1,l2,c)), otherwise

% mySubtraction(L:list, P:list, C:number, R:list)
% (i,i,i,o)

%base case
mySubtraction([],[],_,[]).

%only one element/ the case that handles the last digit subtraction
mySubtraction([H],[],C,R):-
    myDigit(H,0,C,RD),
    RD =:= 0,
    mySubtraction([],[],C,R).

% this case is when the second list is empty (it means that the 1 has
% been subtracted) so the subtraction continues on the other digits,
% with or without a carry, depending on the case
mySubtraction([H|T],[],C,[RD|R]):-
    myDigit(H,0,C,RD),
    myCarry(H,0,C,RC),
    mySubtraction(T,[],RC,R).

%general case, when both lists are non-empty (when it first subtracts 1)
mySubtraction([H1|T1],[H2|T2],C,[RD|R]):-
    myDigit(H1,H2,C,RD),
    myCarry(H1,H2,C,RC),
    mySubtraction(T1,T2,RC,R).

predecessor(L,R,RR):-
    myReverse(L,RL),
    mySubtraction(RL,[1],0,R),
    myReverse(R,RR).


% b. For a heterogeneous list, formed from integer numbers and list of numbers,
%    define a predicate to determine the predecessor of the every sublist considered as numbers.
% Eg.: [1, [2, 3], 4, 5, [6, 7, 9], 10, 11, [1, 2, 0], 6] =>
%      [1, [2, 2], 4, 5, [6, 7, 8], 10, 11, [1, 1, 9] 6]

% heterList(l1l2...ln) =
% = [], if n = 0
% = predecessor(l1) U heterList(l2...ln), if l1 is a list
% = {l1} U heterList(l2...ln), otherwise

% heterList(L:list, R:list)
% (i,o)

heterList([],[]).
heterList([H|T],[RP|R]):-
    is_list(H),
    !,
    predecessor(H,_,RP),
    heterList(T,R).
heterList([H|T],[H|R]):-
    heterList(T,R).
