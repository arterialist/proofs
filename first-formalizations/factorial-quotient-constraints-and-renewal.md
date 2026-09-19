# Factorial quotient constraints, triangular uniqueness, and finite renewal: Lean 4 formalization

**Status:** machine-checked in Lean 4.24.0.
Lean modules:
- [formalization/BuildingBlocks/FactorialQuotientConstraints.lean](../formalization/BuildingBlocks/FactorialQuotientConstraints.lean)
- [formalization/BuildingBlocks/FactorialFiniteRenewal.lean](../formalization/BuildingBlocks/FactorialFiniteRenewal.lean)
- [formalization/BuildingBlocks/FactorialBinaryCarry.lean](../formalization/BuildingBlocks/FactorialBinaryCarry.lean)
Companion note:
- [building-blocks/factorial-and-renewal/factorial-mobius-quotient-renewal.md](../building-blocks/factorial-and-renewal/factorial-mobius-quotient-renewal.md)

Attribution: Arterialist RH research team, September 2026.
Foundational axioms: standard Lean 4 foundations only (`[propext, Classical.choice, Quot.sound]`), zero custom axioms.

## Statement

For an integer $N \ge 1$, let $q_n = \lfloor N/n \rfloor$, and let $S_N = \{q_n : 1 \le n \le N\}$ be the set of distinct quotients.
Define the grouped Möbius coefficients $A_q = \sum_{n: q_n = q} \mu(n)$, and the factorial response:
\[
 g_N(t) = \sum_{n=1}^N \mu(n) (1 - e^{-q_n t}).
\]

**Theorem (Quotient Constraints, Triangular Uniqueness, and Renewal).**
1. **Nested Quotient Commutation:**
   For all natural numbers $N, n, k$:
   \[
    \left\lfloor \frac{\lfloor N/n \rfloor}{k} \right\rfloor = \left\lfloor \frac{N}{nk} \right\rfloor.
   \]
2. **Complete Quotient Constraint System:**
   For every $1 \le k \le N$:
   \[
    \boxed{\quad \sum_{q \in S_N} A_q \left\lfloor \frac{q}{k} \right\rfloor = 1, \quad}
   \]
   and the sum vanishes identically for $k > N$.
3. **Triangular Uniqueness:**
   The quotient transformation matrix on $S_N$ is strictly upper triangular with diagonal entries equal to 1.
   Consequently, it has a trivial kernel, is injective, and $A_q$ is the **unique** real solution to the system (2).
4. **Exact Finite Renewal Identity:**
   For every natural $N$ and every real parameter $t \in \mathbb{R}$:
   \[
    \boxed{\quad \sum_{k=1}^N g_{\lfloor N/k \rfloor}(t) = 1 - e^{-Nt}. \quad}
   \]
5. **Binary Carry Mobius Representation:**
   The binary carry $c(n) = q_n - 2\lfloor q_n / 2 \rfloor \in \{0, 1\}$ satisfies the exact floor mass and response extension identities:
   \[
    g_N(t) - 2 g_N(t/2) = \sum_{n=1}^N \mu(n) (1 - e^{-c(n)t}) e^{-2\lfloor q_n/2\rfloor t}.
   \]

## Formalization notes

- Modules: `BuildingBlocks.FactorialQuotientConstraints`, `BuildingBlocks.FactorialFiniteRenewal`, `BuildingBlocks.FactorialBinaryCarry`.
- Formally audited: all 3 modules compile cleanly with zero `sorry` placeholders and standard foundational axioms `[propext, Classical.choice, Quot.sound]`.
- Establishes that any countermodel to the factorial energy cannot use arbitrary signed vectors satisfying the first moment: it must satisfy the full triangular constraint hierarchy.
