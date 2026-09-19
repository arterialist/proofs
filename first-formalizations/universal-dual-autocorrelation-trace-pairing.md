# First Formalization: Universal Dual Autocorrelation Trace Pairing for Discrete Prime Packets

**Date:** 19 September 2026  
**Lean 4 Modules:** [`formalization/BuildingBlocks/AutocorrelationRegularity.lean`](../../formalization/BuildingBlocks/AutocorrelationRegularity.lean), [`formalization/BuildingBlocks/LogarithmicPrimeWindow.lean`](../../formalization/BuildingBlocks/LogarithmicPrimeWindow.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact real-space duality connecting smooth windowed prime-power sums to continuous causal source integrals:

1. **Autocorrelation Smoothness and Compact Support:**
   Formal proof that the autocorrelation of a compactly supported $C^\infty$ bump is compactly supported in $[-2r, 2r]$ and $C^\infty$ (`autocorrelation_contDiff`, `autocorrelation_tsupport_subset`).
2. **Derivative of the Window Function:**
   Formal derivation of the exact differentiation formula for the logarithmic window $W(x) = x^{-1/2} R(\log x - s)$:
   \[
   W'(x) = x^{-3/2} (R'(\log x - s) - R(\log x - s)/2)
   \]
   (`window_hasDerivAt`, `windowDerivative_continuousAt`).
3. **Physical Moment Factorization:**
   Formal verification that the integral $\int e^{y/2} A_f(y) dy$ factors as the product of physical moments $\hat{f}(1/2)\hat{f}(-1/2)$ (`densityMoment_autocorrelation`).
4. **Boundary Vanishing and Summation by Parts:**
   Formal verification that the window vanishes at $x = 1$ and $x = N$ whenever the support of the kernel is interior to $[1, N]$ (`window_one_eq_zero`, `window_endpoint_eq_zero`).
5. **Universal Trace Pairing Identity:**
   Formal proof of the exact equality between the windowed prime sum error and the continuous pairing against the causal source $a_C(v)$ (`actual_packet_signed_windows`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Autocorrelation regularity and support
theorem autocorrelation_contDiff {f : ℝ → ℝ}
    (hf : ContDiff ℝ ∞ f) (hfc : HasCompactSupport f) :
    ContDiff ℝ ∞ (LogarithmicPrimeWindow.autocorrelation f)

theorem autocorrelation_tsupport_subset {f : ℝ → ℝ} {r : ℝ}
    (hz : ∀ v : ℝ, r ≤ |v| → f v = 0) :
    tsupport (LogarithmicPrimeWindow.autocorrelation f) ⊆ Set.Icc (-2*r) (2*r)

-- Differentiation of logarithmic window
theorem window_hasDerivAt {R D : ℝ → ℝ} {s x : ℝ} (hx : 0 < x)
    (hR : HasDerivAt R (D (Real.log x - s)) (Real.log x - s)) :
    HasDerivAt (window R s) (windowDerivative R D s x) x

-- Universal real-space trace duality
theorem actual_packet_signed_windows {ι : Type*} (T : Finset ι) (c s : ι → ℝ)
    {f : ℝ → ℝ} {r d : ℝ} {N C : ℕ}
    (hf : ContDiff ℝ ∞ f)
    (hz : ∀ v : ℝ, r ≤ |v| → f v = 0) (hrd : 2*r < d)
    (hN : 1 ≤ N) (hNC : N ≤ C) (hd : 0 ≤ d)
    (hs : ∀ i ∈ T, d ≤ s i) (hcut : ∀ i ∈ T, s i + d ≤ Real.log N) :
    (∑ i ∈ T, c i * ((∑ n ∈ Finset.Icc 2 N, ArithmeticFunction.vonMangoldt n *
      LogarithmicPrimeWindow.window (LogarithmicPrimeWindow.autocorrelation f) (s i) n) -
      Real.exp (s i / 2) *
        (LogarithmicPrimeWindow.physicalMoment f (1/2) *
         LogarithmicPrimeWindow.physicalMoment f (-(1/2))))) =
      -(∫ v : ℝ, BuildingBlocks.ChargeFrozenSource.causalSource C v *
        (∑ i ∈ T, c i * LogarithmicPrimeWindow.sourceKernel
          (LogarithmicPrimeWindow.autocorrelation f)
          (deriv (LogarithmicPrimeWindow.autocorrelation f)) (v - s i)))
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified proof of a real-space dual trace formula connecting smooth windowed prime sums directly to causal error integrals, completely circumventing complex contour integration and the non-trivial zeros of $\zeta(s)$.
