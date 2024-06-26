% Чтение строк из файла
% read_lines_from_file(+FileName, -Lines)
read_lines_from_file(FileName, Lines) :- setup_call_cleanup(open(FileName, read, Stream),read_stream_to_lines(Stream, Lines), close(Stream)).

% read_stream_to_lines(+Stream, -Lines)
read_stream_to_lines(Stream, Lines) :-read_line_to_string(Stream, Line), (Line == end_of_file -> Lines = []; Lines = [Line|Tail], read_stream_to_lines(Stream, Tail)).

% Запись списка строк в файл
% write_lines_to_file(+FileName, +Lines)
write_lines_to_file(FileName, Lines) :- setup_call_cleanup( open(FileName, write, Stream), write_lines(Stream, Lines), close(Stream)).


% write_lines(+Stream, +Lines)
write_lines(_, []).
write_lines(Stream, [Line|Tail]) :- writeln(Stream, Line), write_lines(Stream, Tail).

% max_line_length(+Lines, -MaxLength)
max_line_length(Lines, MaxLength) :- maplist(string_length, Lines, Lengths), max_list(Lengths, MaxLength).

% lines_without_spaces(+Lines, -Count)
lines_without_spaces(Lines, Count) :-
    include(no_spaces, Lines, FilteredLines),
    length(FilteredLines, Count).

% no_spaces(+Line) истинно, если строка не содержит пробела
no_spaces(Line) :- \+sub_string(Line, _, _, _, ' ').

% Прочитать из файла строки и вывести длину наибольшей строки.
% print_max_line_length(+FileName)
print_max_line_length(FileName) :- read_lines_from_file(FileName, Lines), max_line_length(Lines, MaxLength), format('The longest line length is: ~w~n', [MaxLength]).

% Определить, сколько в файле строк, не содержащих пробелы.
% print_lines_without_spaces(+FileName)
print_lines_without_spaces(FileName) :- read_lines_from_file(FileName, Lines), lines_without_spaces(Lines, Count), format('Lines without spaces: ~w~n', [Count]).

% Считаем количество 'A' в строке
% count_a_in_string(+Str, -Count)
count_a_in_string(_, 0).
count_a_in_string(Str, Count) :- sub_string(Str, _, 1, _, 'A'), sub_string(Str, 1, _, 0, SubStr), count_a_in_string(SubStr, TailCount), Count is TailCount + 1.


% Находим среднее количество 'A' в списке строк
% average_a_in_lines(+Lines, -Average)
average_a_in_lines(Lines, Average) :- maplist(count_a_in_string, Lines, Counts), sum_list(Counts, Total), length(Lines, NumLines), Average is Total / NumLines.

% Найти и вывести на экран только те строки, в которых букв А
% больше, чем в среднем на строку.
% print_lines_with_more_a_than_average(+FileName)
print_lines_with_more_a_than_average(FileName) :- read_lines_from_file(FileName, Lines), average_a_in_lines(Lines, Average),include({Average}/[Line]>>(count_a_in_string(Line, Count), Count > Average),Lines, FilteredLines), maplist(writeln, FilteredLines).

% Разбивает строку на слова
% split_string_into_words(+Str, -Words)
split_string_into_words(Str, Words) :- split_string(Str, " ", "", Words).

% Вывести самое частое слово.
% most_frequent_word(+FileName, -Word)
most_frequent_word(FileName, Word) :-
    read_lines_from_file(FileName, Lines),
    maplist(split_string_into_words, Lines, WordsList),
    flatten(WordsList, AllWords),
    msort(AllWords, SortedWords),
    pack(SortedWords, PackedWords),
    max_member_by_length(PackedWords, MostFrequent),
    nth0(0, MostFrequent, Word).

% pack(+List, -Packed)
pack([], []).
pack([X|Xs], [[X|Zs]|Zss]) :-
    take_while(X, Xs, Zs, Ys),
    pack(Ys, Zss).


% take_while(+Element, +List, -SubList, -Rest)
take_while(X, [Y|Ys], [Y|Zs], Rest) :-
    X == Y, !,
    take_while(X, Ys, Zs, Rest).
take_while(_, Rest, [], Rest).


% max_member_by_length(+Lists, -Max)
max_member_by_length(Lists, Max) :-
    map_list_to_pairs(length, Lists, Pairs),
    keysort(Pairs, Sorted),
    last(Sorted, _-Max).


% print_string_unique_words(+String, +UniqueWords) - напечатать строку из уникальных слов
print_string_unique_words(String, UniqueWords):-
    read_words(String, WordsInString),
    print_words_if_unique(WordsInString, UniqueWords), !.

% print_words_if_unique(+Words, +UniqueWords) - напечатать все уникальные слова
print_words_if_unique([], _):- !.
print_words_if_unique([Word|TailWords], UniqueWords):-
    member(Word, UniqueWords),
    write_list_str(Word),
    write(" "),
    print_words_if_unique(TailWords, UniqueWords), !.
print_words_if_unique([_|TailWords], UniqueWords):-
    print_words_if_unique(TailWords, UniqueWords), !.

write_list_str([]):-!.
write_list_str([H|List]):-write(H), write_list_str(List).

% print_strings_unique_words(+Strings, +UniqueWords) - напечатать все строки, состоящие только из уникальных слов
print_strings_unique_words([], _):- !.
print_strings_unique_words([String|TailStrings], UniqueWords):-
    print_string_unique_words(String, UniqueWords),
    nl,
    print_strings_unique_words(TailStrings, UniqueWords), !.

% Вывести в отдельный файл строки, состоящие из слов, не
% повторяющихся в исходном файле.
% Проверка, содержит ли строка только уникальные слова
% print_strings_with_only_unique_words(+FilePath, +OutputFile) - записать в файл OutputFile строки с только уникальными словами из файла FilePath
print_strings_with_only_unique_words(FilePath, OutputFile):-
    read_lines_from_file(FilePath, StringList),
    read_all_words(StringList, Words),
    count_elements(Words, SetWords, CountWords),
    get_unique_words(SetWords, CountWords, UniqueWords),
    tell(OutputFile),
    print_strings_unique_words(StringList, UniqueWords),
    told, !.

% read_all_words(Strings, Words) - считать все слова в списке строк
read_all_words(Strings, Words):- read_all_words(Strings, [], Words), !.
read_all_words([], Words, Words):- !.
read_all_words([String|StringsTail], CurWords, Words):-
    read_words(String, StringWords),
    append(CurWords, StringWords, NewCurWords),
    read_all_words(StringsTail, NewCurWords, Words), !.


% read_words(+String, -Words) - записать все слова из String в Words
read_words(String, Words) :-
    read_words(String, [], Words).

read_words([], [FirstWord|TailWords], Words) :-
    reverse(FirstWord, FixedFirstWord), % фиксим, что у последнего слова обратный порядок букв
    reverse([FixedFirstWord|TailWords], Words), % фиксим, что слова стоят в обратном порядке
    !.
read_words([C|Cs], Acc, Words) :-
    (is_word_char(C) ->
        read_word(Cs, [C], RestCs, Word),
        Acc1 = [Word|Acc],
        read_words(RestCs, Acc1, Words)
    ;
        read_words(Cs, Acc, Words)
    ).

% read_word(+Chars, +Acc, -RestCs, -Word) - идти по символам и записывать слово, в Word записать получившееся слово, в RestCs вернуть оставшиеся символы, которые уже не являются частью слова
read_word([], Word, [], Word) :- !.
read_word([C|Cs], Acc, RestCs, Word) :-
    (is_word_char(C) ->
        read_word(Cs, [C|Acc], RestCs, Word)
    ;
        reverse(Acc, Word),
        RestCs = [C|Cs]
    ).

% is_word_char(+C) - проверка, является ли C буквой
is_word_char(C) :-
    code_type(C, alpha).


% count_elements(+List, -L1, -L2) - вывести в L1 уникальные элементы списка List, а в L2 количество повторений каждого элемента
count_elements([], [], []).

count_elements([X|Xs], L1, L2) :-
    count_elements(Xs, L1_Tail, L2_Tail),
    (   member(X, L1_Tail)
    ->  L1 = L1_Tail,
        nth1(Index, L1_Tail, X),
        nth1(Index, L2_Tail, Count),
        NewCount is Count + 1,
        replace(Index, L2_Tail, NewCount, L2)
    ;   L1 = [X|L1_Tail],
        L2 = [1|L2_Tail]
    ).

% replace(+Index, +CurList, +Value, -ResList) - заменить элемент на индексе Index в списке CurList значением Value и вернуть новый список в ResList
replace(1, [_|Xs], Value, [Value|Xs]).
replace(N, [X|Xs], Value, [X|Ys]) :-
    N > 1,
    N1 is N - 1,
    replace(N1, Xs, Value, Ys).


% get_unique_words(+Elements, +Counts, -UniqueWords) - получить список всех неповторяющихся слов
get_unique_words(Elements, Counts, UniqueWords):- get_unique_words(Elements, Counts, [], UniqueWords), !.
get_unique_words([], _, UniqueWords, UniqueWords):- !.
get_unique_words([Element|TailElements], [CountElement|TailCounts], CurUniqueWords, UniqueWords):-
    CountElement is 1,
    get_unique_words(TailElements, TailCounts, [Element|CurUniqueWords], UniqueWords), !.
get_unique_words([_|TailElements], [_|TailCounts], CurUniqueWords, UniqueWords):-
    get_unique_words(TailElements, TailCounts, CurUniqueWords, UniqueWords), !.


% read_str_one(+CurrentChar, +CurrentStr, -ResultStr, -Flag) - прочитать 1 строку, записать в ResultStr, и вернуть флаг, 1 - переход на новую строку , 0 - конец файла
read_str_one(-1,CurrentStr,CurrentStr,0):-!.
read_str_one(10,CurrentStr,CurrentStr,1):-!.
read_str_one(26,CurrentStr,CurrentStr,0):-!.
read_str_one(CurrentSymbol, CurrentStr, ResultStr, Flag):-
    char_code(ResSymbol, CurrentSymbol),
    append(CurrentStr,[ResSymbol],NewCurrentStr),
    get0(NewSymbol),
    read_str_one(NewSymbol,NewCurrentStr,ResultStr,Flag).

% read_all_str(-ResultList) - считать все строки до конца строки или файла.
read_all_str(ResultList):- read_all_str(ResultList, [], 1), !.

% read_all_str(-ResultList, +CurrentList, +Flag)
read_all_str(CurrentList, CurrentList, 0):-!.
read_all_str(StrList, CurrentList, _):-
    get0(NewSymbol),
    read_str_one(NewSymbol,[],ResultStr,Flag),
    append(CurrentList,[ResultStr],NewStrList),
    read_all_str(StrList,NewStrList,Flag).
