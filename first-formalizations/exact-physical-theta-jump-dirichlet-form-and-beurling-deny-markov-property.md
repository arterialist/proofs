# First Formalization: Exact Physical Theta Jump Dirichlet Form and Beurling–Deny Markov Property

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/PhysicalThetaJumpEnergy.lean`](../../formalization/BuildingBlocks/PhysicalThetaJumpEnergy.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization proves the Beurling–Deny sub-Markovian contraction property and boundary killing decomposition for physical theta jump energies in Lean 4:

1. **Elementary Shift and Reverse Symmetry:**
   Formal proof of `edge_mass_reverse`: $\text{edgeMass}(h, -a) = \text{edgeMass}(h, a)$.
2. **Beurling–Deny Energy Contraction:**
   Formal proof of `edge_mass_abs_contract`, `continuous_energy_abs_contract`, `prime_energy_abs_contract`, and `jump_energy_abs_contract`: $\mathcal{E}(|h|) \le \mathcal{E}(h)$.
3. **Killed Exterior Energy Contraction:**
   Formal proof of `killed_energy_abs_contract`: $\mathcal{E}_R(|h|) \le \mathcal{E}_R(h)$ for any truncation horizon $R$.
4. **Three-Way Killed Edge Decomposition:**
   Formal proof of `killed_edge_square_split`: algebraic decomposition of $(h_R(u+a) - h_R(u))^2$ into internal edges, outward killing departures, and inward killing arrivals.
5. **Measurable Space and Null Set Congruence:**
   Formal proof of `jump_energy_ae_congr`, `killed_energy_ae_congr`, and `killed_energy_exterior_nu_ae_congr`.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Shift reversal symmetry of edge mass
theorem edge_mass_reverse (h : ℝ → ℝ) (a : ℝ) : edgeMass h (-a) = edgeMass h a

-- Beurling-Deny modulus contraction for jump Dirichlet form
theorem jump_energy_abs_contract (h : ℝ → ℝ) :
    jumpEnergy (fun u => |h u|) ≤ jumpEnergy h

-- Contraction on killed exterior domain
theorem killed_energy_abs_contract (R : ℝ) (h : ℝ → ℝ) :
    killedEnergy R (fun u => |h u|) ≤ killedEnergy R h

-- Three-way algebraic splitting of killed edges
theorem killed_edge_square_split (R : ℝ) (h : ℝ → ℝ) (u a : ℝ) :
    (killedExtension R h (u + a) - killedExtension R h u) ^ 2 =
      (if R < |u| ∧ R < |u + a| then (h (u + a) - h u) ^ 2 else 0) +
      (if R < |u| ∧ ¬R < |u + a| then h u ^ 2 else 0) +
      (if ¬R < |u| ∧ R < |u + a| then h (u + a) ^ 2 else 0)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified proof in Lean 4 establishing the Beurling–Deny Markov contraction property for non-local arithmetic Dirichlet forms whose jump distributions are governed by the von Mangoldt function $\Lambda(n)$.
