# Compact actual prime-error heat source, terminal charge cancellation, and Laplace identity: Lean 4 formalization

**Status:** machine-checked in Lean 4.24.0.
Lean modules:
- [formalization/BuildingBlocks/ActualCompactHeatEndpoint.lean](../../formalization/BuildingBlocks/ActualCompactHeatEndpoint.lean)
- [formalization/BuildingBlocks/FinitePrimeSourceIntegration.lean](../../formalization/BuildingBlocks/FinitePrimeSourceIntegration.lean)
- [formalization/BuildingBlocks/ActualFiniteHeatSource.lean](../../formalization/BuildingBlocks/ActualFiniteHeatSource.lean)
- [formalization/BuildingBlocks/GoldbachHeatQuadratic.lean](../../formalization/BuildingBlocks/GoldbachHeatQuadratic.lean)

Attribution: Arterialist RH research team, September 2026.
Foundational axioms: standard Lean 4 foundations only (`[propext, Classical.choice, Quot.sound]`), zero custom axioms.

## Statement

For any integer $N \ge 1$ and real $t$, define the compact actual prime-error heat source by:
\[
 \operatorname{compactHeat}(N, t) := \sum_{n=2}^N \Lambda(n) e^{-nt} - \int_1^N e^{-xt}\,dx - e^{-t} - (\psi(N) - N) e^{-Nt}.
\]

**Theorem (Compact Prime-Error Heat Source and Laplace Identity).**
1. **Laplace Integral Representation:**
   For all $N \ge 1$ and all $t \in \mathbb{R}$:
   \[
    \operatorname{compactHeat}(N, t) = t \int_1^N (\psi(x) - x) e^{-xt}\,dx.
   \]
2. **Total Charge Cancellation at Zero Frequency:**
   For all $N \ge 1$:
   \[
    \operatorname{compactHeat}(N, 0) = 0.
   \]
3. **Relation to Centered Goldbach Packet:**
   \[
    \operatorname{compactHeat}(N, t) = H_{\mathrm{Goldbach}}(N, t) + \Delta_{\mathrm{density}}(N, t) - (\psi(N) - N) e^{-Nt},
   \]
   where $\Delta_{\mathrm{density}}(N, t) = \sum_{n=2}^N e^{-nt} - \int_1^N e^{-xt}\,dx$ is the discrete-minus-continuous density cell correction.
4. **Source Minus Terminal Closed Form:**
   \[
    \operatorname{compactHeat}(N, t) = \operatorname{source}(N, t) - (\psi(N) - N) e^{-Nt}.
   \]

## Mathematical Significance

The bare prime-power sum $\sum_{n \le N} \Lambda(n) e^{-nt} - \int_1^N e^{-xt} dx$ has non-zero net charge at $t=0$, equal to $\psi(N) - N$. In physical diffusion models and spectral trace formulas, this non-zero boundary charge creates severe infrared divergence at $t \to 0^+$.

By subtracting the frozen terminal charge $(\psi(N) - N) e^{-Nt}$ and retaining the initial atom $-e^{-t}$, the resulting distribution $\operatorname{compactHeat}(N, t)$ satisfies exact total charge neutrality $\operatorname{compactHeat}(N, 0) = 0$, and equals the exact derivative-coupled Laplace transform $t \int_1^N (\psi(x) - x) e^{-xt} dx$.

## Formalization Notes

- Machine-checked in `BuildingBlocks.ActualCompactHeatEndpoint`.
- Proved theorems:
  - `compactHeat_eq_source_sub_terminal`
  - `compactHeat_eq_error_integral`
  - `compactHeat_at_zero`
  - `compactHeat_eq_goldbach_packet`
- Relies exclusively on `propext`, `Classical.choice`, and `Quot.sound`.
