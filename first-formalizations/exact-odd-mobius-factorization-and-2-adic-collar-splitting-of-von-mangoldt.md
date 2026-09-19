# First Formalization: Exact Odd-Möbius Factorization and 2-Adic Collar Splitting of von Mangoldt

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/SuccessorCollarOddMobius.lean`](../../formalization/BuildingBlocks/SuccessorCollarOddMobius.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization proves the exact odd-Möbius arithmetic factorization $\mu = \mu_{\text{odd}} * (\delta_1 - \delta_2)$, the universal $\log 2$ collapse on even cofactors, and the odd-Möbius divisor/hyperbola formulas for von Mangoldt in Lean 4:

1. **Definitions of 2-Adic and Odd Projections:**
   Formal definitions of `atTwo`, `oddMoebius`, and `oddLogBracket`.
2. **Convolution Action and Factorization:**
   Formal proofs of `atTwo_mul_apply` and `moebius_eq_odd_factor`.
3. **Logarithmic Collapse:**
   Formal proofs of `oddLogBracket_odd`, `oddLogBracket_even` ($L_{\text{odd}}(2m) = \log 2$), `oddLogBracket_apply`, and `oddLogBracket_pos`.
4. **von Mangoldt Factorization:**
   Formal proof of `vonMangoldt_eq_odd_convolution` ($\Lambda = \mu_{\text{odd}} * L_{\text{odd}}$).
5. **Divisor and Hyperbola Expansions:**
   Formal proofs of `vonMangoldt_odd_divisor_formula`, `vonMangoldt_odd_divisor_formula_expanded`, `weighted_vonMangoldt_odd_divisor_formula`, and `weighted_vonMangoldt_odd_factor_pairs`.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exact odd-Möbius factorization of the arithmetic Möbius function
theorem moebius_eq_odd_factor :
    (ArithmeticFunction.moebius : ArithmeticFunction ℝ) =
      oddMoebius * (1 - atTwo)

-- Universal log 2 collapse on even cofactors
theorem oddLogBracket_apply (n : ℕ) :
    oddLogBracket n =
      if n = 0 then 0 else if Even n then Real.log 2 else Real.log n

-- Exact odd-Möbius factorization of von Mangoldt
theorem vonMangoldt_eq_odd_convolution :
    ArithmeticFunction.vonMangoldt = oddMoebius * oddLogBracket

-- Expanded divisor row
theorem vonMangoldt_odd_divisor_formula_expanded (n : ℕ) :
    ArithmeticFunction.vonMangoldt n =
      ∑ d ∈ n.divisors,
        (if Odd d then (ArithmeticFunction.moebius d : ℝ) else 0) *
          (if n / d = 0 then 0 else if Even (n / d) then Real.log 2
            else Real.log (n / d : ℕ))

-- Finite weighted hyperbola pair formula
theorem weighted_vonMangoldt_odd_factor_pairs
    (N : ℕ) (w : ℕ → ℝ) :
    (∑ n ∈ Finset.Icc 1 N, ArithmeticFunction.vonMangoldt n * w n) =
      ∑ a ∈ Finset.Icc 1 N, ∑ b ∈ Finset.Icc 1 (N / a),
        (if Odd a then (ArithmeticFunction.moebius a : ℝ) else 0) *
          (if Even b then Real.log 2 else Real.log b) * w (a * b)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified proof in Lean 4 establishing the 2-adic difference factorization of the Möbius function and proving that all even cofactors in von Mangoldt's dual bracket collapse identically to $\log 2$.
