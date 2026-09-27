my_length([], 0).
my_length([_|X], N) :-
    my_length(X, N1),
    N is N1 + 1.

my_member(A, [A|_]).
my_member(A, [_|Z]) :-
    my_member(A, Z).

my_append([], X, X).
my_append([A|X], Y, [A|Z]) :-
    my_append(X, Y, Z).

my_remove(X, [X|T], T).
my_remove(X, [Y|T], [Y|T1]) :-
    my_remove(X, T, T1).

my_permute([], []).
my_permute(L, [X|T]) :-
    my_remove(X, L, R),
    my_permute(R, T).

my_sublist(S, L) :-
    my_append(_, L1, L),
    my_append(S, _, L1).

remove_at_std(L, I, R) :-
    N1 is I - 1,
    append(P, [_|S], L),
    length(P, N1),
    !,
    append(P, S, R).

remove_at([_|T], 1, T).
remove_at([H|T], N, [H|R]) :-
    N > 1,
    N1 is N - 1,
    remove_at(T, N1, R).

first_negative_std(L, P) :-
    append(Pfx, [X|_], L),
    X < 0,
    !,
    length(Pfx, N),
    P is N + 1.

first_negative([X|_], 1) :-
    X < 0,
    !.
first_negative([_|T], Pos) :-
    first_negative(T, P1),
    Pos is P1 + 1.

remove_first_negative_std(L, R) :-
    first_negative_std(L, P),
    remove_at_std(L, P, R).

remove_first_negative(L, R) :-
    first_negative(L, P),
    remove_at(L, P, R).

show(Label, Goal, Result) :-
    (   call(Goal)
    ->  format('~w = ~w~n', [Label, Result])
    ;   format('~w fails~n', [Label])
    ).

main :-
    List = [3, -1, 4, -5, 9],
    format('List: ~w~n~n', [List]),
    writeln('Standard list predicates:'),
    show('my_length', my_length(List, Len), Len),
    show('my_member(4)', my_member(4, List), true),
    show('my_member(7)', my_member(7, List), true),
    show('my_append([1, 2], [3])', my_append([1, 2], [3], App), App),
    show('my_remove(4)', my_remove(4, List, Rem), Rem),
    findall(P, my_permute([a, b, c], P), Perms),
    format('my_permute([a, b, c]) = ~w~n', [Perms]),
    show('my_sublist([-1, 4])', my_sublist([-1, 4], List), true),
    nl,
    writeln('Remove the first negative element:'),
    show('first_negative_std', first_negative_std(List, P1), P1),
    show('first_negative', first_negative(List, P2), P2),
    show('remove_first_negative_std', remove_first_negative_std(List, R1), R1),
    show('remove_first_negative', remove_first_negative(List, R2), R2),
    findall(R, remove_first_negative_std(List, R), AllStd),
    format('all answers of remove_first_negative_std = ~w~n', [AllStd]),
    show('remove_first_negative([1, 2])', remove_first_negative([1, 2], R3), R3).

:- initialization(main, main).
