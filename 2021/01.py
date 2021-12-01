"""
Advent of Code 2021, Day 1.

Using base Python stuff today.
"""

from utils import header


def read_example(path: str) -> list[int]:
    with open(path) as f:
        return list(map(int, f.readlines()))


def count_increases(lst: list[int]) -> int:
    return sum(lst[i] < lst[i + 1] for i, _ in enumerate(lst[:-1]))


def windowed_sums(lst: list[int], w: int = 3) -> list[int]:
    sublist = lst if w == 0 else lst[: (-w + 1)]
    return [sum(lst[i : i + w]) for i, _ in enumerate(sublist)]


if __name__ == "__main__":
    print(header("Example"))
    data = read_example("data/01/example.txt")
    print("Increases:", count_increases(data))
    print("3 steps:", count_increases(windowed_sums(data)))

    print(header("My Input"))
    data = read_example("data/01/input.txt")
    print("Increases:", count_increases(data))
    print("3 steps:", count_increases(windowed_sums(data)))

    print()
