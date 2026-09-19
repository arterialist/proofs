# First Formalization: Finite Prime-Block Zero Circle Residue Perturbation Bound

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ActualZeroCircleResidues.lean`](../../formalization/BuildingBlocks/ActualZeroCircleResidues.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact contour perturbation theory for logarithmic derivative integrals around arithmetic zeros under prime scattering blocks in Lean 4:

1. **General Analytic Zero Circle Residue Formula:**
   Formal proof that $\oint_{C(s, R)} F(w) \frac{f'(w)}{f(w)} dw = 2\pi i \operatorname{ord}_f(s) F(s)$ for small circles (`analytic_zero_circle_coefficient`).
2. **Specialization to $\xi$ and $\zeta$ Functions:**
   Formal deduction of circle integrals against $\frac{\xi'(w)}{\xi(w)}$ and $\frac{\zeta'(w)}{\zeta(w)}$ (`xi_zero_circle_coefficient`, `zeta_zero_circle_coefficient`).
3. **Exact Difference Identity for Prime Blocks:**
   Formal proof that the contour difference equals $2\pi i \operatorname{ord}_\xi(s) [ \prod \mathcal{P}_p - 1 ] W_c(s)$ (`finite_prime_block_signed_circle_difference`).
4. **Exponential Error Bound Inside the Critical Strip:**
   Formal verification that the contour perturbation is bounded by $2\pi \operatorname{ord}_\xi(s) |W_c(s)| (\exp(\sum (2B_p + B_p^2)) - 1)$ (`finite_prime_block_circle_comparison`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Logarithmic derivative circle integral
theorem analytic_zero_circle_coefficient (f : ℂ → ℂ) (s : ℂ)
    (hf : AnalyticAt ℂ f s) (hfinite : analyticOrderAt f s ≠ ⊤) :
    ∃ ε : ℝ, 0 < ε ∧ ∀ (F : ℂ → ℂ), Differentiable ℂ F →
      ∀ R : ℝ, 0 < R → R < ε →
        (∮ w in C(s, R), F w * logDeriv f w) =
          (2 * Real.pi * Complex.I) * (analyticOrderNatAt f s : ℂ) * F s

-- Exact signed circle difference for prime block scattering
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

-- Exponential perturbation bound inside the critical strip
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

This entry documents a machine-verified proof in Lean 4 bounding the contour integral perturbations of the logarithmic derivative of $\zeta(s)$ across zero circles under prime scattering, with explicit exponential decay rates.
