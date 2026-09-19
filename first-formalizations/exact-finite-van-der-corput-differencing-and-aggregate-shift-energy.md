# First Formalization: Exact Finite van der Corput Differencing and Aggregate Shift Energy

**Date:** 19 September 2026  
**Lean 4 Modules:** [`formalization/BuildingBlocks/FiniteShiftEnergy.lean`](../../formalization/BuildingBlocks/FiniteShiftEnergy.lean), [`formalization/BuildingBlocks/AggregateShiftEnergy.lean`](../../formalization/BuildingBlocks/AggregateShiftEnergy.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes exact finite van der Corput shift energy inequalities with complete signed correlations in Lean 4:

1. **Shift Envelope Conservation:**
   Formal proof of cardinality $|\mathcal{E}(N, H)| = N + H$ and exact sum identity $\sum_{n \in \mathcal{E}} \sum_{h < H} z(n+h) = H \sum_{n < N} z(n)$ (`shiftEnvelope_card`, `sum_shiftEnvelope_shifts`).
2. **Finite van der Corput Differencing:**
   Formal derivation of $H^2 |\sum z(n)|^2 \le (N+H) \sum_{h, j < H} \sum_{n \in \mathcal{E}} \operatorname{Re}(z(n+h)\overline{z(n+j)})$ preserving all signed correlations (`finite_shift_energy`).
3. **Outer Weighted Cauchy Differencing:**
   Formal derivation of weighted van der Corput inequality for families $\{z_p\}$ with weights $\{a_p\}$ (`weighted_finite_shift_energy`).
4. **Aggregate Shift Energy without Cauchy Loss:**
   Formal derivation of aggregate shift energy preserving all mixed cross-terms $p \ne q$ without outer Cauchy-Schwarz degradation (`aggregate_finite_shift_energy`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Shift conservation on envelope
theorem sum_shiftEnvelope_shifts (z : ℤ → ℂ) (N H : ℕ)
    (hz : ∀ n, n ∉ Finset.Ico (0 : ℤ) N → z n = 0) :
    (∑ n ∈ shiftEnvelope N H, ∑ h ∈ Finset.range H, z (n + h)) =
      (H : ℂ) * ∑ n ∈ Finset.Ico (0 : ℤ) N, z n

-- Finite van der Corput differencing
theorem finite_shift_energy (z : ℤ → ℂ) (N H : ℕ)
    (hz : ∀ n, n ∉ Finset.Ico (0 : ℤ) N → z n = 0) :
    (H : ℝ) ^ 2 * ‖∑ n ∈ Finset.Ico (0 : ℤ) N, z n‖ ^ 2 ≤
      ((N : ℝ) + H) *
        ∑ h ∈ Finset.range H, ∑ j ∈ Finset.range H,
          ∑ n ∈ shiftEnvelope N H, (z (n + h) * conj (z (n + j))).re

-- Aggregate shift energy retaining all cross terms
theorem aggregate_finite_shift_energy {ι : Type*} (s : Finset ι) (a : ι → ℂ)
    (z : ι → ℤ → ℂ) (N H : ℕ)
    (hz : ∀ p ∈ s, ∀ n, n ∉ Finset.Ico (0 : ℤ) N → z p n = 0) :
    (H : ℝ) ^ 2 * ‖∑ p ∈ s, a p * ∑ n ∈ Finset.Ico (0 : ℤ) N, z p n‖ ^ 2 ≤
      ((N : ℝ) + H) *
        ∑ h ∈ Finset.range H, ∑ j ∈ Finset.range H,
          ∑ n ∈ shiftEnvelope N H, ∑ p ∈ s, ∑ q ∈ s,
            (a p * conj (a q) * z p (n + h) * conj (z q (n + j))).re
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation of exact, non-asymptotic van der Corput shift energy inequalities in Lean 4 that retains complete signed correlations and aggregate cross-terms across parameter families.
