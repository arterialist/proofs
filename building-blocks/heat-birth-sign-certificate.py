from fractions import Fraction as F


class Interval:
    def __init__(self, lo, hi=None):
        self.lo = F(lo)
        self.hi = self.lo if hi is None else F(hi)

    def __add__(self, other):
        other = other if isinstance(other, Interval) else Interval(other)
        return Interval(self.lo + other.lo, self.hi + other.hi)

    __radd__ = __add__

    def __neg__(self):
        return Interval(-self.hi, -self.lo)

    def __sub__(self, other):
        return self + (-other if isinstance(other, Interval) else -F(other))

    def __mul__(self, other):
        other = other if isinstance(other, Interval) else Interval(other)
        products = [self.lo * other.lo, self.lo * other.hi,
                    self.hi * other.lo, self.hi * other.hi]
        return Interval(min(products), max(products))

    __rmul__ = __mul__


def log_interval(x, terms=64):
    x = F(x)
    if x < 1:
        return -log_interval(1 / x, terms)
    y = (x - 1) / (x + 1)
    lower = 2 * sum((y ** (2 * k + 1)) / (2 * k + 1)
                    for k in range(terms))
    remainder = 2 * y ** (2 * terms + 1) / (
        (2 * terms + 1) * (1 - y * y))
    return Interval(lower, lower + remainder)


def lambda_interval(n):
    prime_base = {2: 2, 3: 3, 4: 2, 5: 5}
    return log_interval(prime_base[n]) if n in prime_base else Interval(0)


def zlog(z):
    return z * log_interval(z) - z


def work_interval(n):
    observation = Interval(-F(1, n + 1))
    observation += sum(lambda_interval(m) * F(1, m + n)
                       for m in range(2, n))
    observation -= log_interval(F(2 * n - 1, n + 1))
    integral = -log_interval(F(n + 1, n))
    integral += sum(lambda_interval(m) * log_interval(F(m + n, m + n - 1))
                    for m in range(2, n))
    integral -= ((zlog(2 * n - 1) - zlog(n + 1))
                 - (zlog(2 * n - 2) - zlog(n)))
    return lambda_interval(n) * observation - integral


for n, lower, upper in [(2, F(174, 1000), F(175, 1000)),
                        (5, -F(134, 1000), -F(133, 1000)),
                        (6, F(185, 1000), F(186, 1000))]:
    result = work_interval(n)
    assert lower < result.lo <= result.hi < upper
    print(f"n={n}: {lower} < heat birth work < {upper}; rational certificate passes")

