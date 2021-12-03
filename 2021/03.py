"""Advent of Code 2021, Day 3."""


import numpy as np
from utils import header


def read_array(path: str) -> np.ndarray:
    with open(path) as f:
        return np.array([[int(item) for item in list(line.strip())] for line in f])


def most_common(arr: np.ndarray) -> np.ndarray:
    return (arr.sum(axis=0) >= arr.shape[0] / 2).astype(int)


def bits2int(bits: np.ndarray) -> int:
    return sum(v * 2 ** i for i, v in enumerate(bits[::-1]))


def iterative_mc_lc(arr: np.ndarray, which: str = "mc") -> np.ndarray:
    assert which in ("mc", "lc"), "Only most or least common"

    data = arr.copy()
    for i in range(arr.shape[1]):
        mc = most_common(data[:, i])
        if which == "lc":
            mc = 1 - mc
        data = data[data[:, i] == mc]
        if data.shape[0] == 1:
            break
    return data[0]


if __name__ == "__main__":
    data = read_array("data/03/input.txt")

    print(header("Part 1"))
    mc = most_common(data)
    lc = 1 - mc
    print("γ rate  =", mc, bits2int(mc))
    print("ε rate  =", lc, bits2int(lc))
    print("Product =", bits2int(mc) * bits2int(lc))

    print(header("Part 2"))
    o2 = iterative_mc_lc(data)
    co2 = iterative_mc_lc(data, which="lc")
    print("O2 rating  =", o2, bits2int(o2))
    print("CO2 rating =", co2, bits2int(co2))
    print("Product    =", bits2int(o2) * bits2int(co2))
    print()
