# First Formalization: Exact Critical Laplace Moment Identity and Compact Initial Difference

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ActualCriticalLaplace.lean`](../../formalization/BuildingBlocks/ActualCriticalLaplace.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact identity between the Laplace transform of the critical positive tail measure and the difference between the compact initial segment Mellin integral and the filled critical transform in Lean 4:

1. **Laplace-Mellin Exponent Bridge:**
   Formal proof that $(tailDensity(x)) e^{-s t(x)} = x^{-s-2} (-W_{\text{tail}}(x))$ (`density_smul_exp`).
2. **Tail Measure Zeroth Moment:**
   Formal equivalence of the positive tail measure's Laplace transform to the Mellin transform of $-W_{\text{tail}}$ at $-s-1$ (`moment_eq_mellin_negativeWTail`).
3. **Compact Initial Difference Representation:**
   Formal proof of $\int_0^\infty e^{-st} d\mu_{\text{tail}}(t) = \mathcal{M}(W_{\text{initial}})(-s-1) - \mathcal{T}_{\text{filled}}(s)$ on $\operatorname{Re}(s) > 1$ (`moment_eq_initial_sub_filledTransform`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exponent transformation
theorem density_smul_exp {A : ℝ}
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0)
    {x : ℝ} (hx : 1 < x) (s : ℂ) :
    (tailDensity A x).toReal • Complex.exp (-s * (time x : ℂ)) =
      (x : ℂ)^(-s-2) * negativeWTail A x

-- Laplace moment equals Mellin transform
theorem moment_eq_mellin_negativeWTail {A : ℝ} (hA : 1 ≤ A)
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0) (s : ℂ) :
    LaplaceMomentDerivatives.moment (tailMeasure A) time 0 s =
      mellin (negativeWTail A) (-s-1)

-- Difference from compact initial segment
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

This entry documents a machine-verified proof in Lean 4 equating the Laplace transform of an arithmetic sign-tail measure to the explicit holomorphic difference between a compact interval integral and the meromorphic critical zeta transform.
