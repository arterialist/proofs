# Exact Dual Dirichlet Offline Decay and Power Suppression Threshold

**Designation:** First Formalization 344  
**Unique Contribution:** [Unique Contribution 335](../unique-contributions/exact-dual-dirichlet-offline-decay-and-power-suppression-threshold.md)  
**Lean 4 Source:** [`formalization/BuildingBlocks/DualDirichletOfflineDecay.lean`](../formalization/BuildingBlocks/DualDirichletOfflineDecay.lean)  
**Primary Formalizer:** Arterialist RH Research Project  
**Date of Verification:** September 2026  
**Axiom Dependencies:** `[propext, Classical.choice, Quot.sound]` (Standard Lean 4 foundations; zero custom axioms, zero `sorry`)

---

## 1. Formalization Scope & Mathematical Objective

In the proper-cofactor dual Dirichlet cancellation framework for the Riemann hypothesis, the complete prime-power row is compared against an ensemble of cofactors $k \in [2, K]$ with $K = T^{1-\delta}$. The residual error against an off-line zero $\rho = \beta + i\gamma$ ($\beta = 1/2 + \varepsilon$, $\varepsilon > 0$) is modulated by the short dual Dirichlet polynomial:
$$S_y(\rho) = \sum_{1 \le n \le y} n^{\rho-1}, \quad y = \frac{T^\delta}{2\pi},$$
multiplied by the scattering factor $\chi(\rho)$.

This module formalizes the exact exponent algebra, proves the existence of the critical cutoff threshold $\delta_{\text{crit}}(\beta) = \varepsilon / \beta$, and proves that for any $\delta < \delta_{\text{crit}}(\beta)$, the combined exponent $\alpha(\beta, \delta) = 1/2 - \beta(1 - \delta)$ is strictly negative, forcing unconditional power suppression of the off-line dual Dirichlet sum.

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

### Unconditional Power Decay and Strict Asymptotic Monotonicity
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
