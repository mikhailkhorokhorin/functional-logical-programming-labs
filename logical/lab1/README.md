# Logical Lab 1. List Operations and Student Database

## Task

`lists.pl` implements the standard list predicates (`my_length`, `my_member`, `my_append`, `my_remove`, `my_permute`, `my_sublist`) and removes the first negative element of a list in two ways: with the standard predicates and with explicit recursion.

`students.pl` holds a database `grade(Group, Student, Subject, Mark)` and prints the average mark and exam status of every student, the number of failed students for every subject and the students with the highest average in every group.

## Build and run

```bash
make run LAB=logical/lab1
```

## Example

```text
remove_first_negative_std = [3,4,-5,9]
remove_first_negative = [3,4,-5,9]
all answers of remove_first_negative_std = [[3,4,-5,9]]

Azurin: average 3.83, all exams passed
Blokcheynis: average 4.00, failed at least one exam

Mathematical Analysis: 3 failed

Group 103: highest average 4.33, students [Klaviaturnikova,Programmiro,Vebservisov]
```

## Notes

The task text is not available, so a failing mark is taken to be `Mark =< 2` (the lowest mark of the five-point scale). The original solution treated every mark below 4 as a failure.
