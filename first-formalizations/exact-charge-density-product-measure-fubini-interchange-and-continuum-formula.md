# First Formalization: Exact Charge Density Product Measure Fubini Interchange and Continuum Formula

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ChargeDensityFubini.lean`](../../formalization/BuildingBlocks/ChargeDensityFubini.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes product measure integrability, Fubini operator interchange, and the continuum representation formula for the prime background density in Lean 4:

1. **Spatial Fiber Integration:**
   Formal proof that $\int_1^\infty \beta(y, v) dy = (e^v - 1)e^{-v/2}$ for all $v \ge 0$ (`betaReal_integral`).
2. **Product Measure Integrability:**
   Formal proof that $(v, y) \mapsto K(v) \beta(y, v)$ is globally integrable under $(\text{volume}|_{(0, \infty)}) \otimes (\text{volume}|_{(1, \infty)})$ (`original_density_joint_integrable`).
3. **Defect Operator Fubini Interchange:**
   Formal proof that $\text{defect}(\int_1^\infty \beta(y, \cdot) dy) = \int_1^\infty \text{defect}(\beta(y, \cdot)) dy$ (`original_density_charge_interchange`).
4. **Continuum Charge Representation:**
   Formal proof of $\text{defect}((e^v - 1)e^{-v/2}) = \int_1^\infty \text{defect}(\beta(y, \cdot)) dy$ (`original_density_charge_formula`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Spatial fiber integral
theorem betaReal_integral {v : ℝ} (hv : 0 ≤ v) :
    (∫ y in Ioi (1 : ℝ), betaReal y v) = (Real.exp v - 1) * Real.exp (-v / 2)

-- Joint product measure integrability
theorem original_density_joint_integrable :
    Integrable kernelBirth ((volume.restrict (Ioi (0 : ℝ))).prod (volume.restrict (Ioi (1 : ℝ))))

-- Fubini operator interchange for the defect
theorem original_density_charge_interchange :
    defect (fun v => ∫ y in Ioi (1 : ℝ), betaReal y v) =
      ∫ y in Ioi (1 : ℝ), defect (fun v => betaReal y v)

-- Exact continuum defect formula
theorem original_density_charge_formula :
    defect (fun v => (Real.exp v - 1) * Real.exp (-v / 2)) =
      ∫ y in Ioi (1 : ℝ), defect (fun v => betaReal y v)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving product measure absolute integrability and Fubini interchange between the memory defect operator and the spatial continuum parameter for the prime counting background source.
