"""2021 AoC, Day 9."""

from math import prod


def load_data(path: str) -> list[list[int]]:
    return [list(map(int, ll.strip())) for ll in open(path)]


def clamp(i: int, maxi: int, mini: int = 0):
    return max(min(i, maxi), mini)


def neighbors(ic: int, ir: int, inputs: list[list[int]]) -> dict[tuple[int, int], int]:
    nr, nc = len(inputs), len(inputs[0])
    keys = {
        (clamp(ic + dx, nc - 1), clamp(ir + dy, nr - 1))
        for dx, dy in zip((-1, 1, 0, 0), (0, 0, -1, 1))
    } - {(ic, ir)}
    return {k: inputs[k[1]][k[0]] for k in keys}


def risk_level(ic: int, ir: int, inputs: list[list[int]]) -> int:
    v = inputs[ir][ic]
    n = neighbors(ic, ir, inputs)
    if any(v >= nv for nv in n.values()):
        return 0
    return v + 1


def nnup(ic: int, ir: int, inputs: list[list[int]], frm=None) -> set[tuple[int, int]]:
    n = neighbors(ic, ir, inputs)
    if frm is not None:
        del n[frm]
    v = inputs[ir][ic]
    result = {(ic, ir)}
    for k, vn in n.items():
        if vn < 9 and vn > v:
            result = result | nnup(*k, inputs, frm=(ic, ir))
    return result


inputs = load_data("data/09/input.txt")

# Part 1
low_points = [
    (ic, ir, risk_level(ic, ir, inputs))
    for ir, _ in enumerate(inputs)
    for ic, _ in enumerate(inputs[ir])
    if risk_level(ic, ir, inputs) > 0
]
print(sum(p[-1] for p in low_points))

# Part 2
print(prod(sorted([len(nnup(*p[:2], inputs)) for p in low_points])[-3:]))
