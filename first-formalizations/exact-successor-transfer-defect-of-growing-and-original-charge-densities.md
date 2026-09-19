# First Formalization: Exact Successor Transfer Defect of Growing and Original Charge Densities

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ChargeDensityEvaluation.lean`](../../formalization/BuildingBlocks/ChargeDensityEvaluation.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact action, mass integrals, defect limits, and closed evaluation of the successor transfer operator on the natural relative charge density in Lean 4:

1. **Cutoff Integration and Operator Shift:**
   Formal derivation of cutoff integral $\int_0^\infty \mathbf{1}_{v \le \log R} e^{v/2} dv = 2(\sqrt{R} - 1)$ (`cutoff_mass`) and translation under successor shift $\mathcal{S}(\text{cutoff}(R)) = \text{cutoff}(R - 1)$ (`successor_cutoff`).
2. **Cutoff Defect Formula:**
   Formal derivation of $\text{defect}(\text{cutoff}(R)) = \sqrt{R - 1} - \sqrt{R}$ (`cutoff_defect`).
3. **Growing Mode Defect Vanishing:**
   Dominated convergence proof that $\text{defect}(v \mapsto e^{v/2}) = 0$ (`original_defect_growth`).
4. **Closed Geometric Density Defect Evaluation:**
   Formal derivation of $\text{defect}((e^v - 1)e^{-v/2}) = 1 - \pi/4$ (`original_density_defect`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Cutoff integral
theorem cutoff_mass {R : ℝ} (hR : 1 ≤ R) :
    (∫ v in Ioi (0 : ℝ), cutoff R v) = 2 * (Real.sqrt R - 1)

-- Downward shift under successor operator
theorem successor_cutoff {R : ℝ} (hR : 2 ≤ R) :
    successor (cutoff R) = cutoff (R - 1)

-- Exact cutoff defect
theorem cutoff_defect {R : ℝ} (hR : 2 ≤ R) :
    defect (cutoff R) = Real.sqrt (R - 1) - Real.sqrt R

-- Growing exponential mode defect vanishes
theorem original_defect_growth :
    defect (fun v : ℝ => Real.exp (v / 2)) = 0

-- Closed geometric defect of the natural relative density
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

## 3. Scope and verification status

This entry documents a machine-verified proof in Lean 4 evaluating the charge defect of the continuous successor transfer operator on the natural arithmetic relative density to the exact geometric value $1 - \pi/4$.
