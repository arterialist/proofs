# First Formalization: Exact Arithmetic Function Möbius-Vaughan Identity and Type I/II Decomposition

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/MobiusVaughan.lean`](../../formalization/BuildingBlocks/MobiusVaughan.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact algebraic Vaughan identity for the Möbius function in the ring of arithmetic functions, the compact support bounds for the convolution coefficients, the factor-pair weighted convolution formula, and the general weighted Type I / Type II sum decomposition in Lean 4:

1. **Exact Ring Algebraic Identity:**
   Formal proof that $\mu = 2\mu_{\le U} - (\mu_{\le U} * \mu_{\le U}) * \zeta + \mu_{>U} * (\mu_{>U} * \zeta)$ (`moebius_vaughan_identity`).
2. **Compact Support Bounds:**
   Formal proofs that $(\mu_{\le U} * \mu_{\le U})(n) = 0$ for $n > U^2$ (`vaughanSmallCoefficient_eq_zero_of_lt`) and $(\mu_{>U} * \zeta)(n) = 0$ for $n \le U$ (`vaughanLargeCoefficient_eq_zero_of_le`).
3. **Factor-Pair Convolution Sum:**
   Formal proof of $\sum_{n \le N} (f * g)(n) w(n) = \sum_{a \le N} f(a) \sum_{b \le N/a} g(b) w(ab)$ (`weighted_convolution_sum`).
4. **General Weighted Type I/II Decomposition:**
   Formal proof of the exact Type I and Type II decomposition for weighted Möbius sums (`moebius_vaughan_weighted_sum`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exact Vaughan identity for Moebius in arithmetic function ring
theorem moebius_vaughan_identity (U : ℕ) :
    (ArithmeticFunction.moebius : ArithmeticFunction ℝ) =
      2 • moebiusSmall U -
        vaughanSmallCoefficient U * (ArithmeticFunction.zeta : ArithmeticFunction ℝ) +
        moebiusLarge U * vaughanLargeCoefficient U

-- Support cutoff for Type I coefficients
theorem vaughanSmallCoefficient_eq_zero_of_lt {U n : ℕ} (hn : U * U < n) :
    vaughanSmallCoefficient U n = 0

-- Support cutoff for Type II coefficients
theorem vaughanLargeCoefficient_eq_zero_of_le {U n : ℕ} (hn : n ≤ U) :
    vaughanLargeCoefficient U n = 0

-- General factor-pair weighted convolution formula
theorem weighted_convolution_sum (f g : ArithmeticFunction ℝ) (w : ℕ → ℝ) (N : ℕ) :
    (∑ n ∈ Finset.Icc 1 N, (f * g) n * w n) =
      ∑ a ∈ Finset.Icc 1 N, f a *
        ∑ b ∈ Finset.Icc 1 (N / a), g b * w (a * b)

-- Exact weighted Type I / Type II sum decomposition
theorem moebius_vaughan_weighted_sum (U N : ℕ) (w : ℕ → ℝ)
    (hw : ∀ n, n ≤ U → w n = 0) :
    (∑ n ∈ Finset.Icc 1 N, (ArithmeticFunction.moebius n : ℝ) * w n) =
      -(∑ a ∈ Finset.Icc 1 N, vaughanSmallCoefficient U a *
        ∑ b ∈ Finset.Icc 1 (N / a),
          (ArithmeticFunction.zeta : ArithmeticFunction ℝ) b * w (a * b)) +
      ∑ a ∈ Finset.Icc 1 N, moebiusLarge U a *
        ∑ b ∈ Finset.Icc 1 (N / a), vaughanLargeCoefficient U b * w (a * b)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving the exact algebraic Möbius-Vaughan identity and its weighted Type I / Type II bilinear decomposition without asymptotic approximations.
