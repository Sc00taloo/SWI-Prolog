%предикат in_list(+[E1|_],+E1) записывает в список условия
in_list([El|_],El).
in_list([_|T],El):-in_list(T,El).

%предикат task8 определяет из какого города приехали дети
%(Алик, Боря, Витя, Лена и Даша).
task8 :-
    Address = [_,_,_,_,_],
    in_list(Address, [alik,_]),
    in_list(Address, [borya,_]),
    in_list(Address, [vitya,_]),
    in_list(Address, [lena,_]),
    in_list(Address, [dasha,_]),
    in_list(Address, [_,harikova]),
    in_list(Address, [_,umani]),
    in_list(Address, [_,poltavi]),
    in_list(Address, [_,slavyansk]),
    in_list(Address, [_,kramatorsk]),
    (not(in_list(Address, [alik,umani])), in_list(Address,[borya,kramatorsk]); in_list(Address, [alik,umani])),
    (in_list(Address,[borya,harikova]); in_list(Address,[vitya,harikova])),
    (not(in_list(Address, [vitya,slavyansk])), in_list(Address,[lena,harikova]); in_list(Address,[vitya,slavyansk])),
    (in_list(Address, [dasha,umani]); in_list(Address,[lena,kramatorsk])),
    write(Address), !.
