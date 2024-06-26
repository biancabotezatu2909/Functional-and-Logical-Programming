% a. Sort a list with removing the double values. E.g.: [4 2 6 2 3 4] --> [2 3 4 6]

% insert(l1l2...ln, p1p2...pm)  = p1p2...pm, if n = 0
%                               = {l1} U insert(l2...ln, p1p2...pm),
%                          otherwise

% insert(L:list,P:list,R:list)
% (i,i,o)
%
% If the first list L is empty, the result R is the second list P.
insert([],P,P).
% the result R is obtained by taking the first element of L and putting it at the beginning of the result list
insert([H|T],P,[H|R]):-
       insert(T,P,R).

% insertOk(l1l2...ln, elem) = {elem}, if n = 0
%                             l1l2...ln, if elem = l1
%                             {elem} U l1l2...ln, if elem < l1
%                             {l1} U insertOk(l2...ln, elem), otherwise

% insertOK(L:list, E:number, P:list)
% (i,i,o)

insertOK([],E,[E]).
insertOK([H|T],E,[H|T]):-
    H=:=E.
insertOK([H|T],E,RI):-
    E<H,
    insert([E],[H|T],RI).
%In simpler terms, it means that if E is greater than the current element in the list, the element E should be inserted later in the list, so the recursion continues with the tail of the list (T) until a suitable position for E is found.
insertOK([H|T],E,RI):-
    insert([H],R,RI),
    insertOK(T,E,R).

% sortare(l1l2...ln) =
% = [], if n = 0
% = insertOK(sortare(l2...ln), l1), otherwise

% sortare(L:list, R:list)
% (i,o)

sortare([],[]).
sortare([H|T],R1):-
    sortare(T,R),
    insertOK(R,H,R1).

%b. For a heterogeneous list, formed from integer numbers and list of numbers,
%   write a predicate to sort every sublist with removing the doubles.
%   Eg.: [1, 2, [4, 1, 4], 3, 6, [7, 10, 1, 3, 9], 5, [1, 1, 1], 7] =>
%        [1, 2, [1, 4], 3, 6, [1, 3, 7, 9, 10], 5, [1], 7].

% sortHetList(l1l2...ln) =
% = [], if n = 0
% = sortare(l1) U sortHetList(l1l2...ln), if l1 is a list
% = {l1} U sortHetList(l2...ln, l1), otherwise

% sortHetList(L:list, R:list)
% (i,o)

sortHetList([],[]).
sortHetList([H|T],[RS|R]):-
    is_list(H),
    !,
    sortare(H,RS),
    sortHetList(T,R).
sortHetList([H|T],[H|R]):-
    sortHetList(T,R).
