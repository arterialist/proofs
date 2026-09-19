# First Formalization: Exact Narrow Pole-Null Wave Packets and Critical Pole Annihilation

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/NarrowPoleNullPacket.lean`](../../formalization/BuildingBlocks/NarrowPoleNullPacket.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization proves the existence and properties of smooth, compactly supported wave packets that annihilate the critical poles $s = \pm 1/2$ in Lean 4:

1. **Existence of Narrow Smooth Bumps:**
   Formal proof of `exists_narrow_bump`: smooth compact bump $\kappa$ with $\kappa(0) = 1$ and support in $(-\delta, \delta)$.
2. **Three-Point Carrier Stencil and Geometry:**
   Formal proof of `carrier_geometry`, `carrier_contDiff`, and `carrier_hasCompactSupport`.
3. **Mellin Moment Factorization:**
   Formal proof of `weighted_integrable`, `moment_translate`, and `carrier_moment`.
4. **Characteristic Polynomial Pole Vanishing:**
   Formal proof of `pole_polynomial`: $1 - (e^{\epsilon/2} + e^{-\epsilon/2})e^{\pm\epsilon/2} + e^{\pm 2\epsilon/2} = 0$.
5. **Real and Complex Pole-Null Packets:**
   Formal proof of `carrier_pole_moments`, `exists_narrow_pole_null`, `complex_lift_square`, and `exists_narrow_complex_pole_null`.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Characteristic polynomial vanishing at s = ±1/2
theorem pole_polynomial (epsilon s : ℝ) (hs : s = 1 / 2 ∨ s = -(1 / 2)) :
    1 - (Real.exp (epsilon / 2) + Real.exp (-epsilon / 2)) * Real.exp (s * epsilon) +
      Real.exp (s * (2 * epsilon)) = 0

-- Simultaneous pole vanishing for carrier bump
theorem carrier_pole_moments {kappa : ℝ → ℝ} (hk : Continuous kappa)
    (hc : HasCompactSupport kappa) (epsilon : ℝ) :
    moment (carrier kappa epsilon (Real.exp (epsilon / 2) + Real.exp (-epsilon / 2))) (1 / 2) = 0 ∧
    moment (carrier kappa epsilon (Real.exp (epsilon / 2) + Real.exp (-epsilon / 2))) (-(1 / 2)) = 0

-- Complete existence of smooth narrow complex pole-null packet
theorem exists_narrow_complex_pole_null {L : ℝ} (hL : 0 < L) :
    ∃ eta : ℝ → ℂ, HasCompactSupport eta ∧ ContDiff ℝ ∞ eta ∧ eta 0 = 1 ∧
      (∀ v, eta v ≠ 0 → -(L / 32) < v ∧ v < 9 * L / 32) ∧
      MeasureTheory.Integrable (fun v => Complex.normSq (eta v)) ∧
      (0 < ∫ v : ℝ, Complex.normSq (eta v)) ∧
      complexMoment eta (1 / 2) = 0 ∧ complexMoment eta (-(1 / 2)) = 0
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified proof in Lean 4 constructing smooth localized wave packets in $C_c^\infty(\mathbb{R}, \mathbb{C})$ that identically annihilate the spectral poles at $s = \pm 1/2$ via an exact three-point difference stencil.
