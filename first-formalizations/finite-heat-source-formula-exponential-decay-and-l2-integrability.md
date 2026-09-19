# First Formalization: Finite Heat Source Formula, Exponential Decay, and L² Integrability

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ActualFiniteHeatSource.lean`](../../formalization/BuildingBlocks/ActualFiniteHeatSource.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact analysis of the finite heat source $S_N(t)$ in Lean 4:

1. **Closed Formula for Continuum Heat Integral:**
   Formal evaluation $\int_a^b e^{-tx} dx = (e^{-ta} - e^{-tb})/t$ (`continuum_heat_integral`) and closed heat source formula (`source_formula`).
2. **Chebyshev Error Identity at $t = 0$:**
   Formal verification that $S_N(0) = \psi(N) - N$ (`source_at_zero`).
3. **Exact Successor Formula:**
   Formal derivation of $S_{N+1}(t) - S_N(t) = \Lambda(N+1) e^{-(N+1)t} - \int_N^{N+1} e^{-tx} dx$ (`source_successor`).
4. **Uniform Exponential Bound:**
   Formal proof of $|S_N(t)| \le (\psi(N) + N) e^{-t}$ for all $t \ge 0$ (`source_norm_bound`).
5. **Unconditional $L^2(0, \infty)$ Square Integrability:**
   Formal verification that $S_N(t)^2$ is integrable on $(0, \infty)$ (`source_square_integrable`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Closed formula for the finite heat source
theorem source_formula (N : ℕ) (t : ℝ) (ht : t ≠ 0) :
    source N t =
      (∑ n ∈ Finset.range (N + 1), Λ n * Real.exp (-(n : ℝ) * t)) -
        (Real.exp (-t) - Real.exp (-(N : ℝ) * t)) / t - Real.exp (-t)

-- Evaluation at t = 0 matches Chebyshev error
theorem source_at_zero (N : ℕ) :
    source N 0 = (∑ n ∈ Finset.range (N + 1), Λ n) - (N : ℝ)

-- Successor increment formula
theorem source_successor (N : ℕ) (t : ℝ) :
    source (N + 1) t - source N t =
      Λ (N + 1) * Real.exp (-((N + 1 : ℕ) : ℝ) * t) -
        ∫ x : ℝ in (N : ℝ)..(N + 1 : ℕ), Real.exp (-t * x)

-- Uniform exponential decay bound
theorem source_norm_bound (N : ℕ) (hN : 1 ≤ N) (t : ℝ) (ht : 0 ≤ t) :
    ‖source N t‖ ≤ variationBound N * Real.exp (-t)

-- L²(0, ∞) square integrability
theorem source_square_integrable (N : ℕ) (hN : 1 ≤ N) :
    IntegrableOn (fun t : ℝ => source N t ^ 2) (Ioi 0)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified proof in Lean 4 connecting the discrete Chebyshev error $\psi(N) - N$ to a continuous heat source $S_N(t)$ with uniform exponential decay and unconditional $L^2(0, \infty)$ square integrability.
