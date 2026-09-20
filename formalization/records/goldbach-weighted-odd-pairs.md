# Odd-centered Goldbach pairs and symmetric weight reflection: Lean 4 formalization

**Status:** machine-checked in Lean 4.24.0.
Lean modules:
- [formalization/BuildingBlocks/GoldbachWeightedOddPairs.lean](../../building-blocks/BuildingBlocks/GoldbachWeightedOddPairs.lean)
- [formalization/BuildingBlocks/GoldbachOddPairs.lean](../../building-blocks/BuildingBlocks/GoldbachOddPairs.lean)
- [formalization/BuildingBlocks/GoldbachOddCentering.lean](../../building-blocks/BuildingBlocks/GoldbachOddCentering.lean)
Companion note:
- [building-blocks/goldbach/goldbach-symmetric-angular-coefficient-formalization.md](../../building-blocks/goldbach/goldbach-symmetric-angular-coefficient-formalization.md)

Attribution: Arterialist RH research team, September 2026.
Foundational axioms: standard Lean 4 foundations only (`[propext, Classical.choice, Quot.sound]`), zero custom axioms.

## Statement

Let $N \ge 2$ be an integer. The odd-centered prime source is defined on $a \in \{1, \ldots, N-1\}$ by:
\[
 o(a) = \begin{cases} \Lambda(a) - 2, & a \text{ odd}, \\ 0, & a \text{ even}. \end{cases}
\]
In particular, $o(1) = -2$ since $\Lambda(1) = 0$.
Let $w: \mathbb{N} \to \mathbb{R}$ be any symmetric weight satisfying $w(N-a) = w(a)$ on $[1, N-1]$.

**Theorem (Centered Odd Goldbach Pair Expansion).**
1. **Weighted Reflection Expansion:**
   For any even integer $N$:
   \[
    \boxed{\quad \sum_{a=1}^{N-1} o(a) o(N-a) w(a) = \sum_{\substack{1 \le a < N \\ a, N-a \text{ odd}}} \Lambda(a)\Lambda(N-a)w(a) - 4 \sum_{\substack{1 \le a < N \\ a \text{ odd}}} \Lambda(a) w(a) + 4 \sum_{\substack{1 \le a < N \\ a \text{ odd}}} w(a). \quad}
   \]
2. **Unweighted Count Evaluation:**
   For $N = 2m$, the number of odd integers in $[1, 2m-1]$ is exactly $m$, and the unweighted centered sum evaluates to:
   \[
    A(2m) = R_{\rm odd}(2m) - 4 \cdot \mathrm{oddWeight}(2m) + 4m,
   \]
   with initial condition $A(2) = 4$.
3. **Even Support Rigidity:**
   $\Lambda(2k) \ne 0 \iff 2k = 2^j$ is a pure power of 2.

## Formalization notes

- Modules: `BuildingBlocks.GoldbachWeightedOddPairs`, `BuildingBlocks.GoldbachOddPairs`, `BuildingBlocks.GoldbachOddCentering`.
- Formally audited: all compiled cleanly with zero `sorry` placeholders and standard foundational axioms `[propext, Classical.choice, Quot.sound]`.
- Directly connects additive Goldbach pairs to symmetric angular kernels without requiring unproved analytic bounds.
