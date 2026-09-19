# First Formalization: Exact Charge Density Defect and Background Growth Annihilation

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ChargeDensityEvaluation.lean`](../../formalization/BuildingBlocks/ChargeDensityEvaluation.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact operator defect evaluation for truncated and full arithmetic density profiles under the nonlinear renewal map $\sigma(v) = \log(1 + e^v)$ in Lean 4:

1. **Exact Successor Scale Shift:**
   Formal proof that $\mathcal{T}(\text{cutoff}(R)) = \text{cutoff}(R - 1)$ (`successor_cutoff`).
2. **Cutoff Mass and Defect:**
   Formal proof of $\text{charge}(\text{cutoff}(R)) = 2(\sqrt{R}-1)$ (`cutoff_mass`) and $\text{defect}(\text{cutoff}(R)) = \sqrt{R-1} - \sqrt{R}$ (`cutoff_defect`).
3. **Annihilation of Background Exponential Growth:**
   Formal proof of `original_defect_growth`: $\text{defect}(v \mapsto e^{v/2}) = 0$ via dominated convergence.
4. **Grand Arithmetic Density Defect Formula:**
   Formal proof of `original_density_defect`:
   \[
   \text{defect}(v \mapsto (e^v - 1)e^{-v/2}) = 1 - \frac{\pi}{4}.
   \]

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Shift commutation of the successor operator on truncated exponential profiles
theorem successor_cutoff {R : ℝ} (hR : 2 ≤ R) :
    successor (cutoff R) = cutoff (R - 1)

-- Closed-form defect of the truncated profile
theorem cutoff_defect {R : ℝ} (hR : 2 ≤ R) :
    defect (cutoff R) = Real.sqrt (R - 1) - Real.sqrt R

-- Exact annihilation of the growing background mode
theorem original_defect_growth :
    defect (fun v : ℝ => Real.exp (v / 2)) = 0

-- Grand exact defect evaluation for the arithmetic density profile
theorem original_density_defect :
    defect (fun v : ℝ => (Real.exp v - 1) * Real.exp (-v / 2)) = 1 - Real.pi / 4
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 proving the shift-commutation $\mathcal{T}(\text{cutoff}(R)) = \text{cutoff}(R-1)$, the exact annihilation of exponential growth $\text{defect}(e^{v/2}) = 0$, and the closed-form geometric evaluation $\text{defect}((e^v-1)e^{-v/2}) = 1 - \pi/4$.
