# First Formalization: Exact Cyclotomic-Farey Tri-Partition and Conductor Interaction Control

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/CyclotomicInteraction.lean`](../../formalization/BuildingBlocks/CyclotomicInteraction.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization proves the exact tri-partition of old cyclotomic conductors, Farey interaction splitting, and explicit logarithmic-divisor bounds in Lean 4:

1. **Conductor Tri-Partition:**
   Formal proof of `oldConductors_partition`: disjoint partition of $\mathcal{O}_N$ into small, recent, and interior conductors.
2. **Positivity and Majorization:**
   Formal proof of `selectedMass_nonneg`, `sectorAbsolute_nonneg`, `selectedAbsolute_nonneg`, `abs_sectorSigned_le`, `abs_selectedSigned_le`, and `selectedAbsolute_mono`.
3. **Logarithmic-Divisor Bound:**
   Formal proof of `selectedAbsolute_le`:
   $$
   \text{selectedAbsolute}(N, s) \le d(N) \log N \cdot \text{selectedMass}(N, s).
   $$
4. **Interaction Sum Partition:**
   Formal proof of `selectedSigned_partition`, `oldInteraction_partition`, and `controlledInteraction_abs_le`:
   $$
   |\mathcal{I}_{\text{controlled}}(X, Y)| \le \mathcal{C}_{\text{small}}(X, Y) + \mathcal{C}_{\text{recent}}(X).
   $$
5. **Discrete-Continuous Equivalence:**
   Formal proof of `nat_sqrt_lt_iff_real` and `mem_interiorConductors_iff`: equivalence of discrete integer bounds to $\sqrt{X} < n < N - \sqrt{N}$.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Disjoint tri-partition of conductors
theorem oldConductors_partition (N Y : ℕ) :
    oldConductors N = smallConductors N Y ∪
      controlledRecentConductors N Y ∪ interiorConductors N Y

-- Explicit divisor-logarithmic bound on absolute sector updates
theorem selectedAbsolute_le {X N : ℕ} (hidentity : ActualOldFactorIdentities X)
    (hN : N ∈ Icc 3 X) (s : Finset ℕ) (hs : s ⊆ oldConductors N) :
    selectedAbsolute N s ≤ (N.divisors.card : ℝ) * Real.log N * selectedMass N s

-- Exact interaction splitting
theorem oldInteraction_partition (X Y : ℕ) :
    oldInteraction X = controlledInteraction X Y + interiorInteraction X Y

-- Boundary cost control
theorem controlledInteraction_abs_le (X Y : ℕ) :
    |controlledInteraction X Y| ≤ smallBoundaryCost X Y + recentBoundaryCost X

-- Equivalence to real interval interior
theorem mem_interiorConductors_iff {N X n : ℕ} (hn : 1 ≤ n) (hOld : n < N) :
    n ∈ interiorConductors N (Nat.sqrt X) ↔
      Real.sqrt X < (n : ℝ) ∧ (n : ℝ) < (N : ℝ) - Real.sqrt N
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified proof in Lean 4 establishing the exact disjoint conductor tri-partition, Farey interaction splitting, and explicit logarithmic-divisor bounds for cyclotomic boundary dynamics.
