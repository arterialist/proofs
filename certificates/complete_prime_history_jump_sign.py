"""Exact rational corner checks for the complete-history jump sign proof.

Logarithms use an explicit positive-series remainder. Square roots use an
integer-square-root enclosure. No floating-point value decides a sign.
"""
from fractions import Fraction as Q
from math import isqrt

Interval = tuple[Q, Q]


def point(a: int | Q) -> Interval:
    return Q(a), Q(a)


def add(a: Interval, b: Interval) -> Interval:
    return a[0] + b[0], a[1] + b[1]


def mul(a: Interval, b: Interval) -> Interval:
    v = [u * w for u in a for w in b]
    return min(v), max(v)


def scale(a: Interval, c: int | Q) -> Interval:
    return mul(a, point(c))


def sqrt_interval(n: int) -> Interval:
    unit = 10**20
    k = isqrt(n * unit**2)
    return Q(k, unit), Q(k + 1, unit)


def log_interval(n: int) -> Interval:
    t = Q(n - 1, n + 1)
    terms = 200
    lo = 2 * sum((t ** (2 * k + 1) / (2 * k + 1)
                  for k in range(terms)), Q(0))
    remainder = 2 * t ** (2 * terms + 1) / ((2 * terms + 1) * (1 - t * t))
    return lo, lo + remainder


def raw_jump(p: int, exponent: int) -> Interval:
    ell, r = log_interval(p), sqrt_interval(p)
    result, power = point(1), point(1)
    for k in range(1, exponent + 1):
        power = mul(power, r)
        coefficient = add(scale(ell, k - 1), point(-2))
        result = add(result, mul(mul(ell, power), coefficient))
    return result


def require(condition: bool, label: str) -> None:
    if not condition:
        raise RuntimeError(f"Certificate failed: {label}")


def main() -> None:
    first_positive = {2: 6, 3: 4, 5: 3, 7: 3, 11: 3, 13: 2}
    for p, first in first_positive.items():
        for exponent in range(1, first):
            interval = raw_jump(p, exponent)
            require(interval[1] < 0, f"J_{{{p}^{exponent}}}<0")
        interval = raw_jump(p, first)
        require(interval[0] > 0, f"J_{{{p}^{first}}}>0")
        require((first - 1) * log_interval(p)[0] > 2,
                f"later raw increments positive for p={p}")
    ell2, r2 = log_interval(2), sqrt_interval(2)
    t2 = mul(ell2, r2)
    require(Q(97, 100) < t2[0] and t2[1] < 1, "97/100<t_2<1")
    t22 = mul(ell2, add(r2, point(2)))
    require(t22[0] > Q(23, 10), "t_{2,2}>23/10")
    ell3, r3 = log_interval(3), sqrt_interval(3)
    require(mul(ell3, r3)[0] > Q(9, 5), "t_3>9/5")
    require(mul(log_interval(5), sqrt_interval(5))[0] > Q(7, 2), "t_5>7/2")
    require(mul(ell3, add(r3, point(3)))[0] > 5, "t_{3,2}>5")
    require(mul(ell3, r3)[0] > Q(3, 5) * (1 + r3[1]),
            "log(3)*sqrt(3)/(1+sqrt(3))>3/5")
    require(log_interval(13)[0] > 2, "log(13)>2")
    print("Exact rational certificate passed: prime-power signs and all monotonicity corners.")


if __name__ == "__main__":
    main()
