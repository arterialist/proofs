# First Formalization: Exact Critical Convergence Abscissa and Landau Singularity Barrier

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ActualCriticalConvergence.lean`](../../formalization/BuildingBlocks/ActualCriticalConvergence.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the critical line convergence barrier $\sigma_c \le 1/2$ via Landau's singularity theorem, universal Laplace integrability on $\sigma > 1/2$, open half-plane holomorphy, and analytic continuation matching the filled critical transform in Lean 4:

1. **Landau Convergence Barrier:**
   Formal proof that the convergence abscissa of the tail measure satisfies $\sigma_c \le 1/2$ (`finite_abscissa_le_half`).
2. **Universal Laplace Integrability:**
   Formal proof of integrability $\int_0^\infty e^{-\sigma t} d\mu_A < \infty$ for all $\sigma > 1/2$ (`laplace_integrable_above_half`).
3. **Open Half-Plane Holomorphy:**
   Formal proof that the Laplace moment function is analytic on $\{s \in \mathbb{C} \mid \operatorname{Re}(s) > 1/2\}$ (`laplace_analyticOnNhd_above_half`).
4. **Analytic Continuation Matching:**
   Formal proof of analytic continuation matching $\Phi(s)$ on $\operatorname{Re}(s) > 1$ (`continuation_analyticOnNhd`, `continuation_eq_filledTransform`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Convergence abscissa bounded by critical line
theorem finite_abscissa_le_half {A : ℝ} (hA : 1 ≤ A)
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0)
    (hbdd : BddBelow (LaplaceConvergenceAbscissa.convergenceSet
      (ActualCriticalMeasure.tailMeasure A) ActualCriticalMeasure.time)) :
    sInf (LaplaceConvergenceAbscissa.convergenceSet
      (ActualCriticalMeasure.tailMeasure A) ActualCriticalMeasure.time) ≤ (1 : ℝ) / 2

-- Laplace integrability above one half
theorem laplace_integrable_above_half {A : ℝ} (hA : 1 ≤ A)
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0)
    {σ : ℝ} (hσ : (1 : ℝ) / 2 < σ) :
    Integrable (fun x => Real.exp (-σ * ActualCriticalMeasure.time x))
      (ActualCriticalMeasure.tailMeasure A)

-- Holomorphy of Laplace transform on Re(s) > 1/2
theorem laplace_analyticOnNhd_above_half {A : ℝ} (hA : 1 ≤ A)
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0) :
    AnalyticOnNhd ℂ (LaplaceMomentDerivatives.moment
      (ActualCriticalMeasure.tailMeasure A) ActualCriticalMeasure.time 0)
      {s : ℂ | (1 : ℝ) / 2 < s.re}

-- Analytic continuation on Re(s) > 1/2
theorem continuation_analyticOnNhd {A : ℝ} (hA : 1 ≤ A)
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0) :
    AnalyticOnNhd ℂ (continuation A) {s : ℂ | (1 : ℝ) / 2 < s.re}

-- Continuation equals filled transform on Re(s) > 1
theorem continuation_eq_filledTransform {A : ℝ} (hA : 1 ≤ A)
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0)
    {s : ℂ} (hs : 1 < s.re) :
    continuation A s = CriticalTransformPoles.filledTransform s
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving the critical line convergence barrier $\sigma_c \le 1/2$ and open half-plane holomorphy via Landau's singularity theorem for zeta-derived measures.
