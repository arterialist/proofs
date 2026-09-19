# First Formalization: Exact Oriented Ramp Prime Weights and Piecewise Summand Algebra

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ActualRampPrimeWeights.lean`](../../formalization/BuildingBlocks/ActualRampPrimeWeights.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact three-region piecewise structure of oriented causal ramp weights, the prime-power exponential simplification $1 - n e^{-A}$, the algebraic decoupling of von Mangoldt cross summands $\frac{\Lambda(n)}{n} - \Lambda(n) e^{-M}$, and global monotonicity in Lean 4:

1. **Piecewise Profile:**
   Formal proof of plateau value $1 - e^{-B}$, internal transition, slope evaluation, and outer vanishing (`orientedWeight_plateau`, `orientedWeight_internal_transition`, `orientedWeight_slope_prime`, `orientedWeight_outer_zero`).
2. **Von Mangoldt Summand Decoupling:**
   Formal derivation of $\frac{\Lambda(n)}{n} W = \frac{\Lambda(n)}{n} - \Lambda(n) e^{-(L+\Delta)}$ in the sloping region (`secondPrimeTerm_slope`).
3. **Global Monotonicity:**
   Formal proof that the finite prime-power cross energy is non-negative and non-decreasing in parameters and cutoff (`actualPrimeCross_nonneg`, `actualPrimeCross_mono`, `actualPrimeCross_mono_cutoff`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Piecewise profile: plateau
theorem orientedWeight_plateau {A B u : ℝ}
    (hB : 0 ≤ B) (hu : u ≤ A - B) :
    orientedWeight A B u = 1 - Real.exp (-B)

-- Internal transition
theorem orientedWeight_internal_transition {A B : ℝ} (hB : 0 ≤ B) :
    orientedWeight A B (A - B) = 1 - Real.exp (-B)

-- Outer vanishing
theorem orientedWeight_outer_zero {A B u : ℝ}
    (hB : 0 ≤ B) (hAu : A ≤ u) :
    orientedWeight A B u = 0

-- Prime-power sloping formula
theorem orientedWeight_slope_prime {A B : ℝ} {n : ℕ}
    (hn : 0 < n) (huA : Real.log (n : ℝ) ≤ A)
    (hAB : A - Real.log (n : ℝ) ≤ B) :
    orientedWeight A B (Real.log (n : ℝ)) =
      1 - (n : ℝ) * Real.exp (-A)

-- Exact algebraic summand decoupling
theorem secondPrimeTerm_slope {L Delta : ℝ} {n : ℕ}
    (hn : 0 < n) (hDelta : Delta ≤ Real.log (n : ℝ))
    (houter : Real.log (n : ℝ) ≤ L + Delta) :
    (ArithmeticFunction.vonMangoldt n / (n : ℝ)) *
        orientedWeight (L + Delta) L (Real.log (n : ℝ)) =
      ArithmeticFunction.vonMangoldt n / (n : ℝ) -
        ArithmeticFunction.vonMangoldt n * Real.exp (-(L + Delta))

-- Discrete prime cross monotonicity
theorem actualPrimeCross_mono (N : ℕ) {A A' B B' : ℝ}
    (hA : A ≤ A') (hB : B ≤ B') :
    actualPrimeCross N A B ≤ actualPrimeCross N A' B'
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving the piecewise profile of oriented causal ramp correlation weights and the algebraic decoupling $\frac{\Lambda(n)}{n} - \Lambda(n) e^{-M}$ for prime-power shifts.
