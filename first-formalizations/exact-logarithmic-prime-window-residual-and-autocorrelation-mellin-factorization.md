# First Formalization: Exact Logarithmic Prime Window Residual and Autocorrelation Mellin Factorization

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/LogarithmicPrimeWindow.lean`](../../formalization/BuildingBlocks/LogarithmicPrimeWindow.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact identity pairing discrete logarithmic prime sums against causal continuous sources, the factorization of autocorrelation density moments into opposite-sign physical Mellin transforms, and multi-window signed arithmetic assembly in Lean 4:

1. **Window Derivative Integration Bridge:**
   Formal proof of `window_hasDerivAt`: $(x^{-1/2} R(\log x - s))' = x^{-3/2} (R'(\log x - s) - R(\log x - s)/2)$.
2. **Jacobian Measure Substitution:**
   Formal proof of `exp_interval_substitution`: $\int_1^{e^b} g(x) dx = \int_0^b e^v g(e^v) dv$ and `exp_source_readout`.
3. **Logarithmic Prime Residual Identity:**
   Formal proof of `window_residual_frozen_source`: $\sum_{n=2}^N \Lambda(n) W_s(n) - e^{s/2} \text{densityMoment}(R) = - \int_\mathbb{R} S_C(v) K_{R, D}(v - s) dv$.
4. **Autocorrelation Density Factorization:**
   Formal proof of `densityMoment_autocorrelation`: $\int_\mathbb{R} e^{y/2}(f * \widetilde{f})(y) dy = \mathcal{M}f(1/2) \cdot \mathcal{M}f(-1/2)$.
5. **Autocorrelation Residual Identity:**
   Formal proof of `autocorrelation_residual_frozen_source`: Direct connection between autocorrelation prime sums and factorized Mellin moments.
6. **Multi-Window Signed Assembly:**
   Formal proof of `signed_windows_frozen_source`: Additive commutation across arbitrary finite linear combinations of window probes.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Logarithmic prime residual paired with frozen source
theorem window_residual_frozen_source {R D : ℝ → ℝ} {s d : ℝ} {N C : ℕ}
    (hN : 1 ≤ N) (hNC : N ≤ C) (hd : 0 ≤ d) (hs : d ≤ s)
    (hR : Continuous R) (hD : Continuous D)
    (hRs : ∀ y, d ≤ |y| → R y = 0) (hDs : ∀ y, d ≤ |y| → D y = 0)
    (hderiv : ∀ y, HasDerivAt R (D y) y) (hcut : s + d ≤ Real.log N) :
    (∑ n ∈ Finset.Icc 2 N, ArithmeticFunction.vonMangoldt n * window R s n) -
        Real.exp (s / 2) * densityMoment R =
      -(∫ v : ℝ, BuildingBlocks.ChargeFrozenSource.causalSource C v * sourceKernel R D (v - s))

-- Autocorrelation density moment factorizes into opposite Mellin moments
theorem densityMoment_autocorrelation {f : ℝ → ℝ} (hf : Continuous f)
    (hfc : HasCompactSupport f) :
    densityMoment (autocorrelation f) =
      physicalMoment f ((1 : ℝ) / 2) * physicalMoment f (-(1 : ℝ) / 2)

-- Full autocorrelation residual formula
theorem autocorrelation_residual_frozen_source {f D : ℝ → ℝ} {s d : ℝ} {N C : ℕ}
    (hN : 1 ≤ N) (hNC : N ≤ C) (hd : 0 ≤ d) (hs : d ≤ s)
    (hf : Continuous f) (hfc : HasCompactSupport f) (hD : Continuous D)
    (hRs : ∀ y, d ≤ |y| → autocorrelation f y = 0)
    (hDs : ∀ y, d ≤ |y| → D y = 0)
    (hderiv : ∀ y, HasDerivAt (autocorrelation f) (D y) y)
    (hcut : s + d ≤ Real.log N) :
    (∑ n ∈ Finset.Icc 2 N, ArithmeticFunction.vonMangoldt n *
      window (autocorrelation f) s n) -
        Real.exp (s / 2) *
          (physicalMoment f ((1 : ℝ) / 2) * physicalMoment f (-(1 : ℝ) / 2)) =
      -(∫ v : ℝ, BuildingBlocks.ChargeFrozenSource.causalSource C v *
        sourceKernel (autocorrelation f) D (v - s))

-- Multi-window linear assembly
theorem signed_windows_frozen_source {ι : Type*} (T : Finset ι) (c s : ι → ℝ)
    {R D : ℝ → ℝ} {d : ℝ} {N C : ℕ}
    (hN : 1 ≤ N) (hNC : N ≤ C) (hd : 0 ≤ d)
    (hs : ∀ i ∈ T, d ≤ s i) (hR : Continuous R) (hD : Continuous D)
    (hRs : ∀ y, d ≤ |y| → R y = 0) (hDs : ∀ y, d ≤ |y| → D y = 0)
    (hderiv : ∀ y, HasDerivAt R (D y) y)
    (hcut : ∀ i ∈ T, s i + d ≤ Real.log N) :
    (∑ i ∈ T, c i * ((∑ n ∈ Finset.Icc 2 N, ArithmeticFunction.vonMangoldt n *
      window R (s i) n) - Real.exp (s i / 2) * densityMoment R)) =
      -(∫ v : ℝ, BuildingBlocks.ChargeFrozenSource.causalSource C v *
        (∑ i ∈ T, c i * sourceKernel R D (v - s i)))
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 proving the exact identity between windowed logarithmic prime sums and causal frozen sources, the factorization of autocorrelation density moments into opposite-sign physical Mellin transforms, and multi-window signed assembly.
