"""Arb certificate for Suzuki's full odd Weil form at a=1/2.

Requires python-flint 0.9.0. All matrix entries use Arb balls and every
inequality that determines the result is asserted on a full enclosure.
"""

from flint import acb, arb, arb_mat, ctx, fmpq
from fractions import Fraction
from math import comb, factorial

ctx.prec = 1024

N = 26
CELLS = 50000
SCALE = 10**12
A = arb(fmpq(1, 2))
M = arb(fmpq(13, 10))
ELL = arb(2).log()
W = ELL / arb(2).sqrt()
P = ELL - A
T = fmpq(24)

assert W < arb(fmpq(1, 2))
assert M - W > arb(fmpq(4, 5))


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

assert moments[0] < 50


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
    dim = X.nrows()
    assert X.ncols() == dim
    out = arb_mat(dim, dim)
    smallest = None
    for i in range(dim):
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

def exponential_moment(c, lo, hi, degree):
    at_hi, at_lo = (c * hi).exp(), (c * lo).exp()
    value = (at_hi - at_lo) / c
    for degree_now in range(1, degree + 1):
        value = ((hi ** degree_now * at_hi - lo ** degree_now * at_lo) / c
                 - arb(degree_now) * value / c)
    return value


def score_moment(lo, hi, degree):
    half = arb(fmpq(1, 2))
    return arb(2).sqrt() / 2 * (
        exponential_moment(half, lo, hi, degree)
        - exponential_moment(-half, lo, hi, degree))


def reflected_score_moment(lo, hi, degree):
    half = arb(fmpq(1, 2))
    return arb(2).sqrt() / 2 * (
        (ELL / 2).exp() * exponential_moment(-half, lo, hi, degree)
        - (-ELL / 2).exp() * exponential_moment(half, lo, hi, degree))


def hyperbolic_sine(x):
    return (x.exp() - (-x).exp()) / 2


def hyperbolic_cosine(x):
    return (x.exp() + (-x).exp()) / 2


# The odd score has positive-halfline coordinate h(x)=sqrt(2)*sinh(x/2).
outside_square = hyperbolic_sine(P) - P
inside_square = hyperbolic_sine(A) - A - outside_square
reflected_cross = ((A - P) * hyperbolic_cosine(ELL / 2)
                   - hyperbolic_sine(A - ELL / 2)
                   + hyperbolic_sine(P - ELL / 2))
score_c_inverse_score = (outside_square / M
                         + (M * inside_square - W * reflected_cross)
                         / (M * M - W * W))

g = arb_mat(N, 1)
for i in range(N):
    degree = 2 * i + 1
    g[i, 0] = (score_moment(arb(0), P, degree) / M
               + (M * score_moment(P, A, degree)
                  - W * reflected_score_moment(P, A, degree))
               / (M * M - W * W)) / A ** degree

z = L.transpose() * GV * g
schur = arb_mat(N + 1, N + 1)
for i in range(N):
    for j in range(N):
        schur[i, j] = (arb(1) if i == j else arb(0)) - Q[i, j]
    schur[i, N] = arb(2).sqrt() * z[i, 0]
    schur[N, i] = schur[i, N]
schur[N, N] = (arb(fmpq(999, 1000))
               - 2 * (score_c_inverse_score + (g.transpose() * GV * g)[0, 0]))
_, pivot_schur = cholesky_verified(schur)

remainder = Fraction(12**53, factorial(53))
assert 5 * remainder < Fraction(1, 10**11)
assert ((Fraction(1, 100000) - Fraction(3, 10**11))
        * Fraction(4, 5) > Fraction(7, 10**6))

print("m(24):", mval(T).str(35))
print("w:", W.str(35))
print("step mass upper:", moments[0].str(35))
print("smallest GU pivot:", pivot_u.str(35))
print("smallest 0.99I-Q pivot:", pivot_r.str(35))
print("smallest rank-one Schur pivot:", pivot_schur.str(35))
print("Taylor remainder:", remainder)
print("CERTIFIED: tau_1/2 < 1 and A_1/2^odd >= 7/1000000 I")
