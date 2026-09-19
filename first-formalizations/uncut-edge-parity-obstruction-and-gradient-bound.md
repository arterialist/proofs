# First Formalization: Uncut Edge Parity Obstruction and Symmetric Gradient Bound

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/UncutEdgeParityFinite.lean`](../../formalization/BuildingBlocks/UncutEdgeParityFinite.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

In finite-element and Galerkin approximations to non-local prime jump operators on the critical line, standard basis choices rely on symmetric "even-hat" piecewise linear elements. This formalization establishes two foundational theorems:
1. **Factor-Four Symmetric Edge Gradient Bound:**
   - Proves that for any graph or complex of directed edges with non-negative edge weights and symmetric endpoint energies ($\sum w(e) \|F(\mathrm{dst}(e))\|^2 = \sum w(e) \|F(\mathrm{src}(e))\|^2$), a one-endpoint marginal bound paying $a \sum w(e) \|F(\mathrm{src}(e))\|^2 \le \mathrm{vertexEnergy}$ implies the universal factor-4 gradient estimate:
     \[
     a \sum_{e \in s} w(e) \|F(\mathrm{dst}(e)) - F(\mathrm{src}(e))\|^2 \le 4 \cdot \mathrm{vertexEnergy}.
     \]
2. **The Even-Hat Parity Obstruction:**
   - Proves that whenever a Galerkin discretization uses even basis elements whose action produces identical observations on a pair of reflected coordinates ($i$ and $j$), any target vector whose observations on $i$ and $j$ differ **cannot lie in the linear span** of those basis elements.
   - Formally verifies the general theorem for arbitrary index types $\iota$ (`odd_target_not_in_even_hat_span_at`) and the 16-cell concrete instantiation (`odd_target_not_in_even_hat_span`).
   - Verifies the monotone convergence lemma (`positive_canonical_stage`) ensuring that an increasing family of cutoffs with positive limiting mass detects the positivity at some finite canonical stage $M \ge 4$.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Factor-four symmetric edge gradient estimate
theorem finite_symmetric_edge_bound
    {V E : Type*} (s : Finset E)
    (src dst : E → V) (weight : E → ℝ) (F : V → ℂ)
    (a vertexEnergy : ℝ) (ha : 0 ≤ a)
    (hw : ∀ e ∈ s, 0 ≤ weight e)
    (hsym : (∑ e ∈ s, weight e * ‖F (dst e)‖ ^ 2) = ∑ e ∈ s, weight e * ‖F (src e)‖ ^ 2)
    (hmarg : a * (∑ e ∈ s, weight e * ‖F (src e)‖ ^ 2) ≤ vertexEnergy) :
    a * (∑ e ∈ s, weight e * ‖F (dst e) - F (src e)‖ ^ 2) ≤ 4 * vertexEnergy

-- Parity obstruction: odd target excluded from even-hat span (general index)
theorem odd_target_not_in_even_hat_span_at
    {ι : Type*} (i j : ι)
    (action : Fin 5 → ι → ℂ) (target : ι → ℂ)
    (heven : ∀ k, action k i = action k j)
    (hodd : target i ≠ target j) :
    ¬ ∃ c : Fin 5 → ℂ, ∀ r, target r = ∑ k : Fin 5, c k * action k r

-- Parity obstruction instantiated on the 16-cell ledger
theorem odd_target_not_in_even_hat_span
    (action : Fin 5 → Fin 16 → ℂ) (target : Fin 16 → ℂ)
    (heven : ∀ j, action j 9 = action j 10)
    (hodd : target 9 ≠ target 10) :
    ¬ ∃ c : Fin 5 → ℂ, ∀ i, target i = ∑ j : Fin 5, c j * action j i

-- Monotone convergence detection of positive canonical stage
theorem positive_canonical_stage
    (fullMass : ℝ) (stageMass : ℕ → ℝ)
    (hfull : 0 < fullMass)
    (happrox : ∀ ε : ℝ, 0 < ε → ∃ M : ℕ, 4 ≤ M ∧ fullMass - ε < stageMass M) :
    ∃ M : ℕ, 4 ≤ M ∧ 0 < stageMass M

-- Grid level zero unit cell validity
theorem reflected_unit_cell_indices (M : ℕ) (hM : 4 ≤ M) :
    M + 2 < 2 * M ∧ M - 3 < 2 * M
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0 and Lake 5.0.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the rigorous mathematical reason why standard symmetric Galerkin approximations to prime transition operators cannot resolve asymmetric spectral targets. By demonstrating that the even-hat span is mathematically disjoint from odd-reflection targets, this work establishes the necessity of including odd or non-symmetric basis elements in any viable spectral realization scheme.
