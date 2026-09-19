# First Formalization: Exact Prime Atom Defect Charge and Reference Closed Forms

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ChargeOriginalBirth.lean`](../../formalization/BuildingBlocks/ChargeOriginalBirth.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes exact pullback identities, the prime atom defect evaluation, absolute summability, and closed-form reference constants in Lean 4:

1. **Pullback and Successor Identities:**
   Formal proofs that $\beta_n(v) = \text{birthPull}(n, 0, v)$ (`beta_eq_birthPull`) and $\text{successor}(\beta_n)(v) = \text{birthPull}(n, 1, v)$ (`successor_beta_eq_birthPull`).
2. **Prime Atom Defect Formula:**
   Formal proof that $\text{defect}(\beta_n) = \text{correction}(n)$ for all $n \ge 2$ (`original_defect_beta`).
3. **Absolute Summability of Weighted Atom Charges:**
   Formal proof of `Summable (fun n => |vonMangoldt(n+2) * defect(beta(n+2))|)` (`original_weighted_atom_charge_summable`).
4. **Exact Closed Forms for Reference Defect:**
   Formal proofs that $\text{defect}(e^{-v/2}) = \pi/4 - 1$ (`original_defect_reference`) and $\text{defect}(-e^{-v/2}) = 1 - \pi/4$ (`original_defect_first_birth`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Prime atom defect equals correction
theorem original_defect_beta {n : ℕ} (hn : 2 ≤ n) :
    BuildingBlocks.SuccessorCharge.defect (beta n) = correction n

-- Summability of weighted prime atom defects
theorem original_weighted_atom_charge_summable :
    Summable (fun n : ℕ => |ArithmeticFunction.vonMangoldt (n + 2) *
      BuildingBlocks.SuccessorCharge.defect (beta (n + 2))|)

-- Reference defect closed form
theorem original_defect_reference :
    BuildingBlocks.SuccessorCharge.defect (fun v : ℝ => Real.exp (-v / 2)) = Real.pi / 4 - 1

-- First birth defect closed form
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

This entry documents a machine-verified implementation in Lean 4 proving the exact evaluation of prime atom defect charges as differences of discrete birth integrals, establishing absolute von Mangoldt summability, and deriving the exact reference constant $\pi/4 - 1$.
