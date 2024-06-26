divisors_sum(N, Sum) :-
    N > 0,
    divisors_sum(N, 1, Sum).

divisors_sum(N, I, Sum) :-
    I * I =< N,
    N mod I =:= 0,
    I2 is N // I,
    divisors_sum(N, I + 1, Sum1),
    (I = I2 ->
        Sum is Sum1 + I
    ;
        Sum is Sum1 + I + I2
    ).

divisors_sum(N, I, Sum) :-
    I * I > N,
    Sum is N - 1.

is_abundant(N) :-
    divisors_sum(N, Sum),
    Sum > N.

cannot_be_sum_of_two_abundant_below_limit(N) :-
    \+ (between(1, N, A), is_abundant(A), between(1, N, B), is_abundant(B), A + B =:= N).

count_numbers_without_abundant_sum_below_limit(Limit, Count) :-
    findall(N, (between(1, Limit, N), cannot_be_sum_of_two_abundant_below_limit(N)), Numbers),
    length(Numbers, Count).

count_numbers_without_abundant_sum_below_limit(20000, Count).
