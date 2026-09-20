# First Formalization in Lean 4: Kappa Coefficient Positivity and Unit Total Mass

**Authors:** Arterialist Research Team  
**Date:** September 2026  
**Lean 4 File:** [`formalization/BuildingBlocks/KappaCoefficientPositivity.lean`](../../formalization/BuildingBlocks/KappaCoefficientPositivity.lean)  
**Dependencies:** `Mathlib.Tactic`, `Mathlib.Analysis.Calculus.Deriv.MeanValue`, `Mathlib.Analysis.SpecialFunctions.Complex.LogBounds`  
**Foundational Axioms:** `[propext, Classical.choice, Quot.sound]` (Zero custom axioms, zero `sorry`)

---

## 1. Mathematical Significance and Overview

In the construction of the discrete Möbius clock and the two-slope affine dilation operator, the primary coefficient sequence is defined by:
\[
\kappa_m = m\log m - (2m+1)\log(m+1) + (m+1)\log(m+2) \qquad (m \in \mathbb{N}_0),
\]
under the arithmetic convention $0 \log 0 := 0$.

This Lean 4 module formalizes the exact analytic proof that:
1. **Strict Monotonicity of the Primitive:** The continuous interpolation $\tau(x) = x(\log(x+1)-\log x)$ satisfies $\tau'(x) = \log(x+1)-\log x - \frac{1}{x+1} > 0$ for all $x > 0$, verified using Mathlib's logarithmic upper bound $\log y < y - 1$ on $y = x/(x+1) \in (0, 1)$.
2. **Strict Positivity of All Coefficients:** Because $\kappa_m = \tau(m+1) - \tau(m)$ and $\tau$ is strictly monotonic, $\kappa_m > 0$ holds for every $m \in \mathbb{N}_0$, with base value $\kappa_0 = \log 2$.
3. **Exact Finite Telescoping:** The partial sums evaluate to $\sum_{m=0}^N \kappa_m = (N+1)\log\frac{N+2}{N+1}$.
4. **Unit Total Mass:** The infinite series has sum exactly 1:
   \[
   \sum_{m=0}^\infty \kappa_m = 1 \qquad (\text{formalized as } \operatorname{HasSum}\ \kappa\ 1).
   \]

---

## 2. Machine-Verified Theorems

```lean
def tau (x : ℝ) := x * (Real.log (x+1) - Real.log x)

def kappa (m:ℕ) : ℝ := (m:ℝ)*log m - (2*(m:ℝ)+1)*log (m+1) + ((m:ℝ)+1)*log (m+2)

theorem strictMonoOn_tau : StrictMonoOn tau (Set.Ioi 0)

theorem kappa_eq_tau_succ_sub (m:ℕ) : kappa m = tau (m+1) - tau m

theorem kappa_pos (m:ℕ) : 0 < kappa m

lemma kappa_zero : kappa 0 = Real.log 2

theorem sum_kappa_range (N : ℕ) :
    (∑ m ∈ Finset.range N, kappa m) = tauNat N

theorem sum_kappa_through (N : ℕ) :
    (∑ m ∈ Finset.range (N + 1), kappa m) =
      ((N : ℝ) + 1) * Real.log (((N : ℝ) + 2) / ((N : ℝ) + 1))

theorem hasSum_kappa_one : HasSum kappa 1
```

---

## 3. Verification Commands and Axiom Audit

To verify independently in Lean 4:
```bash
lake env lean formalization/BuildingBlocks/KappaCoefficientPositivity.lean
```

**Axiom Audit Output:**
```
'BuildingBlocks.KappaCoefficientPositivity.kappa_pos' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.KappaCoefficientPositivity.sum_kappa_range' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.KappaCoefficientPositivity.sum_kappa_through' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.KappaCoefficientPositivity.hasSum_kappa_one' depends on axioms: [propext, Classical.choice, Quot.sound]
```
All theorems depend strictly on foundational axioms with zero custom postulates.
