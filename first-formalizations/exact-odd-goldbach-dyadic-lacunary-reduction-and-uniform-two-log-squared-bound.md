# First Formalization: Exact Odd Goldbach Dyadic Lacunary Reduction and Uniform Two-Log-Squared Bound

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/GoldbachOddPowerBoundFinite.lean`](../../formalization/BuildingBlocks/GoldbachOddPowerBoundFinite.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization proves the exact even von Mangoldt sum over powers of 2, the exact lacunary dyadic reduction of odd Goldbach convolution sums, and the uniform $2(\log N)^2$ upper bound in Lean 4:

1. **Power Support and Even Von Mangoldt Sum:**
   Formal proofs of `powerSupport_eq_image` and `even_vonMangoldt_sum`.
2. **Inner Pair and Even Prime Row Sum:**
   Formal proofs of `innerPair`, `evenPrimeRow_eq_sum`, and `evenPrimeRow_eq_support`.
3. **Exact Dyadic Lacunary Reduction:**
   Formal proof of `odd_primeCoefficient_power_sum`.
4. **Admissible Filter and Uniform Log-Squared Bound:**
   Formal proofs of `admissible_subset`, `admissible_card_le`, `odd_primeCoefficient_le_log_count`, `log_count_le_log`, and `odd_primeCoefficient_le_two_log_sq`.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exact even von Mangoldt sum over powers of two
theorem even_vonMangoldt_sum (Y : ℕ) :
    (∑ m ∈ Icc 1 Y,
      if Even m then ArithmeticFunction.vonMangoldt m else 0) =
      (Nat.log 2 Y : ℝ) * Real.log 2

-- Exact lacunary reduction of odd Goldbach coefficient
theorem odd_primeCoefficient_power_sum {N : ℕ} (hodd : Odd N) (Y : ℕ) :
    BuildingBlocks.CenteredGoldbachHeatScaleIncrementFinite.truncatedPrimeCoefficient Y N =
      2 * Real.log 2 *
        ∑ k ∈ Icc 1 (Nat.log 2 Y),
          if 2 ^ k ≤ N ∧ N - 2 ^ k ∈ Icc 1 Y then
            ArithmeticFunction.vonMangoldt (N - 2 ^ k) else 0

-- Logarithmic count bound
theorem odd_primeCoefficient_le_log_count {N : ℕ} (hodd : Odd N) (Y : ℕ) :
    BuildingBlocks.CenteredGoldbachHeatScaleIncrementFinite.truncatedPrimeCoefficient Y N ≤
      2 * Real.log 2 * (Nat.log 2 N : ℝ) * Real.log (N : ℝ)

-- Uniform two-log-squared upper bound
theorem odd_primeCoefficient_le_two_log_sq {N : ℕ} (hodd : Odd N) (Y : ℕ) :
    BuildingBlocks.CenteredGoldbachHeatScaleIncrementFinite.truncatedPrimeCoefficient Y N ≤
      2 * (Real.log (N : ℝ)) ^ 2
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified proof in Lean 4 establishing the exact dyadic lacunary reduction of odd Goldbach sums and proving the uniform $2(\log N)^2$ bound for truncated prime coefficients.
