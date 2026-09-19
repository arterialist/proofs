# Contribution 242: Exact Geometric Dyadic Block Summation and Half-Plane Analyticity Theorem

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/CoarseSummation.lean`](../../formalization/BuildingBlocks/CoarseSummation.lean), [`building-blocks/coarse/coarse-summation.md`](../../building-blocks/coarse/coarse-summation.md)  
**Classification:** Complex Analysis / Several Complex Variables / Mellin Transforms / Weierstrass Majorant Theorem / Locally Uniform Convergence / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In establishing the analyticity of infinite Dirichlet or Mellin series across half-planes, a fundamental step is transferring localized geometric decay estimates on bounded vertical strips to locally uniform convergence and complex analyticity on arbitrary open domains. While standard complex analysis texts appeal to general normal family or Montel-type theorems, formalizing this principle constructively requires continuous extreme-value analysis on compact metric subsets and differential transfer through uniform Cauchy limits.

This contribution proves:

1. **Compact Majorant Construction from Vertical Bounds:**  
   If a sequence of functions $f_k(s)$ satisfies uniform geometric decay $M r^k$ ($0 \le r < 1$) on any region $a \le \text{Re}(s)$ and $\|s+1\| \le R$, then for every compact set $K \subset \{s \in \mathbb{C} \mid \text{Re}(s) > 1/2\}$, there exists a summable sequence $u: \mathbb{N} \to \mathbb{R}$ with:
   $$
   \|f_k(s)\| \le u(k) \quad \text{for all } k \in \mathbb{N}, s \in K.
   $$
   The proof uses extreme-value compactness to extract $z = \operatorname{argmin}_{s \in K} \text{Re}(s)$ and $w = \operatorname{argmax}_{s \in K} \|s+1\|$.
2. **Locally Uniform Convergence of Block Series:**  
   The sequence of partial sums $\sum_{k \in t} f_k(s)$ converges locally uniformly on the open half-plane $\mathcal{H}_{1/2} = \{s \in \mathbb{C} \mid \text{Re}(s) > 1/2\}$ to the total sum $\sum_{k=0}^\infty f_k(s)$.
3. **Geometric Analyticity Transfer Theorem:**
   `coarseMellinSum_analytic_of_geometric`:  
   If each block $f_k$ is analytic on $\mathbb{C}$, and the family satisfies geometric decay on bounded vertical strips, then the infinite series:
   $$
   F(s) = \sum_{k=0}^\infty f_k(s)
   $$
   is analytic on the entire open half-plane $\mathcal{H}_{1/2}$.

---

## 2. Mathematical Proof

### 2.1. Extreme-Value Compact Majorant
Let $K \subset \{s \in \mathbb{C} \mid \text{Re}(s) > 1/2\}$ be compact. If $K = \emptyset$, $u(k) \equiv 0$ trivially works.
If $K \ne \emptyset$:
- Since $s \mapsto \text{Re}(s)$ is continuous, it achieves a minimum $z \in K$ with $a = z.\text{re} > 1/2$.
- Since $s \mapsto \|s + 1\|$ is continuous, it achieves a maximum $w \in K$ with $R = \|w + 1\| < \infty$.
By hypothesis, there exist $M > 0$ and $0 \le r < 1$ such that $\|f_k(s)\| \le M r^k$ whenever $\text{Re}(s) \ge a$ and $\|s + 1\| \le R$.
Since every $s \in K$ satisfies $\text{Re}(s) \ge a$ and $\|s + 1\| \le R$, we have $\|f_k(s)\| \le M r^k =: u(k)$ for all $s \in K$.
Since $r < 1$, $\sum_{k=0}^\infty u(k) < \infty$, proving summability.

### 2.2. Locally Uniform Convergence via Weierstrass
By characterization of locally uniform convergence on open sets (`tendstoLocallyUniformlyOn_iff_forall_isCompact`), it suffices to verify uniform convergence on every compact subset $K$.
The Weierstrass $M$-test (`tendstoUniformlyOn_tsum`) guarantees uniform convergence on $K$ from the existence of the summable majorant $u(k)$.

### 2.3. Analyticity of the Limit Function
Since each partial sum $S_t(s) = \sum_{k \in t} f_k(s)$ is a finite sum of analytic functions, $S_t$ is complex differentiable on $\mathcal{H}_{1/2}$.
Since $S_t \to F$ locally uniformly on the open set $\mathcal{H}_{1/2}$, Weierstrass's theorem on uniform limits of analytic functions ensures that $F$ is complex differentiable on $\mathcal{H}_{1/2}$.
By `DifferentiableOn.analyticOnNhd`, complex differentiability on an open set implies analyticity on a neighborhood of every point in $\mathcal{H}_{1/2}$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.CoarsePrimitive` in `formalization/BuildingBlocks/CoarseSummation.lean`):
```lean
theorem coarseMellinBlock_compact_majorant
    (hbound : ∀ a R : ℝ, (1 : ℝ) / 2 < a → 0 ≤ R →
      ∃ M r : ℝ, 0 < M ∧ 0 ≤ r ∧ r < 1 ∧
        ∀ k s, a ≤ s.re → ‖s + 1‖ ≤ R → ‖coarseMellinBlock k s‖ ≤ M * r ^ k)
    {K : Set ℂ} (hK : IsCompact K) (hsub : K ⊆ {s | (1 : ℝ) / 2 < s.re}) :
    ∃ u : ℕ → ℝ, Summable u ∧ ∀ k s, s ∈ K → ‖coarseMellinBlock k s‖ ≤ u k

theorem coarseMellinBlock_tendstoLocallyUniformlyOn_of_geometric
    (hbound : ∀ a R : ℝ, (1 : ℝ) / 2 < a → 0 ≤ R →
      ∃ M r : ℝ, 0 < M ∧ 0 ≤ r ∧ r < 1 ∧
        ∀ k s, a ≤ s.re → ‖s + 1‖ ≤ R → ‖coarseMellinBlock k s‖ ≤ M * r ^ k) :
    TendstoLocallyUniformlyOn
      (fun t : Finset ℕ => fun s => ∑ k ∈ t, coarseMellinBlock k s)
      coarseMellinSum atTop {s | (1 : ℝ) / 2 < s.re}

theorem coarseMellinSum_analytic_of_geometric
    (hblock : ∀ k s, AnalyticAt ℂ (coarseMellinBlock k) s)
    (hbound : ∀ a R : ℝ, (1 : ℝ) / 2 < a → 0 ≤ R →
      ∃ M r : ℝ, 0 < M ∧ 0 ≤ r ∧ r < 1 ∧
        ∀ k s, a ≤ s.re → ‖s + 1‖ ≤ R → ‖coarseMellinBlock k s‖ ≤ M * r ^ k) :
    AnalyticOnNhd ℂ coarseMellinSum {s | (1 : ℝ) / 2 < s.re}
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Classical Weierstrass convergence theorem and normal families in complex analysis (Ahlfors 1979, Rudin 1987). Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Provides an abstract, reusable theorem decoupling the geometric decay estimates of specific kernel blocks from the topological machinery of analytic continuation.
- **Target Venues:** *Complex Analysis and Operator Theory* or *Journal of Mathematical Analysis and Applications*.
