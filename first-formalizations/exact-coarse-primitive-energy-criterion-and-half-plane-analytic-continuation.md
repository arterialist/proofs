# First Formalization: Exact Coarse Primitive Energy Criterion and Half-Plane Analytic Continuation

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/CoarseContinuation.lean`](../../formalization/BuildingBlocks/CoarseContinuation.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the existence of summable compact majorants, locally uniform convergence, and the complex analyticity of the total prime error Mellin sum in the critical half-plane $\text{Re}(s) > 1/2$ from the coarse primitive energy bound in Lean 4:

1. **Summable Compact Majorant:**
   Formal proof of `coarseMellinBlock_compact_majorant_of_bound`: Existence of a summable sequence $u: \mathbb{N} \to \mathbb{R}$ dominating dyadic Mellin blocks on any compact subset $K \subset \{s \in \mathbb{C} \mid \text{Re}(s) > 1/2\}$.
2. **Locally Uniform Convergence:**
   Formal proof of `coarseMellinBlock_tendstoLocallyUniformlyOn`: The partial sums $\sum_{k \in t} \text{coarseMellinBlock}(k, s)$ converge locally uniformly on $\text{Re}(s) > 1/2$.
3. **Analyticity on the Critical Half-Plane:**
   Formal proof of `coarseMellinSum_analytic`: The total prime Mellin sum is analytic on the open half-plane $\{s \in \mathbb{C} \mid \text{Re}(s) > 1/2\}$.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Summable uniform majorant on compact subsets of the critical right half-plane
theorem coarseMellinBlock_compact_majorant_of_bound (hb : CoarsePrimitiveBound)
    {K : Set ℂ} (hK : IsCompact K) (hsub : K ⊆ {s | (1 : ℝ) / 2 < s.re}) :
    ∃ u : ℕ → ℝ, Summable u ∧ ∀ k s, s ∈ K → ‖coarseMellinBlock k s‖ ≤ u k

-- Locally uniform convergence of dyadic partial sums
theorem coarseMellinBlock_tendstoLocallyUniformlyOn (hb : CoarsePrimitiveBound) :
    TendstoLocallyUniformlyOn
      (fun t : Finset ℕ => fun s => ∑ k ∈ t, coarseMellinBlock k s)
      coarseMellinSum atTop {s | (1 : ℝ) / 2 < s.re}

-- Grand analytic continuation theorem on the critical half-plane
theorem coarseMellinSum_analytic (hb : CoarsePrimitiveBound) :
    AnalyticOnNhd ℂ coarseMellinSum {s | (1 : ℝ) / 2 < s.re}
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 rigorously deriving the analytic continuation of the prime Mellin sum on $\text{Re}(s) > 1/2$ from an $L^2$ primitive energy bound, executing the complete Weierstrass $M$-test and locally uniform analytic convergence machinery in an interactive theorem prover.
