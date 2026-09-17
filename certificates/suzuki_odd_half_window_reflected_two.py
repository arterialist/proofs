"""Arb certificate for positivity of Suzuki's pole-free odd form at a=1/2.

Requires python-flint 0.9.0. All matrix entries use Arb balls and every
inequality that determines the result is asserted on a full enclosure.
"""

from flint import acb, arb, arb_mat, ctx, fmpq
from fractions import Fraction
from math import comb, factorial

ctx.prec = 1024

N = 13
CELLS = 300
SCALE = 10**12
A = arb(fmpq(1, 2))
M = arb(fmpq(4, 5))
ELL = arb(2).log()
W = ELL / arb(2).sqrt()
P = ELL - A
T = fmpq(14)

assert W < arb(fmpq(1, 2))


def mval(t):
    return acb(arb(fmpq(1, 4)), arb(t) / 2).digamma().real - arb.pi().log()


assert mval(T) > M
step = T / CELLS
weights = []
for cell in range(CELLS):
    kval = M - mval(step * cell)
    # The proposal is constructed from a certified upper endpoint, never a float.
    proposal = max(0, int((kval * SCALE).upper().ceil().unique_fmpz()) + 1)
    q = fmpq(proposal, SCALE)
    assert arb(q) > kval
    weights.append(q)

moments = {}
for power in range(0, 4 * N + 1, 2):
    v = arb(0)
    for cell, q in enumerate(weights):
        lo = arb(step * cell)
        hi = arb(step * (cell + 1))
        v += arb(q) * (hi ** (power + 1) - lo ** (power + 1)) / (power + 1)
    moments[power] = v

assert moments[0] < 100


def integral_power(lo, hi, power):
    return (hi ** (power + 1) - lo ** (power + 1)) / (power + 1)


def gram_u(i, j):
    mi, mj = 2 * i + 1, 2 * j + 1
    plain0 = integral_power(arb(0), P, mi + mj) / A ** (mi + mj)
    plain1 = integral_power(P, A, mi + mj) / A ** (mi + mj)
    cross = arb(0)
    for k in range(mj + 1):
        cross += ((-1) ** k * comb(mj, k) * ELL ** (mj - k)
                  * integral_power(P, A, mi + k))
    cross /= A ** (mi + mj)
    return plain0 / M + (M * plain1 - W * cross) / (M * M - W * W)


GU = arb_mat(N, N)
GV = arb_mat(N, N)
for i in range(N):
    for j in range(i, N):
        gu = gram_u(i, j)
        GU[i, j] = gu
        GU[j, i] = gu
        mi, mj = 2 * i + 1, 2 * j + 1
        gv = (arb(2) / arb.pi() * (-1) ** (i + j)
              * A ** (mi + mj) * moments[mi + mj]
              / (factorial(mi) * factorial(mj)))
        GV[i, j] = gv
        GV[j, i] = gv


def cholesky_verified(X):
    out = arb_mat(N, N)
    smallest = None
    for i in range(N):
        for j in range(i + 1):
            pivot = X[i, j]
            for k in range(j):
                pivot -= out[i, k] * out[j, k]
            if i == j:
                assert pivot > 0, (i, pivot)
                if smallest is None or pivot < smallest:
                    smallest = pivot
                out[i, j] = pivot.sqrt()
            else:
                out[i, j] = pivot / out[j, j]
    return out, smallest


L, pivot_u = cholesky_verified(GU)
Q = L.transpose() * GV * L
R = arb_mat(N, N)
for i in range(N):
    for j in range(N):
        R[i, j] = (arb(fmpq(99, 100)) if i == j else arb(0)) - Q[i, j]
_, pivot_r = cholesky_verified(R)

remainder = Fraction(7**27, factorial(27))
assert remainder < Fraction(1, 150000)
assert 12 * remainder < Fraction(1, 10000)

print("m(14):", mval(T))
print("w:", W)
print("step mass upper:", moments[0])
print("smallest GU pivot:", pivot_u)
print("smallest 0.99I-Q pivot:", pivot_r)
print("Taylor remainder:", remainder)
print("CERTIFIED: L_1/2^odd >= 27/10000 I")
