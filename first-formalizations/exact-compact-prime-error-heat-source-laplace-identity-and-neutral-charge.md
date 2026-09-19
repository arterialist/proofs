# First Formalization: Exact Compact Prime-Error Heat Source Laplace Identity and Neutral Charge

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ActualCompactHeatEndpoint.lean`](../../formalization/BuildingBlocks/ActualCompactHeatEndpoint.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact equivalence between discrete-continuous prime heat packets and the Laplace transform of the cumulative prime error, along with the vanishing of total charge in Lean 4:

1. **Compact Heat Packet Comparisons:**
   Formal proofs of `compactHeat_eq_goldbach_packet` and `compactHeat_eq_source_sub_terminal`: Equating the compact heat source to the centered Goldbach packet and to the continuous source with frozen terminal charge.
2. **Grand Laplace Integral Identity:**
   Formal proof of `compactHeat_eq_error_integral`: Proving $\text{compactHeat}(N, t) = t \int_1^N (\psi(x) - x) e^{-xt} dx$.
3. **Exact Neutral Charge Theorem:**
   Formal proof of `compactHeat_at_zero`: Proving $\text{compactHeat}(N, 0) = 0$ for all $N \ge 1$.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Equivalence with the discrete Goldbach packet plus cell correction and terminal charge
theorem compactHeat_eq_goldbach_packet (N : ℕ) (hN : 1 ≤ N) (t : ℝ) :
    compactHeat N t =
      GoldbachHeat.finiteHeat GoldbachHeat.centeredCoefficient N t +
        densityCellCorrection N t -
          BuildingBlocks.CoarsePrimitive.primeErrorReal N * exp (-(N : ℝ) * t)

-- Grand Laplace transform identity for the step-discontinuous prime error
theorem compactHeat_eq_error_integral (N : ℕ) (hN : 1 ≤ N) (t : ℝ) :
    compactHeat N t =
      t * (∫ x in (1 : ℝ)..(N : ℝ),
        BuildingBlocks.CoarsePrimitive.primeErrorReal x * exp (-x * t))

-- Neutral total charge theorem
theorem compactHeat_at_zero (N : ℕ) (hN : 1 ≤ N) : compactHeat N 0 = 0
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 proving the exact identity between discrete prime heat packets and the continuous Laplace transform $t \int_1^N (\psi(x)-x)e^{-xt} dx$, with guaranteed neutrality of the total charge at $t=0$.
