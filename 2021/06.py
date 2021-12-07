"""Aoc 2021, Day 6"""

from typing import Counter, DefaultDict


def read_data(path: str) -> dict[int, int]:
    return dict(Counter(map(int, open(path).readline().split(","))))


def step(counts: dict[int, int]) -> dict[int, int]:
    newcounts: dict[int, int] = DefaultDict(lambda: 0)
    for i, n in counts.items():
        newi = i - 1 if i > 0 else 6
        newcounts[newi] += counts[i]
        if i == 0:
            newcounts[8] += counts[i]
    return newcounts


data = read_data("data/06/input.txt")

# Part 1
for i in range(1, 81):
    data = step(data)
print(i, sum(data.values()))

# Part 2
for i in range(81, 257):
    data = step(data)
print(i, sum(data.values()))
