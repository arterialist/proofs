# First Formalization: Exact Prime-Pair Density Causal Filter Evaluations and Riesz Tent Weights

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/PrimeDensityFilter.lean`](../../formalization/BuildingBlocks/PrimeDensityFilter.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact closed-form evaluation of the causal filter $\mathcal{L}_0$ on discrete prime-power birth pairs, mixed prime-density convolutions, and pure background density convolutions in Lean 4:

1. **Riesz Tent Weight Realization:**
   Formal proof that the causal filter of prime-power birth convolutions generates the exact Riesz tent weight $(e^s - p^j q^k)\log p \log q$ (`prime_power_pair_evaluation`).
2. **Mixed Prime-Density Terms:**
   Formal proof of the exact evaluation of the symmetrized mixed prime-density convolution terms (`prime_power_mixed_evaluation`).
3. **Pure Density Autocorrelation:**
   Formal proof of the exact normalized closed form for the background density autocorrelation under causal filtering (`density_square_normalized`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Prime-power pair causal filter evaluation
theorem prime_power_pair_evaluation {p q : ℕ} (hp : p.Prime) (hq : q.Prime)
    (j k : ℕ) {s : ℝ} (hs : 0 ≤ s) :
    (Real.log p * Real.log q) *
      L0 (conv (birth ((j : ℝ)*Real.log p)) (birth ((k : ℝ)*Real.log q))) s =
    if (p : ℝ)^j * (q : ℝ)^k ≤ Real.exp s then
      Real.exp (-3*s/2) * (Real.exp s - (p : ℝ)^j*(q : ℝ)^k) *
        Real.log p * Real.log q else 0

-- Symmetrized mixed prime-density causal filter evaluation
theorem prime_power_mixed_evaluation {p : ℕ} (hp : p.Prime) (j : ℕ)
    {s : ℝ} (hs : 0 ≤ s) :
    Real.log p * (L0 (conv (birth ((j : ℝ)*Real.log p)) density) s +
      L0 (conv density (birth ((j : ℝ)*Real.log p))) s) =
    if (p : ℝ)^j ≤ Real.exp s then
      Real.exp (-3*s/2) * Real.log p *
        (Real.exp (2*s) - ((p : ℝ)^j)^2) / (p : ℝ)^j else 0

-- Pure background density causal filter evaluation
theorem density_square_normalized {s : ℝ} (hs : 0 ≤ s) :
    L0 (conv density density) s = Real.exp (-3*s/2) *
      (Real.exp (2*s) * s/2 + Real.exp (2*s)/4 - 1/4)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving that causal linear filtering of prime-power birth convolutions exactly synthesizes the Riesz typical mean weight without Fourier inversion or contour integration.
