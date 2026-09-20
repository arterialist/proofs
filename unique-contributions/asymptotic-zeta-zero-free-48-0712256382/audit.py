#!/usr/bin/env python3
"""Independent exact audit of the degree-110 minimal-Fejer repair.

The candidate is parsed as syntax and is never executed.  This checker
reconstructs all autocorrelations, the active coefficient threshold, the
theta enclosure, the cubed objective comparison, and two directional costs.
"""

from __future__ import annotations

import ast
from fractions import Fraction as Q
from pathlib import Path


ROOT = Path(__file__).resolve().parent
CANDIDATE = ROOT / "certificate.py"
K = 110


def rows_from_syntax() -> list[list[int]]:
    tree = ast.parse(CANDIDATE.read_text())
    for node in tree.body:
        if isinstance(node, ast.Assign):
            if any(isinstance(t, ast.Name) and t.id == "OPT_ROWS" for t in node.targets):
                rows = ast.literal_eval(node.value)
                assert len(rows) == 68
                assert all(len(row) == K + 1 for row in rows)
                assert all(type(x) is int for row in rows for x in row)
                return rows
    raise AssertionError("OPT_ROWS literal not found")


def autocorrelations(rows: list[list[int]]) -> list[Q]:
    den = sum(x * x for row in rows for x in row)
    assert den > 0
    return [Q(1)] + [
        Q(2 * sum(row[j] * row[j + k] for row in rows for j in range(K + 1 - k)), den)
        for k in range(1, K + 1)
    ]


def sin_interval(x: Q, terms: int = 40) -> tuple[Q, Q]:
    term = x
    total = term
    for n in range(terms):
        term = -term * x * x / ((2 * n + 2) * (2 * n + 3))
        total += term
    following = -term * x * x / ((2 * terms + 2) * (2 * terms + 3))
    return min(total, total + following), max(total, total + following)


def cos_interval(x: Q, terms: int = 40) -> tuple[Q, Q]:
    term = Q(1)
    total = term
    for n in range(terms):
        term = -term * x * x / ((2 * n + 1) * (2 * n + 2))
        total += term
    following = -term * x * x / ((2 * terms + 1) * (2 * terms + 2))
    return min(total, total + following), max(total, total + following)


def root_interval(x: Q, b1: Q) -> tuple[Q, Q]:
    sl, su = sin_interval(x)
    cl, cu = cos_interval(x)
    assert 0 < sl <= su and 0 < cl <= cu
    return (
        sl * sl - b1 + b1 * x * cl / su,
        su * su - b1 + b1 * x * cu / sl,
    )


def interval_mul(a: tuple[Q, Q], b: tuple[Q, Q]) -> tuple[Q, Q]:
    values = [a[i] * b[j] for i in range(2) for j in range(2)]
    return min(values), max(values)


def interval_div(a: tuple[Q, Q], b: tuple[Q, Q]) -> tuple[Q, Q]:
    assert not (b[0] <= 0 <= b[1])
    values = [a[i] / b[j] for i in range(2) for j in range(2)]
    return min(values), max(values)


def alpha_interval(theta_lo: Q, theta_hi: Q) -> tuple[Q, Q]:
    """Enclose d(log R)/d b1 on the certified theta interval."""
    sl, _ = sin_interval(theta_lo)
    _, su = sin_interval(theta_hi)
    cl, _ = cos_interval(theta_hi)
    _, cu = cos_interval(theta_lo)
    tan_i = (sl / cu, su / cl)
    # h(theta)=sin(theta)^2/(1-theta*cot(theta)).
    d_lo = 1 - theta_hi * cu / sl
    d_hi = 1 - theta_lo * cl / su
    assert 0 < d_lo <= d_hi
    numerator = (
        3 * sl * cl - theta_hi * (1 + 2 * cu * cu),
        3 * su * cu - theta_lo * (1 + 2 * cl * cl),
    )
    assert numerator[1] < 0
    hprime = interval_div(numerator, (d_lo * d_lo, d_hi * d_hi))
    assert hprime[1] < 0
    return interval_div((2 * tan_i[0], 2 * tan_i[1]), hprime)


def decimal(x: Q) -> str:
    return f"{float(x):.17g}"


def main() -> None:
    raw = autocorrelations(rows_from_syntax())
    fejer = [Q(1)] + [Q(2 * (K + 1 - k), K + 1) for k in range(1, K + 1)]

    thresholds = [
        (k, -raw[k] / (fejer[k] - raw[k]))
        for k in range(1, K + 1)
        if raw[k] < 0
    ]
    active_k, minimum_weight = max(thresholds, key=lambda item: item[1])
    assert active_k == 84
    weight = Q(1, 50_000_000_000)
    assert weight > minimum_weight
    b = [weight * fejer[k] + (1 - weight) * raw[k] for k in range(K + 1)]
    assert b[0] == 1 and b[1] > 1 and all(x > 0 for x in b[1:])
    assert min(range(1, K + 1), key=lambda k: b[k]) == 84

    theta_lo = Q(1_132_674_386_860_969, 10**15)
    theta_hi = Q(1_132_674_386_860_970, 10**15)
    assert root_interval(theta_lo, b[1])[0] > 0
    assert root_interval(theta_hi, b[1])[1] < 0

    bellotti = Q(443_795, 100_000)
    target = Q(240_356_128_191, 5_000_000_000)  # 48.0712256382
    cos_lower = cos_interval(theta_hi)[0]
    bsum = sum(b[1:])
    lhs = Q(9, 16) * bsum * bsum * (bsum + 1) * bellotti * bellotti
    rhs = target**3 * cos_lower**6
    assert lhs < rhs
    assert target < Q(480_712_269_117, 10**10)

    # KKT/reduced-cost check.  At a normalized feasible polynomial (r,s),
    # d log R = alpha dr + beta ds.  Along increasing Fejer weight the
    # derivative is positive, so reducing the old 1e-9 repair is a strict
    # feasible descent until coefficient 84 becomes active.
    old_weight = Q(1, 10**9)
    old = [old_weight * fejer[k] + (1 - old_weight) * raw[k] for k in range(K + 1)]
    old_theta_lo = Q(1_132_674_386_730_249, 10**15)
    old_theta_hi = Q(1_132_674_386_730_250, 10**15)
    alpha = alpha_interval(old_theta_lo, old_theta_hi)
    old_sum = sum(old[1:])
    beta = Q(3 * old_sum + 2, 3 * old_sum * (old_sum + 1))
    delta_r = fejer[1] - old[1]
    delta_s = Q(K) - old_sum
    fejer_cost = (
        alpha[0] * delta_r + beta * delta_s,
        alpha[1] * delta_r + beta * delta_s,
    )
    assert fejer_cost[0] > 26

    # A newly added isolated square |1+z^j|^2/2 has (b1,sum b)=(0,1),
    # independently of j>110.  Its normalized mixing reduced cost is positive.
    alpha_part = interval_mul(alpha, (-old[1], -old[1]))
    isolated_cost = (
        alpha_part[0] + beta * (1 - old_sum),
        alpha_part[1] + beta * (1 - old_sum),
    )
    assert isolated_cost[0] > 3

    print(f"active_repair_index={active_k}")
    print(f"exact_minimum_fejer_weight={minimum_weight}")
    print(f"chosen_fejer_weight={weight}")
    print(f"minimum_b84={decimal(b[84])}")
    print(f"fejer_direction_dlogR={decimal(fejer_cost[0])},{decimal(fejer_cost[1])}")
    print(f"isolated_high_mode_reduced_cost={decimal(isolated_cost[0])},{decimal(isolated_cost[1])}")
    print(f"cube_margin={decimal(rhs-lhs)}")
    print("R2 < 48.0712256382 independent exact audit: PASS")


if __name__ == "__main__":
    main()
