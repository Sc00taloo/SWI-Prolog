%предикат maxDown(+X) находит максимальную цифру числа при помощи
%рекурсии вниз
maxDown(X):-maxDownn(X,0).
maxDownn(0,Y):- write(Y),!.
maxDownn(X,Y):- NUM1 is X mod 10, Y < NUM1 -> X1 is X div 10, maxDownn(X1,NUM1); NUM1 is X mod 10, Y > NUM1 -> X1 is X div 10, maxDownn(X1,Y).

%предикат maxUp(+X,?Y) находит максимальную цифру числа при помощи
%рекурсии вверх
maxUp(0,0):- !.
maxUp(X,Y):- X1 is X div 10, maxUp(X1, Y1), NUM1 is X mod 10, (Y1 < NUM1 -> Y is NUM1; Y is Y1).

%предикат sumDownTree(+X) находит сумму цифр числа, делящихся на 3 с
%помощью рекурсии вниз
sumDownTree(X):-sumDownTreee(X,0).
sumDownTreee(0,Y):-write(Y),!.
sumDownTreee(X,Y):- X1 is X div 10, Y1 is X mod 10, (0 is Y1 mod 3 -> SUM is Y + Y1, sumDownTreee(X1,SUM); sumDownTreee(X1,Y)).

%предикат sumUpTree(+X,?Y) находит сумму цифр числа, делящихся на 3 с
%помощью рекурсии вверх
sumUpTree(0,0):-!.
sumUpTree(X,Y):- X1 is X div 10, sumUpTree(X1,Y1), NUM1 is X mod 10, (0 is NUM1 mod 3 -> Y is NUM1 + Y1; Y is Y1).

%предикат delNumDown(+X) находит количество делителей числа при помощи
%рекурсии вниз
delNumDown(X):-delNumDownn(X,0,1).
delNumDownn(X,Y,X):- Y1 is Y+1, write(Y1), !.
delNumDownn(X,Y,Z):- (X>0), 0 is X mod Z, Y1 is Y+1, Z1 is Z+1 -> delNumDownn(X,Y1,Z1); (X>0), (Z1 is Z+1, delNumDownn(X,Y,Z1)).

%предикат delNumUp(+X,?Y) находит количество делителей числа при помощи
%рекурсии вверх
delNumUp(X,Y) :- delNumUpp(X,Y,X).
delNumUpp(1,1,_):- !.
delNumUpp(X,Y,Z):- (X>0), X1 is X-1,delNumUpp(X1,Y1,Z),(0 is Z mod X -> Y is Y1+1; Y is Y1).




