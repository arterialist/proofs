# First Formalization: Exact Mangoldt-Weighted Birth-Source Majorization and Joint Convergence

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/IntegerBirthSourceBound.lean`](../../formalization/BuildingBlocks/IntegerBirthSourceBound.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This milestone formalization proves the exact von Mangoldt-weighted majorization and two-dimensional absolute summability for integer birth kernels in Lean 4:

1. **First-Moment Source Envelopes:**
   Formal proof of `U_abs_bound` and `interpolant_abs_bound`: $|U(n, u)| \le \frac{(\pi+1)u}{n\sqrt{n}}$ and $|\widetilde{U}(n, u)| \le \frac{(\pi+1)u}{n\sqrt{n}}$.
2. **Von Mangoldt L-Series Convergence at $s = 3/2$:**
   Formal proof of `summable_mangoldt_bound`: $\sum_{n=1}^\infty \frac{\Lambda(n)}{n^{3/2}} < \infty$.
3. **Complete Von Mangoldt-Weighted Majorization:**
   Formal proof of `actual_source_interpolation_le`: $\sum_{n=0}^\infty \Lambda(n+2) U(n+2, u) \le \sum_{n=0}^\infty \Lambda(n+2) \widetilde{U}(n+2, u)$.
4. **Analytic Defect Identity:**
   Formal proof of `actual_source_defect_identity`: exact representation of the interpolation defect as an absolutely convergent sum.
5. **Two-Dimensional Absolute Convergence:**
   Formal proof of `geometric_source_absolute`, `geometric_interpolated_absolute`, and `exponential_clock_absolute`: joint double summability over $\mathbb{N} \times \mathbb{N}$ for all clock rates $t > 0$.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Uniform first-moment bound on birth source
theorem U_abs_bound {n : ℕ} (hn : 2 ≤ n) {u : ℝ} (hu : 0 ≤ u) :
    |U n u| ≤ boundConstant*u/((n : ℝ)*Real.sqrt n)

-- Preservation under linear interpolation
theorem interpolant_abs_bound {n : ℕ} (hn : 2 ≤ n) {u : ℝ} (hu : 0 ≤ u) :
    |interpolant n u| ≤ boundConstant*u/((n : ℝ)*Real.sqrt n)

-- Absolute convergence of von Mangoldt weights at 3/2
theorem summable_mangoldt_bound :
    Summable (fun n : ℕ => ArithmeticFunction.vonMangoldt n / ((n : ℝ)*Real.sqrt n))

-- Complete von Mangoldt-weighted source majorization
theorem actual_source_interpolation_le {u : ℝ} (hu : 0 ≤ u) :
    (∑' n : ℕ, sourceTerm n u) ≤ ∑' n : ℕ, interpolatedTerm n u

-- Exact analytic defect identity
theorem actual_source_defect_identity {u : ℝ} (hu : 0 ≤ u) :
    (∑' n : ℕ, interpolatedTerm n u)-(∑' n : ℕ, sourceTerm n u) =
      ∑' n : ℕ, ArithmeticFunction.vonMangoldt (n+2)*(interpolant (n+2) u-U (n+2) u)

-- Joint two-dimensional exponential clock absolute convergence
theorem exponential_clock_absolute {t : ℝ} (ht : 0 < t) :
    Summable (fun z : ℕ × ℕ => ‖Real.exp (-t*(z.2 : ℝ))*sourceTerm z.1 z.2‖) ∧
    Summable (fun z : ℕ × ℕ => ‖Real.exp (-t*(z.2 : ℝ))*interpolatedTerm z.1 z.2‖)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified proof in Lean 4 establishing the absolute convergence and exact majorization of prime-power weighted birth sources across both discrete arithmetic indices and continuous clock evolutions.
