# Logical Lab 3. State Space Search (DFS, BFS, IDDFS)

## Task

Four black tiles and three white tiles lie in a row of eight cells with one empty cell: `b b b b _ w w w`. A black tile moves right and a white tile moves left, either into the adjacent empty cell or by jumping over one tile. Reach `w w w _ b b b b` using depth-first search, breadth-first search and iterative deepening search and print every path.

## Build and run

```bash
make run LAB=logical/lab3
```

## Example

```text
BFS solution:
b b b b _ w w w
b b b _ b w w w
b b b w b _ w w
...
w w b w _ b b b
w w _ w b b b b
w w w _ b b b b
Steps: 19
```

## Notes

Every path starts with the initial state, and all three searches report the number of moves as the path length minus one.
