"""Advent of Code 2021, Day 2."""

from math import prod

from utils import header


def read_data(path: str) -> list[dict[str, int]]:
    with open(path) as f:
        data = []
        for line in f:
            direction, distance = line.strip().split()
            data += [{direction: int(distance)}]
        return data


def part1() -> tuple[int, ...]:
    """Part 1 is just incrementing coordinates"""
    data = read_data("data/02/input.txt")

    coords = [0, 0]
    for item in data:
        for dir, dist in item.items():
            ix = 0 if dir == "forward" else 1
            sign = -1 if dir == "up" else 1
            coords[ix] += sign * dist

    return tuple(coords)


def part2() -> tuple[int, ...]:
    """Part 2 is more interesting, tracking 'aim'"""
    data = read_data("data/02/input.txt")

    coords, aim = [0, 0], 0
    for item in data:
        for dir, dist in item.items():
            if dir == "forward":
                coords[0] += dist
                coords[1] += aim * dist
            else:
                sign = -1 if dir == "up" else 1
                aim += sign * dist

    return tuple(coords)


if __name__ == "__main__":
    print(header("Part 1"))
    coords = part1()
    print("Coords:", coords)
    print("Product:", prod(coords))

    print(header("Part 2"))
    coords = part2()
    print("Coords:", coords)
    print("Product:", prod(coords))

    print()
