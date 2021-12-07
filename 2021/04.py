"""Advent of Code 2021, Day 4."""

import numpy as np


def read_data(path: str) -> tuple[np.ndarray, np.ndarray]:
    with open(path) as f:
        draws = np.array(f.readline().strip().split(","), int)
        boards = np.array(
            [ln.strip().split() for ln in f.readlines() if ln.strip()], int
        ).reshape(-1, 5, 5)
    return draws, boards


# PART 1


def missing_elems(board: np.ndarray, numbers: np.ndarray) -> list[set[int]]:
    rows, cols = board.shape
    sets = []
    for col in range(cols):
        sets += [set(np.setdiff1d(board[:, col], numbers))]
    for row in range(rows):
        sets += [set(np.setdiff1d(board[row, :], numbers))]
    return sets


def solve_board(board: np.ndarray, draws: np.ndarray) -> tuple[int, int, int]:
    remainders = missing_elems(board, draws[: board.shape[0]])
    for i in range(board.shape[0], draws.size):
        for s in remainders:
            s.difference_update([draws[i]])
        if any(not s for s in remainders):
            print(i, draws[i])
            break
    return i, draws[i], np.setdiff1d(board, draws[: i + 1]).sum()


draws, boards = read_data("data/04/input.txt")
solns = [solve_board(boards[i], draws) for i in range(boards.shape[0])]
print(sorted([(s[0], s[-1] * s[-2]) for s in solns]))
