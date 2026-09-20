# First Formalization: Radius-Two Edge Cell Geometry and 16-to-10/5 Reversal Reduction

**Date:** 19 September 2026  
**Lean 4 Modules:** 
- [`formalization/BuildingBlocks/RadiusTwoEdgeCellGeometry.lean`](../../formalization/BuildingBlocks/RadiusTwoEdgeCellGeometry.lean)
- [`formalization/BuildingBlocks/RadiusTwoEdgeReversalFinite.lean`](../../formalization/BuildingBlocks/RadiusTwoEdgeReversalFinite.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

In spectral realizations of arithmetic trace formulas and compensated Paid-Theta Markov dynamics, non-local dilation shifts $(u \to u \pm \log q)$ on the critical line are projected onto localized spatial grid cells. This development formalizes:
1. **Geometric Stage Emptiness & 16-Cell Classification:**
   - In the exterior observation window $W_M = \{u \in \mathbb{R} : 2 + M^{-1} \le |u| \le M\}$, stages $M=2$ and $M=3$ contain zero prime transitions because the width $2/3$ is strictly less than $\log 2 \approx 0.69315$.
   - At stage $(M, L)=(4, 0)$, out of 48 possible discrete transitions $(q, \sigma, k)$ for prime powers $q \in \{2, 3, 4\}$, directions $\sigma \in \{+, -\}$, and 8 spatial grid cells, exactly 16 cells have positive measure.
   - All 16 intervals are classified, proved to be non-empty, pairwise disjoint, and proven to exhaust the actual geometric transitions.
   - Every observed matrix entry is formally represented as an explicit Bochner interval integral.
2. **Reversal & Reflection Rank Reductions:**
   - Edge reversal invariance of the symmetric measure enforces 6 linear relations reducing the 16 observation coordinates to a 10-dimensional subspace.
   - Spatial reflection symmetry further reduces the 10 coordinates to exactly 5 independent coordinates.
   - Closed bidirectional reconstruction isomorphisms between $\mathbb{C}^{16}$, $\mathbb{C}^{10}$, and $\mathbb{C}^5$ are certified.

---

## 2. Key Formalized Theorems and Axiom Signatures

### `formalization/BuildingBlocks/RadiusTwoEdgeCellGeometry.lean`

```lean
-- Stage 2 and 3 emptiness for all prime-power shifts
theorem stages_two_three_empty_for_actual_shifts (q : PrimePowerLabel) (u : ℝ) :
    (¬ inWindow 2 u) ∧
    (¬(inWindow 3 u ∧ inWindow 3 (u + displacement q))) ∧
    (¬(inWindow 3 u ∧ inWindow 3 (u - displacement q)))

-- Exhaustive list of 16 intervals at stage M = 4
theorem cells_length : cells.length = 16

theorem cell_labels_nodup : (cells.map LabelledInterval.label).Nodup

theorem every_listed_interval_nonempty (I : LabelledInterval) (hI : I ∈ cells) : 
    I.lo < I.hi

-- Exhaustive bidirectional classification: an actual transition occurs iff listed
theorem actual_label_iff_listed (label : Label) :
    (∃ u : ℝ, inStartCell label u ∧ inWindow 4 u ∧
      inWindow 4 (u + signedDisplacement label.orientation label.q)) ↔
      label ∈ cells.map LabelledInterval.label

-- Explicit Bochner interval integral identification
theorem observedEntry_is_explicit_interval_integral
    (psi Phi ell : ℝ → ℝ) (a : ℝ) (I : LabelledInterval) (F : ℝ → ℂ) :
    observedEntry psi Phi ell a I F =
      ((Real.sqrt (2 * cellMass psi Phi ell a I))⁻¹ : ℝ) •
        ∫ u in Set.Icc I.lo I.hi,
          (F (u + signedDisplacement I.label.orientation I.label.q) - F u) *
            (edgeDensity psi Phi ell a I u : ℂ)
```

### `formalization/BuildingBlocks/RadiusTwoEdgeReversalFinite.lean`

```lean
-- Exact 6 reversal relations
def reversalRelations (r : Fin 16 → ℂ) : Prop :=
  r 0 + r 1 + r 4 + r 5 = 0 ∧
  r 2 + r 3 + r 6 + r 7 = 0 ∧
  r 8 + r 10 = 0 ∧ r 9 + r 11 = 0 ∧
  r 12 + r 14 = 0 ∧ r 13 + r 15 = 0

-- 16-to-10 bidirectional reconstruction isomorphism
theorem reduced_reconstructed (s : Fin 10 → ℂ) :
    reduced (reconstructed s) = s

theorem reconstructed_reduced (r : Fin 16 → ℂ) (h : reversalRelations r) :
    reconstructed (reduced r) = r

-- 16-to-5 reflection reduction isomorphism
theorem evenReduced_evenReconstructed (s : Fin 5 → ℂ) :
    evenReduced (evenReconstructed s) = s

theorem evenReconstructed_evenReduced (r : Fin 16 → ℂ)
    (hrev : reversalRelations r) (href : reflectionRelations r) :
    evenReconstructed (evenReduced r) = r
```

### Axiom Audit
Both modules compile with zero warnings, zero errors, zero `sorry`, and strictly depend on:
```
[propext, Classical.choice, Quot.sound]
```

---

## 3. Novelty and Literature Context

Prior literature on spectral approximations to the Weil quadratic form and prime shift operators (Connes, Suzuki, Meyer) operated either with continuous Paley–Wiener spaces or abstract operator truncations without analyzing the discrete cell geometry of localized jump transitions. This is a machine-checked formalization of:
1. The exact stage emptiness $M=2, 3$ from interval lengths versus $\log 2$.
2. The exact 16-cell partition at $(M, L)=(4, 0)$ with Bochner interval integral representation.
3. The exact $16 \to 10$ and $16 \to 5$ dimensional reductions under reversal and reflection invariance.
