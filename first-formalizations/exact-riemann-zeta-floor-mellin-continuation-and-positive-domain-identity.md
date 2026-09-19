# First Formalization: Exact Riemann Zeta Floor-Mellin Continuation and Positive-Domain Identity

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/FloorMellin.lean`](../../formalization/BuildingBlocks/FloorMellin.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization proves the exact analytic continuation of the Riemann zeta function across the critical strip via the fractional-part Mellin transform in Lean 4:

1. **Floor Remainder Bounds and Local Integrability:**
   Formal proof of `floorRemainder_norm_le` ($\|\{x\}\| \le 1$), `floorRemainder_locallyIntegrable`, and `floorRemainder_of_one_le`.
2. **Asymptotics and Mellin Convergence:**
   Formal proof of `floorRemainder_bigO_top`, `floorRemainder_bigO_zero`, and `floorRemainder_mellinConvergent`: convergence on $\text{Re}(s) > 0$.
3. **Holomorphy of the Floor-Mellin Transform:**
   Formal proof of `floorMellin_analytic`: analyticity of $\text{floorMellin}(s) = \int_1^\infty \{x\} x^{-(s+1)} dx$ on $\{s : 0 < s.\text{re}\}$.
4. **Dirichlet Integration by Parts for $\text{Re}(s) > 1$:**
   Formal proof of `zeta_eq_floor_integral` and `zeta_eq_floorMellin_initial`: $\zeta(s) = \frac{s}{s-1} - s \cdot \text{floorMellin}(s)$ on $\text{Re}(s) > 1$.
5. **Positive-Domain Identity Theorem and Strip Continuation:**
   Formal proof of `identity_on_positiveDomain` and `zeta_eq_floorMellin`: unconditional equality $\zeta(s) = \frac{s}{s-1} - s \cdot \text{floorMellin}(s)$ for all $\text{Re}(s) > 0, s \ne 1$.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Convergence of generalized Mellin transform
theorem floorRemainder_mellinConvergent {s : ℂ} (hs : 0 < s.re) :
    MellinConvergent floorRemainder (-s)

-- Holomorphy of the fractional-part Mellin transform
theorem floorMellin_analytic : AnalyticOnNhd ℂ floorMellin {s | 0 < s.re}

-- Punctured positive-domain identity theorem
theorem identity_on_positiveDomain {F : ℂ → ℂ}
    (hF : AnalyticOnNhd ℂ F {s | 0 < s.re ∧ s ≠ 1})
    (hzero : ∀ s : ℂ, 1 < s.re → F s = 0) :
    ∀ s : ℂ, 0 < s.re → s ≠ 1 → F s = 0

-- Exact continuation across the critical strip
theorem zeta_eq_floorMellin {s : ℂ} (hs : 0 < s.re) (hne : s ≠ 1) :
    riemannZeta s = s / (s - 1) - s * floorMellin s
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified proof in Lean 4 establishing the classical integral representation $\zeta(s) = \frac{s}{s-1} - s \int_1^\infty (x - \lfloor x \rfloor) x^{-(s+1)} dx$ throughout the entire critical strip $\text{Re}(s) > 0, s \ne 1$, mediated by a verified complex domain identity theorem.
