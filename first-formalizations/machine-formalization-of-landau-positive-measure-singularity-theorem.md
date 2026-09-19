# First Formalization: Machine Formalization of Landau's Positive-Measure Singularity Theorem and Critical Sign Criterion

**Date:** 19 September 2026  
**Lean 4 Modules:** [`formalization/BuildingBlocks/LandauSingularity.lean`](../../formalization/BuildingBlocks/LandauSingularity.lean), [`formalization/BuildingBlocks/ActualCriticalConvergence.lean`](../../formalization/BuildingBlocks/ActualCriticalConvergence.lean), [`formalization/BuildingBlocks/ActualCriticalSignCriterion.lean`](../../formalization/BuildingBlocks/ActualCriticalSignCriterion.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes Landau's 1905 singularity theorem for positive Laplace transforms and formally derives the Riemann Hypothesis from eventual non-positivity of the critical arithmetic sum $W(x)$:

1. **Center Displacement Geometry:**
   Formal proof that moving the center of a metric ball in $\mathbb{C}$ along the real axis by $\delta$ decreases the radius by at most $\delta$ (`shifted_ball_subset`).
2. **Interior Analytic Germ Construction:**
   Formal construction of a neighborhood filter germ at $a + \delta$ from right-half-disk agreement (`extension_germ`).
3. **Impossibility of Holomorphic Extension across the Abscissa:**
   Formal proof that any holomorphic function agreeing with the Laplace integral on the right of the real abscissa would force convergence strictly to the left of the infimum, contradicting the definition of the abscissa (`finite_abscissa_singular`, `no_holomorphic_extension`).
4. **Abscissa Upper Bound at 1/2:**
   Formal proof that the absence of real singularities of the continued transform on $(1/2, 1]$ forces the finite abscissa of convergence $\sigma_0$ to satisfy $\sigma_0 \le 1/2$ (`finite_abscissa_le_half`).
5. **Deduction of the Full Riemann Hypothesis:**
   Formal deduction that eventual non-positivity of $W(x)$ implies holomorphy of the critical transform on $\operatorname{Re}(s) > 1/2$, delivering the Riemann Hypothesis (`RiemannHypothesis_of_nonpos_after`, `RiemannHypothesis_of_eventually_nonpos`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Classical Landau Singularity Theorem
theorem no_holomorphic_extension (hτ : Measurable τ)
    (hτ0 : ∀ᵐ y ∂μ, 0 ≤ τ y)
    (hne : (LaplaceConvergenceAbscissa.convergenceSet μ τ).Nonempty)
    (hbdd : BddBelow (LaplaceConvergenceAbscissa.convergenceSet μ τ)) :
    ¬ ∃ (R : ℝ) (F : ℂ → ℂ), 0 < R ∧
      DifferentiableOn ℂ F (Metric.ball
        ((sInf (LaplaceConvergenceAbscissa.convergenceSet μ τ) : ℝ) : ℂ) R) ∧
      (∀ z ∈ Metric.ball
        ((sInf (LaplaceConvergenceAbscissa.convergenceSet μ τ) : ℝ) : ℂ) R,
        sInf (LaplaceConvergenceAbscissa.convergenceSet μ τ) < z.re →
        F z = LaplaceMomentDerivatives.moment μ τ 0 z)

-- Abscissa of convergence bounded by 1/2
theorem finite_abscissa_le_half {A : ℝ} (hA : 1 ≤ A)
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0)
    (hbdd : BddBelow (LaplaceConvergenceAbscissa.convergenceSet
      (ActualCriticalMeasure.tailMeasure A) ActualCriticalMeasure.time)) :
    sInf (LaplaceConvergenceAbscissa.convergenceSet
      (ActualCriticalMeasure.tailMeasure A) ActualCriticalMeasure.time) ≤ (1 : ℝ) / 2

-- Proof of Riemann Hypothesis from eventual sign
theorem RiemannHypothesis_of_nonpos_after {A : ℝ} (hA : 1 ≤ A)
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0) :
    RiemannHypothesis
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified proof of Landau's positive-measure singularity theorem in Lean 4, providing the rigorous foundation for Tauberian theorems on Dirichlet series and establishing the machine-checked deduction of the Riemann Hypothesis from one-sided arithmetic sign criteria.
