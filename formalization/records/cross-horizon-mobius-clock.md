# Cross-horizon Möbius clock: Lean 4 formalization

**Status:** machine-checked in Lean 4.24.0.
Lean module:
- [formalization/BuildingBlocks/CrossHorizonMobiusClockFinite.lean](../../building-blocks/BuildingBlocks/CrossHorizonMobiusClockFinite.lean)
Companion notes:
- [building-blocks/factorial-and-renewal/cross-horizon-mobius-clock-finite-formalization.md](../../building-blocks/factorial-and-renewal/cross-horizon-mobius-clock-finite-formalization.md)
- [building-blocks/factorial-and-renewal/cross-horizon-mobius-clock.md](../../building-blocks/factorial-and-renewal/cross-horizon-mobius-clock.md)

Attribution: Arterialist RH research team, September 2026.
Foundational axioms: standard Lean 4 foundations only (`[propext, Classical.choice, Quot.sound]`), zero custom axioms.

## Statement

Let $0 < D < T$ be divisor bounds, $N \ge 1$ the current arithmetic horizon, and $q \in \mathbb{R}$ a clock variable.
Let $\mu$ denote Mathlib's literal `ArithmeticFunction.moebius`.
Define the horizon window by $\operatorname{hw}(D, T, N) = \{d \in \mathbb{N} : D < d < T, d \le N\}$,
and the divisor clock polynomial by:
\[
 G_N(q) = \sum_{d \in \operatorname{hw}(D, T, N)} \mu(d) (1 - q^{\lfloor N/d \rfloor}).
\]

**Theorem (Cross-Horizon Clock Identities).**
1. **Future Prefix Reversal:**
   For any real $q$ (with zero convergence restrictions):
   \[
    (1 - q) \sum_{0 \le i < N} q^i \sum_{\substack{D < d < T \\ d \le N \\ (i+1)d \le N}} \mu(d)
    = \sum_{\substack{D < d < T \\ d \le N}} \mu(d) (1 - q^{\lfloor N/d \rfloor}).
   \]
2. **Floor Integer Difference Step:**
   For all $d > 0$ and $N \ge 1$:
   \[
    \lfloor N/d \rfloor = \lfloor (N-1)/d \rfloor + \mathbf{1}_{d \mid N}.
   \]
3. **Divisor Polynomial Increment:**
   The horizon step increment isolates the exact divisor-clock jump:
   \[
    \boxed{\quad G_N(q) - G_{N-1}(q) = (1 - q) \sum_{\substack{D < d < T \\ d \mid N}} \mu(d) q^{N/d - 1}. \quad}
   \]
4. **Energy Coboundary and Finite Abel Summation:**
   Exact algebraic expansions $(G + \Delta)^2 - G^2 = 2G\Delta + \Delta^2$ and finite summation by parts bounding terminal energies by positive step increments.

## Formalization notes

- Module: `BuildingBlocks.CrossHorizonMobiusClockFinite`.
- Formally audited: zero `sorry`, standard axioms `[propext, Classical.choice, Quot.sound]`.
- Handles boundary cases at $d=N$ explicitly where a divisor enters the horizon window for the first time.
