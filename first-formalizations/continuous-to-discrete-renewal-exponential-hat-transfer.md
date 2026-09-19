# First Formalization: Continuous-to-Discrete Renewal Transfer via Exponential Hats

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/IntegerBirthExponentialHats.lean`](../../formalization/BuildingBlocks/IntegerBirthExponentialHats.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization verifies the exact algebraic equivalence between the continuous Laplace transform of linearly interpolated integer renewal sequences and their discrete generating transforms:

1. **Affine Hat Integration:**
   Formal Bochner interval integration on $[0, 1]$ proving that the exponential moment of an arbitrary affine function $(1-v)c + vd$ equals $\operatorname{leftHat}(t) c + \operatorname{rightHat}(t) d$ (`integral_exp_affine`).
2. **Hyperbolic Sinc Summation Factor:**
   Formal proof of the algebraic identity $\operatorname{leftHat}(t) + e^t \operatorname{rightHat}(t) = \frac{(1-e^{-t})^2}{e^{-t}t^2} = \frac{4\sinh^2(t/2)}{t^2}$ (`hat_factor`).
3. **Partition of the Positive Real Line:**
   Formal decomposition of $[0, \infty)$ into pairwise disjoint integer half-open cells $[j, j+1)$ (`nat_cells_union`, `nat_cells_disjoint`).
4. **Single-Birth Hat Collapsing:**
   Formal geometric summation showing that because the discrete sequence satisfies $c(0) = 0$, the sum of all cell integrals collapses to $\operatorname{interpolationFactor}(t) \sum_{j=0}^\infty e^{-tj} c(j)$ (`actual_birth_hat_identity`).
5. **Complete Arithmetic Source Transfer and Defect:**
   Formal extension across all prime births $n \ge 2$ with von Mangoldt weights, establishing both the exact total transfer (`actual_all_birth_hat_identity`) and the exact defect formula (`actual_all_birth_defect_identity`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Hat definitions
noncomputable def leftHat (t : ℝ) : ℝ := (t - 1 + Real.exp (-t)) / t ^ 2
noncomputable def rightHat (t : ℝ) : ℝ := (1 - (1 + t) * Real.exp (-t)) / t ^ 2
noncomputable def interpolationFactor (t : ℝ) : ℝ :=
  (1 - Real.exp (-t)) ^ 2 / (Real.exp (-t) * t ^ 2)

-- Affine hat integral
theorem integral_exp_affine {t : ℝ} (ht : 0 < t) (c d : ℝ) :
    (∫ v in (0 : ℝ)..1, Real.exp (-t * v) * ((1 - v) * c + v * d)) =
      leftHat t * c + rightHat t * d

-- Multiplier identity
theorem hat_factor {t : ℝ} (ht : 0 < t) :
    leftHat t + rightHat t / Real.exp (-t) = interpolationFactor t

-- Single birth transfer
theorem actual_birth_hat_identity {t : ℝ} (ht : 0 < t) (n : ℕ) :
    (∫ u in Ioi (0 : ℝ), laplaceInterpolated t n u) =
      interpolationFactor t * ∑' j : ℕ, Real.exp (-t * (j : ℝ)) * sourceTerm n j

-- Full arithmetic transfer
theorem actual_all_birth_hat_identity {t : ℝ} (ht : 0 < t) :
    (∑' n : ℕ, ∫ u in Ioi (0 : ℝ), laplaceInterpolated t n u) =
      interpolationFactor t * ∑' n : ℕ, ∑' j : ℕ, Real.exp (-t * (j : ℝ)) * sourceTerm n j

-- Exact defect identity
theorem actual_all_birth_defect_identity {t : ℝ} (ht : 0 < t) :
    interpolationFactor t * (∑' n : ℕ, ∑' j : ℕ, Real.exp (-t * (j : ℝ)) * sourceTerm n j) -
      (∑' n : ℕ, ∫ u in Ioi (0 : ℝ), laplaceSource t n u) =
    ∑' n : ℕ, ∫ u in Ioi (0 : ℝ), Real.exp (-t * u) * ArithmeticFunction.vonMangoldt (n + 2) *
      (interpolant (n + 2) u - U (n + 2) u)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified proof connecting continuous and discrete renewal operators via the exact non-asymptotic B-spline transfer factor $4\sinh^2(t/2)/t^2$.
