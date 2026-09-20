#!/usr/bin/env python3
"""Exact certificate for an asymptotic zeta zero-free-region constant < 48.0717.

Uses only Python's standard library. Every coefficient comparison, Taylor
endpoint enclosure, and final cubed objective comparison is exact rational
arithmetic.
"""
from fractions import Fraction as F
import json

C = [838533033, 271248903950, -171053720943, -603990615353, 742668127631, 1548602227728, -1059654855746, -2743555959644, 1413139710124, 5599565326403, -243753067998, -9334325833494, -3456260031793, 11733055425219, 9452818630228, -15190564025555, -26867945897037, -534576343705, 27557632509970, 5988311117983, -45839510797167, -48852664918463, 22018595549231, 81599462866540, 39766482305334, -58451335580145, -64799124866364, 105298092049284, 368347506909981, 553601443704988, 556630429836286, 406833588061710, 207115292257871, 48727999315961, -29881352944752, -40178544562989, -18322061242128, 1361455401991, 7909142573018, 8316192018439, 8058958335951, 7714200665355, 6351456278042, 5346982684689, 3826982476088, 1806618834077, 391411237450]
D = sum(x*x for x in C)
N = [D] + [2*sum(C[i]*C[i+k] for i in range(len(C)-k))
           for k in range(1, len(C))]
assert len(C) == 47
assert all(x > 0 for x in N[1:])
assert N[1] > D
b1 = F(N[1], D)
b = F(sum(N[1:]), D)
B = F(443795, 100000)

def sin_bounds(x, n=34):
    term = x
    partial = term
    for k in range(n):
        term = -term*x*x/F((2*k+2)*(2*k+3))
        partial += term
    nxt = -term*x*x/F((2*n+2)*(2*n+3))
    return min(partial, partial+nxt), max(partial, partial+nxt)

def cos_bounds(x, n=34):
    term = F(1)
    partial = term
    for k in range(n):
        term = -term*x*x/F((2*k+1)*(2*k+2))
        partial += term
    nxt = -term*x*x/F((2*n+1)*(2*n+2))
    return min(partial, partial+nxt), max(partial, partial+nxt)

def f_bounds(x):
    sl, su = sin_bounds(x)
    cl, cu = cos_bounds(x)
    assert sl > 0 and cl > 0
    # f(x)=sin(x)^2-b1+b1*x*cos(x)/sin(x).
    return sl*sl-b1+b1*x*cl/su, su*su-b1+b1*x*cu/sl

lo = F(1132689689, 10**9)
hi = F(1132689691, 10**9)
assert 0 < lo < hi < F(3, 2) and hi*hi < 2
flo = f_bounds(lo)
fhi = f_bounds(hi)
assert flo[0] > 0 and fhi[1] < 0

# MTY's unique theta is in (lo,hi). Since cos decreases there,
# cos(theta) > the rigorous Taylor lower bound for cos(hi).
cos_hi_lower, _ = cos_bounds(hi)
target = F(480717, 10000)  # 48.0717
# R^3=(9/16)*b^2*(b+1)*B^2/cos(theta)^6.
lhs = F(9, 16)*b*b*(b+1)*B*B
rhs = target**3*cos_hi_lower**6
assert lhs < rhs

result = {
    "degree": 46,
    "D": D,
    "all_bk_positive": True,
    "b1_gt_1": True,
    "minimum_bk_index": min(range(1, 47), key=lambda k: N[k]),
    "minimum_bk_decimal": format(float(F(min(N[1:]), D)), ".17g"),
    "theta_bracket": ["1.132689689", "1.132689691"],
    "R_strictly_below": "48.0717",
    "exact_cube_margin_decimal": format(float(rhs-lhs), ".17g")
}
print(json.dumps(result, indent=2))
