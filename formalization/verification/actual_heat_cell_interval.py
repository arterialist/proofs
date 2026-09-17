"""Exact rational-interval checks for actual-heat-renewal-cell-trace-audit.md.

No floating-point calculation enters an enclosure or assertion.
Run: python3 formalization/verification/actual_heat_cell_interval.py
"""

from fractions import Fraction as F
from math import factorial, isqrt

Interval = tuple[F, F]
ONE: Interval = (F(1), F(1))
ZERO: Interval = (F(0), F(0))
N = 100


def add(a: Interval, b: Interval) -> Interval:
    return a[0] + b[0], a[1] + b[1]


def mul(a: Interval, b: Interval) -> Interval:
    products = (a[0] * b[0], a[0] * b[1], a[1] * b[0], a[1] * b[1])
    return min(products), max(products)


def scale(a: Interval, c: F) -> Interval:
    return mul(a, (c, c))


def power_positive(a: Interval, k: int) -> Interval:
    assert 0 <= a[0] <= a[1]
    return a[0] ** k, a[1] ** k


def log_unit(y: F, terms: int = 24) -> Interval:
    """Atanh series enclosure for 1 <= y < 2."""
    assert 1 <= y < 2
    x = (y - 1) / (y + 1)
    partial = 2 * sum(
        (x ** (2 * j + 1) / (2 * j + 1) for j in range(terms)), F(0)
    )
    remainder = 2 * x ** (2 * terms + 1) / (
        (2 * terms + 1) * (1 - x * x)
    )
    return partial, partial + remainder


def log2_interval(terms: int = 24) -> Interval:
    x = F(1, 3)
    partial = 2 * sum(
        (x ** (2 * j + 1) / (2 * j + 1) for j in range(terms)), F(0)
    )
    remainder = 2 * x ** (2 * terms + 1) / (
        (2 * terms + 1) * (1 - x * x)
    )
    return partial, partial + remainder


LOG2 = log2_interval()


def log_integer(n: int) -> Interval:
    exponent = n.bit_length() - 1
    reduced = F(n, 1 << exponent)
    return add(scale(LOG2, F(exponent)), log_unit(reduced))


def exp_minus_rational(x: F) -> Interval:
    """Alternating Taylor bounds S_59 < exp(-x) < S_60."""
    assert 0 < x <= 1
    lower = sum(((-x) ** j / factorial(j) for j in range(60)), F(0))
    upper = lower + x ** 60 / factorial(60)
    assert 0 < lower < upper < 1
    return lower, upper


def sqrt_rational(x: F) -> Interval:
    if x == 1:
        return ONE
    unit = 10**40
    floor = isqrt(x.numerator * unit * unit // x.denominator)
    lower, upper = F(floor, unit), F(floor + 1, unit)
    assert lower * lower <= x < upper * upper
    return lower, upper


def inverse_sqrt(denominator: int) -> Interval:
    return sqrt_rational(F(1, denominator))


def prime_powers(limit: int) -> dict[int, Interval]:
    values: dict[int, Interval] = {}
    for p in range(2, limit + 1):
        if any(p % d == 0 for d in range(2, isqrt(p) + 1)):
            continue
        logarithm = log_integer(p)
        k = p
        while k <= limit:
            assert k not in values
            values[k] = logarithm
            k *= p
    return values


LAMBDA = prime_powers(N)
assert 4 in LAMBDA and 8 in LAMBDA and 9 in LAMBDA
assert 6 not in LAMBDA and 10 not in LAMBDA


def tails(q: F, t: F) -> tuple[F, F]:
    """Upper bounds for P and the positive derivative sum, k > 100."""
    start = N + 1
    tail_p = q**start * (F(start, 1) / (1 - q) + q / (1 - q) ** 2)
    tail_d = (
        q**start
        * t
        * (
            F(start * start, 1) / (1 - q)
            + 2 * start * q / (1 - q) ** 2
            + q * (1 + q) / (1 - q) ** 3
        )
    )
    # Λ(k) <= log k <= k; (tk - 1/2) <= tk for k >= 101.
    return tail_p, tail_d


def heat_intervals(t: F) -> tuple[Interval, Interval, F, F]:
    exponential = exp_minus_rational(t)
    square_root = sqrt_rational(t)
    prime_sum = ZERO
    derivative_sum = ZERO
    for k, logarithm in LAMBDA.items():
        term = mul(logarithm, power_positive(exponential, k))
        prime_sum = add(prime_sum, term)
        derivative_sum = add(derivative_sum, scale(term, t * k - F(1, 2)))
    tail_p, tail_d = tails(exponential[1], t)
    prime_sum = add(prime_sum, (F(0), tail_p))
    derivative_sum = add(derivative_sum, (F(0), tail_d))
    baseline = scale(exponential, -(1 + 1 / t))
    baseline_derivative = scale(
        exponential, -(t + F(1, 2) + F(1, 2) / t)
    )
    b = mul(square_root, add(prime_sum, baseline))
    derivative = mul(square_root, add(derivative_sum, baseline_derivative))
    return b, derivative, tail_p, tail_d


def euler_gamma_interval() -> Interval:
    """Euler-Maclaurin signed remainder at n=20."""
    n = 20
    harmonic = sum((F(1, k) for k in range(1, n + 1)), F(0))
    log_n = log_integer(n)
    center = harmonic - F(1, 2 * n) + F(1, 12 * n * n)
    # H_n = log n + gamma + 1/(2n) - 1/(12n²)
    #       + remainder, with 0 < remainder < 1/(120n⁴).
    return (
        center - log_n[1] - F(1, 120 * n**4),
        center - log_n[0],
    )


def zeta_half_interval() -> Interval:
    """The signed Hurwitz-tail enclosure in audit Eq. (4), n=20."""
    n = 20
    s_n = ZERO
    for k in range(1, n + 1):
        s_n = add(s_n, inverse_sqrt(k))
    root_inverse = inverse_sqrt(n)
    coefficient = 2 * n + F(1, 2) - F(1, 24 * n)
    a_n = add(
        scale(root_inverse, coefficient),
        (F(0), root_inverse[1] / (384 * n**3)),
    )
    return s_n[0] - a_n[1], s_n[1] - a_n[0]


def h_kernel_interior() -> Interval:
    """H(log(5/2)) on the second logarithmic cell."""
    s_two = add(ONE, inverse_sqrt(2))
    minus_zeta = scale(zeta_half_interval(), F(-1))
    minus_volume = scale(sqrt_rational(F(5, 2)), F(-2))
    return add(add(s_two, minus_zeta), minus_volume)


def encloses_in(interval: Interval, lower: str, upper: str) -> None:
    assert F(lower) < interval[0] <= interval[1] < F(upper)


def decimal_floor(value: F, places: int = 18) -> str:
    unit = 10**places
    integer = value.numerator * unit // value.denominator
    sign = "-" if integer < 0 else ""
    magnitude = abs(integer)
    return f"{sign}{magnitude // unit}.{magnitude % unit:0{places}d}"


def decimal_ceil(value: F, places: int = 18) -> str:
    unit = 10**places
    integer = -((-value.numerator * unit) // value.denominator)
    sign = "-" if integer < 0 else ""
    magnitude = abs(integer)
    return f"{sign}{magnitude // unit}.{magnitude % unit:0{places}d}"


def display(label: str, interval: Interval, places: int = 18) -> None:
    print(
        f"{label}: ({decimal_floor(interval[0], places)}, "
        f"{decimal_ceil(interval[1], places)})"
    )


def main() -> None:
    b0, h1, _, _ = heat_intervals(F(1))
    _, derivative2, _, tail2 = heat_intervals(F(1, 2))
    _, derivative3, _, tail3 = heat_intervals(F(1, 3))
    _, derivative_interior, _, _ = heat_intervals(F(2, 5))
    kernel_interior = h_kernel_interior()
    gamma = euler_gamma_interval()
    b_constant = (
        (1 + gamma[0]) / 2,
        (1 + gamma[1]) / 2,
    )
    h0 = add(b0, b_constant)

    encloses_in(b0, "-0.561527", "-0.561526")
    encloses_in(h0, "0.22707", "0.22709")
    encloses_in(h1, "-0.350147", "-0.350145")
    encloses_in(derivative2, "-0.060112", "-0.060111")
    encloses_in(derivative3, "0.070492", "0.070494")
    encloses_in(derivative_interior, "0.018173", "0.018175")
    encloses_in(kernel_interior, "0.00518", "0.00519")
    encloses_in(gamma, "0.57721", "0.57722")
    assert tail2 * inverse_sqrt(2)[1] < F("1.11e-18")
    assert tail3 * inverse_sqrt(3)[1] < F("1.75e-11")

    print(f"prime-power support count through {N}: {len(LAMBDA)}")
    display("gamma", gamma)
    display("b(0)", b0)
    display("h(0+)", h0)
    display("h'(0+)", h1)
    display("h'(log 2)", derivative2)
    display("h'(log 3)", derivative3)
    display("h'(log(5/2))", derivative_interior)
    display("H(log(5/2))", kernel_interior)
    display("derivative tail at log 2", (F(0), tail2 * inverse_sqrt(2)[1]), 24)
    display("derivative tail at log 3", (F(0), tail3 * inverse_sqrt(3)[1]), 24)
    print("all displayed intervals and derivative-tail bounds verified")


if __name__ == "__main__":
    main()
