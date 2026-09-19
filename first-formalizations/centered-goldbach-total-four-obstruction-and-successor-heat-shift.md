# First Formalization: Centered Goldbach Total-Four Obstruction and Successor Heat Shift Covariance

**Date:** 19 September 2026  
**Lean 4 Modules:** [`formalization/BuildingBlocks/CenteredGoldbachPositiveTransferObstruction.lean`](../../formalization/BuildingBlocks/CenteredGoldbachPositiveTransferObstruction.lean), [`formalization/BuildingBlocks/CenteredGoldbachSuccessorHeatFinite.lean`](../../formalization/BuildingBlocks/CenteredGoldbachSuccessorHeatFinite.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact algebraic obstruction to coefficientwise positivity for the centered Goldbach convolution and the discrete successor heat shift covariance law:

1. **Closed Form at Total Four:**
   Formal proof of the exact arithmetic formula $c_3(4) = (\log 2 - 1)^2 - 2(\log 3 - 1)$ (`centered_coefficient_four_exact`).
2. **Strict Negativity of Total-Four Coefficient:**
   Formal derivation of $c_3(4) < 0$ using machine-verified Taylor bounds on $\log 2$ and $\log 3$ (`centered_coefficient_four_neg`).
3. **Refutation of Positivity Conjectures:**
   Formal refutation of even-coefficient nonnegativity (`not_all_even_centered_coefficients_nonnegative`) and of centered Hankel matrix positive semidefiniteness (`centered_hankel_diagonal_not_nonnegative`).
4. **Endpoint Identity for Shifted Heat:**
   Formal proof of the shift-endpoint relation $\operatorname{shiftedFiniteHeat}(a, Y, t) = e^t \operatorname{finiteHeat}(a, Y, t) - a(1) + a(Y+1) e^{-Yt}$ (`shiftedFiniteHeat_endpoint`, `shiftedCenteredHeat_endpoint`).
5. **Opposite Sign Shifts at Totals 2 and 4:**
   Formal proofs that $\Delta c(2) = (\log 2)^2 - 2\log 2 < 0$ (`successor_coefficient_two_neg`) while $\Delta c(4) = (\log 2 - 1)^2 + (\log 3)^2 - 1 > 0$ (`successor_coefficient_four_pos`).
6. **Continuous Scale Covariance Identity:**
   Formal proof of the integrated shell identity $\operatorname{shiftedShell}(Y, T) - \operatorname{heatShell}(Y, T) = 2 \operatorname{crossShell}(Y, T) + \operatorname{variationShell}(Y, T)$ (`shiftedShell_sub_original`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exact closed form and strict negativity
theorem centered_coefficient_four_exact :
    truncatedCoefficient 3 4 =
      (Real.log 2 - 1) ^ 2 - 2 * (Real.log 3 - 1)

theorem centered_coefficient_four_neg : truncatedCoefficient 3 4 < 0

-- Refutation of coefficientwise nonnegativity
theorem not_all_even_centered_coefficients_nonnegative :
    ¬(∀ Y N : ℕ, Even N → N ≤ Y + 1 → 0 ≤ truncatedCoefficient Y N)

theorem centered_hankel_diagonal_not_nonnegative :
    ¬(∀ x : ℝ, 0 ≤ truncatedCoefficient 3 4 * x ^ 2)

-- Discrete successor signed decomposition and opposite signs
theorem successor_coefficient_two_neg :
    shiftedCoefficient 1 2 -
      BuildingBlocks.CenteredGoldbachTruncatedHeat.truncatedCoefficient 1 2 < 0

theorem successor_coefficient_four_pos :
    0 < shiftedCoefficient 3 4 -
      BuildingBlocks.CenteredGoldbachTruncatedHeat.truncatedCoefficient 3 4

-- Integrated continuous shell covariance
theorem shiftedShell_sub_original (Y : ℕ) (T : ℝ) :
    shiftedShell Y T - finiteHeatScaleIncrement Y T =
      2 * crossShell Y T + variationShell Y T
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified proof of the strict negativity of the first nontrivial centered Goldbach coefficient $c_3(4) < 0$ and the refutation of Hankel positivity for centered prime convolutions, accompanied by the exact algebraic successor covariance decomposition in Lean 4.
