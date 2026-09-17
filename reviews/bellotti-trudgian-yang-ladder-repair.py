"""Certified replacement for arXiv:2603.21490v1, Lemma 10 ladder.

Run with: uv run --with python-flint==0.9.0 python reviews/bellotti-trudgian-yang-ladder-repair.py
"""

from fractions import Fraction

from flint import acb, acb_poly, arb, ctx


ctx.prec = 128
c = [4, -8, 2, 20, -9, -34, 27, 91, -27, -201, 32,
     895, 1949, 2389, 1896, 949, 239]
D = 14912370
A = [sum(v * v for v in c)]
A += [2 * sum(c[j] * c[j + k] for j in range(17 - k))
      for k in range(1, 17)]
assert A[0] == D and min(A) > 0
assert Fraction(A[1], D) == Fraction(865534, 497079)
assert Fraction(sum(A[1:]), D) == Fraction(2919857, 828465)
P = acb_poly(c)

primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41,
          43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97]
lower = [
    '0.234195', '0.050073', '0.0073564', '0.00205251',
    '0.00039742', '0.00022273', '0.00009071', '0.00006314',
    '0.00003427', '0.00001656', '0.00001346', '0.0000078',
    '0.00000569', '0.00000491', '0.00000374', '0.00000259',
    '0.00000187', '0.00000169', '0.00000127', '0.00000106',
    '0.00000097', '0.00000077', '0.00000066', '0.00000053',
    '0.00000041',
]
assert len(primes) == len(lower) == 25


def ball(q):
    return arb(q.numerator) / q.denominator


# |G_p''(1,x)| <= M2[p], exactly, because every cosine coefficient is positive.
M2 = [sum((Fraction(A[k] * (m * k) ** 2, D * p ** m)
           for m in range(1, 16) for k in range(1, 17)), Fraction(0))
      for p in primes]
N = 32768
threshold = [ball(Fraction(b)) + 5 * ball(m2) / N ** 2
             for b, m2 in zip(lower, M2)]
weights = [[arb(1) / p ** m for m in range(1, 16)] for p in primes]

# G_p is even and 2*pi-periodic. Linear interpolation between adjacent
# grid points has error <= M2 * (2*pi/N)^2 / 8 < 5*M2/N^2.
for j in range(N // 2 + 1):
    z = acb(0, 2 * arb.pi() * j / N).exp()
    zm = acb(1)
    values = [arb(0) for _ in primes]
    for m in range(15):
        zm *= z
        v = P(zm)
        pmx = (v.real * v.real + v.imag * v.imag) / D
        for i in range(25):
            values[i] += weights[i][m] * pmx
    for value, bound in zip(values, threshold):
        assert value > bound

# Arb comparisons include all rounding error in the logarithms.
weighted = sum(arb(p).log() * ball(Fraction(b))
               for p, b in zip(primes, lower))
assert weighted > arb('0.235484')

# Terms p^m > e^59 cannot use the paper's Lemma 11. Their total is <2e-9:
# at most 375 terms, p^(-m*sigma)<e^(-59/2)<2e-13,
# log(p)<5, and P(x)<=sum(a_k)<5 for sigma>=sigma0>1/2.
kappa = arb(433) / 859
assert kappa * (weighted - arb('0.000000002')) > arb('0.1187')
print('Certified: weighted ladder > 0.235484 and corrected Lemma 10 > 0.1187 f(0).')
