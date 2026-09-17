from fractions import Fraction
from math import factorial

# e bounds
elo = Fraction(2721, 1001)
ehi = Fraction(1457, 536)
e_lower_series = sum(Fraction(1, factorial(k)) for k in range(11))
e_upper_series = sum(Fraction(1, factorial(k)) for k in range(10)) + Fraction(11, 10 * factorial(10))
assert elo < e_lower_series
assert e_upper_series < ehi

# Alternating arctangent bounds: 4 terms lower, 5 terms upper.
def atan_bounds(x: Fraction):
    terms = [(-1) ** k * x ** (2 * k + 1) / (2 * k + 1) for k in range(5)]
    lower = sum(terms[:4], Fraction(0))
    upper = sum(terms[:5], Fraction(0))
    return lower, upper

la, ua = atan_bounds(Fraction(1, 5))
lb, ub = atan_bounds(Fraction(1, 239))
pi_lower = 16 * la - 4 * ub
pi_upper = 16 * ua - 4 * lb
assert Fraction(333, 106) < pi_lower
assert pi_upper < Fraction(355, 113)

# Exponent and denominator bounds.
assert Fraction(355, 113) * ehi ** 6 < Fraction(2535, 2)
L = Fraction(333, 106) * (2 * Fraction(333, 106) * elo ** 6 - 3)
assert L > 0

# Squared form of e^(2523/2) / L < 10^544.
assert ehi ** 2523 < L ** 2 * 10 ** 1088

print('Certified: J(3) < 10^544')
