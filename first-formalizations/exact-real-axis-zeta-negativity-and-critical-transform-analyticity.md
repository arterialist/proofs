# First Formalization: Exact Real-Axis Zeta Negativity and Critical Transform Analyticity

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/CriticalTransformRealAxis.lean`](../../formalization/BuildingBlocks/CriticalTransformRealAxis.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the non-negativity of the fractional-part Mellin transform, strict negativity of $\zeta(\sigma)$ on $(0, 1)$, real non-vanishing on $(0, \infty) \setminus \{1\}$, and unconditional analyticity of the filled critical transform on $(1/2, \infty)$ in Lean 4:

1. **Fractional-Part Mellin Non-Negativity:**
   Formal proof of `floorMellin_re_nonneg`: $\text{Re}(\int_1^\infty \{x\} x^{-(\sigma+1)} dx) \ge 0$ for all $\sigma > 0$.
2. **Strict Negativity of Zeta on $(0, 1)$:**
   Formal proof of `riemannZeta_re_neg`: $\text{Re}(\zeta(\sigma)) < 0$ for all $\sigma \in (0, 1)$.
3. **Real Non-Vanishing of Zeta:**
   Formal proof of `riemannZeta_ne_zero_real`: $\zeta(\sigma) \ne 0$ for all $\sigma \in (0, \infty) \setminus \{1\}$.
4. **Real Ray Analyticity of the Filled Transform:**
   Formal proofs of `analyticAt_filledTransform_of_ne_zero` and `analyticAt_filledTransform_real`: Unconditional analyticity of `filledTransform` at every real point $\sigma > 1/2$.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Non-negativity of the fractional-part integral
theorem floorMellin_re_nonneg {σ : ℝ} (hσ : 0 < σ) :
    0 ≤ (floorMellin (σ : ℂ)).re

-- Strict negativity of Riemann zeta on (0, 1)
theorem riemannZeta_re_neg {σ : ℝ} (hσ0 : 0 < σ) (hσ1 : σ < 1) :
    (riemannZeta (σ : ℂ)).re < 0

-- Non-vanishing of Riemann zeta on the positive real axis
theorem riemannZeta_ne_zero_real {σ : ℝ} (hσ0 : 0 < σ) (hσ1 : σ ≠ 1) :
    riemannZeta (σ : ℂ) ≠ 0

-- Unconditional complex analyticity of the filled transform along (1/2, ∞)
theorem analyticAt_filledTransform_real {σ : ℝ} (hσ : (1 : ℝ) / 2 < σ) :
    AnalyticAt ℂ CriticalTransformPoles.filledTransform (σ : ℂ)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving that $\text{Re}(\zeta(\sigma)) < 0$ on $(0, 1)$ and establishing the unconditional analyticity of the filled quadratic prime transform along the entire real ray $(1/2, \infty)$.
