# First Formalization: Exact Biorthogonal Constraint Projection and Cubic Hardy Obstruction

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ConstrainedHardyObstruction.lean`](../../formalization/BuildingBlocks/ConstrainedHardyObstruction.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact biorthogonal constraint projection operator into simultaneous kernels and proves the cubic-vs-quadratic scaling obstruction in Lean 4:

1. **Exact Biorthogonal Constraint Annihilation:**
   Formal proof of `constraintCorrected_mem_kernel`: $L_i(P_L(x)) = 0$ for all $i \in \{1, \dots, n\}$ under the biorthogonality condition $L_i(z_j) = \delta_{ij}$.
2. **Cubic Scaling Dominance:**
   Formal proof of `cubic_weight_beats_quadratic_energy`: Cubic growth $c t^3 \le \text{port}$ strictly dominates quadratic energy $C t^2 + D$ when $C + D < c t$ and $t \ge 1$.
3. **Corrected Packet Failure:**
   Formal proof of `corrected_packet_failure`: Finite bounded-energy corrections cannot bridge the spectral gap.
4. **Disjoint Non-Negative Weight Monotonicity:**
   Formal proof of `disjoint_weight_keeps_packet_lower_bound`: $\text{packet} \le \text{packet} + \text{correction}$ for $\text{correction} \ge 0$.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exact biorthogonal linear constraint projection
theorem constraintCorrected_mem_kernel {n : ℕ}
    (L : Fin n → V →ₗ[ℝ] ℝ) (z : Fin n → V) (x : V)
    (hdual : ∀ i j, L i (z j) = if i = j then 1 else 0) :
    ∀ i, L i (constraintCorrected L z x) = 0

-- Cubic boundary scaling strictly dominates quadratic core energy
theorem cubic_weight_beats_quadratic_energy
    {c C D t port energy : ℝ}
    (hD : 0 ≤ D) (ht : 1 ≤ t)
    (hthreshold : C + D < c * t)
    (hport : c * t^3 ≤ port)
    (henergy : energy ≤ C * t^2 + D) :
    energy < port

-- Impossibility of bridging the spectral gap with finite bounded corrections
theorem corrected_packet_failure
    {c C D t port rawEnergy correctionEnergy correctedEnergy : ℝ}
    (hD : 0 ≤ D) (ht : 1 ≤ t)
    (hthreshold : C + D < c * t)
    (hport : c * t^3 ≤ port)
    (hraw : rawEnergy ≤ C * t^2)
    (hcorr : correctionEnergy ≤ D)
    (htotal : correctedEnergy ≤ rawEnergy + correctionEnergy) :
    correctedEnergy < port
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving the biorthogonal projection theorem for simultaneous linear functionals and establishing the cubic-vs-quadratic Hardy scaling obstruction against finite correction recovery.
