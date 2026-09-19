# First Formalization: Exact Complete Weil Divisor-Packet Prime Energy Identity

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/CompactWeilDivisorEnergyFinite.lean`](../../formalization/BuildingBlocks/CompactWeilDivisorEnergyFinite.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact algebraic ground-state transformation of the complete Weil prime form on finite hyperbola divisor networks in Lean 4:

1. **Incoming Square Logarithm Identity:**
   Formal derivation of $\sum_{d \le N} \sum_{n \le N/d} \frac{\Lambda(d)}{nd} g(nd)^2 = \sum_{m \le N} \frac{\log m}{m} g(m)^2$ (`incoming_square_eq_log`).
2. **Dirichlet History Energy Positivity:**
   Formal derivation of $\mathcal{E}_{\text{history}}(g) = \sum \frac{\Lambda(d)}{nd} (g(n) - g(nd))^2 \ge 0$ (`historyEnergy_nonneg`).
3. **Pointwise Boundary Defect Regrouping:**
   Formal derivation of $\mathcal{E}_{\text{boundary}}(g) = \sum_{n \le N} \frac{g(n)^2}{n} (\log(N/n) - \sum_{d \le N/n} \frac{\Lambda(d)}{d})$ (`boundaryEnergy_eq_pointwise`).
4. **Exact Prime Deficit Decomposition:**
   Formal proofs of $\log N \|g\|^2 - \mathcal{P}_N(g) = \mathcal{E}_{\text{history}}(g) + \mathcal{E}_{\text{boundary}}(g)$ in global and pointwise forms (`prime_deficit_eq_history_add_boundary`, `prime_deficit_eq_history_add_pointwise`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Incoming prime-power edge mass identity
theorem incoming_square_eq_log (N : ℕ) (g : ℕ → ℝ) :
    (∑ d ∈ Finset.Icc 1 N,
      ∑ n ∈ Finset.Icc 1 (N / d),
        edgeWeight n d * g (n * d) ^ 2) =
      ∑ m ∈ Finset.Icc 1 N,
        Real.log (m : ℝ) * g m ^ 2 / (m : ℝ)

-- Manifest nonnegativity of the history difference square
theorem historyEnergy_nonneg (N : ℕ) (g : ℕ → ℝ) :
    0 ≤ historyEnergy N g

-- Pointwise regrouping by Mertens defect
theorem boundaryEnergy_eq_pointwise (N : ℕ) (g : ℕ → ℝ) :
    boundaryEnergy N g =
      ∑ n ∈ Finset.Icc 1 N,
        boundaryDefect N n * g n ^ 2 / (n : ℝ)

-- Global ground-state decomposition
theorem prime_deficit_eq_history_add_boundary (N : ℕ) (g : ℕ → ℝ) :
    Real.log (N : ℝ) * vertexNorm N g - primeGraph N g =
      historyEnergy N g + boundaryEnergy N g

-- Pointwise ground-state decomposition
theorem prime_deficit_eq_history_add_pointwise (N : ℕ) (g : ℕ → ℝ) :
    Real.log (N : ℝ) * vertexNorm N g - primeGraph N g =
      historyEnergy N g +
        ∑ n ∈ Finset.Icc 1 N,
          boundaryDefect N n * g n ^ 2 / (n : ℝ)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 proving the exact algebraic decomposition of the Weil prime form into a non-negative Dirichlet history form and pointwise Mertens boundary defects.
