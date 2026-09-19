# First Formalization: Exact Causal Probability Delay Dissipation and Same-Prime Residual Bounds

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/SamePrimeHistoryProbability.lean`](../../formalization/BuildingBlocks/SamePrimeHistoryProbability.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the Borel measurability of the same-prime history function $s(v)$, its integrability under any causal finite delay measure, the contractive probability averaging bound, and the universal non-positivity of the delay dissipation residual in Lean 4:

1. **Borel Measurability:**
   Formal proof that $s$ is measurable from monotonicity (`s_measurable`).
2. **Causal Delay Integrability:**
   Formal proof that $r \mapsto s(v - r)$ is integrable for any finite measure supported on causal delays $[0, \infty)$ (`delayed_s_integrable`).
3. **Probability Averaging Bound:**
   Formal proof that $0 \le \int s(v - r) \, d\mu(r) \le s(v)$ for any causal probability measure $\mu$ (`delayed_s_integral_bounds`).
4. **Universal Non-Positive Residual:**
   Formal proof that $-s(v) \le \int s(v - r) \, d\mu(r) - s(v) \le 0$ unconditionally (`samePrime_residual_bounds`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Measurability from monotonicity
theorem s_measurable : Measurable s

-- Causal delay integrability
theorem delayed_s_integrable {μ : Measure ℝ} [IsFiniteMeasure μ]
    (hcausal : ∀ᵐ r ∂μ, 0 ≤ r) (v : ℝ) :
    Integrable (fun r : ℝ => s (v - r)) μ

-- Probability averaging contraction
theorem delayed_s_integral_bounds {μ : Measure ℝ} [IsProbabilityMeasure μ]
    (hcausal : ∀ᵐ r ∂μ, 0 ≤ r) (v : ℝ) :
    0 ≤ (∫ r, s (v - r) ∂μ) ∧ (∫ r, s (v - r) ∂μ) ≤ s v

-- Universal non-positive delay dissipation residual
theorem samePrime_residual_bounds {μ : Measure ℝ} [IsProbabilityMeasure μ]
    (hcausal : ∀ᵐ r ∂μ, 0 ≤ r) (v : ℝ) :
    -s v ≤ (∫ r, s (v - r) ∂μ) - s v ∧
      (∫ r, s (v - r) ∂μ) - s v ≤ 0
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 establishing universal energy dissipation and non-positive residuals $\int s(v-r)d\mu(r) - s(v) \le 0$ under arbitrary causal probability distributions.
