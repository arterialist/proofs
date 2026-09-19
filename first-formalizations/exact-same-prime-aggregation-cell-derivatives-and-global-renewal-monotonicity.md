# First Formalization: Exact Same-Prime Aggregation Cell Derivatives and Global Renewal Monotonicity

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/SamePrimeAggregationMonotone.lean`](../../formalization/BuildingBlocks/SamePrimeAggregationMonotone.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the normalized chronological tent equivalence, the exact intra-cell derivative formula, cell-by-cell monotonicity via kernel coercivity, and the global monotonicity of the renewal profiles $H$ and $h$ in Lean 4:

1. **Normalized Tent Equivalence:**
   Formal proof that $H(x) = S(x) / (x \sqrt{x})$ (`H_eq_normalized_tent`).
2. **Cell Profile Identification:**
   Formal proof that $H(x) = \text{cell}_k(x)$ on $[k, k+1]$ (`H_eq_cell`).
3. **Exact Cell Derivative Formula:**
   Formal proof that $\frac{d}{dx}\text{cell}_k(x) = \frac{3 B(k) - x A(k)}{2 x^2 \sqrt{x}}$ (`cell_hasDerivAt`).
4. **Intra-Cell Monotonicity:**
   Formal proof that $\text{cell}_k$ is monotone non-decreasing on $[k, k+1]$ (`cell_monotoneOn`).
5. **Global Renewal Monotonicity:**
   Formal proof that $H$ is monotone on $[1, \infty)$ and $h(v) = H(e^v)$ is monotone on $[0, \infty)$ (`H_monotoneOn`, `h_monotoneOn`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Tent normalization equivalence
theorem H_eq_normalized_tent {x : ℝ} (hx : 0 < x) :
    H x = ChronologicalDivisibility.S x / (x * Real.sqrt x)

-- Cell identification
theorem H_eq_cell {k : ℕ} (hk : 1 ≤ k) {x : ℝ}
    (hx : x ∈ Set.Icc (k : ℝ) ((k : ℝ) + 1)) : H x = cell k x

-- Exact cell derivative
theorem cell_hasDerivAt (k : ℕ) {x : ℝ} (hx : 0 < x) :
    HasDerivAt (cell k) ((3 * B k - x * A k) / (2 * x ^ 2 * Real.sqrt x)) x

-- Cell monotonicity
theorem cell_monotoneOn {k : ℕ} (hk : 1 ≤ k) :
    MonotoneOn (cell k) (Set.Icc (k : ℝ) ((k : ℝ) + 1))

-- Global ray monotonicity
theorem H_monotoneOn : MonotoneOn H (Set.Ici 1)

-- Logarithmic age monotonicity
theorem h_monotoneOn : MonotoneOn h (Set.Ici 0)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 proving the exact algebraic derivative $\frac{3 B(k) - x A(k)}{2 x^{5/2}}$ and establishing global monotonicity for normalized arithmetic tent renewal functions across infinite jump boundaries.
