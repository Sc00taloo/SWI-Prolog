readList(0, []).
readList(N, [X|List]) :-
    N > 0,
    read(X),
    N1 is N - 1,
    readList(N1, List).

findCountAB(List,A,B,Count):-findCountAB(List,A,B,0,Count).
findCountAB([],_,_,Count,Count):-!.
findCountAB([H|T],A,B,TruCount,Count):- A<B->((A=<H, H=<B)->(NewTruCount is TruCount+1, findCountAB(T,A,B,NewTruCount,Count));findCountAB(T,A,B,TruCount,Count));(B>A->findCountAB([H|T],B,A,TruCount,Count);(A=B,!,fail)) .

writeResult1(Counter) :-
    write("Count numbers in line A B: "),
    write(Counter).



findMinEl(List,Count):-findMinEl(List,List,9,0,Count).
findMinEl([],[],_,Count,Count):-!.
findMinEl([H|T],List,Min,TruCount,Count):- H=<Min-> (Min1 is H, findMinEl(T,List,Min1,TruCount,Count)); findMinEl(T,List,Min,TruCount,Count).
findMinEl([],[H|T],Min,TruCount,Count):- H=Min->(NewTruCount is TruCount+1, findMinEl([],T,Min,NewTruCount,Count)); findMinEl([],T,Min,TruCount,Count).

writeResult2(Counter) :-
    write("Count min el in array: "),
    write(Counter).


createList(List,NewList):-createList(List,NewList,NewList,_,_,0).
createList([],List,List,_,_,_):-!.
createList([H|T],List,TruList,Max,Ave,Count):- Count is 0 ->(Count1 is Count+1, length1([H|T],K), sum([H|T],Sum), max([H|T],Max), Ave is Sum div K,createList([H|T],List,[],Max,Ave,Count1));((H>Ave,H<Max)->(append(TruList,[H],TruList1), createList(T,List,TruList1,Max,Ave,Count));createList(T,List,TruList,Max,Ave,Count)).

length1([],0):-!.
length1([_|T], Cout) :- length(T,I), Cout is I + 1.

sum([],0):-!.
sum([H|T],Ave):- sum(T,Ave1), Ave is Ave1+H.

max([],0):-!.
max([H|T],Max):-max(T,Max1), (Max1<H->Max is H; Max is Max1).

writeResult3(List) :-
    write("New list: "),
    write(List).

avengerNotSimple(List,Ave):-avengerNotSimple(List,[],[],Ave,Ave).
avengerNotSimple([],ListSim,ListNSim,Ave,TruAve):-avengerNotSimple(ListSim,ListNSim,Ave,TruAve).
avengerNotSimple([H|T],ListSim,ListNSim,Ave,TruAve):-simple(H)->(append(ListSim,[H],ListSim1),avengerNotSimple(T,ListSim1,ListNSim,Ave,TruAve));(append(ListNSim, [H], ListNSim1), avengerNotSimple(T,ListSim,ListNSim1,Ave,TruAve)).

avengerNotSimple([H|T],ListNSim,Ave,TruAve):- length1([H|T],K), sum([H|T],Sum), AveSimple is Sum div K, avengerNotSimplee(ListNSim, AveSimple,Ave,TruAve,0,0).

avengerNotSimplee([],_,_,Ave,Sum,Count):-Ave is Sum div Count.
avengerNotSimplee([H|T],AveSimple,Ave,TruAve,Sum,Count):-H>AveSimple-> (Count1 is Count+1, TruAve1 is Sum+H,avengerNotSimplee(T,AveSimple,Ave,TruAve,TruAve1,Count1));avengerNotSimplee(T,AveSimple,Ave,TruAve,Sum,Count).

simple(1) :- !, fail.
simple(X) :- simple(X, 2).
simple(X, X) :- !.
simple(X, I) :- 0 =:= (X mod I), !, fail; I1 is I + 1, simple(X, I1), !.

writeResult4(Ave) :-
    write("Avenger not simple el: "),
    write(Ave).
