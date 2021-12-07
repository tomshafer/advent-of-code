"""AoC 2021, Day 5"""

from collections import Counter


def read_data(path: str) -> list[tuple[tuple[int, ...], ...]]:
    return sorted(
        [
            tuple(tuple(map(int, item.split(","))) for item in line.strip().split("->"))
            for line in open(path)
        ]
    )


def solve(data: list[tuple[tuple[int, ...], ...]], diagonals: bool = False) -> int:
    counts: dict = Counter()
    for (xa, ya), (xb, yb) in data:
        if not diagonals and xa != xb and ya != yb:
            continue
        dx = 0 if xa == xb else -1 if xa > xb else 1
        dy = 0 if ya == yb else -1 if ya > yb else 1
        steps = max(abs(xb - xa), abs(yb - ya))
        counts.update([(xa + i * dx, ya + i * dy) for i in range(steps + 1)])

    return sum(1 for v in counts.values() if v > 1)


data = read_data("data/05/input.txt")

# Part 1
print(solve(data))

# Part 2
print(solve(data, diagonals=True))
