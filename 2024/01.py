"""Advent of Code 2024, Day 1."""

import numpy as np
from collections import Counter

mat = np.loadtxt("01.txt", dtype=int)

# Part 1: Sum over sorted distances
np.abs(np.sort(mat[:, 0]) - np.sort(mat[:, 1])).sum()

# Part 2: Weighted sum over entries
counts = Counter(mat[:, 1])
vec = np.sort(mat[:, 0])
np.sum([v * counts[v] for v in vec])
