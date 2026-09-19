# First Formalization: Exact Whole-Frequency Logarithmic Moment Bound for Actual Arithmetic Sources

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ChargeFrozenLogMoment.lean`](../../formalization/BuildingBlocks/ChargeFrozenLogMoment.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the whole-frequency integrability and non-asymptotic upper bound for the logarithmic moment of the actual arithmetic source spectral density in Lean 4:

1. **Measurability of Fourier Transform and Spectral Density:**
   Formal proof of `measurable_hat` and `measurable_density` via 2D joint measurability and slice integration.
2. **Global Integrability of Spectral Density:**
   Formal proof of `integrable_density` using the Cauchy envelope majorant.
3. **Exact Whole-Frequency Logarithmic Moment Bound:**
   Formal proof of `actual_log_moment`:
   \[
   \int_\mathbb{R} \rho_N(\xi) \log(2 + |\xi|) d\xi \le \text{mass}(N) \cdot \left( \log 2 + \log\left(1 + \frac{E_N}{\text{mass}(N)}\right) + 1 \right),
   \]
   covering the zero-mass edge case without any extra hypotheses.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Measurability of the Fourier transform across R
theorem measurable_hat (N : ℕ) : Measurable (hat N)

-- Global L¹ integrability of the spectral density on R
theorem integrable_density {N : ℕ} (hN : 2 ≤ N) : Integrable (density N)

-- Grand whole-frequency logarithmic moment theorem
theorem actual_log_moment {N : ℕ} (hN : 2 ≤ N) :
    Integrable (fun ξ : ℝ => density N ξ * Real.log (2 + |ξ|)) ∧
    (∫ ξ : ℝ, density N ξ * Real.log (2 + |ξ|)) ≤
      mass N * (Real.log 2 + Real.log (1 + envelope N / mass N) + 1)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 establishing a rigorous whole-frequency logarithmic moment bound $\int_\mathbb{R} \rho_N(\xi) \log(2 + |\xi|) d\xi \le M_N (\log 2 + \log(1 + E_N/M_N) + 1)$ for the actual prime-counting spectral density without artificial frequency truncation or conditional assumptions.
