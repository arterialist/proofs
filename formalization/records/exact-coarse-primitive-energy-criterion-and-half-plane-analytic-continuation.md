# Contribution 238: Exact Coarse Primitive Energy Criterion and Half-Plane Analytic Continuation

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/CoarseContinuation.lean`](../../formalization/BuildingBlocks/CoarseContinuation.lean), [`building-blocks/coarse/coarse-continuation.md`](../../building-blocks/coarse/coarse-continuation.md)  
**Classification:** Complex Analysis / Analytic Number Theory / Mellin Transforms / Analytic Continuation / Weierstrass Majorants / Locally Uniform Convergence / Critical Line Abscissa

---

## 1. Executive Summary and Mathematical Statement

A central problem in analytic prime number theory is establishing the holomorphic extension of the Mellin transform of the prime-counting error $\psi(x) - x$ across the critical abscissa $\text{Re}(s) > 1/2$. The coarse primitive condition (`CoarsePrimitiveBound`) asserts that the integrated square of the localized primitive satisfies $E(X) = \int_X^{2X} (\int_X^x (\psi(u)-u) du)^2 dx \le C_\epsilon X^{4+\epsilon}$ for all $\epsilon > 0$.

This contribution proves:

1. **Summable Compact Majorant Existence:**  
   For any compact set $K \subset \{s \in \mathbb{C} \mid \text{Re}(s) > 1/2\}$, under `CoarsePrimitiveBound`, there exists an absolutely summable sequence $u: \mathbb{N} \to \mathbb{R}$ ($\sum_{k=0}^\infty u_k < \infty$) dominating all dyadic Mellin blocks on $K$:
   $$
   \|\text{coarseMellinBlock}(k, s)\| \le u_k \quad \text{for all } k \in \mathbb{N}, s \in K.
   $$
2. **Locally Uniform Convergence of Dyadic Partial Sums:**  
   The sequence of partial sums of dyadic Mellin blocks:
   $$
   S_T(s) = \sum_{k \le T} \text{coarseMellinBlock}(k, s) = \sum_{k \le T} \int_{2^k}^{2^{k+1}} (\psi(x) - x) x^{-(s+1)} \, dx
   $$
   converges locally uniformly on the open right half-plane $\mathcal{H}_{1/2} = \{s \in \mathbb{C} \mid \text{Re}(s) > 1/2\}$ to the total Mellin sum $\text{coarseMellinSum}(s)$.
3. **Analytic Continuation Theorem:**
   Under `CoarsePrimitiveBound`, the total prime error Mellin sum $\text{coarseMellinSum}(s)$ is analytic on the entire open half-plane $\text{Re}(s) > 1/2$:
   $$
   \text{AnalyticOnNhd } \mathbb{C} \, \text{coarseMellinSum} \, \{s \in \mathbb{C} \mid \text{Re}(s) > 1/2\}.
   $$
   This establishes that an $L^2$ primitive bound on prime fluctuations guarantees zero singularities for the prime Mellin transform in the entire critical half-plane $\text{Re}(s) > 1/2$.

---

## 2. Mathematical Proof

### 2.1. Construction of the Compact Majorant
Let $K \subset \{s \in \mathbb{C} \mid \text{Re}(s) > 1/2\}$ be compact.
Since $K$ is compact, $a = \inf_{s \in K} \text{Re}(s) > 1/2$ and $R = \sup_{s \in K} \|s + 1\| < \infty$.
By Contribution 236 (`coarseMellinBlock_geometric_bound`), there exist $M > 0$ and $0 \le r < 1$ such that:
$$
\|\text{coarseMellinBlock}(k, s)\| \le M \cdot r^k \quad \text{for all } s \in K, k \in \mathbb{N}.
$$
Defining $u_k = M r^k$:
Since $0 \le r < 1$, the geometric series $\sum_{k=0}^\infty u_k = \frac{M}{1 - r} < \infty$ is summable, providing the required Weierstrass $M$-test majorant.

### 2.2. Locally Uniform Convergence
By the Weierstrass $M$-test for series of functions (`coarseMellinBlock_tendstoLocallyUniformlyOn_of_geometric`), existence of a summable majorant on every compact subset of an open set implies that the partial sums $\sum_{k \in t} \text{coarseMellinBlock}(k, s)$ converge locally uniformly on $\mathcal{H}_{1/2}$.

### 2.3. Analyticity of the Limit
By Contribution 237 (`coarseMellinBlock_analytic`), each individual dyadic block $s \mapsto \text{coarseMellinBlock}(k, s)$ is analytic on $\mathbb{C}$.
By Weierstrass's theorem on analytic functions (the locally uniform limit of analytic functions is analytic, formalized via `coarseMellinSum_analytic_of_geometric`), the limit $\text{coarseMellinSum}$ is analytic on $\mathcal{H}_{1/2} = \{s \in \mathbb{C} \mid \text{Re}(s) > 1/2\}$.

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

- **Prior Literature:** Analytic continuation via Dirichlet series and Mellin transforms in analytic number theory (Titchmarsh 1986, Montgomery-Vaughan 2007). Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Establishes a complete, verified pipeline from coarse energy bounds to locally uniform convergence and complex analyticity on the critical half-plane.
- **Target Venues:** *Inventiones Mathematicae* or *Annals of Mathematics*.
