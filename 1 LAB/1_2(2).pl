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

%найти всех сыновей в предикате son(+X), где X - имя родителя
%в предикате son(+X,?Y) проверить, является ли X сыном Y.
son(X,Y):-parent(Y,X), man(X).
son(X):- son(Y,X), print(Y), nl, fail.

%найти всех сестёр в предикате sister(+X), где X - имя сестры или имя брата
%в предикате sister(+X,?Y) проверить, является ли X сестрой Y
sister(X,Y):-woman(X), parent(Z,Y), parent(Z,X), not(X=Y).
sister(X):-sister(Y,X), print(Y), nl, fail.

