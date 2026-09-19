# First Formalization: Exact Adjacent Additive Totals Discrete Derivative and Goldbach Pairing Oscillation

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/CenteredGoldbachAdjacentTotalsFinite.lean`](../../formalization/BuildingBlocks/CenteredGoldbachAdjacentTotalsFinite.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization proves the exact discrete derivative formula for adjacent convolution totals and establishes rigorous sign oscillation for adjacent even/odd pairings under heat kernels in Lean 4:

1. **Adjacent Discrete Derivative Identity:**
   Formal proof of `boundedCoefficient_adjacent`:
   \[
   C_Y(N+1) - C_Y(N) = \text{core}(a, Y, N) + \text{birth}(a, Y, N) - \text{departure}(a, Y, N).
   \]
2. **Face Evaluations:**
   Formal proof of `birthFace_eq_if` and `departureFace_eq_if`.
3. **Interior Derivative and Constant Cancellation:**
   Formal proof of `centered_adjacent` and `centered_adjacent_derivative_eq_mangoldt`.
4. **Odd Total Even-Prime Parity Symmetry:**
   Formal proof of `odd_primeCoefficient_eq_two_evenPrimeRow`.
5. **Sign Oscillation of Adjacent Pairs:**
   Formal evaluations `coefficient_two_at_three`, `coefficient_three_at_three`, `coefficient_five_at_three`, and proofs of `adjacentPair_three_two_pos`, `adjacentPair_three_four_neg`, `weightedAdjacentPair_three_two_pos`, and `weightedAdjacentPair_three_four_neg`.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- General discrete derivative formula for truncated convolutions
theorem boundedCoefficient_adjacent {Y : ℕ} (hY : 1 ≤ Y) (a : ℕ → ℝ) (N : ℕ) :
    boundedCoefficient a Y (N + 1) - boundedCoefficient a Y N =
      adjacentDerivativeCore a Y N + birthFace a Y N - departureFace a Y N

-- Exact cancellation of centering constant in interior derivative
theorem centered_adjacent_derivative_eq_mangoldt (Y N : ℕ) :
    adjacentDerivativeCore centeredCoefficient Y N =
      ∑ m ∈ Icc 1 Y, ∑ n ∈ Icc 1 (Y - 1),
        if m + n = N then centeredCoefficient m *
          (ArithmeticFunction.vonMangoldt (n + 1) -
            ArithmeticFunction.vonMangoldt n) else 0

-- Odd total even-prime symmetry factor 2
theorem odd_primeCoefficient_eq_two_evenPrimeRow {N : ℕ} (hodd : Odd N) (Y : ℕ) :
    BuildingBlocks.CenteredGoldbachHeatScaleIncrementFinite.truncatedPrimeCoefficient Y N =
      2 * evenPrimeRow Y N

-- Bare adjacent pair sign oscillation
theorem adjacentPair_three_two_pos : 0 < adjacentPair 3 2
theorem adjacentPair_three_four_neg : adjacentPair 3 4 < 0

-- Heat-shell weighted adjacent pair sign oscillation
theorem weightedAdjacentPair_three_two_pos {T : ℝ} (hT : 0 < T) :
    0 < weightedAdjacentPair 3 2 T
theorem weightedAdjacentPair_three_four_neg {T : ℝ} (hT : 0 < T) :
    weightedAdjacentPair 3 4 T < 0
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified proof in Lean 4 establishing the exact discrete derivative decomposition for truncated additive convolutions and proving the impossibility of universal adjacent-pair sign bounds under heat kernels.
