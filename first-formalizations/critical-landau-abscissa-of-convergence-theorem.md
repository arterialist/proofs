# First Formalization 100: Critical Landau Abscissa of Convergence Theorem

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ActualCriticalConvergence.lean`](../../formalization/BuildingBlocks/ActualCriticalConvergence.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This landmark **100th formalization** establishes the machine-verified proof of Landau's abscissa-of-convergence theorem applied to the critical arithmetic potential in Lean 4:

1. **Abscissa Upper Bound:**
   Formal proof that if the critical potential real part is eventually non-positive, its convergence abscissa cannot exceed $1/2$ (`finite_abscissa_le_half`).
2. **Universal Integrability Above One Half:**
   Formal derivation of Laplace integrability $\int_0^\infty e^{-\sigma t} d\mu_{\text{tail}} < \infty$ for all $\sigma > 1/2$ (`laplace_integrable_above_half`).
3. **Open Half-Plane Holomorphy:**
   Formal proof that the Laplace moment integral is analytic on $\{s \in \mathbb{C} : \operatorname{Re}(s) > 1/2\}$ (`laplace_analyticOnNhd_above_half`).
4. **Holomorphic Continuation and Agreement:**
   Formal verification of the continuation's holomorphy (`continuation_analyticOnNhd`) and agreement with the filled transform for $\operatorname{Re}(s) > 1$ (`continuation_eq_filledTransform`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Finite convergence abscissa is bounded by 1/2
theorem finite_abscissa_le_half {A : ℝ} (hA : 1 ≤ A)
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0)
    (hbdd : BddBelow (LaplaceConvergenceAbscissa.convergenceSet
      (ActualCriticalMeasure.tailMeasure A) ActualCriticalMeasure.time)) :
    sInf (LaplaceConvergenceAbscissa.convergenceSet
      (ActualCriticalMeasure.tailMeasure A) ActualCriticalMeasure.time) ≤ (1 : ℝ) / 2

-- Laplace integrability on the critical half-plane
theorem laplace_integrable_above_half {A : ℝ} (hA : 1 ≤ A)
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0)
    {σ : ℝ} (hσ : (1 : ℝ) / 2 < σ) :
    Integrable (fun x => Real.exp (-σ * ActualCriticalMeasure.time x))
      (ActualCriticalMeasure.tailMeasure A)

-- Holomorphy of Laplace transform on {Re(s) > 1/2}
theorem laplace_analyticOnNhd_above_half {A : ℝ} (hA : 1 ≤ A)
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0) :
    AnalyticOnNhd ℂ (LaplaceMomentDerivatives.moment
      (ActualCriticalMeasure.tailMeasure A) ActualCriticalMeasure.time 0)
      {s : ℂ | (1 : ℝ) / 2 < s.re}

-- Agreement with filled transform
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

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified proof in Lean 4 combining Landau's theorem on non-negative measures with the arithmetic potential, rigorously guaranteeing that any one-sided tail sign hypothesis forces the Laplace convergence domain to extend all the way to $\operatorname{Re}(s) = 1/2$.
