# First Formalization: Exact Prime Seed L² Strong Cutoff Convergence and Uniform Operator Approximation

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/PrimeSeedSquareConvergence.lean`](../../formalization/BuildingBlocks/PrimeSeedSquareConvergence.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the strong $L^2(\mathbb{R})$ convergence of finite prime cutoffs to the all-prime seed and proves uniform approximation of the causal renewal memory operator across the half-line $L^2$ unit ball in Lean 4:

1. **Pointwise Stabilization and Domination:**
   Formal proof of eventuality $\text{finitePrimeSeed}(P, v) = \text{allPrimeSeed}(v)$ (`cutoff_seed_eventually_eq`) and squared error domination by $\text{allPrimeSeed}^2$ (`cutoff_seed_square_error_bound`).
2. **Strong $L^2$ Dominated Convergence:**
   Formal proof that the $L^2$ error tends to 0 via dominated convergence (`cutoff_seed_square_error_tendsto`, `cutoff_seed_sqrt_error_tendsto`).
3. **Cauchy-Schwarz Pointwise Operator Error Bound:**
   Formal proof that the operator difference is bounded by $\|B - B_P\|_{L^2} \cdot \|f\|_{L^2}$ for all $v \in \mathbb{R}$ (`cutoff_memory_error_bound`).
4. **Uniform Convergence Across Ages and the $L^2$ Unit Ball:**
   Formal proof of uniform convergence for fixed $f \in L^2$ (`cutoff_memory_uniform`) and uniform convergence across all $f$ in the $L^2((0, \infty))$ unit ball (`cutoff_memory_uniform_unit_ball`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Pointwise cutoff stabilization
theorem cutoff_seed_eventually_eq (v : ℝ) :
    ∀ᶠ P : ℕ in atTop, finitePrimeSeed (primesBelow P) v = allPrimeSeed v

-- Squared error domination
theorem cutoff_seed_square_error_bound (P : ℕ) (v : ℝ) :
    (allPrimeSeed v - finitePrimeSeed (primesBelow P) v) ^ 2 ≤ allPrimeSeed v ^ 2

-- Strong L² error convergence
theorem cutoff_seed_square_error_tendsto :
    Tendsto (fun P : ℕ => ∫ v, (allPrimeSeed v - finitePrimeSeed (primesBelow P) v) ^ 2)
      atTop (𝓝 0)

theorem cutoff_seed_sqrt_error_tendsto :
    Tendsto (fun P : ℕ => sqrt (∫ v,
      (allPrimeSeed v - finitePrimeSeed (primesBelow P) v) ^ 2)) atTop (𝓝 0)

-- Cauchy-Schwarz causal memory bound
theorem cutoff_memory_error_bound (P : ℕ) {f : ℝ → ℝ}
    (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ)))) (v : ℝ) :
    |SuccessorCharge.causalMemory allPrimeSeed f v -
      SuccessorCharge.causalMemory (finitePrimeSeed (primesBelow P)) f v| ≤
      sqrt (∫ w, (allPrimeSeed w - finitePrimeSeed (primesBelow P) w) ^ 2) *
        sqrt (∫ u in Ioi (0 : ℝ), f u ^ 2)

-- Uniform convergence on the L² unit ball
theorem cutoff_memory_uniform_unit_ball {ε : ℝ} (hε : 0 < ε) :
    ∃ P₀ : ℕ, ∀ P ≥ P₀, ∀ f : ℝ → ℝ,
      MemLp f 2 (volume.restrict (Ioi (0 : ℝ))) →
      (∫ u in Ioi (0 : ℝ), f u ^ 2) ≤ 1 → ∀ v : ℝ,
      |SuccessorCharge.causalMemory allPrimeSeed f v -
        SuccessorCharge.causalMemory (finitePrimeSeed (primesBelow P)) f v| < ε
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 establishing the strong $L^2$ convergence of prime renewal cutoffs via Lebesgue dominated convergence and proving uniform operator approximation over the half-line $L^2$ unit ball.
