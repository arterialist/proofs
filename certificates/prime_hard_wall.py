"""Finite exact and numerical diagnostics for the hard-wall report."""
import cmath
import itertools
import math
from fractions import Fraction

primes = (2, 3, 5)
N = 6
states = []
for bits in itertools.product((0, 1), repeat=len(primes)):
    n = math.prod(p ** b for p, b in zip(primes, bits))
    if n <= N:
        states.append(bits)
assert len(states) == 5

def covariance(i, j):
    return Fraction(sum(a[i] * a[j] for a in states), len(states)) - Fraction(sum(a[i] for a in states) * sum(a[j] for a in states), len(states) ** 2)

assert covariance(0, 1) == Fraction(1, 25)
assert covariance(0, 2) == Fraction(-2, 25)
upper_zero = (1 + complex(-2, 1)) ** 2 + complex(0, 2)
assert upper_zero == 0
assert (1 - Fraction(1, 2)) ** 2 - Fraction(1, 4) == 0

def logistic(v):
    if v >= 0:
        return 1 / (1 + math.exp(-v))
    a = math.exp(v)
    return a / (1 + a)

kappa = 36
L = math.log(6.5)
w = {n: logistic(kappa * (L - math.log(n))) for n in (1, 2, 3, 5, 6, 10, 15, 30)}
A, B, C, D = w[1] + w[5], w[2] + w[10], w[3] + w[15], w[6] + w[30]
soft_rayleigh = B * C - A * D
assert soft_rayleigh < 0

def mobius(n):
    result = 1
    p = 2
    while p * p <= n:
        if n % p == 0:
            n //= p
            result = -result
            if n % p == 0:
                return 0
        p += 1
    if n > 1:
        result = -result
    return result

test_N, test_kappa = 100, 4000
x = test_N + 0.5
hard = sum(mobius(n) for n in range(1, test_N + 1))
soft = sum(mobius(n) * logistic(test_kappa * math.log(x / n)) for n in range(1, 1001))
bound = (test_N / x) ** test_kappa * (1 + test_N / (test_kappa + 1)) + (x / (test_N + 1)) ** test_kappa * (1 + (test_N + 1) / (test_kappa - 1))
assert abs(soft - hard) <= bound + 1e-12

print("Exact prime occupation covariance and zero checks passed.")
print("Floating-point soft-wall diagnostics only:", soft_rayleigh, abs(soft-hard), bound)
