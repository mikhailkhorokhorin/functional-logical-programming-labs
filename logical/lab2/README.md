# Logical Lab 2. Bird Fanciers Logic Puzzle

## Task

Seven bird fanciers, Voronov, Golubev, Kanareykin, Grachev, Chaikin, Skvortsov and Popugaev, each own one bird: a raven, dove, canary, rook, gull, starling or parrot. Every surname comes from a bird name, and nobody owns their namesake bird. Golubev and Kanareykin are the only single ones, everybody else is married. Dark birds belong only to owners named after light birds, the rook owner is married, the raven owner is single, Chaikin does not own the rook, the namesake of Grachev's bird owns the canary, and the namesake of Voronov's bird is married and owns the bird named after the parrot owner. Find the owner of the starling.

## Build and run

```bash
make run LAB=logical/lab2
```

## Example

```text
Birds of the owners:
Voronov owns the gull (married)
Golubev owns the canary (single)
Kanareykin owns the raven (single)
Grachev owns the dove (married)
Chaikin owns the starling (married)
Skvortsov owns the parrot (married)
Popugaev owns the rook (married)

Number of consistent assignments: 1
The starling belongs to Chaikin.
```

## Notes

`solve/2` wraps the search in `once/1`, so it returns the answer exactly once. The program also counts all consistent assignments to show that the solution is unique.
