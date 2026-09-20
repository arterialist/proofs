# Möbius–Stokes boundary decomposition and complete divisor renewal: Lean 4 formalization

**Status:** machine-checked in Lean 4.24.0.
Lean module:
- [formalization/BuildingBlocks/MobiusStokesFiniteBoundary.lean](../../formalization/BuildingBlocks/MobiusStokesFiniteBoundary.lean)
Companion notes:
- [building-blocks/geometry/mobius-stokes-finite-boundary-formalization.md](../../building-blocks/geometry/mobius-stokes-finite-boundary-formalization.md)
- [building-blocks/geometry/mobius-stokes-future-boundary-and-hard-reservoir.md](../../building-blocks/geometry/mobius-stokes-future-boundary-and-hard-reservoir.md)

Attribution: Arterialist RH research team, September 2026.
Foundational axioms: standard Lean 4 foundations only (`[propext, Classical.choice, Quot.sound]`), zero custom axioms.

## Statement

Let $D, N \in \mathbb{N}$ with $D \le N$, and let $p$ be a prime number.
Let $\mu$ denote Mathlib's literal `ArithmeticFunction.moebius`.
Define the bulk Möbius mass on $(D, N]$ by:
\[
 B_{D, N} = \sum_{D < d \le N} \mu(d),
\]
and the $p$-coprime face by:
\[
 F_p(\mathrm{lo}, \mathrm{hi}) = \sum_{\substack{\mathrm{lo} < m \le \mathrm{hi} \\ p \nmid m}} \mu(m).
\]

**Theorem (Möbius–Stokes Boundary Decomposition).**
1. **Complete Divisor Renewal Endpoint:**
   \[
    \sum_{d=1}^N \mu(d) \lfloor N/d \rfloor = 1 \qquad (\forall N \ge 1).
   \]
2. **Primitive Prime Reindexing:**
   The map $d \mapsto d/p$ is a bijection between primitive multiples $\{d \in (D, N] : p \mid d, p^2 \nmid d\}$
   and $p$-coprime cofactors $\{m \in (D/p, N/p] : p \nmid m\}$, and all $p^2 \mid d$ terms vanish ($\mu(d) = 0$).
3. **Möbius–Stokes Boundary Identity:**
   \[
    \boxed{\quad B_{D, N} = F_p(D, N) - F_p(D/p, N/p) \quad}
   \]
4. **Exact Two-Face Endpoint Cancellation:**
   \[
    \boxed{\quad B_{D, N} = F_p(\max(D, N/p), N) - F_p(D/p, \min(D, N/p)). \quad}
   \]

## Formalization notes

- Defined in namespace `BuildingBlocks.MobiusStokesFiniteBoundary`.
- Uses `Finset.sum_bij` for the reindexing theorem `primitive_multiples_reindex`.
- Proved unconditionally with integer arithmetic without assuming squarefree divisors, asymptotic estimates, or the Riemann Hypothesis.
- Certified to depend solely on `[propext, Classical.choice, Quot.sound]`.
