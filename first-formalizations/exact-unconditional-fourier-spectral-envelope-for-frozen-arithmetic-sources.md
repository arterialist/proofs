# First Formalization: Exact Unconditional Fourier-Spectral Envelope for Frozen Arithmetic Sources

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ChargeFrozenSpectralBound.lean`](../../formalization/BuildingBlocks/ChargeFrozenSpectralBound.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact unconditional Fourier-spectral decay envelope for the frozen causal arithmetic source in Lean 4:

1. **Critical Line Mellin Modulus:**
   Formal proof that $\|x^{-w(\xi)}\| = x^{-1/2}$ for $w(\xi) = 1/2 + i\xi$ (`norm_mellin_atom`).
2. **Chebyshev-Mertens Prime Power Sum Bound:**
   Formal proof of $\|\sum_{n=2}^N \Lambda(n) n^{-w(\xi)}\| \le (8\log 2) N^{1/2}$ (`norm_prime_sum_le`).
3. **Continuous Background Density Bound:**
   Formal proof of $\|\int_1^N x^{-w(\xi)} dx\| \le 2(N^{1/2} - 1)$ (`norm_density_integral_le`).
4. **Critical Mellin Numerator Majorant:**
   Formal proof bounding the combined numerator by $(8\log 2 + 2) N^{1/2}$ (`norm_mellin_numerator_le`).
5. **Denominator Modulus Identity:**
   Formal proof that $\|w(\xi)\|^2 = 1/4 + \xi^2$ (`w_norm_sq`).
6. **Universal Unconditional Spectral Envelope:**
   Formal proof that $\|\widehat{\text{causalSource}}(N, \xi)\|^2 \le \frac{4 (8 \log 2 + 2)^2 N}{1 + \xi^2}$ holding uniformly for all real frequencies $\xi \in \mathbb{R}$ without zero-free hypotheses (`fourier_norm_sq_le`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Modulus on the critical line
theorem norm_mellin_atom {x : ℝ} (hx : 0 < x) (ξ : ℝ) :
    ‖(x : ℂ) ^ (-w ξ)‖ = x ^ (-(1 / 2 : ℝ))

-- Weighted prime sum bound
theorem norm_prime_sum_le {N : ℕ} (hN : 2 ≤ N) (ξ : ℝ) :
    ‖∑ n ∈ Finset.Icc 2 N, (ArithmeticFunction.vonMangoldt n : ℂ) *
      (n : ℂ) ^ (-w ξ)‖ ≤ (8 * Real.log 2) * (N : ℝ) ^ (1 / 2 : ℝ)

-- Continuous density integral bound
theorem norm_density_integral_le {N : ℕ} (hN : 1 ≤ N) (ξ : ℝ) :
    ‖∫ x : ℝ in (1 : ℝ)..(N : ℝ), (x : ℂ) ^ (-w ξ)‖ ≤
      2 * ((N : ℝ) ^ (1 / 2 : ℝ) - 1)

-- Critical Mellin numerator bound
theorem norm_mellin_numerator_le {N : ℕ} (hN : 2 ≤ N) (ξ : ℝ) :
    ‖-1 + (∑ n ∈ Finset.Icc 2 N, (ArithmeticFunction.vonMangoldt n : ℂ) *
      (n : ℂ) ^ (-w ξ)) -
      (∫ x : ℝ in (1 : ℝ)..(N : ℝ), (x : ℂ) ^ (-w ξ))‖ ≤
      (8 * Real.log 2 + 2) * (N : ℝ) ^ (1 / 2 : ℝ)

-- Exact denominator modulus
theorem w_norm_sq (ξ : ℝ) : ‖w ξ‖ ^ 2 = 1 / 4 + ξ ^ 2

-- Unconditional Fourier-spectral envelope
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

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 establishing an explicit, unconditional quadratic spectral envelope $O(N/(1+\xi^2))$ for the Fourier transform of the causal arithmetic charge source across all frequencies $\xi \in \mathbb{R}$.
