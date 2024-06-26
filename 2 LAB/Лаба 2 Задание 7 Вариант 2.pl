%Дан целочисленный массив и отрезок a..b. Необходимо найти количество
%элементов, значение которых принадлежит этому отрезку.

%предикат чтения readList1(+N,-[X|List]) - считывает N элементов и
%формирует список [X|List]. Данный предикат используется для всех
%заданий!
readList(0, []).
readList(N, [X|List]) :-
    N > 0,
    read(X),
    N1 is N - 1,
    readList(N1, List).

%предикат логики работы findCountAB(?List,+A,+B,?Count) - находит
%кол-во элементов в списке, которые попадают в отрезок A и B. Если A и
%B равно, то выдаст false
findCountAB(List,A,B,Count):-findCountAB(List,A,B,0,Count).
findCountAB([],_,_,Count,Count):-!.
findCountAB([H|T],A,B,TruCount,Count):- A<B->((A=<H, H=<B)->(NewTruCount is TruCount+1, findCountAB(T,A,B,NewTruCount,Count));findCountAB(T,A,B,TruCount,Count));(B>A->findCountAB([H|T],B,A,TruCount,Count);(A=B,!,fail)) .

%предикат вывода writeResult1(?Counter) - выводит кол-во элементов
%найденых на отрезке A и B
writeResult1(Counter) :-
    write("Count numbers in line A B: "),
    write(Counter).


%Дан целочисленный массив. Необходимо найти количество минимальных
%элементов.

%предикат логики работы findMinEl(?List,?Count) - находит кол-во
%минимальных элементов в списке List
findMinEl(List,Count):-findMinEl(List,List,9,0,Count).
findMinEl([],[],_,Count,Count):-!.
findMinEl([H|T],List,Min,TruCount,Count):- H=<Min-> (Min1 is H, findMinEl(T,List,Min1,TruCount,Count)); findMinEl(T,List,Min,TruCount,Count).
findMinEl([],[H|T],Min,TruCount,Count):- H=Min->(NewTruCount is TruCount+1, findMinEl([],T,Min,NewTruCount,Count)); findMinEl([],T,Min,TruCount,Count).

%предикат вывода writeResult2(?Counter) - выводи кол-во минимаьлных
%элементов, которые были найдены в предикате логики работы
writeResult2(Counter) :-
    write("Count min el in array: "),
    write(Counter).


%Для введенного списка построить новый с элементами, большими, чем среднее
%арифметическое списка, но меньшими, чем его максимальное значение.

%предикат логики работы createList(?List,?NewList) находит сначала
%среднее арифметическое списка, затем максимально значение, а потом
%сравнивает элементы старого списка, если элемент больше средне
%арифметического и меньше максимального, то записывает этот элемент в
%новый список
createList(List,NewList):-createList(List,NewList,NewList,_,_).
createList([H|T],TruList,_,Max,Ave):- length1([H|T],K), sum([H|T],Sum), max([H|T],Max), Ave is Sum div K,createListt([H|T],TruList,_,Max,Ave).

% предикат createListt(+[H|T],?List,?TruList,+Max,+Ave)
% продолжение предиката логики работы
createListt([],List,List,_,_):-!.
createListt([H|T],List,TruList,Max,Ave):-((H>Ave,H<Max)->(append(TruList,[H],TruList1), createListt(T,List,TruList1,Max,Ave));createListt(T,List,TruList,Max,Ave)).

%предикат length1(?List,?Cout) нужен для подсчёта кол-во элементов в
%списке
length1([],0):-!.
length1([_|T], Cout) :- length(T,I), Cout is I + 1.

%предикат sum(?List,?Ave) нужен для подсчёта суммы всех элементов списка
sum([],0):-!.
sum([H|T],Ave):- sum(T,Ave1), Ave is Ave1+H.

%предикат max(?List,?Max) нужен для нахождения максимального элемента в
%списке
max([],0):-!.
max([H|T],Max):-max(T,Max1), (Max1<H->Max is H; Max is Max1).

%предикат вывода writeResult3(?List) - выводит новый список, который
%был получен в предикате логики работы
writeResult3(List) :-
    write("New list: "),
    write(List).


%Для введенного списка посчитать среднее арифметическое непростых
%элементов,которые больше, чем среднее арифметическое простых.

%предикат логики работы avengerNotSimple(?List,?Ave) - сначала
%разбивает список List на простые и не простые числа. Затем считает
%среднее арифметическое простых чисел, а затем находит сумму простых
%элементов, которые больше средне арифметического числа простых
%элементов и считает их средне арифметическое непростых элементов
avengerNotSimple(List,Ave):-avengerNotSimple(List,[],[],Ave,Ave).
avengerNotSimple([],ListSim,ListNSim,Ave,TruAve):-avengerNotSimple(ListSim,ListNSim,Ave,TruAve).
avengerNotSimple([H|T],ListSim,ListNSim,Ave,TruAve):-simple(H)->(append(ListSim,[H],ListSim1),avengerNotSimple(T,ListSim1,ListNSim,Ave,TruAve));(append(ListNSim, [H], ListNSim1), avengerNotSimple(T,ListSim,ListNSim1,Ave,TruAve)).

avengerNotSimple([H|T],ListNSim,Ave,TruAve):- length1([H|T],K), sum([H|T],Sum), AveSimple is Sum div K, avengerNotSimplee(ListNSim, AveSimple,Ave,TruAve,0,0).

%предикат avengerNotSimplee(+List,+AveSimple,Ave,TruAve,-Sum,-Count)
%продолжение предиката логики работы
avengerNotSimplee([],_,_,Ave,Sum,Count):-Ave is Sum div Count.
avengerNotSimplee([H|T],AveSimple,Ave,TruAve,Sum,Count):-H>AveSimple-> (Count1 is Count+1, TruAve1 is Sum+H,avengerNotSimplee(T,AveSimple,Ave,TruAve,TruAve1,Count1));avengerNotSimplee(T,AveSimple,Ave,TruAve,Sum,Count).

%предикат simple(+X) проверяет число на простоту
simple(1) :- !, fail.
simple(X) :- simple(X, 2).
simple(X, X) :- !.
simple(X, I) :- 0 =:= (X mod I), !, fail; I1 is I + 1, simple(X, I1), !.

%предикат вывода writeResult4(?Ave) - выводит среднее арифметическое
%не простых элементов, который был получен в предикате логики работы
writeResult4(Ave) :-
    write("Avenger not simple el: "),
    write(Ave).

