# First Formalization: Exact Three-Component Gram Energy Decomposition for Arithmetic Heat Sources

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ActualHeatDensityPairing.lean`](../../formalization/BuildingBlocks/ActualHeatDensityPairing.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact three-component Gram energy decomposition for the continuous $L^2(0, \infty)$ Hilbert norm of arithmetic heat sources in Lean 4:

1. **Continuous Density Self-Energy Closed Formula:**
   Formal proof that $\int_0^\infty (\text{density}_N(t))^2 dt = 2N\log(2N) - 2(N+1)\log(N+1) + 2\log 2$ (`density_square_closed_formula`).
2. **Discrete-Continuous Logarithmic Cross-Term:**
   Formal evaluation $\int_0^\infty e^{-xt} \text{density}_N(t) dt = \log((x+N)/(x+1))$ (`mixed_density_integral`).
3. **General Profile Density Gram Identity:**
   Formal proof of the Gram expansion for arbitrary discrete profiles against the continuous density background (`complete_density_gram`).
4. **Actual Prime Fluctuation Heat Source Gram Formula:**
   Formal derivation of the exact closed evaluation for $\int_0^\infty S_N(t)^2 dt$ (`actual_source_gram`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Closed formula for continuous density L² energy
theorem density_square_closed_formula (N : ℕ) (hN : 1 ≤ N) :
    (∫ t : ℝ in Ioi 0, density N t ^ 2) =
      2 * (N : ℝ) * Real.log (2 * (N : ℝ)) -
        2 * ((N : ℝ) + 1) * Real.log ((N : ℝ) + 1) + 2 * Real.log 2

-- Discrete-continuous logarithmic cross pairing
theorem mixed_density_integral (N : ℕ) (hN : 1 ≤ N) (x : ℝ) (hx : 1 ≤ x) :
    (∫ t : ℝ in Ioi 0, Real.exp (-x * t) * density N t) =
      Real.log ((x + N) / (x + 1))

-- Complete three-component Gram matrix identity for arithmetic heat source
theorem actual_source_gram (N : ℕ) (hN : 1 ≤ N) :
    (∫ t : ℝ in Ioi 0, source N t ^ 2) =
      (∑ i ∈ Finset.range (N + 1), ∑ j ∈ Finset.range (N + 1),
        atomicCoefficient i * atomicCoefficient j / (atomicCoordinate i + atomicCoordinate j)) -
      2 * (∑ i ∈ Finset.range (N + 1), atomicCoefficient i *
        Real.log ((atomicCoordinate i + N) / (atomicCoordinate i + 1))) +
      (2 * (N : ℝ) * Real.log (2 * (N : ℝ)) -
        2 * ((N : ℝ) + 1) * Real.log ((N : ℝ) + 1) + 2 * Real.log 2)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified proof in Lean 4 evaluating the continuous $L^2(0, \infty)$ Hilbert norm of the prime fluctuation heat source as an exact finite algebraic-logarithmic sum.
