"""Arb certificate for complete mixed-ramp Weil positivity on the middle box.

Run from the repository root with python-flint installed:
python3 certificates/mixed_ramp_middle_arb_certificate.py.
The analytic justification for each interval bound is in
building-blocks/weil-and-spectral/complete-weil-positive-causal-ramp-cone.md.
"""

from bisect import bisect_right
from fractions import Fraction
from functools import lru_cache

from flint import arb, ctx

ctx.prec = 192

ZERO = arb(0)
ONE = arb(1)
TWO = arb(2)
K = arb(753) / 1000
U = 10
E_U = arb(U).exp()
assert E_U.lower() > 22026 and E_U.upper() < 22027

gamma = arb.const_euler()
C = 1 - gamma - (2 * arb.pi()).log()
S = 1 - TWO.log()
assert C.upper() < 0

# Exact integer sieve and every prime power q<=floor(exp(10)).
limit = 22026
prime = bytearray(b'\1') * (limit + 1)
prime[0] = prime[1] = 0
for q in range(2, int(limit**.5) + 1):
    if prime[q]:
        prime[q * q : limit + 1 : q] = b'\0' * len(prime[q * q : limit + 1 : q])
items = []
for p in range(2, limit + 1):
    if prime[p]:
        q = p
        while q <= limit:
            items.append((q, p))
            q *= p
items.sort()
nodes = [q for q, _ in items]
logp = {p: arb(p).log() for _, p in items}
A = [ZERO]
PSI = [ZERO]
max_H = arb(0)
max_q = None
for q, p in items:
    h_before = arb(q).log() - A[-1]
    if h_before.upper() > max_H.upper():
        max_H = h_before
        max_q = q
    A.append(A[-1] + logp[p] / q)
    PSI.append(PSI[-1] + logp[p])
H_at_U = arb(U) - A[-1]
if H_at_U.upper() > max_H.upper():
    max_H = H_at_U
    max_q = 'U'
assert max_q == 3
assert max_H.upper() < K.lower(), max_H
assert gamma.upper() < K.lower()
assert (gamma - arb(13) / 1000).lower() > 0


@lru_cache(maxsize=30000)
def ar(x: Fraction):
    return arb(x.numerator) / x.denominator


@lru_cache(maxsize=30000)
def B_exact(x: Fraction):
    if x == 0:
        return ZERO
    y = ar(x)
    ey = y.exp()
    n = int(float(ey))
    assert ey.lower() > n and ey.upper() < n + 1, (x, ey, n)
    j = bisect_right(nodes, n)
    return y - 1 + (-y).exp() - A[j] + (-y).exp() * PSI[j]


B_U = B_exact(Fraction(U))
J_U = arb(U).ei() - E_U / U


@lru_cache(maxsize=30000)
def B(x: Fraction):
    if x <= U:
        return B_exact(x)
    y = ar(x)
    ey = y.exp()
    J_y = y.ei() - ey / y
    return (E_U * B_U + gamma * (ey - E_U)
            - arb(13) / 10 * (J_y - J_U)) / ey


@lru_cache(maxsize=30000)
def T(x: Fraction):
    if x == 0:
        return S
    q = (-ar(x)).exp()
    return q - q.atanh() - q / 2 * (1 - q * q).log()


def lower_box(a: Fraction, b: Fraction, c: Fraction, d: Fraction):
    # Coordinates: a<=L<=b and c<=Delta=M-L<=d.
    l = (a + b) / 2
    delta = (c + d) / 2
    m = l + delta
    bl = B(l) - K * ar((b - a) / 2)
    bm = B(m) - K * ar((b - a + d - c) / 2)
    bd = B(delta) + K * ar((d - c) / 2)
    r = bl + bm - (-ar(a)).exp() * bd
    if r.lower() < 0:
        r = ZERO  # The actual hybrid residual is nonnegative.

    # Termwise monotonic bounds on the exact gamma expansion.
    eb = (-ar(b)).exp()
    g = C * (1 - eb) + S - T(a)
    g += eb * (T(d) - ar(a).exp() * T(d + a))
    return r + g


stack = [(Fraction(2, 25), Fraction(7), Fraction(0), Fraction(6))]
target = arb(1) / 200  # A uniform lower margin of 0.005 on this box.
leaves = 0
minimum = None
max_stack = 1
while stack:
    a, b, c, d = stack.pop()
    lower = lower_box(a, b, c, d)
    if lower.lower() > target.upper():
        leaves += 1
        if minimum is None or lower.lower() < minimum.lower():
            minimum = lower
        continue
    if 2 * (b - a) >= d - c:
        mid = (a + b) / 2
        stack.extend([(a, mid, c, d), (mid, b, c, d)])
    else:
        mid = (c + d) / 2
        stack.extend([(a, b, c, mid), (a, b, mid, d)])
    if len(stack) > max_stack:
        max_stack = len(stack)
    assert leaves < 200000, 'Subdivisions exceeded planned certificate size'

print('prime powers:', len(items))
print('H exact maximum upper certificate:', max_H)
print('accepted rectangles:', leaves, 'maximum stack:', max_stack)
print('least accepted Arb lower:', minimum)
assert minimum.lower() > arb('0.00500020778')
print('CERTIFIED: Q(f_L,f_M)>0.005 for 2/25<=L<=7 and 0<=M-L<=6')
