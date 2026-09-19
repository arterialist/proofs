# First Formalization: Exact Finite Rayleigh Numerator of the Weil Divisor Packet

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/CompactWeilDivisorRayleighFinite.lean`](../../formalization/BuildingBlocks/CompactWeilDivisorRayleighFinite.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact collapse of the complete directed divisor packet sum to the harmonic logarithm sum, and the exact closed evaluation of the flat state Rayleigh numerator in Lean 4:

1. **Complete Divisor Edge Collapse:**
   Formal proof of $\sum_{d=1}^N \sum_{r \le N/d} \frac{\Lambda(d)}{dr} = \sum_{m=1}^N \frac{\log m}{m}$ (`complete_divisor_edge_sum`).
2. **Ordered-Pair Rayleigh Numerator:**
   Formal evaluation of $2 \sum_{d=1}^N \sum_{r \le N/d} \frac{\Lambda(d)}{dr} = 2 \sum_{m=1}^N \frac{\log m}{m}$ (`ordered_divisor_rayleigh_numerator`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Complete divisor edge arithmetic collapse
theorem complete_divisor_edge_sum (N : ℕ) :
    (∑ d ∈ Finset.Icc 1 N,
      ∑ r ∈ Finset.Icc 1 (N / d),
        ArithmeticFunction.vonMangoldt d / ((d : ℝ) * r)) =
      ∑ m ∈ Finset.Icc 1 N, Real.log m / (m : ℝ)

-- Symmetrized ordered-pair Rayleigh numerator
theorem ordered_divisor_rayleigh_numerator (N : ℕ) :
    2 * (∑ d ∈ Finset.Icc 1 N,
      ∑ r ∈ Finset.Icc 1 (N / d),
        ArithmeticFunction.vonMangoldt d / ((d : ℝ) * r)) =
      2 * ∑ m ∈ Finset.Icc 1 N, Real.log m / (m : ℝ)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 establishing the exact closed arithmetic collapse of the finite Weil divisor packet Rayleigh numerator on the uniform test vector to twice the logarithmic harmonic sum.
