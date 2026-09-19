# First Formalization: Exact Integer Birth Density Difference L1 Decay and Mangoldt Series Integration

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/IntegerBirthDifferenceL1.lean`](../../formalization/BuildingBlocks/IntegerBirthDifferenceL1.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization proves the exact strip-plus-tail majorant on integer birth density differences, establishes the $n^{-3/2}$ $L^1$ decay bound, and verifies the dominated convergence interchange of continuous integration and countable von Mangoldt series in Lean 4:

1. **Definitions of Strip and Tail Majorants:**
   Formal definitions of `lower`, `stripMajorant`, and `tailMajorant`.
2. **Common Tail and Pointwise Domination:**
   Formal proofs of `common_tail_difference` and `difference_norm_le`.
3. **Integral Evaluations and L1 Decay:**
   Formal proofs of `strip_integrable`, `tail_integrable`, `strip_integral`, `tail_integral`, `difference_integral_norm_le`, and `difference_integral_norm_birth_bound`.
4. **Von Mangoldt Weighted Summability:**
   Formal proofs of `mangoldt_difference_integral_norm_summable` and `weighted_difference_integrable`.
5. **Dominated Convergence and Series Integration:**
   Formal proofs of `all_birth_difference_integrable` and `all_birth_difference_integral`.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- L1 decay bound on birth density differences
theorem difference_integral_norm_birth_bound {n j : ℕ} (hn : 2 ≤ n) :
    (∫ x in Ioi (1:ℝ), ‖birthDensity n (j+1) x-birthDensity n j x‖) ≤
      2*((j:ℝ)+2)^2/((n:ℝ)*Real.sqrt n)

-- Countable L1 summability against von Mangoldt function
theorem mangoldt_difference_integral_norm_summable (j : ℕ) :
    Summable (fun n : ℕ => ∫ x in Ioi (1:ℝ),
      ‖ArithmeticFunction.vonMangoldt (n+2) *
        (birthDensity (n+2) (j+1) x-birthDensity (n+2) j x)‖)

-- Integrability of the infinite sum of birth differences
theorem all_birth_difference_integrable (j : ℕ) :
    IntegrableOn (fun x => ∑' n : ℕ, ArithmeticFunction.vonMangoldt (n+2) *
      (birthDensity (n+2) (j+1) x-birthDensity (n+2) j x)) (Ioi 1)

-- Termwise interchange of integration and infinite von Mangoldt sum
theorem all_birth_difference_integral (j : ℕ) :
    (∫ x in Ioi (1:ℝ), ∑' n : ℕ, ArithmeticFunction.vonMangoldt (n+2) *
      (birthDensity (n+2) (j+1) x-birthDensity (n+2) j x)) =
    ∑' n : ℕ, ArithmeticFunction.vonMangoldt (n+2) *
      (IntegerBirthDiscreteCorrection.discreteBirth (n+2) (j+1)-
        IntegerBirthDiscreteCorrection.discreteBirth (n+2) j)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified proof in Lean 4 establishing the $n^{-3/2}$ $L^1$ decay of integer birth density differences and justifying the termwise dominated convergence integration of countable von Mangoldt arithmetic series.
