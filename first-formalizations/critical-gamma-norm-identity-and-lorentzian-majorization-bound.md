# First Formalization: Critical Gamma Norm Identity and Lorentzian Majorization Bound

**Date:** 19 September 2026  
**Lean 4 Modules:** [`formalization/BuildingBlocks/AdditiveHeatGamma.lean`](../../formalization/BuildingBlocks/AdditiveHeatGamma.lean), [`formalization/BuildingBlocks/AdditiveHeatWeight.lean`](../../formalization/BuildingBlocks/AdditiveHeatWeight.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact critical line norm squared of the complex Gamma function and its rational Lorentzian majorization in Lean 4:

1. **Critical Line Sine and Gamma Norm:**
   Formal proofs that $\sin(\pi(1/2+i\xi)) = \cosh(\pi\xi)$ (`sin_half_line`) and $\|\Gamma(1/2+i\xi)\|^2 = \frac{\pi}{\cosh(\pi\xi)}$ (`gamma_half_line_norm_sq`).
2. **Cosh Quadratic Minorization:**
   Formal derivation of $1 + x^2/2 \le \cosh x$ from the infinite series (`quadratic_le_cosh`).
3. **Physical Denominator Bound:**
   Formal proof of $1 + 4\xi^2 \le \cosh(\pi\xi)$ using $\pi > 3 \implies \pi^2 > 8$ (`physical_denominator_le_cosh`).
4. **Rational Lorentzian Majorization:**
   Formal proof that $\frac{\pi}{\cosh(\pi\xi)} \le \frac{\pi/4}{1/4+\xi^2}$ (`heat_weight_le_physical`, `weighted_heat_le_physical`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Critical line Gamma norm squared
theorem gamma_half_line_norm_sq (ξ : ℝ) :
    ‖Complex.Gamma ((1 / 2 : ℂ) + (ξ : ℂ) * Complex.I)‖ ^ 2 =
      Real.pi / Real.cosh (Real.pi * ξ)

-- Physical denominator bound
theorem physical_denominator_le_cosh (ξ : ℝ) :
    1 + 4 * ξ ^ 2 ≤ Real.cosh (Real.pi * ξ)

-- Rational Lorentzian majorization
theorem heat_weight_le_physical (ξ : ℝ) :
    Real.pi / Real.cosh (Real.pi * ξ) ≤
      (Real.pi / 4) / (1 / 4 + ξ ^ 2)

-- Weighted version
theorem weighted_heat_le_physical (ξ w : ℝ) (hw : 0 ≤ w) :
    (Real.pi / Real.cosh (Real.pi * ξ)) * w ≤
      ((Real.pi / 4) / (1 / 4 + ξ ^ 2)) * w
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified proof in Lean 4 connecting the critical Gamma reflection identity to sharp rational Lorentzian majorization bounds for parabolic heat spectral kernels.
