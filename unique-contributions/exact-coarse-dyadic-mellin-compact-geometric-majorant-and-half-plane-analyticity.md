# Contribution 219: Exact Coarse Dyadic Mellin Compact Geometric Majorant and Half-Plane Analyticity

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/CoarseContinuation.lean`](../../formalization/BuildingBlocks/CoarseContinuation.lean), [`formalization/BuildingBlocks/CoarseSummation.lean`](../../formalization/BuildingBlocks/CoarseSummation.lean), [`building-blocks/coarse/coarse-continuation.md`](../../building-blocks/coarse/coarse-continuation.md)  
**Classification:** Complex Analysis / Analytic Number Theory / Mellin Transforms / Dyadic Decompositions / Weierstrass Analyticity Theorems / Prime Error Integrals

---

## 1. Executive Summary and Mathematical Statement

In the analytic continuation of the Mellin transform of prime error terms, proving that dyadic frequency blocks aggregate into a holomorphic function on the open critical half-plane $\mathbb{H}_{1/2} = \{s \in \mathbb{C} \mid \text{Re}(s) > 1/2\}$ requires uniform bounds on compact subsets. Naive point-by-point bounds do not suffice to establish analyticity of the infinite series without local uniform convergence.

This contribution proves:

1. **Compact Geometric Majorant:**  
   Under the coarse primitive energy bound $E(2^k) \le C_\epsilon (2^k)^{4+\epsilon}$ for all $\epsilon > 0$, for any compact subset $K \subset \{s \in \mathbb{C} \mid \text{Re}(s) > 1/2\}$, there exists a summable sequence $u : \mathbb{N} \to \mathbb{R}$ such that:
   $$
   \sup_{s \in K} \| \text{coarseMellinBlock}_k(s) \| \le u_k \quad \text{for all } k \in \mathbb{N},
   $$
   where the dyadic Mellin block is:
   $$
   \text{coarseMellinBlock}_k(s) = \int_{2^k}^{2 \cdot 2^k} (\psi(x) - x) x^{-(s+1)} \, dx.
   $$
2. **Locally Uniform Partial Sum Convergence:**  
   The finite dyadic partial sums converge locally uniformly on $\{s \in \mathbb{C} \mid \text{Re}(s) > 1/2\}$ to the infinite sum:
   $$
   \lim_{t \to \infty} \sum_{k \in t} \text{coarseMellinBlock}_k(s) = \sum_{k=0}^\infty \text{coarseMellinBlock}_k(s) = \text{coarseMellinSum}(s).
   $$
3. **Half-Plane Analyticity:**  
   The total coarse Mellin sum $\text{coarseMellinSum}(s)$ is analytic on the open half-plane:
   $$
   \text{coarseMellinSum} \in \mathcal{O}\left(\{s \in \mathbb{C} \mid \text{Re}(s) > 1/2\}\right).
   $$

---

## 2. Mathematical Proof

### 2.1. Extremal Coordinates on Compact Sets
Let $K \subset \mathbb{H}_{1/2}$ be a non-empty compact set.
By the extreme value theorem, the continuous functions $s \mapsto \text{Re}(s)$ and $s \mapsto \|s+1\|$ achieve their minimum and maximum on $K$, respectively:
$$
a = \min_{s \in K} \text{Re}(s) > \frac{1}{2}, \quad R = \max_{s \in K} \|s + 1\| < \infty.
$$

### 2.2. Uniform Geometric Decay
By the Cauchy-Schwarz dyadic estimate (`coarseMellinBlock_geometric_bound`), whenever $\text{Re}(s) \ge a > 1/2$ and $\|s+1\| \le R$:
$$
\|\text{coarseMellinBlock}_k(s)\| \le M(a, R) \cdot r(a)^k,
$$
with ratio $r(a) = 2^{-(a - 1/2 - \epsilon/2)} < 1$.
Since $r < 1$, the majorant $u_k = M r^k$ is a convergent geometric progression with $\sum_{k=0}^\infty u_k < \infty$.

### 2.3. Locally Uniform Convergence and Weierstrass Analyticity
By the Weierstrass $M$-test for locally uniform limits (`tendstoUniformlyOn_tsum`), the series converges uniformly on each compact subset $K$.
Since each dyadic block $\text{coarseMellinBlock}_k(s)$ is an entire function of $s$ (`coarseMellinBlock_analytic`), the partial sums are holomorphic. By the Weierstrass uniform convergence theorem (`DifferentiableOn.analyticOnNhd`), the limit function $\text{coarseMellinSum}(s)$ is analytic on $\mathbb{H}_{1/2}$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.CoarsePrimitive` in `formalization/BuildingBlocks/CoarseContinuation.lean`):
```lean
theorem coarseMellinBlock_compact_majorant_of_bound (hb : CoarsePrimitiveBound)
    {K : Set ℂ} (hK : IsCompact K) (hsub : K ⊆ {s | (1 : ℝ) / 2 < s.re}) :
    ∃ u : ℕ → ℝ, Summable u ∧ ∀ k s, s ∈ K → ‖coarseMellinBlock k s‖ ≤ u k

theorem coarseMellinBlock_tendstoLocallyUniformlyOn (hb : CoarsePrimitiveBound) :
    TendstoLocallyUniformlyOn
      (fun t : Finset ℕ => fun s => ∑ k ∈ t, coarseMellinBlock k s)
      coarseMellinSum atTop {s | (1 : ℝ) / 2 < s.re}

theorem coarseMellinSum_analytic (hb : CoarsePrimitiveBound) :
    AnalyticOnNhd ℂ coarseMellinSum {s | (1 : ℝ) / 2 < s.re}
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Dyadic decompositions of Mellin transforms, Dirichlet series, and Weierstrass convergence theorems (Titchmarsh 1986, Montgomery-Vaughan 2007). Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Connects discrete dyadic prime energy bounds to complex half-plane holomorphy via a fully machine-checked Weierstrass theorem.
- **Target Venues:** *Complex Analysis and Operator Theory* or *Journal of Mathematical Analysis and Applications*.
