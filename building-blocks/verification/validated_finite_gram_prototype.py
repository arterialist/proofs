#!/usr/bin/env python3
"""Exact-rational preflight for the radius-two constrained Gram certificate.

This program deliberately has no floating-point path.  It accepts outward
rational intervals for the *actual* theta entries, checks that the four real
constraint rows are present, combines coherent port terms before estimating,
and applies reproducible Gershgorin/Schur sufficient tests.  The distributed
template is incomplete because the published sources do not contain a
validated killed ground or a concrete finite observation row.
"""

from __future__ import annotations

import argparse
import json
from dataclasses import dataclass
from fractions import Fraction
from pathlib import Path
from typing import Any


@dataclass(frozen=True)
class I:
    lo: Fraction
    hi: Fraction

    def __post_init__(self) -> None:
        if self.hi < self.lo:
            raise ValueError(f"reversed interval [{self.lo}, {self.hi}]")

    def __add__(self, other: "I") -> "I":
        return I(self.lo + other.lo, self.hi + other.hi)

    def __sub__(self, other: "I") -> "I":
        return I(self.lo - other.hi, self.hi - other.lo)

    def __mul__(self, other: "I") -> "I":
        xs = (self.lo * other.lo, self.lo * other.hi,
              self.hi * other.lo, self.hi * other.hi)
        return I(min(xs), max(xs))

    def maxabs(self) -> Fraction:
        return max(abs(self.lo), abs(self.hi))

    def out(self) -> list[str]:
        return [str(self.lo), str(self.hi)]


def q(x: str | int) -> Fraction:
    return Fraction(x)


def iv(x: Any, name: str, missing: list[str]) -> I | None:
    if x is None:
        missing.append(name)
        return None
    if not isinstance(x, list) or len(x) != 2:
        raise ValueError(f"{name}: expected [rational lower, rational upper]")
    return I(q(x[0]), q(x[1]))


def matrix(raw: Any, name: str, n: int, missing: list[str],
           symmetric: bool = True) -> list[list[I]] | None:
    if raw is None:
        missing.append(name)
        return None
    if len(raw) != n or any(len(row) != n for row in raw):
        raise ValueError(f"{name}: expected {n} by {n}")
    ans: list[list[I]] = []
    for i, row in enumerate(raw):
        ans.append([])
        for j, x in enumerate(row):
            z = iv(x, f"{name}[{i},{j}]", missing)
            if z is None:
                return None
            ans[-1].append(z)
    if symmetric:
        for i in range(n):
            for j in range(n):
                if ans[i][j] != ans[j][i]:
                    raise ValueError(f"{name}: interval matrix is not exactly symmetric")
    return ans


def madd(xs: list[list[list[I]]]) -> list[list[I]]:
    n = len(xs[0])
    return [[sum((a[i][j] for a in xs), I(Fraction(0), Fraction(0)))
             for j in range(n)] for i in range(n)]


def gershgorin_lower(a: list[list[I]]) -> Fraction:
    return min(a[i][i].lo - sum(a[i][j].maxabs() for j in range(len(a)) if j != i)
               for i in range(len(a)))


def gershgorin_upper(a: list[list[I]]) -> Fraction:
    return max(a[i][i].hi + sum(a[i][j].maxabs() for j in range(len(a)) if j != i)
               for i in range(len(a)))


def rational_even_mesh(level: int) -> dict[str, Any]:
    """Even linear hats on [0,2], reflected to [-2,2]."""
    knots = [Fraction(2 * j, level) for j in range(level + 1)]
    hats = []
    for j, t in enumerate(knots):
        support = [knots[max(0, j - 1)], knots[min(level, j + 1)]]
        hats.append({"index": j, "center": str(t),
                     "positive_half_support": [str(x) for x in support],
                     "reflection": "h_j(-u)=h_j(u)"})
    # Exact Lebesgue Gram is only a mesh implementation check, not theta data.
    h = Fraction(2, level)
    gram = [[Fraction(0) for _ in hats] for _ in hats]
    for i in range(level + 1):
        gram[i][i] = (Fraction(2, 3) * h if i in (0, level)
                      else Fraction(4, 3) * h)
        if i < level:
            gram[i][i + 1] = gram[i + 1][i] = Fraction(1, 3) * h
    return {"knots": [str(x) for x in knots], "hats": hats,
            "unweighted_even_L2_gram_mesh_check": [[str(x) for x in row] for row in gram],
            "warning": "This Gram uses du, not dnu=b*Phi du, and is never used as theta evidence."}


def run(doc: dict[str, Any]) -> dict[str, Any]:
    missing: list[str] = []
    required_rows = ["mean", "a_c", "Re_J", "Im_J"]
    if doc.get("constraints", {}).get("row_names") != required_rows:
        raise ValueError(f"constraint rows must be exactly {required_rows}")
    n = int(doc["trial_dimension"])
    if doc.get("constraints", {}).get("exact_projection_provenance") is None:
        missing.append("constraints.exact_projection_provenance")
    rows = doc["constraints"].get("rows")
    if rows is None:
        missing.append("constraints.rows (exact residuals on constrained basis)")
    elif len(rows) != 4 or any(len(row) != n for row in rows):
        raise ValueError("constraints.rows must be 4 by trial_dimension")
    elif any(x is None for row in rows for x in row):
        missing.append("constraints.rows contains unpublished entries")
    elif any(q(x) != 0 for row in rows for x in row):
        raise ValueError("constrained-basis row residuals must be exact rational zero")

    alpha = iv(doc.get("alpha_2"), "alpha_2", missing)
    mass = matrix(doc.get("mass"), "mass", n, missing)
    kc = matrix(doc.get("killed", {}).get("continuous"), "killed.continuous", n, missing)
    kph = matrix(doc.get("killed", {}).get("prime_head"), "killed.prime_head", n, missing)
    kpt = matrix(doc.get("killed", {}).get("prime_tail"), "killed.prime_tail", n, missing)
    for ledger in ("prime_head_ledger", "prime_tail_bound_provenance"):
        if doc.get("killed", {}).get(ledger) is None:
            missing.append(f"killed.{ledger}")

    port_parts = []
    for label in ("continuous_continuous", "continuous_prime",
                  "prime_continuous", "prime_prime"):
        z = matrix(doc.get("port", {}).get(label), f"port.{label}", n, missing,
                   symmetric=label in ("continuous_continuous", "prime_prime"))
        if z is not None:
            port_parts.append(z)
    for scalar in ("a_normalization", "psi2_enclosure_provenance",
                   "prime_head_complete_through", "prime_tail_bound",
                   "exterior_tail_bound", "prime_head_ledger",
                   "orientation_ledger"):
        if doc.get("port", {}).get(scalar) is None:
            missing.append(f"port.{scalar}")

    lam = iv(doc.get("complement", {}).get("lambda_N_plus_1"),
             "complement.lambda_N_plus_1", missing)
    p0 = iv(doc.get("complement", {}).get("P0"), "complement.P0", missing)
    delta = iv(doc.get("complement", {}).get("mixed_normalized_norm"),
               "complement.mixed_normalized_norm", missing)

    out: dict[str, Any] = {
        "classification": "INCOMPLETE — no numerical evidence",
        "trial_dimension": n,
        "missing": sorted(set(missing)),
        "tests": {},
    }
    if missing:
        return out

    assert alpha and mass and kc and kph and kpt and lam and p0 and delta
    k = madd([kc, kph, kpt])
    # A = K-alpha M, with interval multiplication preserving outward bounds.
    a_mat = [[k[i][j] - alpha * mass[i][j] for j in range(n)] for i in range(n)]
    p_mat = madd(port_parts)
    for i in range(n):
        for j in range(n):
            if p_mat[i][j] != p_mat[j][i]:
                raise ValueError("combined coherent port enclosure is not exactly symmetric")
    a_floor = gershgorin_lower(a_mat)
    p_ceiling = gershgorin_upper(p_mat)
    gap = lam.lo - alpha.hi
    if a_floor <= 0 or gap <= 0:
        out["classification"] = "REJECTED by exact sufficient preconditions"
        out["tests"] = {"A_floor": str(a_floor), "complement_gap": str(gap)}
        return out
    r_hi = max(Fraction(0), p_ceiling) / a_floor
    beta_hi = max(Fraction(0), p0.hi) / gap
    d_hi = delta.maxabs()
    coarse = r_hi + beta_hi <= 1
    schur = (r_hi <= 1 and beta_hi <= 1 and
             d_hi * d_hi <= (1 - r_hi) * (1 - beta_hi))
    out["classification"] = "CERTIFIED" if coarse or schur else "QUANTIFIED SUFFICIENT-TEST DEFICIT"
    out["tests"] = {
        "A_gershgorin_floor": str(a_floor),
        "P_gershgorin_ceiling": str(p_ceiling),
        "r_upper": str(r_hi), "beta_upper": str(beta_hi),
        "coarse_sum": str(r_hi + beta_hi),
        "coarse_deficit_over_one": str(max(Fraction(0), r_hi + beta_hi - 1)),
        "delta_upper": str(d_hi),
        "schur_rhs": str((1-r_hi)*(1-beta_hi)),
        "coarse_accept": coarse, "schur_accept": schur,
    }
    return out


def main() -> None:
    ap = argparse.ArgumentParser()
    ap.add_argument("certificate", type=Path)
    ap.add_argument("--write-mesh", type=Path)
    ap.add_argument("--mesh-level", type=int, default=4)
    args = ap.parse_args()
    if args.write_mesh:
        args.write_mesh.write_text(json.dumps(rational_even_mesh(args.mesh_level), indent=2) + "\n")
    result = run(json.loads(args.certificate.read_text()))
    print(json.dumps(result, indent=2))


if __name__ == "__main__":
    main()
