# First Formalization: Exact All-Prime Jump Process Causal Support and Initial-Gap Theorem

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/PrimeSeedCausalSupport.lean`](../../formalization/BuildingBlocks/PrimeSeedCausalSupport.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact $\log 2$ initial support gap of the all-prime Lévy measure, the support gap addition under convolution, the exact sub-threshold atomicity of compound Poisson laws, and the strict absence of negative ages for the all-prime process in Lean 4:

1. **Lower Support Inactivity:**
   Formal proof that $\text{seed}_{\log p}(v) = 0$ for $v < \log 2$ (`seed_prime_eq_zero_before_log_two`).
2. **Lévy Initial Gap:**
   Formal proof that $\nu_{\mathcal{P}}((-\infty, \log 2)) = 0$ and almost everywhere non-negativity (`allPrimeLevyMeasure_initial_gap`, `allPrimeLevyMeasure_ae_nonneg`).
3. **Convolution Support Propagation:**
   Formal proof that $(\mu * \nu)((-\infty, a+b)) = 0$ and $\mu^{*n}((-\infty, nL)) = 0$ (`conv_initial_gap`, `jumpPower_initial_gap`).
4. **Sub-Threshold Atomicity:**
   Formal proof that below the first jump threshold $L$, $\mathcal{P}_u(A) = e^{-u \|\mu\|} \delta_0(A)$ (`finiteJumpLaw_initial_region`).
5. **Strict Causality of the All-Prime Process:**
   Formal proofs that $\mathbb{P}(X_u \in (-\infty, \log 2)) = e^{-u \|\nu_{\mathcal{P}}\|}$ and $\mathbb{P}(X_u < 0) = 0$ (`allPrimeProcess_initial_cell`, `allPrimeProcess_no_negative_age`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Prime seed lower inactivity
theorem seed_prime_eq_zero_before_log_two (p : Nat.Primes) {v : ℝ}
    (hv : v < log 2) : seed (log p) v = 0

-- All-prime Lévy measure initial gap
theorem allPrimeLevyMeasure_initial_gap :
    allPrimeLevyMeasure (Set.Iio (log 2)) = 0

theorem allPrimeLevyMeasure_ae_nonneg :
    ∀ᵐ v ∂allPrimeLevyMeasure, (0 : ℝ) ≤ v

-- Convolution gap addition
theorem conv_initial_gap {μ ν : Measure ℝ} [IsFiniteMeasure μ] [IsFiniteMeasure ν]
    {a b : ℝ} (hμ : μ (Set.Iio a) = 0) (hν : ν (Set.Iio b) = 0) :
    (μ ∗ ν) (Set.Iio (a + b)) = 0

-- Convolution power gap
theorem jumpPower_initial_gap {μ : Measure ℝ} [IsFiniteMeasure μ] {L : ℝ}
    (hμ : μ (Set.Iio L) = 0) (n : ℕ) : jumpPower μ n (Set.Iio ((n : ℝ) * L)) = 0

-- Sub-threshold atomicity
theorem finiteJumpLaw_initial_region {μ : Measure ℝ} [IsFiniteMeasure μ] {L : ℝ}
    (hL : 0 < L) (hμ : μ (Set.Iio L) = 0) (u : ℝ≥0) {A : Set ℝ}
    (hA : MeasurableSet A) (hAL : A ⊆ Set.Iio L) :
    finiteJumpLaw μ u A =
      ENNReal.ofReal (exp (-(u : ℝ) * (measureUnivNNReal μ : ℝ))) *
        Measure.dirac (0 : ℝ) A

-- Initial cell mass
theorem allPrimeProcess_initial_cell (u : ℝ≥0) :
    allPrimeProcess u (Set.Iio (log 2)) =
      ENNReal.ofReal (exp (-(u : ℝ) *
        (measureUnivNNReal PrimeSeedMass.allPrimeLevyMeasure : ℝ)))

-- Zero negative age probability
theorem allPrimeProcess_no_negative_age (u : ℝ≥0) :
    allPrimeProcess u (Set.Iio 0) = 0
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 proving support gap propagation for convolution powers of finite measures and establishing the strict causality and sub-threshold atomicity $\mathcal{P}_u(A) = e^{-u\|\mu\|}\delta_0(A)$ of the all-prime jump process.
