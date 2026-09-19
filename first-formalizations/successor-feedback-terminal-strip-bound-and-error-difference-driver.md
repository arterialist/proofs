# First Formalization: Successor Feedback Terminal-Strip Bound and Error-Difference Driver

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/SuccessorFeedbackBoundary.lean`](../../formalization/BuildingBlocks/SuccessorFeedbackBoundary.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exponential decay of the boundary strip, infinite relative charge identity, and error-difference representation of the feedback driver in Lean 4:

1. **Terminal Strip Bound:**
   Formal proof that the boundary integral over $[R, \sigma(R)]$ is bounded by $4 M e^{-R/2}$ (`terminal_strip_bound`).
2. **Infinite Relative Charge Identity:**
   Formal derivation of $\int_0^\infty (T(T^j f) - T^j f) = \int_0^\infty K T^j f$ (`profile_relative_charge`).
3. **Innovation Driver Identification:**
   Formal proof that the feedback driver $d_j = \frac{1}{2} \int_0^\infty \operatorname{innovation}(j)$ (`driver_eq_innovation_integral`).
4. **Chebyshev Error Difference Integral:**
   Formal proof that $d_j = \frac{1}{2} \int_1^\infty \frac{E(x+j+1) - E(x+j)}{\sqrt{x}} \, dx$ (`driver_eq_difference_integral`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exponential decay of terminal strip error
theorem terminal_strip_bound {H : ℝ → ℝ} {M : ℝ} (hM : 0 ≤ M)
    (hb : ∀ x, 0 < x → |H x| ≤ M) (j : ℕ)
    {R : ℝ} (hR : log 2 ≤ R) :
    |∫ u in R..sigma R, weight u * successor^[j] (MixedEnergy.physicalLift H) u| ≤
      4 * M * exp (-R / 2)

-- Master relative charge identity on (0, ∞)
theorem profile_relative_charge {H : ℝ → ℝ} (hH : Measurable H)
    {M : ℝ} (hM : 0 ≤ M) (hb : ∀ x, 0 < x → |H x| ≤ M) (j : ℕ)
    (hi : IntegrableOn (fun v => successor (successor^[j] (MixedEnergy.physicalLift H)) v -
      successor^[j] (MixedEnergy.physicalLift H) v) (Ioi (0 : ℝ))) :
    (∫ v in Ioi (0 : ℝ), successor (successor^[j] (MixedEnergy.physicalLift H)) v -
      successor^[j] (MixedEnergy.physicalLift H) v) =
      ∫ v in Ioi (0 : ℝ), kernel v * successor^[j] (MixedEnergy.physicalLift H) v

-- Feedback driver as integrated error difference
theorem driver_eq_difference_integral (j : ℕ) :
    driver j = (1 / 2 : ℝ) * ∫ x in Ioi (1 : ℝ),
      (physicalError (x + j + 1) - physicalError (x + j)) / sqrt x
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified proof that boundary defects of iterated successor operators decay exponentially as $e^{-R/2}$ and that the physical feedback driver is identically governed by the integrated difference of Chebyshev prime errors.
