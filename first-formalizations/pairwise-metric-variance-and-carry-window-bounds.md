# First Formalization in Lean 4: Pairwise Metric Variance Identity and Separated Carry Window Lower Bounds

**Authors:** Arterialist Research Team  
**Date:** September 2026  
**Lean 4 File:** [`formalization/BuildingBlocks/CarryWindowVariance.lean`](../../formalization/BuildingBlocks/CarryWindowVariance.lean)  
**Dependencies:** `Mathlib.Algebra.BigOperators.Intervals`, `Mathlib.Data.Real.Sqrt`  
**Foundational Axioms:** `[propext, Classical.choice, Quot.sound]` (Zero custom axioms, zero `sorry`)

---

## 1. Mathematical Significance and Overview

In the study of arithmetic carry propagation, digital discrepancy, and the variance of local counting functions (such as divisor carries and prime-gap fluctuations across moving windows), lower bounds on the second moment around an arbitrary center $c \in \mathbb{R}$ are essential to rule out degenerate flat profiles.

Given an integer window of length $n$ and a sequence $f : \mathbb{N} \to \mathbb{R}$ with minimum step separation $L > 0$ (i.e., $L(j - i) \le f(j) - f(i)$ for $i \le j$), the variance around an arbitrary center $c$ satisfies the universal cubic lower bound:
$$
\sum_{i=0}^{n-1} (f(i) - c)^2 \ge \frac{L^2 n(n^2 - 1)}{12}.
$$
The proof proceeds via a double-sum metric identity that relates the sum of centered squared deviations to the uncentered pairwise squared differences:
$$
\sum_{i, j < n} (f(i) - f(j))^2 = 2n \sum_{i < n} f(i)^2 - 2 \left( \sum_{i < n} f(i) \right)^2 \le 2n \sum_{i < n} (f(i) - c)^2.
$$
By evaluating the universal quadratic index sum $\sum_{i, j < n} (i - j)^2 = \frac{n^2(n^2 - 1)}{6}$, the lower bound holds independently of the center $c$.

The discrete proof requires algebraic sums, casts, and monotonicity arguments. It is a reusable project lemma; Lean-wide priority has not been established.

---

## 2. Machine-Verified Theorems

### 2.1 Universal Algebraic Pairwise Variance Identity

```lean
theorem pairwise_sq_identity (n : ℕ) (f : ℕ → ℝ) :
    (∑ i ∈ range n, ∑ j ∈ range n, (f i - f j)^2) =
      2 * (n : ℝ) * (∑ i ∈ range n, (f i)^2) -
        2 * (∑ i ∈ range n, f i)^2
```

### 2.2 Discrete First and Second Moment Sums of Cast Ranges

```lean
theorem sum_range_cast (n : ℕ) :
    (∑ i ∈ range n, (i : ℝ)) = (n : ℝ) * ((n : ℝ) - 1) / 2

theorem sum_range_cast_sq (n : ℕ) :
    (∑ i ∈ range n, (i : ℝ)^2) =
      (n : ℝ) * ((n : ℝ) - 1) * (2 * (n : ℝ) - 1) / 6
```

### 2.3 Pairwise Index Quadratic Form Evaluation

```lean
theorem pairwise_index_sq (n : ℕ) :
    (∑ i ∈ range n, ∑ j ∈ range n, ((i : ℝ) - j)^2) =
      (n : ℝ)^2 * ((n : ℝ)^2 - 1) / 6
```

### 2.4 Separated Carry Window Variance Lower Bounds

```lean
theorem sq_separated_variance_lower_bound (n : ℕ) (hn : 0 < n)
    (f : ℕ → ℝ) (L c : ℝ)
    (hsep : ∀ i ∈ range n, ∀ j ∈ range n,
      L^2 * ((i : ℝ) - j)^2 ≤ (f i - f j)^2) :
    L^2 * (n : ℝ) * ((n : ℝ)^2 - 1) / 12 ≤
      ∑ i ∈ range n, (f i - c)^2

theorem separated_variance_lower_bound (n : ℕ) (hn : 0 < n)
    (f : ℕ → ℝ) (L c : ℝ) (hL : 0 ≤ L)
    (hsep : ∀ i ∈ range n, ∀ j ∈ range n, i ≤ j →
      L * ((j : ℝ) - i) ≤ f j - f i) :
    L^2 * (n : ℝ) * ((n : ℝ)^2 - 1) / 12 ≤
      ∑ i ∈ range n, (f i - c)^2
```

---

## 3. Verification Commands and Axiom Audit

To verify independently in Lean 4:
```bash
lake env lean formalization/BuildingBlocks/CarryWindowVariance.lean
```

**Axiom Audit Output:**
```
'BuildingBlocks.CarryWindow.pairwise_sq_identity' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.CarryWindow.pairwise_index_sq' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.CarryWindow.sq_separated_variance_lower_bound' depends on axioms: [propext, Classical.choice, Quot.sound]
'BuildingBlocks.CarryWindow.separated_variance_lower_bound' depends on axioms: [propext, Classical.choice, Quot.sound]
```
No custom axioms or `sorry` placeholders are utilized.
