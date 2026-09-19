# First Formalization: Exact Factorial Interior Energy Linear Budget and Dyadic Transfer

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/FactorialBirthInteriorBound.lean`](../../formalization/BuildingBlocks/FactorialBirthInteriorBound.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact linear interior energy bound and dyadic transfers for factorial cell models in Lean 4:

1. **Clock Origin Vanishing:**
   Formal proof of `beta_le_half`: $\beta(t) = \tanh(t/2) \le t/2$ for all $t \ge 0$.
2. **Uniform Origin Envelope:**
   Formal proof of `interior_row_uniform`: $|\text{interiorRow}(N, t)| \le N/4$ on $(0, 1]$.
3. **Inverse-Square Tail:**
   Formal proof of `interior_row_tail`: $|\text{interiorRow}(N, t)| \le N/t^2$ on $[1, \infty)$.
4. **Unconditional Linear Budget:**
   Formal proof of `interior_energy_linear`: $|\text{interiorEnergy}(N)| \le \frac{5}{4} N$.
5. **Exact Dyadic Budget:**
   Formal proof of `dyadic_interior_budget`: $\left|\sum_{N=X}^{2X-1} \text{interiorEnergy}(N)\right| \le \frac{5}{8} X (3X - 1)$.
6. **Energy-Boundary Transfers:**
   Formal proof of `actual_energy_upper`, `actual_boundary_upper`, and their dyadic counterparts `actual_dyadic_energy_upper`, `actual_dyadic_boundary_upper`.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Linear origin vanishing of clock function
theorem beta_le_half (t : ℝ) (ht : 0 ≤ t) : beta t ≤ t / 2

-- Uniform origin envelope
theorem interior_row_uniform (N : ℕ) (t : ℝ) (ht : 0 < t) :
    |interiorRow N t| ≤ (N : ℝ) / 4

-- Inverse-square tail bound
theorem interior_row_tail (N : ℕ) (t : ℝ) (ht : 0 < t) :
    |interiorRow N t| ≤ (N : ℝ) / t ^ 2

-- Unconditional linear interior energy budget
theorem interior_energy_linear (N : ℕ) : |interiorEnergy N| ≤ 5 * (N : ℝ) / 4

-- Exact dyadic horizon budget
theorem dyadic_interior_budget (X : ℕ) :
    |∑ N ∈ Ico X (2 * X), interiorEnergy N| ≤ 5 * (X : ℝ) * (3 * (X : ℝ) - 1) / 8

-- Energy-boundary transfers
theorem actual_energy_upper (N : ℕ) :
    FactorialBinaryIntegrability.integratedEnergy N ≤ boundaryEnergy N + 5 * (N : ℝ) / 4

theorem actual_boundary_upper (N : ℕ) :
    boundaryEnergy N ≤ FactorialBinaryIntegrability.integratedEnergy N + 5 * (N : ℝ) / 4
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified proof in Lean 4 establishing the unconditional linear subordination of bulk interior energy in factorial cell dynamics and proving exact dyadic energy-boundary transfer inequalities.
