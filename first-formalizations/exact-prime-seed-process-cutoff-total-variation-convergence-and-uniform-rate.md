# First Formalization: Exact Prime Seed Process Cutoff Total Variation Convergence and Uniform Rate

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/PrimeSeedCutoffConvergence.lean`](../../formalization/BuildingBlocks/PrimeSeedCutoffConvergence.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact measure splitting, total activity defect formula, and quantitative total variation convergence rate $\frac{32 u}{\log P}$ for cutoff approximations to the all-prime jump process in Lean 4:

1. **Lévy Measure Splitting and Activity Defect:**
   Formal proof that $\nu_{\text{primesBelow } P} + \nu_{> P} = \nu_{\mathcal{P}}$ (`levyMeasure_primesBelow_add_tail`) and that the difference in total activities equals the tail mass (`cutoff_mass_difference`).
2. **Quantitative Event-Wise Convergence Rate:**
   Formal proof that for all $P \ge 8$ and $u \ge 0$, the event-wise error on any measurable set $A$ is bounded by $\frac{32 u}{\log P}$ (`seedProcess_cutoff_event_bound`).
3. **Uniform Convergence on Compact Time Horizons:**
   Formal proof of uniform total variation convergence across all events and times $u \le U$ (`seedProcess_cutoff_uniform`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exact Lévy measure splitting
theorem levyMeasure_primesBelow_add_tail (P : ℕ) :
    levyMeasure (primesBelow P) + primeTailLevyMeasure P = allPrimeLevyMeasure

-- Activity defect identity
theorem cutoff_mass_difference (P : ℕ) :
    (measureUnivNNReal allPrimeLevyMeasure : ℝ) -
      (measureUnivNNReal (levyMeasure (primesBelow P)) : ℝ) =
        (primeTailLevyMeasure P Set.univ).toReal

-- Quantitative event error bound
theorem seedProcess_cutoff_event_bound (P : ℕ) (hP : 8 ≤ P) (u : ℝ≥0)
    {A : Set ℝ} (hA : MeasurableSet A) :
    |(seedProcess (primesBelow P) u).real A - (allPrimeProcess u).real A| ≤
      32 * (u : ℝ) / log (P : ℝ)

-- Uniform total variation convergence on compact time intervals
theorem seedProcess_cutoff_uniform (U : ℝ≥0) {ε : ℝ} (hε : 0 < ε) :
    ∃ P₀ : ℕ, ∀ P ≥ P₀, ∀ u : ℝ≥0, u ≤ U → ∀ A : Set ℝ,
      MeasurableSet A →
        |(seedProcess (primesBelow P) u).real A - (allPrimeProcess u).real A| < ε
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 deriving the quantitative total variation error rate $\frac{32 u}{\log P}$ for prime cutoff jump processes and proving uniform total variation convergence on compact time intervals.
