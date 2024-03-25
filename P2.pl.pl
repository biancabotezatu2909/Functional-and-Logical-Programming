%a) Write a predicate to determine if a list has even numbers of elements without
%  counting the elements from the list.

% verifyEven(l1l2...ln) =
% = true, if n = 0
% = false, if n = 1
% = verifyEven(l3...ln), otherwise

% verifyEven(L:list)
% (i)
% example: [1,2,3,4,5]
% first, the tail T is going to be [3,4,5]
% so it will replace the list with T => list = [3,4,5]
% then it will 'cut' the first 2 and so on until it will remain 1
% elelement [5]
% since neither  of the 2 facts are not true =>false
verifyEven([]).
verifyEven([_,_|T]):-verifyEven(T).

% b. Write a predicate to delete first occurrence of the minimum number from a list.

% min(a,b) = a , if a < b
%            b, otherwise
%if A is less than B => minimum = A
min(A,B,A):-
    A < B.
min(A,B,B):-
    A >= B.

% minList(l1l2...ln) = l1, if n = 1
%                      min(l1, minList(l2...ln)), otherwise

% minList(L:list,R:list)
% (i,o)
% base case: "if the list has only one element (itself) then the minimum
% is itself
% makes the minimum between the head and the minimum from the tail
minList([H],H).
minList([H|T],R1):-
    minList(T,R),
    min(H,R,R1).

% removeFirstOcc(l1l2...ln, elem) = [], if n = 0
%                                 = l2...ln, if l1 = elem
%                                 = removeFirstOcc(l2...ln, elem),
%                              otherwise

% removeFirstOcc(L:list, E:number, R:list)
% (i,i,o)
%base case = empty list
removeFirstOcc([],_,[]).
%if the head is the element to be removed, it will return the tail
removeFirstOcc([H|T],E,T):-
    H=:=E,!.
%if the element is not the head => we have to search it in the tail
removeFirstOcc([H|T],E,[H|R]):-
    removeFirstOcc(T,E,R).

% wrapper function
main(L,R):-
	minList(L,M),
    removeFirstOcc(L,M,R).




