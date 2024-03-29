man(voeneg).
man(ratibor).
man(boguslav).
man(velerad).
man(duhovlad).
man(svyatoslav).
man(dobrozhir).
man(bogomil).
man(zlatomir).

woman(goluba).
woman(lubomila).
woman(bratislava).
woman(veslava).
woman(zhdana).
woman(bozhedara).
woman(broneslava).
woman(veselina).
woman(zdislava).

parent(voeneg,ratibor).
parent(voeneg,bratislava).
parent(voeneg,velerad).
parent(voeneg,zhdana).

parent(goluba,ratibor).
parent(goluba,bratislava).
parent(goluba,velerad).
parent(goluba,zhdana).

parent(ratibor,svyatoslav).
parent(ratibor,dobrozhir).
parent(lubomila,svyatoslav).
parent(lubomila,dobrozhir).

parent(boguslav,bogomil).
parent(boguslav,bozhedara).
parent(bratislava,bogomil).
parent(bratislava,bozhedara).

parent(velerad,broneslava).
parent(velerad,veselina).
parent(veslava,broneslava).
parent(veslava,veselina).

parent(duhovlad,zdislava).
parent(duhovlad,zlatomir).
parent(zhdana,zdislava).
parent(zhdana,zlatomir).

father(X,Y):- man(X), parent(X,Y).
mother(X,Y):- woman(X), parent(X,Y).

%в предикате grand_mas(+X) находит вех бабушек, где X - имя внука или внучки.
%предикат grand_ma(+X,?Y) проверяет, является ли X бабушкой Y.
grand_ma(X,Y):- mother(X,Z), parent(Z,Y).
grand_mas(X):- grand_ma(Y,X), print(Y), nl, fail.

%предикат grand_pa_and_son(?X,?Y) проверяет, является ли X дедушкой для внука Y или, является ли X внуком для дедушки Y.
grand_pa_and_son(X,Y):- father(X,Z), parent(Z,Y), man(Y); father(Y,Z), parent(Z,X), man(X).

%в предикате uncle(+X) находит всех дядей, где X - имя сына или дочки отца.
%предикат uncle(+X,?Y) проверяет, является ли X дядей Y.
uncle(X,Y):- parent(Z,Y), parent(A,Z), parent(A,X), not(X=Z), man(X).
uncle(X):- uncle(Y,X), print(Y), nl, fail.


