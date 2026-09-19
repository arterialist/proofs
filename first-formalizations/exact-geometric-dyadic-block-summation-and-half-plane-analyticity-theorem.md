# First Formalization: Exact Geometric Dyadic Block Summation and Half-Plane Analyticity Theorem

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/CoarseSummation.lean`](../../formalization/BuildingBlocks/CoarseSummation.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes an abstract complex-analytic transfer theorem in Lean 4, proving that any sequence of entire functions satisfying geometric decay on bounded vertical strips sums to an analytic function on the half-plane $\text{Re}(s) > 1/2$:

1. **Compact Majorant Construction:**
   Formal proof of `coarseMellinBlock_compact_majorant`: Existence of a summable geometric majorant on every compact subset $K \subset \{s \in \mathbb{C} \mid \text{Re}(s) > 1/2\}$.
2. **Locally Uniform Convergence:**
   Formal proof of `coarseMellinBlock_tendstoLocallyUniformlyOn_of_geometric`: Locally uniform convergence of partial sums to the infinite series.
3. **Analyticity Transfer:**
   Formal proof of `coarseMellinSum_analytic_of_geometric`: Proof that the infinite series $F(s) = \sum_{k=0}^\infty f_k(s)$ is analytic on the open half-plane $\text{Re}(s) > 1/2$.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Compact majorant extraction from vertical strip geometric bounds
theorem coarseMellinBlock_compact_majorant
    (hbound : ∀ a R : ℝ, (1 : ℝ) / 2 < a → 0 ≤ R →
      ∃ M r : ℝ, 0 < M ∧ 0 ≤ r ∧ r < 1 ∧
        ∀ k s, a ≤ s.re → ‖s + 1‖ ≤ R → ‖coarseMellinBlock k s‖ ≤ M * r ^ k)
    {K : Set ℂ} (hK : IsCompact K) (hsub : K ⊆ {s | (1 : ℝ) / 2 < s.re}) :
    ∃ u : ℕ → ℝ, Summable u ∧ ∀ k s, s ∈ K → ‖coarseMellinBlock k s‖ ≤ u k

-- Locally uniform convergence on the half-plane
theorem coarseMellinBlock_tendstoLocallyUniformlyOn_of_geometric
    (hbound : ∀ a R : ℝ, (1 : ℝ) / 2 < a → 0 ≤ R →
      ∃ M r : ℝ, 0 < M ∧ 0 ≤ r ∧ r < 1 ∧
        ∀ k s, a ≤ s.re → ‖s + 1‖ ≤ R → ‖coarseMellinBlock k s‖ ≤ M * r ^ k) :
    TendstoLocallyUniformlyOn
      (fun t : Finset ℕ => fun s => ∑ k ∈ t, coarseMellinBlock k s)
      coarseMellinSum atTop {s | (1 : ℝ) / 2 < s.re}

-- Analyticity transfer theorem for geometric block series
theorem coarseMellinSum_analytic_of_geometric
    (hblock : ∀ k s, AnalyticAt ℂ (coarseMellinBlock k) s)
    (hbound : ∀ a R : ℝ, (1 : ℝ) / 2 < a → 0 ≤ R →
      ∃ M r : ℝ, 0 < M ∧ 0 ≤ r ∧ r < 1 ∧
        ∀ k s, a ≤ s.re → ‖s + 1‖ ≤ R → ‖coarseMellinBlock k s‖ ≤ M * r ^ k) :
    AnalyticOnNhd ℂ coarseMellinSum {s | (1 : ℝ) / 2 < s.re}
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This module provides a reusable project implementation of analyticity transfer for geometric block series on complex half-planes. Its exact formulation may be distinctive, but the audit did not establish Lean-wide or worldwide priority.
