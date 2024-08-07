%Дан целочисленный массив. Необходимонайти индекс минимального элемента.

%предикат чтения readList1(+N,-[X|List]) - считывает N элементов и
%формирует список [X|List]. Данный предикат используется для всех
%заданий!
readList1(0, []).
readList1(N, [X|List]) :-
    N > 0,
    read(X),
    N1 is N - 1,
    readList1(N1, List).

%предикат логики работы findMinIndex(?[X|Xs],?Index) - находит
%индекс минимального элемента в списке [X|Xs].
findMinIndex([X|Xs], Index) :- minListIndex(Xs, X, 0, 0, Index).

minListIndex([], _, _, Index, Index).
minListIndex([X|Xs], Min, CurrentIndex, TruIndex, Index) :-
    X =< Min,
    NewCurrentIndex is CurrentIndex + 1,
    NewIndex is CurrentIndex + 1,
    minListIndex(Xs, X, NewCurrentIndex, NewIndex, Index).
minListIndex([X|Xs], Min, CurrentIndex, TruIndex, Index) :-
    X > Min,
    NewCurrentIndex is CurrentIndex + 1,
    minListIndex(Xs, Min, NewCurrentIndex, TruIndex, Index).

%предикат вывода writeResult(?MinIndex) - выводит найденный индекс
%минимального элемента.
writeResult1(MinIndex) :-
    write("Index of the minimum element is: "),
    write(MinIndex).


%Дан целочисленный массив. Необходимо найти два наименьших элемента.

%предикат логики работы findTwoMinNum(?List,-Num1,-Num2) - находит 2
%минимальных элемента в списке List.
findTwoMinNum(List,Num1,Num2):- min_list(List, Num1),
    select(Num1,List,NewList), min_list(NewList,Num2),!.

min_list([H|T], Min):-min_list(T, H, Min).
  min_list([], _):- fail.
  min_list([], Min0, Min):-Min = Min0.
  min_list([H|T], Min0, Min):- Min1 is min(H, Min0),min_list(T, Min1, Min).
%предикат minList(+[X|Xs],?Num) находит минимальный элемент в списке
minList([],9):-!.
minList([X|Xs],Num):- minList(Xs, Num1), (X<Num1 -> Num=X; Num = Num1).

%предикат вывода writeResult2(-MinNum1,-MinNum2) - выводит найденные
%минимальные элементы строки.
writeResult2(MinNum1, MinNum2) :-
    write("First minimum number is: "),
    writeln(MinNum1),
    write("Second minimum number is: "),
    write(MinNum2).


%Дан целочисленный массив. Найти количество чётных элементов.

%предикат логики работы findNumChyot(?List,?Num) - находит количество
%чётных элементов в списке List.
findNumChyot(List,Num):- findNumChyot(List, 0, Num).
findNumChyot([],Num,Num).
findNumChyot([X|Xs],TruNum,Num):-
    0 is X mod 2 -> TruNum1 is TruNum + 1, findNumChyot(Xs,TruNum1,Num); findNumChyot(Xs,TruNum,Num).

%предикат вывода writeResult3(?Num) - выводит количество
%чётных элементов.
writeResult3(Num) :-
    write("Number is: "),
    write(Num).




max_digit_up(0,0):-!.
max_digit_up(InputNumber,CurrentMaximumDigit):- NextInputNumber is InputNumber div 10, max_digit_up(NextInputNumber,CurrentResult), NewDigit is InputNumber mod 10, max(NewDigit,CurrentResult,NewResult), CurrentMaximumDigit is NewResult.
