#!/usr/bin/env python3
"""Emit the exact symbolic ledger for the canonical finite edge observation.

No theta or ground values are evaluated.  The output enumerates every prime
power q <= M, both orientations, and the rational dyadic start-point cells.
The actual cell is obtained by intersecting with E_M at both endpoints.
"""

from __future__ import annotations
import argparse, json
from fractions import Fraction


def prime_power(q: int) -> tuple[int, int] | None:
    for p in range(2, q + 1):
        if any(p % d == 0 for d in range(2, int(p ** 0.5) + 1)):
            continue
        x, k = p, 1
        while x < q:
            x *= p
            k += 1
        if x == q:
            return p, k
    return None


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("--M", type=int, default=64)
    ap.add_argument("--level", type=int, default=2)
    args = ap.parse_args()
    if args.M < 2 or args.level < 0:
        raise SystemExit("require M >= 2 and level >= 0")
    powers = []
    for q in range(2, args.M + 1):
        pk = prime_power(q)
        if pk:
            p, k = pk
            powers.append({"q": q, "prime": p, "exponent": k,
                           "Lambda_q": f"log({p})",
                           "orientations": [-1, 1]})
    width = Fraction(1, 2 ** args.level)
    cells = []
    start = Fraction(-args.M)
    while start < args.M:
        cells.append([str(start), str(start + width)])
        start += width
    out = {
        "status": "symbolic exact ledger; no validated masses",
        "M": args.M, "dyadic_level": args.level,
        "start_cells": cells,
        "prime_powers": powers,
        "edge_cell_formula":
            "D(q,sigma,I)={(u,v): u in I intersect E_M, v=u+sigma*log(q) in E_M}",
        "cell_mass_formula":
            "m_D=integral_D [Lambda(q)/sqrt(q)]*psi(u)*psi(v)*Phi(u)*Phi(v)/((a+ell(u))*(a+ell(v))) du",
        "coordinate_formula":
            "O_D(f)=0 if m_D=0, else (2*m_D)^(-1/2)*integral_D (f(v)/rho(v)-f(u)/rho(u)) d sigma_M",
        "warning": "The source proves that some finite member detects each fixed compact source class, but supplies no effective M or dyadic level."
    }
    print(json.dumps(out, indent=2))


if __name__ == "__main__":
    main()
