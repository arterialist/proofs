# First Formalization: Exact Additive Heat Gram Positivity and Cauchy-Lipschitz Embedding

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/AdditiveHeatPairing.lean`](../../formalization/BuildingBlocks/AdditiveHeatPairing.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact Hilbert space metric, Cauchy-Hilbert Gram positivity, and global 1/2-Lipschitz continuity of the exponential birth embedding in Lean 4:

1. **Exponential Laplace Integrals:**
   Formal proof of `exponential_pair_integrable` and `exponential_pair_integral`: $\int_0^\infty e^{-xt}e^{-yt}dt = \frac{1}{x+y}$.
2. **Gramian Representation and Positivity:**
   Formal proof of `profile_square`, `finite_heat_gram`, and `finite_additive_gram_nonnegative`:
   \[
   \sum_{i, j \in S} \frac{c_i c_j}{x_i + x_j} = \int_0^\infty \left( \sum_{i \in S} c_i e^{-x_i t} \right)^2 dt \ge 0.
   \]
3. **Metric Tensor for Differences:**
   Formal proof of `exponential_difference_square_integrable`, `exponential_difference_square_integral`, and `exponential_difference_square_bound`.
4. **$L^2$ Space Construction:**
   Formal construction of `exponential_memLp` and the birth embedding `birth : Ici 1 → Lp ℝ 2`.
5. **Certified Metric and Lipschitz Bound:**
   Formal proof of `birth_distance_square`, `birth_distance_bound`, and `birth_lipschitz` (Lipschitz constant $1/2$).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Exact Laplace inner product for Cauchy-Hilbert kernel
theorem exponential_pair_integral {x y : ℝ} (hx : 0 < x) (hy : 0 < y) :
    (∫ t : ℝ in Ioi 0, Real.exp (-x * t) * Real.exp (-y * t)) = 1 / (x + y)

-- Positivity of finite additive heat Gram matrices
theorem finite_additive_gram_nonnegative {ι : Type*} (s : Finset ι)
    (x c : ι → ℝ) (hx : ∀ i ∈ s, 0 < x i) :
    0 ≤ ∑ i ∈ s, ∑ j ∈ s, c i * c j / (x i + x j)

-- Exact Riemannian metric tensor on the heat curve
theorem birth_distance_square (x y : Ici (1 : ℝ)) :
    ‖birth x - birth y‖ ^ 2 =
      ((x : ℝ) - (y : ℝ)) ^ 2 / (2 * (x : ℝ) * (y : ℝ) * ((x : ℝ) + (y : ℝ)))

-- Global 1/2-Lipschitz continuity into L²
theorem birth_lipschitz : LipschitzWith (1 / 2 : NNReal) birth
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified proof in Lean 4 certifying the exact metric tensor and global 1/2-Lipschitz continuity for exponential birth curves into $L^2(0, \infty)$, and the positive-semidefiniteness of Cauchy-Hilbert additive Gram forms via their continuous Laplace square representations.
