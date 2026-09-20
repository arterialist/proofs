# Dual-exponent real-power algebra and suppression threshold

**Designation:** First Formalization 344  
**Unique Contribution:** [Unique Contribution 335](../../formalization/records/exact-dual-dirichlet-offline-decay-and-power-suppression-threshold.md)  
**Lean 4 Source:** [`formalization/BuildingBlocks/DualDirichletOfflineDecay.lean`](../../formalization/BuildingBlocks/DualDirichletOfflineDecay.lean)  
**Primary Formalizer:** Arterialist RH Research Project  
**Date of Verification:** September 2026  
**Axiom Dependencies:** `[propext, Classical.choice, Quot.sound]` (Standard Lean 4 foundations; zero custom axioms, zero `sorry`)

---

## 1. Formalization Scope & Mathematical Objective

The motivating argument concerns a short dual Dirichlet polynomial, but this Lean module does not define that polynomial, the Gamma or scattering factor, a zeta zero, or a bound for a Dirichlet sum. It formalizes the real-exponent algebra that such an estimate would use. In the intended notation, the external argument would concern
$$S_y(\rho) = \sum_{1 \le n \le y} n^{\rho-1}, \quad y = \frac{T^\delta}{2\pi},$$
multiplied by the scattering factor $\chi(\rho)$.

The module proves that if $\beta = 1/2 + \varepsilon$, $\varepsilon > 0$, and $\delta < \varepsilon/\beta$, then the real number $1/2 - \beta(1-\delta)$ is negative. It also proves corresponding `Real.rpow` identities and inequalities. Applying this algebra to an actual dual sum would require separately proved analytic estimates that are absent here.

---

## 2. Key Formal Definitions and Machine-Checked Theorems

### Exponent Definitions and Exact Algebraic Rearrangement
```lean
noncomputable def dualExponent (β δ : ℝ) : ℝ := 1/2 - β * (1 - δ)

theorem dual_exponent_identity (β δ ε : ℝ) (hβ : β = 1/2 + ε) :
    dualExponent β δ = δ / 2 - ε * (1 - δ)

noncomputable def criticalDelta (β ε : ℝ) : ℝ := ε / β
```

### Critical Threshold and Strict Negative Exponent
```lean
theorem dual_exponent_neg (β δ ε : ℝ) (hβ : β = 1/2 + ε) (hε : 0 < ε)
    (hδ : δ < criticalDelta β ε) : dualExponent β δ < 0

theorem dual_exponent_decay_rate (β δ ε : ℝ) (hβ : β = 1/2 + ε) (hε : 0 < ε)
    (hδ : δ < criticalDelta β ε) : 0 < - (dualExponent β δ)

theorem dual_exponent_critical_line (δ : ℝ) :
    dualExponent (1/2) δ = δ / 2
```

### Real-power decay and strict monotonicity under the stated inequalities
```lean
theorem offline_power_decay (T C β δ ε : ℝ) (hT : 1 < T) (hC : 0 < C)
    (hβ : β = 1/2 + ε) (hε : 0 < ε) (hδ : δ < criticalDelta β ε) :
    C * T ^ (dualExponent β δ) < C

theorem offline_power_strict_monotonicity {T1 T2 C β δ ε : ℝ}
    (hT1 : 0 < T1) (hT12 : T1 < T2) (hC : 0 < C)
    (hβ : β = 1/2 + ε) (hε : 0 < ε) (hδ : δ < criticalDelta β ε) :
    C * T2 ^ (dualExponent β δ) < C * T1 ^ (dualExponent β δ)

theorem offline_dual_product_bound {T C_chi C_poly β δ : ℝ}
    (hT : 0 < T) :
    (C_chi * T ^ (1/2 - β)) * (C_poly * T ^ (δ * β)) =
      (C_chi * C_poly) * T ^ (dualExponent β δ)
```

---

## 3. Axiom Verification Output

```
'BuildingBlocks.DualDirichletOfflineDecay.dual_exponent_identity' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.DualDirichletOfflineDecay.dual_exponent_neg' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.DualDirichletOfflineDecay.dual_exponent_decay_rate' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.DualDirichletOfflineDecay.dual_exponent_critical_line' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.DualDirichletOfflineDecay.dual_product_exponent' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.DualDirichletOfflineDecay.offline_power_decay' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.DualDirichletOfflineDecay.offline_power_strict_monotonicity' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.DualDirichletOfflineDecay.offline_dual_product_bound' depends on axioms: [propext, Classical.choice, Quot.sound]
```
All theorems verified under Lean 4.24.0.
