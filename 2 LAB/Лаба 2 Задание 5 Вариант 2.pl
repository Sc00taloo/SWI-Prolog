%Найти количество чисел, взаимно простых с заданным.

%предикат чтения readNum(?X) - даёт пользователю ввести число X,Данный
%предикат используется для всех заданий!
readNum(X):-read(X).

%предикат логики работы coprimeNumber(?N,?Count) находит кол-во чисел,
%взаимно простых с заданым N
coprimeNumber(N,Count):-findall(X,(between(1,N,X), areCoprime(N,X)), Coprime), length(Coprime, Count).

%предикат areCompire(+N,+Y) нужен для перебора разных перемен для
%НОД
areCoprime(X,Y):-nod(X,Y,1).

%предикат nod(+X,+Y,-Nod) нужен для нахождние наибольшего общего
%делителя
nod(X,Y,Nod):- Z is X mod Y,(Z is 0 -> Nod is Y; nod(Y,Z,Nod)).

% предикат вывода writeResult(?Count) выводит количество чисел, которые
% были получены в предикате логики работы
writeResult1(Count) :-
    write("Count coprime number: "),
    write(Count).


%Найти делитель числа, являющийся взаимно простым с наибольшим
%количеством цифр данного числа.

%предикат логики работы findCoprimeNumber(?N,?X) разбивает число на
%цифры, проверяет каждое число на взаимное простоту с N, находим самое
%максимальное из них а затем получает делить X
findCoprimeNumber(0,_):-!.
findCoprimeNumber(N,X):- numInList(N,List),findall(K,(member(K, List),K>0, areCoprime(N,K)), Coprime), maxNum(Coprime,Max), X is N div Max.

%предикат numInList(+N,?List) создаёт список List из цифр числа N
numInList(0,[]):-!.
numInList(N,List):-N1 is N div 10, numInList(N1,List1), N2 is N mod 10, append(List1,[N2],List).

%предикат maxNum(+List,?X) находит максимальное число среди списка List
maxNum([],0):-!.
maxNum([H|T],X):-maxNum(T,X1), X1>=H -> X is X1; X is H.

%предикат вывода writeResult2(?Num) выводит делить числа Num, который
%был получен в предикате логики работы
writeResult2(Num) :-
    write("Del number: "),
    write(Num).



%По прологу первая задача - список делителей числа
divisors(Number, Divisors) :-find_divisors(Number, 1, Divisors).

find_divisors(Number, CurrentDivisor, []) :-CurrentDivisor > Number, !.

% Если делитель делиться на число
find_divisors(Number, CurrentDivisor, [CurrentDivisor|RestDivisors]) :- CurrentDivisor =< Number, 0 is Number mod CurrentDivisor,!, NextDivisor is CurrentDivisor + 1, find_divisors(Number, NextDivisor, RestDivisors).

% Если делитель не делиться на число
find_divisors(Number, CurrentDivisor, Divisors) :- CurrentDivisor =< Number,not(0 is Number mod CurrentDivisor),NextDivisor is CurrentDivisor + 1, find_divisors(Number, NextDivisor, Divisors).
