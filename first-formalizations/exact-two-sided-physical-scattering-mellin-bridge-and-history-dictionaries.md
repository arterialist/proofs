# First Formalization: Exact Two-Sided Physical Scattering Mellin Bridge and History Dictionaries

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ActualScatteringMellinSignBridge.lean`](../../formalization/BuildingBlocks/ActualScatteringMellinSignBridge.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact dictionary matching and two-sided Mellin moment product factorization under physical prime scattering in Lean 4:

1. **Positive History Dictionary:**
   Formal proof that $\mathcal{H}_p(h + 1/2, M) = \mathcal{P}_p^+(h, M)$ (`positive_history_dictionary`).
2. **Negative History Dictionary:**
   Formal proof that $\mathcal{H}_p(-(h + 1/2), M) = \mathcal{P}_p^-(h, M)$ (`negative_history_dictionary`).
3. **Two-Sided Mellin Factorization:**
   Formal proof that $\mathcal{M}(\mathcal{S}_{p, M} f)(h + 1/2) \mathcal{M}(\mathcal{S}_{p, M} f)(-(h + 1/2)) = \mathcal{P}_p^+ \mathcal{P}_p^- \mathcal{M}(f)(h + 1/2) \mathcal{M}(f)(-(h + 1/2))$ (`actual_physical_two_sided_mellin`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Positive history dictionary
theorem positive_history_dictionary (p : ℝ) (h M : ℕ) :
    originalHistory p ((h : ℂ) + 1 / 2) M =
      (positiveMultiplier p h M : ℂ)

-- Negative history dictionary
theorem negative_history_dictionary (p : ℝ) (h M : ℕ) :
    originalHistory p (-((h : ℂ) + 1 / 2)) M =
      (negativeMultiplier p h M : ℂ)

-- Two-sided Mellin product factorization
theorem actual_physical_two_sided_mellin (p h M : ℕ) (hp : p.Prime)
    {f : ℝ → ℂ} (hf : Continuous f) (hc : HasCompactSupport f) :
    BuildingBlocks.FullComplexHistoryMellin.mellin (BuildingBlocks.CompactScatteringOperator.historyPhysical
      (1 / Real.sqrt (p : ℝ)) M (Real.log (p : ℝ)) f) ((h : ℂ) + 1 / 2) *
    BuildingBlocks.FullComplexHistoryMellin.mellin (BuildingBlocks.CompactScatteringOperator.historyPhysical
      (1 / Real.sqrt (p : ℝ)) M (Real.log (p : ℝ)) f) (-((h : ℂ) + 1 / 2)) =
    ((positiveMultiplier (p : ℝ) h M * negativeMultiplier (p : ℝ) h M : ℝ) : ℂ) *
      (BuildingBlocks.FullComplexHistoryMellin.mellin f ((h : ℂ) + 1 / 2) * BuildingBlocks.FullComplexHistoryMellin.mellin f (-((h : ℂ) + 1 / 2)))
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified proof in Lean 4 connecting physical wave packet scattering histories to two-sided Mellin moment multiplier dictionaries with strict sign invariance.
