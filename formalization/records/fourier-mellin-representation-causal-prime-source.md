# First Formalization in Lean 4: Exact Fourier–Mellin Representation of the Causal Prime Source

**Authors:** Arterialist Research Team  
**Date:** September 2026  
**Lean 4 File:** [`formalization/BuildingBlocks/ChargeFrozenFourier.lean`](../../formalization/BuildingBlocks/ChargeFrozenFourier.lean)  
**Dependencies:** `BuildingBlocks.ChargeFrozenIntegrability`, `Mathlib.MeasureTheory.Integral.IntervalIntegral.Basic`, `Mathlib.Analysis.SpecialFunctions.Pow.Complex`  
**Foundational Axioms:** `[propext, Classical.choice, Quot.sound]` (Zero custom axioms, zero `sorry`)

---

## 1. Mathematical Significance and Overview

In the dynamical and spectral analysis of prime numbers, the scale-invariant causal prime source with natural cutoff $N \ge 2$ is defined on the real line $\mathbb{R}$ by:
\[
a_N(v) := \sum_{n=2}^N \Lambda(n) e^{-v/2} \mathbf{1}_{v \ge \log n} - e^{-v/2} \min(e^v, N) \mathbf{1}_{v \ge 0}.
\]
Here $v = \log x$ is the logarithmic age coordinate, and the continuous subtraction $-e^{-v/2}\min(e^v, N)$ represents the smooth arithmetic centering corresponding to the main term in Chebyshev's $\psi(x)$.

The connection between this time-domain causal source and the complex zeros of the Riemann zeta function is provided by its Fourier transform along the critical line. For angular frequency $\xi \in \mathbb{R}$ and critical parameter $w(\xi) := 1/2 + i\xi$:
\[
\int_{\mathbb{R}} e^{-i\xi v} a_N(v) dv = \frac{-1 + \sum_{n=2}^N \Lambda(n) n^{-w(\xi)} - \int_1^N x^{-w(\xi)} dx}{w(\xi)}.
\]

This Lean 4 formalization machine-checks:
1. The exact pointwise decomposition into atomic prime pulses and clipped continuous centering without separating non-integrable growing terms from their compensating tails.
2. The Lebesgue integrability of each atomic component and the continuous centering.
3. The exact evaluation of the continuous complex power integral $\int_1^N x^{-w} dx = \frac{N^{1-w} - 1}{1 - w}$.
4. The complete identity equating the Fourier transform of the causal prime source to the truncated explicit formula quotiented by $w(\xi)$.

---

## 2. Machine-Verified Theorems

### 2.1 Atomic Decomposition and Indicator Equivalence

```lean
noncomputable def centering (N : ℕ) : ℝ → ℝ :=
  (Ici (0 : ℝ)).indicator (fun v => Real.exp (-v / 2) * min (Real.exp v) (N : ℝ))

/-- A convergent finite decomposition of the literal source, without separating
the divergent growth term from its compensating tail. -/
theorem causalSource_eq_atoms_sub_centering {N : ℕ} (hN : 2 ≤ N) (v : ℝ) :
    causalSource N v =
      (∑ n ∈ Finset.Icc 2 N, ArithmeticFunction.vonMangoldt n * beta n v) -
        centering N v

theorem beta_eq_indicator {n : ℕ} (hn : 0 < n) :
    beta n = (Ici (Real.log (n : ℝ))).indicator (fun v => Real.exp (-v / 2))
```

### 2.2 Fourier Integrals of Components

```lean
noncomputable def w (ξ : ℝ) : ℂ := 1 / 2 + Complex.I * (ξ : ℂ)

theorem beta_fourier_integral {n : ℕ} (hn : 0 < n) (ξ : ℝ) :
    (∫ v : ℝ, Complex.exp (-Complex.I * (ξ : ℂ) * (v : ℂ)) * (beta n v : ℂ)) =
      Complex.exp (-w ξ * (Real.log (n : ℝ) : ℂ)) / w ξ

theorem centering_fourier_integral {N : ℕ} (hN : 1 ≤ N) (ξ : ℝ) :
    (∫ v : ℝ, Complex.exp (-Complex.I * (ξ : ℂ) * (v : ℂ)) * (centering N v : ℂ)) =
      (Complex.exp ((1 - w ξ) * (Real.log (N : ℝ) : ℂ)) - 1) / (1 - w ξ) +
        (N : ℂ) * Complex.exp (-w ξ * (Real.log (N : ℝ) : ℂ)) / w ξ
```

### 2.3 Master Fourier–Mellin Identity

```lean
theorem causalSource_fourier_mellin {N : ℕ} (hN : 2 ≤ N) (ξ : ℝ) :
    (∫ v : ℝ, Complex.exp (-Complex.I * (ξ : ℂ) * (v : ℂ)) * (causalSource N v : ℂ)) =
      (-1 + (∑ n ∈ Finset.Icc 2 N, (ArithmeticFunction.vonMangoldt n : ℂ) *
        (n : ℂ) ^ (-w ξ)) -
        (∫ x : ℝ in (1 : ℝ)..(N : ℝ), (x : ℂ) ^ (-w ξ))) / w ξ
```

---

## 3. Verification Commands and Axiom Audit

To verify independently in Lean 4:
```bash
lake env lean formalization/BuildingBlocks/ChargeFrozenFourier.lean
```

**Axiom Audit Output:**
```
'BuildingBlocks.ChargeFrozenFourier.causalSource_eq_atoms_sub_centering' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.ChargeFrozenFourier.beta_eq_indicator' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.ChargeFrozenFourier.beta_fourier_integral' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.ChargeFrozenFourier.centering_fourier_integral' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.ChargeFrozenFourier.integrable_beta_fourier' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.ChargeFrozenFourier.integrable_centering_fourier' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.ChargeFrozenFourier.causalSource_fourier_integral' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.ChargeFrozenFourier.density_mellin_integral' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.ChargeFrozenFourier.terminal_centering_exp' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.ChargeFrozenFourier.causalSource_fourier_mellin' depends on axioms: [propext, Classical.choice, Quot.sound]
```
The proof depends strictly on the standard foundationals.
