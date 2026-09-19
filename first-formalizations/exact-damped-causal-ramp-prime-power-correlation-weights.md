# First Formalization: Exact Damped Causal Ramp Prime-Power Correlation Weights

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ActualRampPrimeWeights.lean`](../../formalization/BuildingBlocks/ActualRampPrimeWeights.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact algebraic properties of oriented prime cross-correlation weights for damped causal ramps in Lean 4:

1. **Piecewise Weight Properties:**
   Formal proof of outer vanishing (`orientedWeight_outer_zero`), internal plateau (`orientedWeight_plateau`), and transition value (`orientedWeight_internal_transition`).
2. **Exact Prime-Power Evaluation:**
   Formal proof that $W(A, B, \log n) = 1 - n e^{-A}$ in the sloping region (`orientedWeight_slope_prime`).
3. **Von Mangoldt Summand Splitting:**
   Formal derivation of $\frac{\Lambda(n)}{n} W(L+\Delta, L, \log n) = \frac{\Lambda(n)}{n} - \Lambda(n) e^{-(L+\Delta)}$ (`secondPrimeTerm_slope`).
4. **Monotonicity and Positivity:**
   Formal proofs that the finite sum is non-negative and non-decreasing in ramp parameters and cutoff $N$ (`actualPrimeCross_nonneg`, `actualPrimeCross_mono`, `actualPrimeCross_mono_cutoff`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Sloping prime weight evaluation
theorem orientedWeight_slope_prime {A B : ℝ} {n : ℕ}
    (hn : 0 < n) (huA : Real.log (n : ℝ) ≤ A)
    (hAB : A - Real.log (n : ℝ) ≤ B) :
    orientedWeight A B (Real.log (n : ℝ)) =
      1 - (n : ℝ) * Real.exp (-A)

-- Von Mangoldt summand evaluation in the sloping region
theorem secondPrimeTerm_slope {L Delta : ℝ} {n : ℕ}
    (hn : 0 < n) (hDelta : Delta ≤ Real.log (n : ℝ))
    (houter : Real.log (n : ℝ) ≤ L + Delta) :
    (ArithmeticFunction.vonMangoldt n / (n : ℝ)) *
        orientedWeight (L + Delta) L (Real.log (n : ℝ)) =
      ArithmeticFunction.vonMangoldt n / (n : ℝ) -
        ArithmeticFunction.vonMangoldt n * Real.exp (-(L + Delta))

-- Monotonicity in cutoff
theorem actualPrimeCross_mono_cutoff {N N' : ℕ} {A B : ℝ}
    (hNN : N ≤ N') (hB : 0 ≤ B) :
    actualPrimeCross N A B ≤ actualPrimeCross N' A B
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified proof in Lean 4 connecting damped causal ramp correlation weights to von Mangoldt prime sums and exact Chebyshev difference summands.
