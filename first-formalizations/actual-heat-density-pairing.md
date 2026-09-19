# Exact actual heat density pairing and prime source Gram evaluation: Lean 4 formalization

**Status:** machine-checked in Lean 4.24.0.
Lean modules:
- [formalization/BuildingBlocks/ActualFiniteHeatSource.lean](../formalization/BuildingBlocks/ActualFiniteHeatSource.lean)
- [formalization/BuildingBlocks/AdditiveHeatPairing.lean](../formalization/BuildingBlocks/AdditiveHeatPairing.lean)
- [formalization/BuildingBlocks/ActualHeatDensityPairing.lean](../formalization/BuildingBlocks/ActualHeatDensityPairing.lean)

Attribution: Arterialist RH research team, September 2026.
Foundational axioms: standard Lean 4 foundations only (`[propext, Classical.choice, Quot.sound]`), zero custom axioms.

## Statement

Let $N \ge 1$ be an integer. The actual finite prime heat source is defined on $t \in (0, \infty)$ by:
\[
 \operatorname{source}(N, t) := \sum_{n=1}^N \Lambda(n) e^{-nt} - e^{-t} - \int_1^N e^{-yt}\,dy.
\]
Here $\operatorname{density}(N, t) := \int_1^N e^{-yt}\,dy = \frac{e^{-t} - e^{-Nt}}{t}$.

**Theorem (Actual Heat Density Pairing and Prime Source Gram Evaluation).**
1. **Exponential Heat Kernel Pairing:** For any $x, y > 0$:
   \[
    \int_0^\infty e^{-xt} e^{-yt}\,dt = \frac{1}{x + y}.
   \]
2. **Mixed Discrete-Continuous Density Pairing:** For any $x \ge 1$ and $N \ge 1$:
   \[
    \int_0^\infty e^{-xt} \operatorname{density}(N, t)\,dt = \log\left( \frac{x + N}{x + 1} \right).
   \]
3. **Continuous Background Self-Energy:** For any $N \ge 1$:
   \[
    \int_0^\infty \operatorname{density}(N, t)^2\,dt = 2N \log(2N) - 2(N+1) \log(N+1) + 2\log 2.
   \]
4. **Exact Actual Prime Source $L^2$ Gram Evaluation:**
   With atomic coefficients $c_n = \Lambda(n) - \mathbf{1}_{n=1}$ and coordinates $x_n = \max(n, 1)$:
   \[
   \begin{aligned}
    \int_0^\infty \operatorname{source}(N, t)^2\,dt ={}& \sum_{i, j \le N} \frac{c_i c_j}{x_i + x_j} - 2\sum_{i \le N} c_i \log\left( \frac{x_i + N}{x_i + 1} \right) \\
    &+ \Big[ 2N\log(2N) - 2(N+1)\log(N+1) + 2\log 2 \Big].
   \end{aligned}
   \]

## Mathematical Proof Overview

1. **Mixed density integral:** Fubini's theorem swaps $\int_1^N dy \int_0^\infty dt \, e^{-(x+y)t} = \int_1^N \frac{dy}{x+y} = \log\frac{x+N}{x+1}$.
2. **Density square integral:** Fubini's theorem on the double integral $\int_1^N \int_1^N \frac{du\,dv}{u+v}$ integrates $u+v$ along the diagonal coordinates, yielding the exact closed form $2N\log(2N) - 2(N+1)\log(N+1) + 2\log 2$.
3. **Profile decomposition:** Writing $\operatorname{source}(N, t) = \operatorname{profile}(t) - \operatorname{density}(N, t)$, expanding the square $(P - D)^2 = P^2 - 2PD + D^2$, and integrating termwise establishes the exact Gram formula.

## Formalization Notes

- Fully machine-checked in `BuildingBlocks.ActualHeatDensityPairing`.
- Verified theorems:
  - `mixed_joint_integrable`: Joint integrability of $e^{-xt} e^{-yt}$ on $[1, N] \times (0, \infty)$.
  - `mixed_density_integral`: Exact evaluation to $\log((x+N)/(x+1))$.
  - `density_square_closed_formula`: Exact evaluation of $\int_0^\infty D_N(t)^2 dt$.
  - `complete_density_gram`: General quadratic Gram formula for any finite profile.
  - `actual_source_profile`: Identification of $\operatorname{source}(N, t)$ as an atomic profile minus density.
  - `actual_source_gram`: The exact closed-form evaluation of $\int_0^\infty \operatorname{source}(N, t)^2 dt$.
- Relies exclusively on `propext`, `Classical.choice`, and `Quot.sound`.
