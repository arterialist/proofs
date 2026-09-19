# First Formalization: Exact Laplace-Mellin Measure Duality and Negative-Tail Isomorphism

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ActualCriticalLaplace.lean`](../../formalization/BuildingBlocks/ActualCriticalLaplace.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact measure-theoretic and algebraic duality between Laplace moment integrals on $[0, \infty)$ and shifted Mellin integrals on $(1, \infty)$ for critical tail measures in Lean 4:

1. **Pointwise Density Multiplier Algebra:**
   Formal proof that $\rho_A(x) e^{-s t(x)} = x^{-s-2} (-W_{\text{tail}, A}(x))$ (`density_smul_exp`, `tailDensity_toReal`).
2. **Integral Equivalence:**
   Formal proof that the $0$-th Laplace moment equals the Mellin transform $\mathcal{M}(-W_{\text{tail}, A})(-s-1)$ (`moment_eq_mellin_negativeWTail`).
3. **Decomposition into Initial Mellin and Filled Transform:**
   Formal proof of $\int_0^\infty e^{-st} d\mu_A = \mathcal{M}(W_{\text{init}, A})(-s-1) - \Phi(s)$ on $\operatorname{Re}(s) > 1$ (`moment_eq_initial_sub_filledTransform`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Density conversion to real
theorem tailDensity_toReal {A : ℝ}
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0)
    {x : ℝ} (hx : 0 ≤ x) :
    (tailDensity A x).toReal = x^(-2 : ℝ) * (negativeWTail A x).re

-- Density smul exponential equals Mellin integrand
theorem density_smul_exp {A : ℝ}
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0)
    {x : ℝ} (hx : 1 < x) (s : ℂ) :
    (tailDensity A x).toReal • Complex.exp (-s * (time x : ℂ)) =
      (x : ℂ)^(-s-2) * negativeWTail A x

-- Laplace moment equals Mellin transform of negative tail
theorem moment_eq_mellin_negativeWTail {A : ℝ} (hA : 1 ≤ A)
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0) (s : ℂ) :
    LaplaceMomentDerivatives.moment (tailMeasure A) time 0 s =
      mellin (negativeWTail A) (-s-1)

-- Laplace moment equals initial Mellin minus filled transform
theorem moment_eq_initial_sub_filledTransform {A : ℝ} (hA : 1 ≤ A)
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0)
    {s : ℂ} (hs : 1 < s.re) :
    LaplaceMomentDerivatives.moment (tailMeasure A) time 0 s =
      mellin (initialPart ActualCriticalMellin.W A) (-s-1) -
        CriticalTransformPoles.filledTransform s
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving the exact Bochner integral equivalence between positive Laplace measures and shifted Mellin transforms of critical tails.
