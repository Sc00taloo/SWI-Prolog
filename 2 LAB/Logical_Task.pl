%предикат in_list(+[E1|_],+E1) записывает в список условия
in_list([El|_],El).
in_list([_|T],El):-in_list(T,El).

%предикат task4 определяет цвета платьев и туфель на каждой из подруг
%(Аня, Валя и Наташа)ю
task4 :-
    Dress = [_, _, _],
    in_list(Dress, [anya, _, _]),
    in_list(Dress, [valya, _, _]),
    in_list(Dress, [natasha, _, green]),
    in_list(Dress, [_, green, _]),
    in_list(Dress, [_, white, _]),
    in_list(Dress, [_, blue, _]),
    in_list(Dress, [_, _, white]),
    in_list(Dress, [_, _, blue]),
    in_list(Dress, [anya,X,X]),
    not(in_list(Dress, [valya,X,X])),
    not(in_list(Dress, [natasha,X,X])),
    not(in_list(Dress, [valya, white, _])),
    not(in_list(Dress, [valya, _, white])),
    in_list(Dress, [natasha, _, green]),
    not(in_list(Dress, [valya, white, green])),
    not(in_list(Dress, [anya, _, green])),
    not(in_list(Dress, [valya, _, green])),
    write(Dress), !.
