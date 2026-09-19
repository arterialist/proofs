# First Formalization: Exact Causal Source Fourier-Mellin Representation and Critical Dirichlet Discrepancy

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ChargeFrozenFourier.lean`](../../formalization/BuildingBlocks/ChargeFrozenFourier.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact harmonic Fourier-Mellin identity connecting the time-domain causal source to the critical-line Dirichlet polynomial discrepancy in Lean 4:

1. **Atomic and Centering Decomposition:**
   Formal proof of `causalSource_eq_atoms_sub_centering`: $\text{causalSource}(N, v) = \sum_{n=2}^N \Lambda(n)\beta_n(v) - \text{centering}(N, v)$.
2. **Atomic Fourier Transform:**
   Formal proof of `beta_fourier_integral`: $\int_\mathbb{R} e^{-i\xi v} \beta_n(v) dv = \frac{n^{-w(\xi)}}{w(\xi)}$ where $w(\xi) = 1/2 + i\xi$.
3. **Centering Fourier Transform and Mellin Integral:**
   Formal proof of `centering_fourier_integral` and `density_mellin_integral`: $\int_1^N x^{-w} dx = \frac{N^{1-w}-1}{1-w}$.
4. **Grand Closed-Form Fourier-Mellin Theorem:**
   Formal proof of `causalSource_fourier_mellin`:
   \[
   \int_\mathbb{R} e^{-i\xi v} \text{causalSource}(N, v) dv = \frac{-1 + \sum_{n=2}^N \Lambda(n) n^{-w(\xi)} - \int_1^N x^{-w(\xi)} dx}{w(\xi)}.
   \]

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Decomposition of the causal source into atoms and centering
theorem causalSource_eq_atoms_sub_centering {N : ℕ} (hN : 2 ≤ N) (v : ℝ) :
    causalSource N v =
      (∑ n ∈ Finset.Icc 2 N, ArithmeticFunction.vonMangoldt n * beta n v) -
        centering N v

-- Exact Fourier transform of each prime-power birth atom
theorem beta_fourier_integral {n : ℕ} (hn : 0 < n) (ξ : ℝ) :
    (∫ v : ℝ, Complex.exp (-Complex.I * (ξ : ℂ) * (v : ℂ)) * (beta n v : ℂ)) =
      Complex.exp (-w ξ * (Real.log (n : ℝ) : ℂ)) / w ξ

-- Exact Fourier transform of continuous background centering
theorem centering_fourier_integral {N : ℕ} (hN : 1 ≤ N) (ξ : ℝ) :
    (∫ v : ℝ, Complex.exp (-Complex.I * (ξ : ℂ) * (v : ℂ)) * (centering N v : ℂ)) =
      (Complex.exp ((1 - w ξ) * (Real.log (N : ℝ) : ℂ)) - 1) / (1 - w ξ) +
        (N : ℂ) * Complex.exp (-w ξ * (Real.log (N : ℝ) : ℂ)) / w ξ

-- Grand closed-form Fourier-Mellin formula for the arithmetic source
theorem causalSource_fourier_mellin {N : ℕ} (hN : 2 ≤ N) (ξ : ℝ) :
    (∫ v : ℝ, Complex.exp (-Complex.I * (ξ : ℂ) * (v : ℂ)) * (causalSource N v : ℂ)) =
      (-1 + (∑ n ∈ Finset.Icc 2 N, (ArithmeticFunction.vonMangoldt n : ℂ) *
        (n : ℂ) ^ (-w ξ)) -
        (∫ x : ℝ in (1 : ℝ)..(N : ℝ), (x : ℂ) ^ (-w ξ))) / w ξ
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 of the exact closed-form Fourier-Mellin transform connecting the real-line causal arithmetic step function directly to the critical-line Dirichlet polynomial discrepancy $\frac{-1 + \sum_{n \le N} \Lambda(n) n^{-(1/2+i\xi)} - \int_1^N x^{-(1/2+i\xi)} dx}{1/2 + i\xi}$.
