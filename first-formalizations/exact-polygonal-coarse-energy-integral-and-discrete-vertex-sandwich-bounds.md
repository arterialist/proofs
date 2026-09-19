# First Formalization: Exact Polygonal Coarse Energy Integral and Discrete Vertex Sandwich Bounds

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/PolygonalCoarseEnergy.lean`](../../formalization/BuildingBlocks/PolygonalCoarseEnergy.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact continuous integral of two-sided affine cell energy and sharp discrete vertex sandwich bounds with universal constants $1/6$ and $1/2$ in Lean 4:

1. **Exact Affine Cell Energy Evaluation:**
   Formal proof of `cellEnergy_integral`: $\int_0^1 (((1-u)p+uq)^2 + (A - ((1-u)p+uq))^2) du = \text{cellEnergy}(A, p, q)$.
2. **Sharp Vertex Lower and Upper Bounds:**
   Formal proofs of `cellEnergy_lower` and `cellEnergy_upper`: Bounding $\text{cellEnergy}(A, p, q)$ strictly between $1/6$ and $1/2$ of the nodal vertex sum $p^2 + (A-p)^2 + q^2 + (A-q)^2$.
3. **Grand Weighted Partition Energy Comparison:**
   Formal proof of `polygonal_energy_bounds`: Two-sided inequalities bounding continuous weighted polygonal energies by discrete vertex quadratic forms.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exact evaluation of the continuous affine two-sided cell energy
theorem cellEnergy_integral (A p q : ℝ) :
    (∫ u in (0 : ℝ)..1,
      ((1-u)*p+u*q)^2 + (A-((1-u)*p+u*q))^2) = cellEnergy A p q

-- Sharp lower bound with optimal constant 1/6
theorem cellEnergy_lower (A p q : ℝ) :
    (p^2 + (A-p)^2 + q^2 + (A-q)^2) / 6 ≤ cellEnergy A p q

-- Sharp upper bound with optimal constant 1/2
theorem cellEnergy_upper (A p q : ℝ) :
    cellEnergy A p q ≤ (p^2 + (A-p)^2 + q^2 + (A-q)^2) / 2

-- Weighted polygonal energy comparison across partitions
theorem polygonal_energy_bounds (m : ℕ) (h f : ℕ → ℝ) (A : ℝ)
    (hh : ∀ i ∈ Finset.range m, 0 ≤ h i) :
    (∑ i ∈ Finset.range m, h i *
      ((f i)^2 + (A-f i)^2 + (f (i+1))^2 + (A-f (i+1))^2) / 6) ≤
      (∑ i ∈ Finset.range m, h i * cellEnergy A (f i) (f (i+1))) ∧
    (∑ i ∈ Finset.range m, h i * cellEnergy A (f i) (f (i+1))) ≤
      (∑ i ∈ Finset.range m, h i *
        ((f i)^2 + (A-f i)^2 + (f (i+1))^2 + (A-f (i+1))^2) / 2)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 establishing the sharp equivalence between continuous piecewise affine coarse primitive integrals and discrete nodal quadratic forms, providing the computational foundation for certified interval bounds on energy functionals.
