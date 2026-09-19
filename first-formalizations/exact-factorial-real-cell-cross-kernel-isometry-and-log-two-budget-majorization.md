# First Formalization: Exact Factorial Real-Cell Cross Kernel Isometry and Log-Two Budget Majorization

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/FactorialRealCellCrossKernel.lean`](../../formalization/BuildingBlocks/FactorialRealCellCrossKernel.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization proves the exact bilinear phase integral identity, the finite double sum representation of the inverse test phase cross-integral, the log 2 budget majorization bound, and the symmetry of the cross kernel in Lean 4:

1. **Bilinear Phase Algebra and Integrability:**
   Formal proofs of `phase_bilinear_row`, `phase_bilinear_integrable`, and `phase_bilinear_integral`.
2. **Definition of Actual Cross Kernel:**
   Formal definition of `actualCrossKernel` ($K_{\text{actual}}(x, y)$).
3. **Continuous Domain Maintenance:**
   Formal proof of `real_quotient_ge_one` ($j \le \lfloor x \rfloor \implies 1 \le x/j$).
4. **Cross-Phase Energy Integral Isometry:**
   Formal proofs of `inverseTestPhase_cross_integrable` and `inverseTestPhase_cross_integral`.
5. **Majorization and Symmetry:**
   Formal proofs of `actualCrossKernel_norm_le` ($\|K(x, y)\| \le (\log 2) B(\lfloor x \rfloor) B(\lfloor y \rfloor)$) and `actualCrossKernel_symm`.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exact bilinear phase integral evaluation
theorem phase_bilinear_integral {ι κ : Type*} (s : Finset ι) (r : Finset κ)
    (c a : ι → ℝ) (d b : κ → ℝ) (ha : ∀ i ∈ s, 1 ≤ a i) (hb : ∀ j ∈ r, 1 ≤ b j) :
    (∫ t in Ioi 0, (∑ i ∈ s, c i * scalarPhase (a i) t) *
      (∑ j ∈ r, d j * scalarPhase (b j) t) * FactorialBinaryEnergy.weight t) =
      ∑ i ∈ s, ∑ j ∈ r, c i * d j * phaseKernel (a i) (b j)

-- Exact evaluation of inverse test phase cross-integral as discrete kernel
theorem inverseTestPhase_cross_integral {x y : ℝ} (hx : 1 ≤ x) (hy : 1 ≤ y) :
    (∫ t in Ioi 0, inverseTestPhase x t * inverseTestPhase y t * FactorialBinaryEnergy.weight t) =
      actualCrossKernel x y

-- Exact majorization bound by log 2 and inverse coefficient budgets
theorem actualCrossKernel_norm_le {x y : ℝ} (hx : 1 ≤ x) (hy : 1 ≤ y) :
    ‖actualCrossKernel x y‖ ≤ log 2 * inverseCoefficientBudget ⌊x⌋₊ * inverseCoefficientBudget ⌊y⌋₊

-- Exact symmetry of the actual cross kernel
theorem actualCrossKernel_symm (x y : ℝ) : actualCrossKernel x y = actualCrossKernel y x
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified proof in Lean 4 establishing the exact 2D Möbius-weighted cross-kernel representation of continuous inverse test phase correlations and proving the $\log 2$ budget majorization inequality.
