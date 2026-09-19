# First Formalization: Exact Fubini Defect Interchange and Causal Charge Density Integrability

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ChargeDensityFubini.lean`](../../formalization/BuildingBlocks/ChargeDensityFubini.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the 2D product measurability and integrability of the renewal-birth kernel and the exact Fubini interchange theorem for the non-compact operator defect functional in Lean 4:

1. **Joint Measurability & Fiber Integrals:**
   Formal proofs of `kernelBirth_measurable` and `betaReal_integral`: $\int_1^\infty \beta_{\mathbb{R}}(y, v) dy = (e^v - 1) e^{-v/2}$.
2. **Product Measure Joint Integrability:**
   Formal proof of `original_density_joint_integrable`: $\text{kernelBirth} \in L^1((0, \infty) \times (1, \infty))$ under Lebesgue product measure.
3. **Grand Fubini Defect Interchange Theorem:**
   Formal proof of `original_density_charge_interchange`: $\text{defect}(\int_1^\infty \beta_{\mathbb{R}} dy) = \int_1^\infty \text{defect}(\beta_{\mathbb{R}}) dy$.
4. **Continuum Charge Defect Evaluation:**
   Formal proof of `original_density_charge_formula`: Computing the explicit defect of the continuum profile $(e^v - 1) e^{-v/2}$.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Unconditional absolute integrability on the 2D product measure space
theorem original_density_joint_integrable :
    Integrable kernelBirth ((volume.restrict (Ioi (0 : ℝ))).prod (volume.restrict (Ioi (1 : ℝ))))

-- Grand Fubini interchange theorem for the non-compact defect functional
theorem original_density_charge_interchange :
    defect (fun v => ∫ y in Ioi (1 : ℝ), betaReal y v) =
      ∫ y in Ioi (1 : ℝ), defect (fun v => betaReal y v)

-- Explicit formula equating continuum defect to integrated birth defect
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

This entry documents a machine-verified implementation in Lean 4 establishing the Fubini interchange theorem for operator defect functionals on non-$L^1$ boundary densities, linking the collective continuum charge deficit directly to integrated discrete prime birth defects.
