color(dove, light).
color(parrot, light).
color(raven, dark).
color(rook, dark).
color(canary, light).
color(gull, light).
color(starling, dark).

namesake('Voronov', raven).
namesake('Golubev', dove).
namesake('Kanareykin', canary).
namesake('Grachev', rook).
namesake('Chaikin', gull).
namesake('Skvortsov', starling).
namesake('Popugaev', parrot).

owners(People) :-
    People = [
        person('Voronov', VoronovBird, married),
        person('Golubev', GolubevBird, single),
        person('Kanareykin', KanareykinBird, single),
        person('Grachev', GrachevBird, married),
        person('Chaikin', ChaikinBird, married),
        person('Skvortsov', SkvortsovBird, married),
        person('Popugaev', PopugaevBird, married)
    ],
    permutation([raven, dove, canary, rook, gull, starling, parrot],
                [VoronovBird, GolubevBird, KanareykinBird, GrachevBird,
                 ChaikinBird, SkvortsovBird, PopugaevBird]),
    forall(member(person(Surname, Bird, _), People),
           \+ namesake(Surname, Bird)),
    forall(member(person(Surname, Bird, _), People),
           (   color(Bird, dark)
           ->  namesake(Surname, OwnBird),
               color(OwnBird, light)
           ;   true
           )),
    namesake(VoronovBirdNamesake, VoronovBird),
    member(person(VoronovBirdNamesake, _, married), People),
    ChaikinBird \= rook,
    member(person(_, rook, married), People),
    member(person(_, raven, single), People),
    namesake(GrachevBirdNamesake, GrachevBird),
    member(person(GrachevBirdNamesake, canary, _), People),
    member(person(ParrotOwner, parrot, _), People),
    namesake(ParrotOwner, ParrotOwnerBird),
    member(person(VoronovBirdNamesake, ParrotOwnerBird, _), People).

solve(People, StarlingOwner) :-
    once(owners(People)),
    member(person(StarlingOwner, starling, _), People).

main :-
    solve(People, StarlingOwner),
    writeln('Birds of the owners:'),
    forall(member(person(Surname, Bird, Status), People),
           format('~w owns the ~w (~w)~n', [Surname, Bird, Status])),
    findall(Solution, owners(Solution), Solutions),
    length(Solutions, Count),
    format('~nNumber of consistent assignments: ~d~n', [Count]),
    format('The starling belongs to ~w.~n', [StarlingOwner]).

:- initialization(main, main).
