# Finite hyperbola divisor transfer and cofactor decomposition in Lean 4

**Status:** complete Lean 4 formalization, September 2026.
Compiled in:
- [ActualPrimeCofactorFutureFinite.lean](../../formalization/BuildingBlocks/ActualPrimeCofactorFutureFinite.lean)

Attribution: Arterialist RH research team, September 2026.
The exact finite hyperbola transfer and hard-cutoff cofactor decomposition may be a project-specific formulation. The available documentation does not provide a reproducible worldwide search, so priority is provisional.

## Mathematical content

Using Mathlib's actual von Mangoldt function `ArithmeticFunction.vonMangoldt`:

1. **Weighted Dirichlet identity (`weighted_log_eq_complete_future`):**
   Proves the exact finite hyperbola identity for any complex test weight $g$:
   $$
    \sum_{n=1}^N (\log n) g(n) = \sum_{d=1}^N \Lambda(d) \sum_{k=1}^{\lfloor N/d \rfloor} g(d k).
   $$
2. **Cofactor splitting (`cofactor_sum_one_and_proper`):**
   Splits the inner cofactor sum into the $k=1$ prime contribution and proper cofactors $k \ge 2$:
   $$
    \sum_{k=1}^{\lfloor N/d \rfloor} g(d k) = g(d) + \sum_{k=2}^{\lfloor N/d \rfloor} g(d k).
   $$
3. **Hard-cutoff cofactor transfer (`cofactor_cutoff_transfer`):**
   For any cutoff $C$, under the vanishing hypothesis that $g(d) = 0$ for $d \le C$:
   $$
    \operatorname{primeRow}(N, g) = \operatorname{logRow}(N, g) - \operatorname{lowFullFuture}(N, C, g) - \operatorname{highProperFuture}(N, C, g).
   $$
   Here $\operatorname{lowFullFuture}$ sums over $d \le C$ with all $k \ge 1$, while $\operatorname{highProperFuture}$
   sums over $d > C$ with proper cofactors $k \ge 2$.

### Verification and dependencies
- Lean version: 4.24.0.
- Axiom dependencies: standard Mathlib foundations only (`propext`, `Classical.choice`, `Quot.sound`).
- Zero custom axioms, zero `sorry`.
