move(State, NewState) :-
    append(Left, [b, '_'|Right], State),
    append(Left, ['_', b|Right], NewState).
move(State, NewState) :-
    append(Left, [b, X, '_'|Right], State),
    member(X, [b, w]),
    append(Left, ['_', X, b|Right], NewState).
move(State, NewState) :-
    append(Left, ['_', w|Right], State),
    append(Left, [w, '_'|Right], NewState).
move(State, NewState) :-
    append(Left, ['_', X, w|Right], State),
    member(X, [b, w]),
    append(Left, [w, X, '_'|Right], NewState).

dfs(Goal, Goal, Path, Path).
dfs(Current, Goal, Visited, Path) :-
    move(Current, Next),
    \+ member(Next, Visited),
    dfs(Next, Goal, [Next|Visited], Path).

solve_dfs(Start, Goal, Path) :-
    once(dfs(Start, Goal, [Start], RevPath)),
    reverse(RevPath, Path).

bfs_queue([Goal-Path|_], Goal, Path).
bfs_queue([Current-PathSoFar|RestQueue], Goal, Path) :-
    findall(Next-[Next|PathSoFar],
            (   move(Current, Next),
                \+ member(Next, PathSoFar)
            ),
            NewPaths),
    append(RestQueue, NewPaths, Queue),
    bfs_queue(Queue, Goal, Path).

solve_bfs(Start, Goal, Path) :-
    once(bfs_queue([Start-[Start]], Goal, RevPath)),
    reverse(RevPath, Path).

iddfs(Goal, Goal, Path, _, Path).
iddfs(Current, Goal, Visited, Depth, Path) :-
    Depth > 0,
    move(Current, Next),
    \+ member(Next, Visited),
    NewDepth is Depth - 1,
    iddfs(Next, Goal, [Next|Visited], NewDepth, Path).

solve_iddfs(Start, Goal, Path) :-
    between(0, 100, Depth),
    iddfs(Start, Goal, [Start], Depth, RevPath),
    !,
    reverse(RevPath, Path).

print_state(State) :-
    atomic_list_concat(State, ' ', Line),
    writeln(Line).

report(Name, Path) :-
    format('~w solution:~n', [Name]),
    forall(member(State, Path), print_state(State)),
    length(Path, Length),
    Steps is Length - 1,
    format('Steps: ~d~n', [Steps]).

main :-
    Start = [b, b, b, b, '_', w, w, w],
    Goal = [w, w, w, '_', b, b, b, b],
    solve_dfs(Start, Goal, DfsPath),
    report('DFS', DfsPath),
    nl,
    solve_bfs(Start, Goal, BfsPath),
    report('BFS', BfsPath),
    nl,
    solve_iddfs(Start, Goal, IddfsPath),
    report('IDDFS', IddfsPath).

:- initialization(main, main).
