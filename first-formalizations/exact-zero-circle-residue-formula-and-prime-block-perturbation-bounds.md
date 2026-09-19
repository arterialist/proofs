# First Formalization: Exact Zero-Circle Residue Formula and Prime-Block Perturbation Bounds

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ActualZeroCircleResidues.lean`](../../formalization/BuildingBlocks/ActualZeroCircleResidues.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact contour circle integral residue formula for logarithmic derivatives of analytic functions, its specialization to Riemann's $\xi$ and $\zeta$, the prime-block paired evaluation, and quantitative error bounds in Lean 4:

1. **Circle Integral Log-Derivative Residue Formula:**
   Formal proof of $\oint_{C(s, R)} F(w) \frac{f'(w)}{f(w)} dw = 2\pi i \cdot m \cdot F(s)$ for analytic $f$ with zero order $m$ (`analytic_zero_circle_coefficient`).
2. **Residue Evaluation for $\xi$ and $\zeta$:**
   Formal proof of contour circle integrals extracting the exact zero order of $\xi$ and $\zeta$ (`xi_zero_circle_coefficient`, `zeta_zero_circle_coefficient`).
3. **Prime-Block Centered Residue Evaluation:**
   Formal derivation of circle integrals under physical prime-block action factoring out the Euler product $\prod \mathcal{P}_p$ (`finite_prime_block_xi_circle_coefficient`, `finite_prime_block_zeta_circle_coefficient`).
4. **Exact Perturbation Difference and Exponential Bounds:**
   Formal proof of exact signed difference (`finite_prime_block_signed_circle_difference`) and sharp exponential comparison bound in the strip interior (`finite_prime_block_circle_comparison`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- General analytic circle integral formula
theorem analytic_zero_circle_coefficient (f : ℂ → ℂ) (s : ℂ)
    (hf : AnalyticAt ℂ f s) (hfinite : analyticOrderAt f s ≠ ⊤) :
    ∃ ε : ℝ, 0 < ε ∧ ∀ (F : ℂ → ℂ), Differentiable ℂ F →
      ∀ R : ℝ, 0 < R → R < ε →
        (∮ w in C(s, R), F w * logDeriv f w) =
          (2 * Real.pi * Complex.I) * (analyticOrderNatAt f s : ℂ) * F s

-- Specialization to Riemann xi function
theorem xi_zero_circle_coefficient (s : ℂ) :
    ∃ ε : ℝ, 0 < ε ∧ ∀ (F : ℂ → ℂ), Differentiable ℂ F →
      ∀ R : ℝ, 0 < R → R < ε →
        (∮ w in C(s, R), F w * logDeriv xi w) =
          (2 * Real.pi * Complex.I) * (analyticOrderNatAt xi s : ℂ) * F s

-- Specialization to Riemann zeta function
theorem zeta_zero_circle_coefficient (s : ℂ) (hs : 0 < s.re) (hs1 : s ≠ 1) :
    ∃ ε : ℝ, 0 < ε ∧ ∀ (F : ℂ → ℂ), Differentiable ℂ F →
      ∀ R : ℝ, 0 < R → R < ε →
        (∮ w in C(s, R), F w * logDeriv riemannZeta w) =
          (2 * Real.pi * Complex.I) * (analyticOrderNatAt xi s : ℂ) * F s

-- Signed perturbation difference formula
theorem finite_prime_block_signed_circle_difference {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g) (s : ℂ) (hs : 0 < s.re) (hs1 : s ≠ 1) :
    ∃ ε : ℝ, 0 < ε ∧ ∀ (primes : Finset ℕ), (∀ p ∈ primes, 2 ≤ p) →
      ∀ (M : ℕ) (R : ℝ), 0 < R → R < ε →
        (∮ w in C(s, R), BuildingBlocks.ActualPhysicalResidues.centeredWeight
          (blockPhysical primes.toList M f) (blockPhysical primes.toList M g) w *
            logDeriv riemannZeta w) -
        (∮ w in C(s, R), BuildingBlocks.ActualPhysicalResidues.centeredWeight f g w *
          logDeriv riemannZeta w) =
          (2 * Real.pi * Complex.I) * (analyticOrderNatAt xi s : ℂ) *
            ((∏ p ∈ primes, BuildingBlocks.GrowingPrimeScatteringBounds.paired p (s - 1 / 2) M) - 1) *
              BuildingBlocks.ActualPhysicalResidues.centeredWeight f g s

-- Quantitative interior strip comparison bound
theorem finite_prime_block_circle_comparison {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g) (s : ℂ) (hs : 0 < s.re) (hs1 : s ≠ 1)
    (delta : ℝ) (hd : 0 < delta) (hz : |(s - 1 / 2).re| ≤ 1 / 2 - delta) :
    ∃ ε : ℝ, 0 < ε ∧ ∀ (primes : Finset ℕ), (∀ p ∈ primes, 2 ≤ p) →
      ∀ (M : ℕ) (R : ℝ), 0 < R → R < ε →
        ‖(∮ w in C(s, R), BuildingBlocks.ActualPhysicalResidues.centeredWeight
          (blockPhysical primes.toList M f) (blockPhysical primes.toList M g) w *
            logDeriv riemannZeta w) -
        (∮ w in C(s, R), BuildingBlocks.ActualPhysicalResidues.centeredWeight f g w *
          logDeriv riemannZeta w)‖ ≤
          ‖(2 * Real.pi * Complex.I) * (analyticOrderNatAt xi s : ℂ)‖ *
            ‖BuildingBlocks.ActualPhysicalResidues.centeredWeight f g s‖ *
              (Real.exp (∑ p ∈ primes,
                let B := Real.exp (-(M : ℝ) * delta * Real.log (p : ℝ)) /
                  (1 - Real.exp (-delta * Real.log (p : ℝ)))
                2 * B + B ^ 2) - 1)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving exact zero-circle residue formulas $\oint F \frac{\zeta'}{\zeta} = 2\pi i m F(s)$ paired with multi-prime scattering operators and quantitative interior strip perturbation bounds.
