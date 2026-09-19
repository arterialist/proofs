# First Formalization: Exact Logarithmic Overlap Loss and Algebraic Spacing Bounds

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/LogarithmicOverlap.lean`](../../formalization/BuildingBlocks/LogarithmicOverlap.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact real-variable inequalities and non-asymptotic bounds for logarithmic overlap loss in Lean 4:

1. **Rational Function Identity:**
   Formal proof of `one_sub_overlapFraction_eq`: $1 - \Phi(u, v) = \frac{(1-u)(1+u+v)}{1+v}$.
2. **Logarithmic Decomposition:**
   Formal proof of `log_overlap_eq`: $\log(1 - \Phi(u, v)) = \log(1-u) + \log(1+u+v) - \log(1+v)$.
3. **Exact Overlap Identity:**
   Formal proof of `overlap_identity`: $(L + \log(1-u))(L + \log(1+u+v)) - L(L + \log(1+v)) = L\log(1 - \Phi) + \log(1-u)\log(1+u+v)$.
4. **Logarithmic Overlap Loss:**
   Formal proof of `overlap_loss`: difference $\le -L \frac{u(u+v)}{1+v}$.
5. **Uniform Error Compensation:**
   Formal proof of `uniform_error_bound`: $L \frac{u(u+v)}{1+v} \le (2L + \log(1+v))\eta + \eta^2$.
6. **Normalized Spacing Bound:**
   Formal proof of `uniform_error_fraction_bound`: $\frac{u(u+v)}{1+v} \le \left(2 + \frac{\log(1+v)}{L}\right)\eta + \frac{\eta^2}{L}$.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exact overlap decomposition
theorem overlap_identity (L : ℝ) {u v : ℝ}
    (hu : 0 ≤ u) (hu1 : u < 1) (hv : 0 ≤ v) :
    (L + Real.log (1 - u)) * (L + Real.log (1 + u + v)) -
        L * (L + Real.log (1 + v)) =
      L * Real.log (1 - overlapFraction u v) +
        Real.log (1 - u) * Real.log (1 + u + v)

-- Overlap loss bound
theorem overlap_loss {L u v : ℝ} (hL : 0 < L)
    (hu : 0 ≤ u) (hu1 : u < 1) (hv : 0 ≤ v) :
    (L + Real.log (1 - u)) * (L + Real.log (1 + u + v)) -
        L * (L + Real.log (1 + v)) ≤
      -L * u * (u + v) / (1 + v)

-- Error compensation bound
theorem uniform_error_bound {L u v η : ℝ} (hL : 0 < L)
    (hu : 0 ≤ u) (hu1 : u < 1) (hv : 0 ≤ v) (hη : 0 ≤ η)
    (hcorrected : L * (L + Real.log (1 + v)) ≤
      (L + Real.log (1 - u) + η) * (L + Real.log (1 + u + v) + η)) :
    L * u * (u + v) / (1 + v) ≤
      (2 * L + Real.log (1 + v)) * η + η ^ 2

-- Normalized fraction bound
theorem uniform_error_fraction_bound {L u v η : ℝ} (hL : 0 < L)
    (hu : 0 ≤ u) (hu1 : u < 1) (hv : 0 ≤ v) (hη : 0 ≤ η)
    (hcorrected : L * (L + Real.log (1 + v)) ≤
      (L + Real.log (1 - u) + η) * (L + Real.log (1 + u + v) + η)) :
    u * (u + v) / (1 + v) ≤
      (2 + Real.log (1 + v) / L) * η + η ^ 2 / L
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified proof in Lean 4 establishing explicit non-asymptotic bounds on the product loss of perturbed logarithmic factors and the resulting uniform error compensation barriers.
