# First Formalization: Exact Boundary Mean Correction and Reciprocal Dual Compact Vanishing

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/MeanCorrection.lean`](../../formalization/BuildingBlocks/MeanCorrection.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization proves the exact elimination of the non-zero mean obstruction in dual step approximations and the preservation of compact support and reciprocity in Lean 4:

1. **Boundary Correction Definition and Mean:**
   Formal proof of `boundaryCorrection_intervalIntegrable`, `boundaryCorrection_mean` ($\int_0^1 (\{2y\} - 2\{y\}) dy = -1/2$), and `boundaryCorrection_periodic`.
2. **Mean-Corrected Profiles:**
   Definitions of `meanCorrectedDual` and `meanCorrectedError`, with formal proofs of `meanCorrectedDual_reciprocal` and `meanCorrectedError_periodic`.
3. **Exact Mean Zero Cancellation:**
   Formal proof of `meanCorrectedError_mean_zero`:
   $$
   \int_0^1 \mathcal{E}_{\text{corr}}(N, y) dy = 0.
   $$
4. **Compact Support Vanishing:**
   Formal proof of `boundaryCorrection_zero_of_small` and `meanCorrectedDual_zero_above_one`: $\mathcal{D}_{\text{corr}}(N, x) = 0$ for all $x > 1$ and $N \ge 2$.
5. **Uniform Bounds and Integrability:**
   Formal proof of `boundaryCorrection_abs_le` ($|B(y)| \le 3$), `meanCorrectedDual_error_abs_bound`, and `meanCorrectedDual_sq_intervalIntegrable`.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Unit period mean of the boundary correction
theorem boundaryCorrection_mean : (∫ y in (0 : ℝ)..1, boundaryCorrection y) = -1 / 2

-- Exact reciprocal duality
theorem meanCorrectedDual_reciprocal {N : ℕ} (hN : 0 < N) {y : ℝ} (hy : y ≠ 0) :
    1 + meanCorrectedDual N (1 / ((N : ℝ) * y)) = meanCorrectedError N y

-- Exact zero-mean integral
theorem meanCorrectedError_mean_zero (N : ℕ) :
    (∫ y in (0 : ℝ)..1, meanCorrectedError N y) = 0

-- Compact support vanishing outside (0, 1]
theorem meanCorrectedDual_zero_above_one {N : ℕ} (hN : 2 ≤ N) {x : ℝ} (hx : 1 < x) :
    meanCorrectedDual N x = 0

-- L^2 interval integrability of the squared error
theorem meanCorrectedDual_sq_intervalIntegrable (N : ℕ) (a b : ℝ) :
    IntervalIntegrable (fun x => (1 + meanCorrectedDual N x) ^ 2) volume a b
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified proof in Lean 4 constructing an exact periodic boundary correction that completely neutralizes the non-zero mean obstruction of the Nyman–Beurling step approximation while strictly maintaining compact support on $(0, 1]$ and reciprocal duality.
