# First Formalization: Exact Unconditional Cauchy-Lorentz Spectral Envelope for Arithmetic Sources

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ChargeFrozenSpectralBound.lean`](../../formalization/BuildingBlocks/ChargeFrozenSpectralBound.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the unconditional, uniform Cauchy-Lorentz spectral decay envelope for the Fourier transform of the causal arithmetic source in Lean 4:

1. **Critical Line Mellin Atom Modulus:**
   Formal proof of `norm_mellin_atom`: $\|x^{-w(\xi)}\| = x^{-1/2}$ for any base $x > 0$.
2. **Unconditional Prime Sum Modulus Bound:**
   Formal proof of `norm_prime_sum_le`: $\|\sum_{n=2}^N \Lambda(n) n^{-w(\xi)}\| \le (8 \log 2) \sqrt{N}$.
3. **Continuous Background Density Bound:**
   Formal proof of `norm_density_integral_le`: $\|\int_1^N x^{-w(\xi)} dx\| \le 2(\sqrt{N}-1)$.
4. **Discrepancy Numerator Modulus Bound:**
   Formal proof of `norm_mellin_numerator_le`: $\|\text{Numerator}\| \le (8 \log 2 + 2) \sqrt{N}$.
5. **Grand Cauchy-Lorentz Spectral Envelope:**
   Formal proof of `fourier_norm_sq_le`:
   $$
   \|\widehat{\text{causalSource}}(N, \xi)\|^2 \le \frac{4 (8 \log 2 + 2)^2 N}{1 + \xi^2}.
   $$

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Critical-line modulus of the Mellin character atom
theorem norm_mellin_atom {x : ℝ} (hx : 0 < x) (ξ : ℝ) :
    ‖(x : ℂ) ^ (-w ξ)‖ = x ^ (-(1 / 2 : ℝ))

-- Unconditional bound on the prime Dirichlet polynomial on the critical line
theorem norm_prime_sum_le {N : ℕ} (hN : 2 ≤ N) (ξ : ℝ) :
    ‖∑ n ∈ Finset.Icc 2 N, (ArithmeticFunction.vonMangoldt n : ℂ) *
      (n : ℂ) ^ (-w ξ)‖ ≤ (8 * Real.log 2) * (N : ℝ) ^ (1 / 2 : ℝ)

-- Unconditional bound on the continuous background density integral
theorem norm_density_integral_le {N : ℕ} (hN : 1 ≤ N) (ξ : ℝ) :
    ‖∫ x : ℝ in (1 : ℝ)..(N : ℝ), (x : ℂ) ^ (-w ξ)‖ ≤
      2 * ((N : ℝ) ^ (1 / 2 : ℝ) - 1)

-- Modulus squared of the denominator weight
theorem w_norm_sq (ξ : ℝ) : ‖w ξ‖ ^ 2 = 1 / 4 + ξ ^ 2

-- Grand uniform Cauchy-Lorentz spectral decay envelope
theorem fourier_norm_sq_le {N : ℕ} (hN : 2 ≤ N) (ξ : ℝ) :
    ‖∫ v : ℝ, Complex.exp (-Complex.I * (ξ : ℂ) * (v : ℂ)) *
      (causalSource N v : ℂ)‖ ^ 2 ≤
      4 * (8 * Real.log 2 + 2) ^ 2 * (N : ℝ) / (1 + ξ ^ 2)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving an unconditional, uniform $O(N/(1+\xi^2))$ Cauchy-Lorentz frequency decay envelope for the Fourier transform of the prime counting source function $\widehat{\text{causalSource}}(N, \xi)$ across all real frequencies $\xi \in \mathbb{R}$.
