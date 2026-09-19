# First Formalization: Exact Autocorrelation Smoothness and Signed Logarithmic Prime Packet Duality

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/AutocorrelationRegularity.lean`](../../formalization/BuildingBlocks/AutocorrelationRegularity.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the group convolution identity $A(f) = \check{f} * f$, the preservation of $C^\infty$ smoothness and compact support under autocorrelation, the boundary-clamping regularity of wave packets, and the exact signed discrete-continuous prime packet duality in Lean 4:

1. **Autocorrelation Convolution Identity:**
   Formal proof that $A(f) = \text{convolution}(\check{f}, f)$ (`autocorrelation_eq_convolution`).
2. **Infinite Differentiability:**
   Formal proof that $f \in C^\infty_c(\mathbb{R}) \implies A(f) \in C^\infty_c(\mathbb{R})$ (`autocorrelation_contDiff`).
3. **Exact Support Doubling:**
   Formal proof that $\text{supp}(f) \subseteq [-r, r] \implies \text{tsupp}(A(f)) \subseteq [-2r, 2r]$ (`autocorrelation_tsupport_subset`).
4. **Boundary-Clamped Packet Regularity:**
   Formal proof that $A(f)$ and $A(f)'$ are continuous and vanish identically for $|y| \ge d > 2r$ (`source_packet_regular`).
5. **Signed Logarithmic Prime Packet Duality:**
   Formal proof equating signed sums of prime window packets to continuous integrals against the frozen causal charge source (`actual_packet_signed_windows`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Autocorrelation as group convolution with reflection
theorem autocorrelation_eq_convolution (f : ℝ → ℝ) :
    LogarithmicPrimeWindow.autocorrelation f =
      convolution (fun v => f (-v)) f (ContinuousLinearMap.mul ℝ ℝ) volume

-- Smoothness of autocorrelation
theorem autocorrelation_contDiff {f : ℝ → ℝ}
    (hf : ContDiff ℝ ∞ f) (hfc : HasCompactSupport f) :
    ContDiff ℝ ∞ (LogarithmicPrimeWindow.autocorrelation f)

-- Support doubling under autocorrelation
theorem autocorrelation_tsupport_subset {f : ℝ → ℝ} {r : ℝ}
    (hz : ∀ v : ℝ, r ≤ |v| → f v = 0) :
    tsupport (LogarithmicPrimeWindow.autocorrelation f) ⊆ Set.Icc (-2*r) (2*r)

-- Complete boundary-clamping regularity
theorem source_packet_regular {f : ℝ → ℝ} {r d : ℝ}
    (hf : ContDiff ℝ ∞ f) (hfc : HasCompactSupport f)
    (hz : ∀ v : ℝ, r ≤ |v| → f v = 0) (hd : 2*r < d) :
    Continuous (LogarithmicPrimeWindow.autocorrelation f) ∧
    Continuous (deriv (LogarithmicPrimeWindow.autocorrelation f)) ∧
    (∀ y, HasDerivAt (LogarithmicPrimeWindow.autocorrelation f)
      (deriv (LogarithmicPrimeWindow.autocorrelation f) y) y) ∧
    (∀ y, d ≤ |y| → LogarithmicPrimeWindow.autocorrelation f y = 0) ∧
    (∀ y, d ≤ |y| → deriv (LogarithmicPrimeWindow.autocorrelation f) y = 0)

-- Signed discrete-continuous prime packet duality
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

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 establishing the group convolution smoothness of seed autocorrelations and the exact signed duality between discrete prime window sums and continuous causal source integrals.
