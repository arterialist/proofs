# First Formalization: Exact Goldbach Three-Phase Fourier Reconstruction of Chebyshev Prime Error

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/GoldbachThreePhaseFourier.lean`](../../formalization/BuildingBlocks/GoldbachThreePhaseFourier.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact identification of continuous angular Fourier integrals of the parity-centered Goldbach triangle with algebraic three-adic harmonics, and proves the exact Fourier inversion formula reconstructing the Chebyshev prime error in Lean 4:

1. **Completely Multiplicative 3-Adic Phase:**
   Formal proof of `threeComplexPhase_mul`: $\chi_3(mn, \theta) = \chi_3(m, \theta) \chi_3(n, \theta)$.
2. **Hermitian Real Goldbach Triangle:**
   Formal proof of `complexCenteredGoldbach_im_zero`: $\text{Im}(G_N(\theta)) = 0$, and `complexCenteredGoldbach_re`: Real part matches the angular biphase sum.
3. **Exact Trigonometric Integrals:**
   Formal proof of `integral_cos_integer_frequency`, `integral_cosine_first_frequency`, and `pair_cosine_first_frequency`.
4. **Harmonic Projection Identity:**
   Formal proof of `threeAngularHarmonic_eq`: The continuous angular integral $\frac{1}{\pi} \int_0^{2\pi} G_N(\theta) \cos \theta \, d\theta$ equals the algebraic first harmonic.
5. **Chebyshev Error Inversion Formulas:**
   Formal proof of `threeAngularHarmonic_prime_error` and `actual_prime_error_from_complex_angular_harmonic`: Exact reconstruction of $\psi(2k+3) - (2k+3)$ from the continuous Fourier coefficient.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Multiplicative phase property
theorem threeComplexPhase_mul {m n : ℕ}
    (hm : m ≠ 0) (hn : n ≠ 0) (θ : ℝ) :
    threeComplexPhase (m * n) θ =
      threeComplexPhase m θ * threeComplexPhase n θ

-- Real-valued nature of centered Goldbach triangle
theorem complexCenteredGoldbach_im_zero (N : ℕ) (θ : ℝ) :
    (complexCenteredGoldbach N θ).im = 0

-- Angular integral matches algebraic first harmonic
theorem threeAngularHarmonic_eq (N : ℕ) :
    threeAngularHarmonic N = threeFirstHarmonic N

-- Angular harmonic prime error relation
theorem threeAngularHarmonic_prime_error (k : ℕ) :
    threeAngularHarmonic (2 * k + 6) =
      2 * Real.log 3 *
        (BuildingBlocks.psi (2 * k + 3) - (2 * k + 3 : ℝ) -
          Real.log 2 * (Nat.log 2 (2 * k + 3) : ℝ) - 1 -
            Real.log 3 * ((lateThreeLadder (2 * k + 6)).card : ℝ))

-- Direct inversion from the continuous complex Fourier integral
theorem actual_prime_error_from_complex_angular_harmonic (k : ℕ) :
    BuildingBlocks.psi (2 * k + 3) - (2 * k + 3 : ℝ) =
      complexAngularHarmonic (2 * k + 6) / (2 * Real.log 3) +
        Real.log 2 * (Nat.log 2 (2 * k + 3) : ℝ) + 1 +
          Real.log 3 * ((lateThreeLadder (2 * k + 6)).card : ℝ)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving that continuous angular Fourier integrals of finite Goldbach triangles invert into the exact discrete Chebyshev prime error without asymptotic or minor-arc errors.
