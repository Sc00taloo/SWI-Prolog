%Предметная область - аниме
%вызываем предикат main. Main вызывает первый объект fault(-Problem)
main :- retractall(asked(_,_)), fault(Problem), !,
    nl, write('Your anime is '), write(Problem), write(.), nl.
main :- nl, write('Your anime cannot be recognized.'), nl.

%вопрос problem(-fantasy)
problem(fantasy) :-
    query('What genre is your anime fantasy').

%вопрос problem(-drama)
problem(drama) :-
    query('What genre is your anime drama').

%вопрос problem(-macha)
problem(mecha) :-
    query('Are there mechs in anime').

%вопрос problem(-detective)
problem(detective) :-
    query('What genre is your anime detective').

%вопрос problem(-comedy)
problem(comedy) :-
    query('What genre is your anime comedy').

%вопрос problem(-everyday_life)
problem(everyday_life) :-
    query('What genre is your anime everyday life').

%1 объект fault(-robotics_notes)
fault(robotics_notes) :-
    problem(detective),
    problem(mecha),
    problem(fantasy),
    problem(drama).

%2 объект fault(-fruits_basket)
fault(fruits_basket) :-
    problem(comedy),
    problem(detective),
    problem(drama),
    problem(fantasy).

%3 объект fault(-gurren_lagann)
fault(gurren_lagann) :-
    problem(mecha),
    problem(comedy),
    problem(fantasy).

%4 объект fault(-iron_alchemic)
fault(iron_alchemic) :-
    problem(drama),
    problem(comedy),
    problem(fantasy).

%5 объект fault(-spy_family)
fault(spy_family) :-
    problem(comedy),
    problem(detective),
    problem(everyday_life).

%6 объект fault(-konosuba)
fault(konosuba) :-
    problem(comedy),
    problem(fantasy),
    problem(drama).

%7 объект fault(-mushishi)
fault(mushishi) :-
    problem(everyday_life),
    problem(detective),
    problem(fantasy).

%8 объект fault(-toradora)
fault(toradora) :-
    problem(drama),
    problem(comedy),
    problem(everyday_life).

%9 объект fault(-attak_of_titans)
fault(attak_of_titans) :-
    problem(detective),
    problem(drama),
    problem(fantasy).

%10 объект fault(-black_bulter)
fault(black_butler) :-
    problem(comedy),
    problem(detective),
    problem(fantasy).

%11 объект fault(-evangelion)
fault(evangelion) :-
    problem(mecha),
    problem(drama).

%12 объект fault(-melancholy_of_haruhi_suzumiya)
fault(melancholy_of_haruhi_suzumiya) :-
    problem(everyday_life),
    problem(detective).

%13 объект fault(-code_geass)
fault(code_geass) :-
    problem(mecha),
    problem(fantasy).

%14 объект fault(-cowboy_bebop)
fault(cowboy_bebop) :-
    problem(detective),
    problem(drama).

%15 объект fault(-kobayashi_san_no_maid_dragon)
fault(kobayashi_san_no_maid_dragon) :-
    problem(fantasy),
    problem(everyday_life).

%16 объект fault(-chi_yamada)
fault(chi_yamada) :-
    problem(comedy).

%17 объект fault(-mobile_suit_gundam)
fault(mobile_suit_gundam) :-
    problem(mecha).

%18 объект fault(-ayaka)
fault(ayaka) :-
    problem(fantasy).

%19 объект fault(-god_is_notebook)
fault(god_is_notebook) :-
    problem(detective).

%20 объект fault(-tama_where_did_he_come_from)
fault(tama_where_did_he_come_from) :-
    problem(everyday_life).

%в предикате query(-Prompt) спрашиваем вопросы, где пользователь может ответить y % -(Да) или n/любое другое слово -(Нет)
query(Prompt) :-
    (   asked(Prompt, Reply) -> true
    ;   nl, write(Prompt), write(' (y/n)? '),
        read(X),(X = y -> Reply = y ; Reply = n),
	assert(asked(Prompt, Reply))
    ),
    Reply = y.
