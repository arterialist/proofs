# Unique Contribution 250: Exact Compact Prime-Error Heat Source Laplace Identity and Neutral Charge

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/ActualCompactHeatEndpoint.lean`](../../formalization/BuildingBlocks/ActualCompactHeatEndpoint.lean), [`building-blocks/heat/actual-compact-heat-endpoint.md`](../../building-blocks/heat/actual-compact-heat-endpoint.md)  
**Classification:** Analytic Number Theory / Heat Semigroups / Laplace Transforms / Distributional Integration by Parts / Neutral Total Charge / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the diffusion formulation of prime fluctuations, the step-discontinuous error $\Delta(x) = \psi(x) - x$ acts as a boundary source propagating through the 1D heat semigroup $e^{-xt}$. Truncating this source to a finite compact interval $[1, N]$ introduces artificial boundary effects unless compensated by a frozen terminal charge $-(\psi(N) - N)e^{-Nt}$ and an initial density atom $-e^{-t}$.

This contribution proves:

1. **Exact Compact Heat Source Structure:**  
   The compact heat packet on $[1, N]$:
   \[
   \text{compactHeat}(N, t) = \sum_{n=2}^N \Lambda(n) e^{-nt} - \int_1^N e^{-xt} dx - e^{-t} - (\psi(N) - N) e^{-Nt},
   \]
   relates directly to the discrete centered Goldbach heat packet via the cell density correction:
   \[
   \text{compactHeat}(N, t) = \text{finiteHeat}(\text{centeredCoefficient}, N, t) + \text{densityCellCorrection}(N, t) - (\psi(N) - N) e^{-Nt}.
   \]
2. **Grand Laplace Transform Representation:**  
   For any integer truncation $N \ge 1$ and diffusion parameter $t \in \mathbb{R}$:
   \[
   \text{compactHeat}(N, t) = t \int_1^N (\psi(x) - x) e^{-xt} \, dx.
   \]
   The jump discontinuities of $\psi(x)$ at prime powers and the step changes in the integral kernel are absorbed completely by the frozen terminal charge and the initial boundary term, producing an exact continuous Laplace representation scaled by $t$.
3. **Exact Neutral Total Charge:**  
   Evaluating at $t = 0$:
   \[
   \text{compactHeat}(N, 0) = 0 \quad (\forall N \ge 1).
   \]
   The total charge of the compact heat source vanishes identically for every truncation $N$, guaranteeing that the diffused prime fluctuation field carries zero net electrostatic charge.

---

## 2. Mathematical Proof

### 2.1. Integration by Parts with Jump Discontinuities
Let $w(x) = e^{-xt}$. Its derivative is $w'(x) = -t e^{-xt}$.
By the Stieltjes integration by parts formula for the step function $\Delta(x) = \psi(x) - x$:
\[
\int_1^N \Delta(x) w'(x) \, dx = \Delta(N) w(N) - \Delta(1) w(1) - \int_1^N w(x) \, d\Delta(x).
\]
Since $\Delta(1) = \psi(1) - 1 = 0 - 1 = -1$, the boundary term evaluates to:
\[
(\psi(N) - N) e^{-Nt} - (-1) e^{-t} = (\psi(N) - N) e^{-Nt} + e^{-t}.
\]
The measure increment is $d\Delta(x) = d\psi(x) - dx = \sum_{n=2}^N \Lambda(n) \delta_n(x) - dx$.
Thus:
\[
\int_1^N w(x) \, d\Delta(x) = \sum_{n=2}^N \Lambda(n) e^{-nt} - \int_1^N e^{-xt} \, dx.
\]
Substituting into the integration by parts identity:
\[
\int_1^N (\psi(x) - x) (-t e^{-xt}) \, dx = (\psi(N) - N) e^{-Nt} + e^{-t} - \left( \sum_{n=2}^N \Lambda(n) e^{-nt} - \int_1^N e^{-xt} \, dx \right).
\]
Multiplying by $-1$:
\[
t \int_1^N (\psi(x) - x) e^{-xt} \, dx = \sum_{n=2}^N \Lambda(n) e^{-nt} - \int_1^N e^{-xt} \, dx - e^{-t} - (\psi(N) - N) e^{-Nt} = \text{compactHeat}(N, t).
\]

### 2.2. Total Charge Neutrality
Evaluating at $t = 0$:
\[
\text{compactHeat}(N, 0) = 0 \cdot \int_1^N (\psi(x) - x) \cdot 1 \, dx = 0.
\]

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.ActualCompactHeatEndpoint` in `formalization/BuildingBlocks/ActualCompactHeatEndpoint.lean`):
```lean
theorem compactHeat_eq_goldbach_packet (N : ℕ) (hN : 1 ≤ N) (t : ℝ) :
    compactHeat N t =
      GoldbachHeat.finiteHeat GoldbachHeat.centeredCoefficient N t +
        densityCellCorrection N t -
          BuildingBlocks.CoarsePrimitive.primeErrorReal N * exp (-(N : ℝ) * t)

theorem compactHeat_eq_source_sub_terminal (N : ℕ) (t : ℝ) :
    compactHeat N t =
      ActualFiniteHeatSource.source N t -
        BuildingBlocks.CoarsePrimitive.primeErrorReal N * exp (-(N : ℝ) * t)

theorem compactHeat_eq_error_integral (N : ℕ) (hN : 1 ≤ N) (t : ℝ) :
    compactHeat N t =
      t * (∫ x in (1 : ℝ)..(N : ℝ),
        BuildingBlocks.CoarsePrimitive.primeErrorReal x * exp (-x * t))

theorem compactHeat_at_zero (N : ℕ) (hN : 1 ≤ N) : compactHeat N 0 = 0
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Heat kernel methods in analytic number theory (Balian-Bloch 1970, Berry-Keating 1999) and smoothing of arithmetic step functions. A machine-verified exact identity equating the full discrete-continuous truncated heat packet to $t \int_1^N (\psi(x)-x)e^{-xt} dx$ with verified neutral charge in Lean 4 is new.
- **Advancement:** Establishes an exact non-asymptotic bridge between discrete prime power packets, Goldbach convolutions, and continuous heat flow.
- **Target Venues:** *Communications in Mathematical Physics* or *Journal of Functional Analysis*.
