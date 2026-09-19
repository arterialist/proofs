# First Formalization: Exact Cyclotomic Prefix Derivative Multiplicative Update and Root Deficit Stability

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/CyclotomicPrefix.lean`](../../formalization/BuildingBlocks/CyclotomicPrefix.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization proves the exact multiplicative derivative update for cyclotomic prefix polynomials at old roots of unity, the non-vanishing of prefix derivatives, and the Lipschitz stability of root deficits in Lean 4:

1. **Definitions of Prefix Polynomial and Root Deficit:**
   Formal definitions of `phaseRoot`, `prefixPolynomial`, `rootDeficit`, and `oldRootUpdate`.
2. **Inductive Step and Root Vanishing:**
   Formal proofs of `prefixPolynomial_succ`, `prefixPolynomial_step`, and `prefixPolynomial_eval_zero`.
3. **Multiplicative Derivative Step:**
   Formal proof of `prefixDerivative_old_step` ($P_N'(\alpha) = P_{N-1}'(\alpha) \Phi_N(\alpha)$).
4. **Separability and Simplicity of Roots:**
   Formal proof of `prefixDerivative_ne_zero` ($P_N'(\alpha) \ne 0$).
5. **Deficit Stability Estimates:**
   Formal proofs of `clippedLog_lipschitz`, `oldRootUpdate_abs_le_factorLog`, and `oldRootUpdate_abs_le`.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Inductive factor step for prefix polynomial
theorem prefixPolynomial_step {N : ℕ} (hN : 1 ≤ N) :
    prefixPolynomial N = prefixPolynomial (N - 1) * Polynomial.cyclotomic N ℂ

-- Exact multiplicative step for prefix derivative at old root
theorem prefixDerivative_old_step {N n : ℕ} {α : ℂ}
    (hn : 0 < n) (hOld : n < N) (hα : IsPrimitiveRoot α n) :
    (prefixPolynomial N).derivative.eval α =
      (prefixPolynomial (N - 1)).derivative.eval α *
        (Polynomial.cyclotomic N ℂ).eval α

-- Non-vanishing of prefix derivative at all roots of unity
theorem prefixDerivative_ne_zero {N n : ℕ} {α : ℂ}
    (hn : 0 < n) (hnN : n ≤ N) (hα : IsPrimitiveRoot α n) :
    (prefixPolynomial N).derivative.eval α ≠ 0

-- Logarithmic factor bound on root deficit update
theorem oldRootUpdate_abs_le_factorLog {N n : ℕ} {α : ℂ}
    (hn : 0 < n) (hOld : n < N) (hα : IsPrimitiveRoot α n) :
    |oldRootUpdate N α| ≤ |Real.log ‖(Polynomial.cyclotomic N ℂ).eval α‖|

-- Regularized divisor-logarithm bound
theorem oldRootUpdate_abs_le {N n : ℕ} {α : ℂ}
    (hn : 0 < n) (hOld : n < N) (hα : IsPrimitiveRoot α n)
    (hidentity : OldFactorRegularizedIdentity α n N) :
    |oldRootUpdate N α| ≤ (N.divisors.card : ℝ) * Real.log N
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified proof in Lean 4 establishing the exact multiplicative derivative update at old roots of unity for cyclotomic prefix polynomials and proving the Lipschitz stability of the logarithmic derivative deficit.
