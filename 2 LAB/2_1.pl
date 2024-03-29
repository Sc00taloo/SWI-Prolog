%реализовать предикат max(+X,+Y,+U,-Z), где U максимально из чисел X,Y,Z
max(X,Y,U,Z):- Z = 7, Z1 is Z, X>Y, X>Z1 -> X is U;
               Z = 7, Z1 is Z, Y>X, Y>Z1 -> Y is U;
               Z = 7, Z1 is Z, Z1>X, Z1>Y -> Z1 is U.

%реализовать предикат fact(+N,?X) факториал с помощью рекурсии вверх
fact(0,1):- !.
fact(N,X):- N1 is N-1, fact(N1,X1), X is N*X1.

%реализовать предикат fact(+N,?X) факториал с помощью рекурсии вниз
fact2(N,X):- fact2(N,1,X).
fact2(0,X,X):- !.
fact2(N,A,X):-
    A1 is N*A,
    N1 is N-1,
    fact2(N1,A1,X).

%предикат sumRecUp(+X,?Y) находит сумму цифр числа с помощью рекурсии
%вверх
sumRecUp(0,0):-!.
sumRecUp(X,Y):- NUM1 is X div 10, sumRecUp(NUM1,NUM2), Y is NUM2 + (X mod 10).

%предикат sumRecDown(+X,?Y) находит сумму цифр числа с помощью рекурсии
%вниз
sumRecDown(X,Y):-sumRecDownn(X,Y,0).
sumRecDownn(0,X,X):-!.
sumRecDownn(X,Y,Z):- NUM1 is X mod 10, NUM2 is NUM1 + Z, X1 is X div 10, sumRecDownn(X1,Y,NUM2).

% предикат freedom(+X) проверяет, является +X свободным числом от
% квадратов. Свободным от квадратов, называется
% число, которое не делится ни на один квадрат, кроме 1
freedom(X):-freedom(X,2).
freedom(1,2):-!.
freedom(X,X):-!.
freedom(X,Y):- X>Y, Y1 is Y*Y, 0 =:= (X mod Y1),!,fail; X>Y, Y2 is Y+1, freedom(X,Y2).

%предикат list_write(+[H|T]) выводит список на экран.
list_write([]):-!.
list_write([H|T]):- writeln(H), list_write(T).

%предикат createList создаёт список. Пользователь вводит значения
%списка. Чтобы прекратить вводить данные, пользователь
%должен ввести -1., тогда список выведется на экран
createList(L1):-read(Elem),createList(Elem,L1).
createList(-1,[]):-!.
createList(Elem,[Elem|T]):-read(NextEl),createList(NextEl,T).
createList:- write('Creating list'),nl, write('Enter -1 to stop'),nl, createList(L), list_write(L).

% предикат sum_list_down(+List, ?Summ) проверяет, является ли ?Summ
% суммой элементов списка или записывает в эту переменную сумму
% элементов. Использована рекурсия вниз
sum_list_down(List,Summ):-sum_list_downn(List,Summ,0).
sum_list_downn([],X,X):-!.
sum_list_downn([H|T],Sum, X):- X1 is X + H, sum_list_downn(T, Sum, X1).

% предикат sum_list_down(+List, ?Summ) проверяет, является ли ?Summ
% суммой элементов списка или записывает в эту переменную сумму
% элементов. Использована рекурсия вверх
sum_list_up([],0):-!.
sum_list_up([H|T], Sum):- sum_list_up(T,Sum1), Sum is H + Sum1.

% предикат deleteSum(+List,+Summ) удаляет все элементы, сумма цифр
% которых равна данной.
deleteSum(List,Summ):- deleteSum(List,[],Summ,0).
deleteSum([],[],_,_):-!,fail.
deleteSum([],W,_,_):-list_write(W).
deleteSum([H|T],W,Sum,K):- (not(0 is H mod 10) -> sumRecUp(H,K1), (K1 is Sum -> deleteSum(T,W,Sum,K);(append(W,[H],W1), deleteSum(T,W1,Sum,K))); H1 is H mod 10, K1 is K+H1, (K1 is Sum -> deleteSum(T,W,Sum,K);(append(W,[H],W1), deleteSum(T,W1,Sum,K)))).
