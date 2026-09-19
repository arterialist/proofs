# First Formalization: Exact Operator Defect of Prime Birth Atoms and Weighted Summability

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ChargeOriginalBirth.lean`](../../formalization/BuildingBlocks/ChargeOriginalBirth.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the coordinate pull-back, index-shift commutation, exact operator defect formula, and absolute weighted summability for prime birth step-atoms $\beta_n$ in Lean 4:

1. **Physical Pull-Back Identity:**
   Formal proof of `beta_eq_birthPull`: $\beta_n(v) = \text{birthPull}(n, 0, v)$.
2. **Successor Index-Shift Commutation:**
   Formal proof of `successor_beta_eq_birthPull`: $\mathcal{T}(\beta_n)(v) = \text{birthPull}(n, 1, v)$.
3. **Exact Atom Defect Identification:**
   Formal proof of `original_defect_beta`: $\text{defect}(\beta_n) = \text{correction}(n)$ for all $n \ge 2$.
4. **Absolute Summability of Prime Defects:**
   Formal proof of `original_weighted_atom_charge_summable`: $\sum_{n=2}^\infty \Lambda(n) |\text{defect}(\beta_n)| < \infty$.
5. **Reference Defect Invariants:**
   Formal proofs of $\text{defect}(e^{-v/2}) = \pi/4 - 1$ (`original_defect_reference`) and $\text{defect}(-e^{-v/2}) = 1 - \pi/4$ (`original_defect_first_birth`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Identity between the logarithmic step-atom and the physical birth pull-back
theorem beta_eq_birthPull (n : ℕ) (v : ℝ) : beta n v = birthPull n 0 v

-- Commutation of the continuous successor operator with physical index advancement
theorem successor_beta_eq_birthPull (n : ℕ) (v : ℝ) :
    BuildingBlocks.SuccessorCharge.successor (beta n) v = birthPull n 1 v

-- Exact identification of the operator defect with the discrete arithmetic correction
theorem original_defect_beta {n : ℕ} (hn : 2 ≤ n) :
    BuildingBlocks.SuccessorCharge.defect (beta n) = correction n

-- Absolute summability of von Mangoldt weighted prime atom defects
theorem original_weighted_atom_charge_summable :
    Summable (fun n : ℕ => |ArithmeticFunction.vonMangoldt (n + 2) *
      BuildingBlocks.SuccessorCharge.defect (beta (n + 2))|)

-- Reference defect invariants
theorem original_defect_reference :
    BuildingBlocks.SuccessorCharge.defect (fun v : ℝ => Real.exp (-v / 2)) = Real.pi / 4 - 1

theorem original_defect_first_birth :
    BuildingBlocks.SuccessorCharge.defect (fun v : ℝ => -Real.exp (-v / 2)) = 1 - Real.pi / 4
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving that the continuous successor operator advances the discrete prime birth index $\mathcal{T}(\beta_n) = \text{birthPull}(n, 1)$, that the operator defect matches the arithmetic correction $\text{defect}(\beta_n) = \text{correction}(n)$, and that the total von Mangoldt weighted defect series is absolutely summable.
