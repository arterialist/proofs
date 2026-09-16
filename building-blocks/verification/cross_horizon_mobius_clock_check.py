from fractions import Fraction
from math import ceil, log, sqrt


def mobius_sieve(limit: int) -> list[int]:
    mu = [1] * (limit + 1)
    is_prime = [True] * (limit + 1)
    mu[0] = 0
    for p in range(2, limit + 1):
        if is_prime[p]:
            for n in range(p, limit + 1, p):
                if n != p:
                    is_prime[n] = False
                mu[n] *= -1
            for n in range(p * p, limit + 1, p * p):
                mu[n] = 0
    return mu


def clock_field(mu: list[int], D: int, T: int, N: int, q: Fraction) -> Fraction:
    return sum(
        (mu[d] * (1 - q ** (N // d))
         for d in range(D + 1, min(T, N + 1))),
        Fraction(0),
    )


X = 100
D = ceil(sqrt(X))
T = ceil(X * log(X))
mu = mobius_sieve(T)

q = Fraction(1, 2)
g100 = clock_field(mu, D, T, 100, q)
g101 = clock_field(mu, D, T, 101, q)
g102 = clock_field(mu, D, T, 102, q)
d101 = g101 - g100
d102 = g102 - g101

assert (g100, d101) == (Fraction(57, 512), Fraction(-1, 2))
assert 2 * g100 * d101 == Fraction(-57, 512)
assert d101 * d101 == Fraction(1, 4)
assert g101 * g101 - g100 * g100 == Fraction(71, 512)
assert (g101, d102) == (Fraction(-199, 512), Fraction(-9, 64))
assert 2 * g101 * d102 == Fraction(1791, 16384)

for q in (Fraction(1, 4), Fraction(1, 10)):
    values = [clock_field(mu, D, T, n, q) for n in range(X, 2 * X + 1)]
    assert any(2 * values[i - 1] * (values[i] - values[i - 1]) > 0
               for i in range(1, len(values)))

Xh = 128
Dh = ceil(sqrt(Xh))
muh = mobius_sieve(2 * Xh)
packet = []
running = sum(muh[Dh + 1:Xh + 1])
for n in range(Xh, 2 * Xh):
    if n > Xh:
        running += muh[n]
    packet.append(running)


def haar_detail_energy(xs: list[int]) -> Fraction:
    if len(xs) == 1:
        return Fraction(0)
    half = len(xs) // 2
    left, right = xs[:half], xs[half:]
    top = Fraction((sum(left) - sum(right)) ** 2, len(xs))
    return top + haar_detail_energy(left) + haar_detail_energy(right)


total = sum(x * x for x in packet)
root = Fraction(sum(packet) ** 2, len(packet))
details = haar_detail_energy(packet)
assert (total, root, details) == (867, Fraction(2809, 128), Fraction(108167, 128))
assert Fraction(total) == root + details

print("Certified cross-horizon counterexamples and exact Haar identity")
