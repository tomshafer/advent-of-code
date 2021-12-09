def read_data(path: str) -> list[list[list[set[str]]]]:
    with open(path) as f:
        return [
            [
                list(set(i) for i in item.strip().split())
                for item in line.strip().split("|")
            ]
            for line in f
        ]


def solve_chain(code, output):
    scode = sorted(code, key=len)

    d = {}
    d[1] = scode.pop(0)
    d[7] = scode.pop(0)
    d[4] = scode.pop(0)
    d[8] = scode.pop(-1)

    l5 = scode[:3]
    l6 = scode[3:]

    d[9] = min(l6, key=lambda i: (d[8] - i) & d[4])
    d[6] = max(l6, key=lambda i: (d[8] - i) & d[1])
    d[0] = max(l6, key=lambda i: (d[8] - i) & d[4] - d[1])

    d[3] = min(l5, key=lambda i: (d[8] - i) & d[1])
    d[2] = max(l5, key=lambda i: i & (d[8] - d[4]))
    d[5] = max(l5, key=lambda i: (i & d[4]) - d[1])

    c = {"".join(sorted(v)): str(k) for k, v in d.items()}  # Reverse map
    t = "".join([c.get("".join(sorted(r))) for r in output])
    return int(t)


inputs = read_data("data/08/input.txt")

# Part 1
print(sum(len(yi) in (2, 3, 4, 7) for _, y in inputs for yi in y))

# Part 2
print(sum(solve_chain(*x) for x in inputs))
