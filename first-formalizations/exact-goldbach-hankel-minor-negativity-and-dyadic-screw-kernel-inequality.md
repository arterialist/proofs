# First Formalization: Exact Goldbach Hankel Minor Negativity and Dyadic Screw Kernel Inequality

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/GoldbachScrewMinorFinite.lean`](../../formalization/BuildingBlocks/GoldbachScrewMinorFinite.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization proves the exact negativity of the first nonzero Hankel moment minor for raw additive Goldbach convolutions and proves the dyadic two-point principal screw kernel inequality in Lean 4:

1. **Screw Kernel Symmetries and Minor Determinants:**
   Formal proof of `screwKernel_diagonal`, `screwKernel_dyadic_cross`, `dyadic_minor_determinant`, and `dyadic_screw_inequality` ($4a \le b \le 0$).
2. **Explicit Arithmetic Row Formula:**
   Formal definitions of `endpointWeight`, `hOnePrimeRow`, `hOneArchimedean`, `hOneArithmetic`, and proof of `hOne_dyadic_finite_consumer`.
3. **Moment Minor Nonnegativity:**
   Formal proof of finite Cauchy-Schwarz in moment form `finite_moment_minor_nonnegative`.
4. **Exact Goldbach Coefficient Evaluations:**
   Formal proofs of `prime_goldbach_four` ($G(4) = (\log 2)^2$), `prime_goldbach_five` ($G(5) = 2 \log 2 \log 3$), and `prime_goldbach_six` ($G(6) = 2(\log 2)^2 + (\log 3)^2$).
5. **Hankel Minor Negativity and Non-Positivity Proof:**
   Formal proofs of `first_nonzero_goldbach_hankel_minor_neg` and `raw_goldbach_not_hankel_positive`.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- First nonzero Goldbach Hankel minor is strictly negative
theorem first_nonzero_goldbach_hankel_minor_neg :
    shiftedPrimeGoldbach 2 * shiftedPrimeGoldbach 4 -
      shiftedPrimeGoldbach 3 ^ 2 < 0

-- Refutation of Hankel moment positivity for raw Goldbach convolutions
theorem raw_goldbach_not_hankel_positive :
    ¬ (∀ k : ℕ,
      shiftedPrimeGoldbach (k + 1) ^ 2 ≤
        shiftedPrimeGoldbach k * shiftedPrimeGoldbach (k + 2))

-- Dyadic screw kernel minor inequality
theorem dyadic_screw_inequality {a b : ℝ}
    (ha : a ≤ 0) (hb : b ≤ 0)
    (hdet : 0 ≤ b * (4 * a - b)) :
    4 * a ≤ b ∧ b ≤ 0

-- Dyadic minor determinant formula
theorem dyadic_minor_determinant (a b : ℝ) :
    (-2 * a) * (-2 * b) - (-b) ^ 2 = b * (4 * a - b)

-- Finite weighted Cauchy-Schwarz moment inequality
theorem finite_moment_minor_nonnegative {ι : Type*} [DecidableEq ι]
    (s : Finset ι) (w x : ι → ℝ) (hw : ∀ i ∈ s, 0 ≤ w i) :
    (∑ i ∈ s, w i * x i) ^ 2 ≤
      (∑ i ∈ s, w i) * ∑ i ∈ s, w i * x i ^ 2
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified proof in Lean 4 establishing the failure of Hankel moment positivity for raw additive Goldbach convolutions and certifying the two-point dyadic principal minor inequality for even screw kernels.
