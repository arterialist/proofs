# First Formalization: Exact Selberg-Riesz Area Cauchy Energy Contraction Bound

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/SelbergReflectionBound.lean`](../../formalization/BuildingBlocks/SelbergReflectionBound.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact reciprocal quadratic transformation theorem, the jump-admissible Cauchy-Schwarz inequality for interval integrals, and the sharp $N^{3/2}$ energy contraction upper bound on the centered Selberg auto-convolution area primitive in Lean 4:

1. **Reciprocal Quadratic Transformation:**
   Formal proof of $\int_1^T q(T/a)^2 da = T \int_1^T q(t)^2/t^2 dt$ (`integral_reciprocal_square`).
2. **Jump-Admissible Cauchy-Schwarz:**
   Formal proof of $(\int_a^b fg)^2 \le (\int_a^b f^2)(\int_a^b g^2)$ via non-positive quadratic discriminants (`interval_integral_mul_sq_le`).
3. **Filtered Energy Bound:**
   Formal proof of $S(N)^2 \le N^3 (\int_1^N E^2/t^2)(\int_1^N (E - \psi_1/t)^2/t^2)$ (`selbergCenteredArea_sq_le_filtered`).
4. **Sharp $N^{3/2}$ Prime Energy Contraction Bound:**
   Formal proof that $|S(N)| \le N \sqrt{N} \int_1^N E(t)^2/t^2 dt$ (`abs_selbergCenteredArea_le`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Reciprocal quadratic change of variables
theorem integral_reciprocal_square {T : ℝ} (hT : 1 ≤ T) (q : ℝ → ℝ) :
    (∫ a in (1 : ℝ)..T, q (T/a)^2) = T * ∫ t in (1 : ℝ)..T, q t^2/t^2

-- Jump-admissible Cauchy-Schwarz inequality
theorem interval_integral_mul_sq_le {f g : ℝ → ℝ} {a b : ℝ} (hab : a ≤ b)
    (hf : IntervalIntegrable (fun t => f t^2) volume a b)
    (hg : IntervalIntegrable (fun t => g t^2) volume a b)
    (hfg : IntervalIntegrable (fun t => f t*g t) volume a b) :
    (∫ t in a..b, f t*g t)^2 ≤
      (∫ t in a..b, f t^2) * ∫ t in a..b, g t^2

-- Filtered energy upper bound
theorem selbergCenteredArea_sq_le_filtered {N : ℕ} (hN : 1 ≤ N) :
    selbergCenteredArea N ^ 2 ≤ (N : ℝ)^3 *
      (∫ t in (1 : ℝ)..(N : ℝ), primeErrorReal t^2/t^2) *
      (∫ t in (1 : ℝ)..(N : ℝ),
        (primeErrorReal t - coarsePrefix 1 t/t)^2/t^2)

-- Sharp absolute N^{3/2} prime-energy contraction bound
theorem abs_selbergCenteredArea_le {N : ℕ} (hN : 1 ≤ N) :
    |selbergCenteredArea N| ≤ (N : ℝ) * Real.sqrt N *
      ∫ t in (1 : ℝ)..(N : ℝ), primeErrorReal t^2/t^2
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 establishing the sharp $N^{3/2}$ energy contraction upper bound bounding discrete Selberg auto-convolutions by continuous quadratic prime-error energy.
