# First Formalization: Exact Factorial Binary Infinite Energy Recurrence and Cauchy Majorant

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/FactorialBinaryIntegrability.lean`](../../formalization/BuildingBlocks/FactorialBinaryIntegrability.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization proves the global Cauchy majorant, improper Lebesgue integrability, dilation invariance, and infinite-horizon dyadic energy balance recurrence for the factorial binary carry system in Lean 4:

1. **Origin and Tail Exponential Increment Bounds:**
   Formal proof of `sizeBudget_nonneg`, `exponential_increment_bounds`, `response_abs_linear` ($|R(N, t)| \le K t$), and `response_abs_bounded` ($|R(N, t)| \le K$).
2. **Global Integrable Cauchy Majorant:**
   Formal proof of `weight_le_inverse_square` ($w(u) \le 1/u^2$) and `energyRow_majorant`:
   $$
   \text{energyRow}(N, u) \le \frac{2 (\text{sizeBudget}(N))^2}{1 + u^2}.
   $$
3. **Improper Lebesgue Integrability on $(0, \infty)$:**
   Formal proof of `energyRow_integrable`, `densityRow_le_energy`, `densityRow_integrable`, `scaled_energyRow_integrable`, and `workRow_integrable`.
4. **Dilation Scaling Identity:**
   Formal proof of `scaled_energy_integral`:
   $$
   \int_0^\infty \frac{1}{2} \text{energyRow}(N, u/2) du = \mathcal{E}(N).
   $$
5. **Exact Infinite-Horizon Energy Balance:**
   Formal proof of `binary_energy_infinite` ($\mathcal{E}(2N+b) - 2\mathcal{E}(N) = \mathcal{W}(N, b) - \mathcal{D}(N)$) and `integratedWork_original_clock`.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Global integrable Cauchy majorant
theorem energyRow_majorant (N : ℕ) (u : ℝ) (hu : 0 < u) :
    energyRow N u ≤ 2 * sizeBudget N ^ 2 * (1 + u ^ 2)⁻¹

-- Complete integrability of energy, density, and work
theorem energyRow_integrable (N : ℕ) : IntegrableOn (energyRow N) (Ioi 0)

theorem densityRow_integrable (N : ℕ) : IntegrableOn (densityRow N) (Ioi 0)

theorem workRow_integrable (N b : ℕ) (hb : b ≤ 1) :
    IntegrableOn (workRow N b) (Ioi 0)

-- Scale-invariance under dilation
theorem scaled_energy_integral (N : ℕ) :
    (∫ u in Ioi 0, energyRow N (u / 2) / 2) = integratedEnergy N

-- Exact infinite-horizon dyadic energy balance
theorem binary_energy_infinite (N b : ℕ) (hb : b ≤ 1) :
    integratedEnergy (2 * N + b) - 2 * integratedEnergy N =
      integratedWork N b - integratedDensity N

-- Work representation in canonical time clock
theorem integratedWork_original_clock (N b : ℕ) :
    integratedWork N b = ∫ t in Ioi 0,
      (2 * response N (2 * t) * innovation N b t + innovation N b t ^ 2) * weight t
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified proof in Lean 4 establishing the global improper Lebesgue integrability and infinite-horizon dyadic recurrence $\mathcal{E}(2N+b) - 2\mathcal{E}(N) = \mathcal{W}(N, b) - \mathcal{D}(N)$ for factorial binary carry dynamics.
