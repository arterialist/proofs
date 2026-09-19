# First Formalization: Exact Compound Poisson Subordination Principle and Activity Defect Coupling Bound

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/PrimeSeedLawComparison.lean`](../../formalization/BuildingBlocks/PrimeSeedLawComparison.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact Poisson subordination principle for jump measures $\mu \le \nu$, proves the sharp sub-probability event coupling lemma without extra factors of 2, and derives the non-asymptotic activity defect total variation bound in Lean 4:

1. **Convolution Monotonicity:**
   Formal proof of convolution monotonicity $\mu * \rho \le \nu * \sigma$ (`conv_mono_of_finite`) and jump power monotonicity $\mu^{*n} \le \nu^{*n}$ (`jumpPower_mono`).
2. **Poisson Subordination Principle:**
   Formal proof that $e^{-u(\|\nu\| - \|\mu\|)} \mathcal{P}_u^{(\mu)} \le \mathcal{P}_u^{(\nu)}$ (`finiteJumpLaw_domination`).
3. **Sub-Probability Event Coupling Lemma:**
   Formal proof that $c \cdot \mu \le \nu \implies |\mu(A) - \nu(A)| \le 1 - c$ for all measurable sets $A$ (`probability_event_bound_of_domination`).
4. **Sharp Activity Defect Total Variation Bound:**
   Formal proof that $|\mathcal{P}_u^{(\mu)}(A) - \mathcal{P}_u^{(\nu)}(A)| \le u (\|\nu\| - \|\mu\|)$ (`finiteJumpLaw_event_bound`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Monotonicity of measure convolution
theorem conv_mono_of_finite {μ ν ρ σ : Measure ℝ}
    [IsFiniteMeasure ρ] [IsFiniteMeasure σ] (hμ : μ ≤ ν) (hρ : ρ ≤ σ) :
    μ ∗ ρ ≤ ν ∗ σ

-- Monotonicity of jump powers
theorem jumpPower_mono {μ ν : Measure ℝ} [IsFiniteMeasure μ] [IsFiniteMeasure ν]
    (h : μ ≤ ν) (n : ℕ) : jumpPower μ n ≤ jumpPower ν n

-- Exact Poisson subordination principle
theorem finiteJumpLaw_domination {μ ν : Measure ℝ} [IsFiniteMeasure μ]
    [IsFiniteMeasure ν] (h : μ ≤ ν) (u : ℝ≥0) :
    ENNReal.ofReal (exp (-(u : ℝ) *
      ((measureUnivNNReal ν : ℝ) - (measureUnivNNReal μ : ℝ)))) •
        finiteJumpLaw μ u ≤ finiteJumpLaw ν u

-- Sub-probability event coupling lemma
theorem probability_event_bound_of_domination {μ ν : Measure ℝ}
    [IsProbabilityMeasure μ] [IsProbabilityMeasure ν] {c : ℝ}
    (hc : 0 ≤ c) (hc1 : c ≤ 1) (h : ENNReal.ofReal c • μ ≤ ν)
    {A : Set ℝ} (hA : MeasurableSet A) :
    |μ.real A - ν.real A| ≤ 1 - c

-- Sharp activity defect bound
theorem finiteJumpLaw_event_bound {μ ν : Measure ℝ} [IsFiniteMeasure μ]
    [IsFiniteMeasure ν] (h : μ ≤ ν) (u : ℝ≥0) {A : Set ℝ}
    (hA : MeasurableSet A) :
    |(finiteJumpLaw μ u).real A - (finiteJumpLaw ν u).real A| ≤
      (u : ℝ) * ((measureUnivNNReal ν : ℝ) - (measureUnivNNReal μ : ℝ))
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving the general compound Poisson subordination principle $e^{-u(\|\nu\| - \|\mu\|)} \mathcal{P}_u^{(\mu)} \le \mathcal{P}_u^{(\nu)}$ and establishing the sharp event error bound $u (\|\nu\| - \|\mu\|)$ without extraneous constants.
