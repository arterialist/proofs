"""Exact witness against arXiv:2603.21490v1, Table 1, p=5 entry."""

from fractions import Fraction


c = [4, -8, 2, 20, -9, -34, 27, 91, -27, -201, 32,
     895, 1949, 2389, 1896, 949, 239]
D = 14912370
A = [sum(v * v for v in c)]
A += [2 * sum(c[j] * c[j + k] for j in range(17 - k))
      for k in range(1, 17)]
assert A[0] == D
assert Fraction(A[1], D) == Fraction(865534, 497079)
assert Fraction(sum(A[1:]), D) == Fraction(2919857, 828465)

q = 1000000
a = -78647
U = [1, a]
for j in range(2, 241):
    U.append(2 * a * U[-1] - q * q * U[-2])

# G_5(1, arccos(a/q)) = numerator / denominator exactly.
numerator = sum(
    5 ** (15 - m) * sum(A[k] * q ** (240 - m * k) * U[m * k]
                          for k in range(17))
    for m in range(1, 16)
)
denominator = D * 5 ** 15 * q ** 240

assert 735649 * denominator < 10 ** 8 * numerator
assert 10 ** 8 * numerator < 735650 * denominator
assert 10 ** 8 * numerator < 735709 * denominator  # Table 1 bound
print("0.00735649 < G_5(1, arccos(-78647/1000000)) < 0.00735650")
