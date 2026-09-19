# First Formalization: Even Goldbach Three-Phase Fourier Reconstruction of Chebyshev Error

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/GoldbachThreePhaseFourier.lean`](../../formalization/BuildingBlocks/GoldbachThreePhaseFourier.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This entry documents a machine-verified proof of exact Fourier extraction for the even Goldbach triangle with completely multiplicative 3-adic phase, and its inversion to the Chebyshev prime error:

1. **Multiplicative Character Properties:**
   Formal proof that $\chi_3(mn, \theta) = \chi_3(m, \theta) \chi_3(n, \theta)$ (`threeComplexPhase_mul`), $\chi_3(3^j, \theta) = e^{i j \theta}$ (`threeComplexPhase_three_pow`), and $\chi_3(p, \theta) = 1$ for all primes $p \ne 3$ (`threeComplexPhase_other_prime`).
2. **Algebraic Harmonic Identity:**
   Formal proof that the continuous angular integral $H_1(N) = \frac{1}{\pi} \int_0^{2\pi} \operatorname{complexCenteredGoldbach}(N, \theta) \cos \theta \, d\theta$ equals the discrete algebraic harmonic `threeFirstHarmonic` (`threeAngularHarmonic_eq`).
3. **Chebyshev Error Reconstruction:**
   Formal identity relating $H_1(2k+6)$ directly to $2 \log 3 (\psi(2k+3) - (2k+3) - \dots)$ (`threeAngularHarmonic_prime_error`, `complexAngularHarmonic_prime_error`).
4. **Exact Non-Asymptotic Inversion:**
   Formal proof of the explicit reconstruction formula for $\psi(2k+3) - (2k+3)$ from the complex angular harmonic (`actual_prime_error_from_complex_angular_harmonic`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Algebraic harmonic evaluation
theorem threeAngularHarmonic_eq (N : ℕ) :
    threeAngularHarmonic N = threeFirstHarmonic N

-- Harmonic relation to prime error
theorem complexAngularHarmonic_prime_error (k : ℕ) :
    complexAngularHarmonic (2 * k + 6) =
      2 * Real.log 3 *
        (BuildingBlocks.psi (2 * k + 3) - (2 * k + 3 : ℝ) -
          Real.log 2 * (Nat.log 2 (2 * k + 3) : ℝ) - 1 -
            Real.log 3 * ((lateThreeLadder (2 * k + 6)).card : ℝ))

-- Exact inversion to Chebyshev error
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

This entry documents a machine-verified identity connecting the additive Goldbach problem directly to the prime number theorem's error term $\psi(X) - X$ via 3-adic multiplicative Fourier harmonics.
