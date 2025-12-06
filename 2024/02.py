import numpy as np

with open("02.txt") as f:
    reports = [list(map(int, line.split())) for line in f]

diffs = [[v - r[i] for i, v in enumerate(r[1:])] for r in reports]

# Part 1
t1 = [[(abs(x) >= 1 and abs(x) <= 3) for x in d] for d in diffs]
m1 = [all(t) for t in t1]

t2 = [[int(x >= 0) for x in d] for d in diffs]
m2 = [sum(d) % len(d) == 0 for d in t2]

len([r for i, r in enumerate(reports) if m1[i] and m2[i]])


# Part 2: LOLO, brute force
uids = [i for i, _ in enumerate(reports) if not (m1[i] and m2[i])]

ok = []
for i in uids:
    br = [_ for _ in reports[uids[i]]]
    for k, _ in enumerate(br):
        nbr = [b for i, b in enumerate(br) if i != k]
        diffs = [[v - nbr[i] for i, v in enumerate(nbr[1:])]]
        t1 = [[(abs(x) >= 1 and abs(x) <= 3) for x in d] for d in diffs]
        m1 = [all(t) for t in t1][0]
        t2 = [[int(x >= 0) for x in d] for d in diffs]
        m2 = [sum(d) % len(d) == 0 for d in t2][0]
        if m1 and m2:
            ok+=[i]
            break

len(ok)
