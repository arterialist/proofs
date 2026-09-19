# First Formalization: Exact Prime-Memory Charge Cutoff Decay and Finite-Rank Defect Error

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/MemoryChargeCutoff.lean`](../../formalization/BuildingBlocks/MemoryChargeCutoff.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization proves the explicit quantitative finite-rank defect error bounds and prime cutoff decay for the prime-memory charge operator in Lean 4:

1. **Kernel Linearity and Defect Splitting:**
   Formal proof of `memoryDefectKernel_sub` and `remainder_defectKernel_identity`.
2. **Pointwise Decay and Support Gap:**
   Formal proof of `primeSeedRemainder_eq_zero` ($R_P(v) = 0$ for $v < \log P$), `three_log_two_le_log_cutoff`, and `primeSeedRemainder_bound` ($R_P(v) \le (64\log 2 + 30)/\log P$).
3. **Exponential Remainder Mass Integration:**
   Formal proof of `exponential_remainder_mass_bound`:
   \[
   \int_0^\infty e^{-w} R_P(w) dw \le \frac{64 \log 2 + 30}{P \log P}.
   \]
4. **Decay and Energy Form Majorization:**
   Formal proof of `remainder_defectKernel_bound`, `remainder_memory_charge_bound_weighted`, and `remainder_memory_charge_bound_energy`.
5. **Finite-Rank Operator Rank-Defect Error Bound:**
   Formal proof of `cutoff_memory_charge_rank_error`: explicit $L^1$ error bound on the transposed action against causal mixed-energy sources.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Pointwise decay bound on omitted prime seeds
theorem primeSeedRemainder_bound {P : ℕ} (hP : 8 ≤ P) (v : ℝ) :
    primeSeedRemainder P v ≤ (64 * log 2 + 30) / log (P : ℝ)

-- Exponential remainder mass bound
theorem exponential_remainder_mass_bound {P : ℕ} (hP : 8 ≤ P) :
    (∫ w in Ioi (0 : ℝ), exp (-w) * primeSeedRemainder P w) ≤
      (64 * log 2 + 30) / ((P : ℝ) * log (P : ℝ))

-- Defect kernel bound against energy-bounded causal source
theorem remainder_memory_charge_bound_energy {P : ℕ} (hP : 8 ≤ P)
    {H : ℝ → ℝ} (hH : Measurable H)
    (hzero : ∀ᵐ x : ℝ, x < 1 → H x = 0) (hE : MixedEnergy.energy H < ∞) :
    IntegrableOn (fun u => SuccessorCharge.memoryDefectKernel (primeSeedRemainder P) u *
      MixedEnergy.physicalLift H u) (Ioi (0 : ℝ)) ∧
    |∫ u in Ioi (0 : ℝ), SuccessorCharge.memoryDefectKernel (primeSeedRemainder P) u *
      MixedEnergy.physicalLift H u| ≤
      ((64 * log 2 + 30) / ((P : ℝ) * log (P : ℝ))) * sqrt ((MixedEnergy.energy H).toReal)

-- Explicit rank-defect error bound for finite prime cutoffs
theorem cutoff_memory_charge_rank_error {P : ℕ} (hP : 8 ≤ P)
    {H : ℝ → ℝ} (hH : Measurable H)
    (hzero : ∀ᵐ x : ℝ, x < 1 → H x = 0) (hE : MixedEnergy.energy H < ∞) :
    let J := ∫ u in Ioi (0 : ℝ),
      (SuccessorCharge.memoryDefectKernel allPrimeSeed u -
        SuccessorCharge.memoryDefectKernel (finitePrimeSeed (primesBelow P)) u) *
          MixedEnergy.physicalLift H u
    IntegrableOn (fun v => exp (-v / 2) * J) (Ioi (0 : ℝ)) ∧
      (∫ v in Ioi (0 : ℝ), |exp (-v / 2) * J|) ≤
        (2 * (64 * log 2 + 30) / ((P : ℝ) * log (P : ℝ))) * sqrt ((MixedEnergy.energy H).toReal)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified proof in Lean 4 certifying explicit non-asymptotic error bounds $O(1 / (P \log P))$ with verified constants $(64\log 2 + 30)$ for finite-rank prime-memory operator approximations against infinite-dimensional causal energy spaces.
