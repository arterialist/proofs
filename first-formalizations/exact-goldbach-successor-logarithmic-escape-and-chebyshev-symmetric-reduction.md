# First Formalization: Exact Goldbach Successor Logarithmic Escape and Chebyshev Symmetric Reduction

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/GoldbachSuccessorLogFinite.lean`](../../formalization/BuildingBlocks/GoldbachSuccessorLogFinite.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization proves the exact non-negativity and symmetric reduction of the 2D Goldbach logarithmic escape loss into a single Chebyshev convolution in Lean 4:

1. **Definitions of Logarithmic Pair Metrics:**
   Formal definitions of `cofactor`, `logLeg`, `logPair`, `logEscapeNumerator`, `logEscape`, and `signedCofactorError`.
2. **Pointwise and Global Non-Negativity:**
   Formal proofs of `logPair_nonneg`, `logPair_eq_log_ratio`, and `logEscape_nonneg`.
3. **Cofactor and Chebyshev Identification:**
   Formal proof of `cofactor_eq_psi`.
4. **Symmetric Reduction and Trimming:**
   Formal proofs of `logEscapeNumerator_eq_cofactor`, `logEscapeNumerator_eq_psi`, `logEscape_eq_psi`, and `logEscape_eq_psi_trim`.
5. **Rational Cofactor Error Splitting:**
   Formal proof of `rationalCofactor_eq_baseline_add_error`.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Non-negativity of split logarithmic pair loss on additive triangle
theorem logPair_nonneg {s m n : ℕ} (hm : 2 ≤ m) (hn : 2 ≤ n)
    (had : m + n ≤ s) : 0 ≤ logPair s m n

-- Unconditional non-negativity of finite logarithmic escape loss
theorem logEscape_nonneg (s : ℕ) : 0 ≤ logEscape s

-- Symmetric reduction of double sum to Chebyshev-weighted convolution
theorem logEscapeNumerator_eq_psi (s : ℕ) :
    logEscapeNumerator s =
      2 * ∑ m ∈ Icc 2 s,
        Λ m * BuildingBlocks.CoarsePrimitive.psi (s - m) * logLeg s m

-- Exact endpoint trimming to s-2
theorem logEscape_eq_psi_trim (s : ℕ) (hs : 4 ≤ s) :
    logEscape s =
      (2 * ∑ m ∈ Icc 2 (s - 2),
        Λ m * BuildingBlocks.CoarsePrimitive.psi (s - m) * logLeg s m) /
        (s : ℝ) ^ 2

-- Rational cofactor split into baseline count and signed Chebyshev error
theorem rationalCofactor_eq_baseline_add_error (s : ℕ) (hs : 4 ≤ s) :
    (∑ m ∈ Icc 2 (s - 2),
      Λ m * BuildingBlocks.CoarsePrimitive.psi (s - m) /
        ((s - m : ℕ) : ℝ)) =
      BuildingBlocks.CoarsePrimitive.psi (s - 2) + signedCofactorError s
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified proof in Lean 4 establishing the exact symmetric reduction of 2D Goldbach logarithmic transport loss to a 1D Chebyshev convolution, proving unconditional non-negativity and boundary trimming to $s-2$.
