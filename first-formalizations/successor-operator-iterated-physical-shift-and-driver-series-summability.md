# First Formalization: Successor-Operator Iterated Physical Shift and Driver-Series Summability

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/SuccessorFeedbackSource.lean`](../../formalization/BuildingBlocks/SuccessorFeedbackSource.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact iterated shift formula, uniform defect bounds, and absolute summability of the driver generating series in Lean 4:

1. **Iterated Physical Shift Formula:**
   Formal proof that $(T^j \mathcal{L} H)(v) = e^{v/2} H(e^v + j)$ for all $j \in \mathbb{N}$ (`successor_iterate_physicalLift`).
2. **Uniform Defect Bound:**
   Formal proof that $|\operatorname{defect}(T^j \mathcal{L} H)| \le 2 M$ uniformly for all $j \in \mathbb{N}$ (`iterate_defect_bound`).
3. **Chebyshev Error Bounds:**
   Formal proof of $|E(x)| \le 4\log 2 + 1$ (`physicalError_abs_le`) and driver bound $|d_j| \le 2(4\log 2 + 1)$ (`driver_abs_le`).
4. **Analytic Driver Generating Series:**
   Formal proof that $\sum_{j=0}^\infty d_j r^j$ is summable for all $|r| < 1$ (`driver_series_summable`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exact iterated physical shift formula
theorem successor_iterate_physicalLift (H : ℝ → ℝ) (j : ℕ) (v : ℝ) :
    successor^[j] (MixedEnergy.physicalLift H) v =
      exp (v / 2) * H (exp v + j)

-- Uniform defect bound for all iterates
theorem iterate_defect_bound {H : ℝ → ℝ} (hH : Measurable H)
    {M : ℝ} (hM : 0 ≤ M) (hb : ∀ x, 0 < x → |H x| ≤ M) (j : ℕ) :
    |defect (successor^[j] (MixedEnergy.physicalLift H))| ≤ 2 * M

-- Uniform bound on feedback drivers
theorem driver_abs_le (j : ℕ) : |driver j| ≤ 2 * (4 * log 2 + 1)

-- Summability of generating function series on the unit disk
theorem driver_series_summable {r : ℝ} (hr : |r| < 1) :
    Summable (fun j : ℕ => driver j * r ^ j)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified proof that iterates of the successor transfer operator act as exact linear shifts on the physical variable, yielding a holomorphic driver generating function on the unit disk.
