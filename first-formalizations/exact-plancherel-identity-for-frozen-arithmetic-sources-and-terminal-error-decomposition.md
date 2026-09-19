# First Formalization: Exact Plancherel Identity for Frozen Arithmetic Sources and Terminal Error Decomposition

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ChargeFrozenPlancherel.lean`](../../formalization/BuildingBlocks/ChargeFrozenPlancherel.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact real-line Plancherel identity, autocorrelation convolution identification, and terminal prime error decomposition for arithmetic sources in Lean 4:

1. **Autocorrelation Convolution and Fourier Transform:**
   Formal proof that $\text{complexCorrelation}(N, h) = (f * \tilde{f})(-h)$ (`complexCorrelation_eq_convolution`) and its angular Fourier transform equals $\rho_N(\xi)$ (`transform_complexCorrelation`).
2. **Mathlib Fourier Inversion at Origin:**
   Formal proof of Fourier inversion for the autocorrelation function and the exact Plancherel identity $\text{mass}(N) = 2\pi \int_{-\infty}^\infty (\text{causalSource}(N, v))^2 dv$ (`mass_eq_physical_norm`).
3. **Prefix and Terminal Boundary Splitting:**
   Formal proof of the exact decomposition $\text{mass}(N) = 2\pi (\int_0^{\log N} (\text{causalSource})^2 + \frac{(\psi(N)-N)^2}{N})$ (`mass_eq_prefix_terminal`).
4. **Physical Layer-Cake Bound:**
   Formal proof of `actual_log_moment_physical` bounding the logarithmic spectral moment by the physical $L^2$ energy.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Autocorrelation transform equals arithmetic spectral density
theorem transform_complexCorrelation (N : ℕ) (ξ : ℝ) :
    transform (complexCorrelation N) ξ = (density N ξ : ℂ)

-- Real-line Plancherel identity for the arithmetic causal source
theorem mass_eq_physical_norm {N : ℕ} (hN : 2 ≤ N) :
    mass N = (2 * Real.pi) * ∫ v : ℝ, (causalSource N v) ^ 2

-- Exact prefix and terminal error decomposition
theorem mass_eq_prefix_terminal {N : ℕ} (hN : 2 ≤ N) :
    mass N = (2 * Real.pi) *
      ((∫ v in Set.Ioc 0 (Real.log (N : ℝ)), (causalSource N v) ^ 2) +
        (CoarsePrimitive.psi N - (N : ℝ)) ^ 2 / (N : ℝ))

-- Non-asymptotic logarithmic moment bound via physical L² norm
theorem actual_log_moment_physical {N : ℕ} (hN : 2 ≤ N) :
    Integrable (fun ξ : ℝ => density N ξ * Real.log (2 + |ξ|)) ∧
    (∫ ξ : ℝ, density N ξ * Real.log (2 + |ξ|)) ≤
      ((2 * Real.pi) * ∫ v : ℝ, (causalSource N v) ^ 2) *
        (Real.log 2 + Real.log (1 + envelope N /
          ((2 * Real.pi) * ∫ v : ℝ, (causalSource N v) ^ 2)) + 1)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 proving the exact real-line Plancherel identity $\text{mass}(N) = 2\pi \|\text{causalSource}(N)\|_{L^2}^2$ via Fourier inversion of the autocorrelation function, along with its explicit terminal boundary decomposition into prefix dispersion and the normalized terminal error $\frac{(\psi(N)-N)^2}{N}$.
