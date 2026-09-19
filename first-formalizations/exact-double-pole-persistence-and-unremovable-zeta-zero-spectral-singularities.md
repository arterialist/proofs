# First Formalization: Exact Double Pole Persistence and Unremovable Zeta-Zero Spectral Singularities

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/LogDerivativePole.lean`](../../formalization/BuildingBlocks/LogDerivativePole.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the logarithmic derivative factorization, the general double pole persistence theorem under analytic subtractions, the finite positive analytic order of non-trivial zeta zeros, and the persistence of an unremovable double pole at any off-critical zeta zero in Lean 4:

1. **Logarithmic Residue Formula:**
   Formal proof that $f = (z - \rho)^m u \implies f'/f = \frac{m}{z - \rho} + u'/u$ (`logDeriv_of_factorization`).
2. **Double Pole Persistence Theorem:**
   Formal proof that $Q(z)(G(z)^2 - H(z))$ has exact meromorphic order $-2$ with non-zero trailing coefficient $Q(\rho) m^2$ (`double_pole_persistence`).
3. **Finite Analytic Multiplicity of Zeta Zeros:**
   Formal proof that $\zeta(\rho) = 0 \land \rho \ne 1 \implies \exists m \ge 1, \text{ord}_\rho(\zeta) = m$ (`zeta_zero_finite_order`).
4. **Persistence of Double Pole at Any Off-Critical Zero:**
   Formal proof that any hypothetical zero $\rho$ with $\text{Re}(\rho) > 1/2$ forces a non-zero double pole of order $-2$ in the regularized Mellin transform (`actual_zeta_zero_double_pole`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Logarithmic derivative factorization
theorem logDeriv_of_factorization {f u : ℂ → ℂ} {ρ : ℂ} {m : ℕ}
    (hu : AnalyticAt ℂ u ρ) (hu0 : u ρ ≠ 0)
    (hfactor : f =ᶠ[𝓝 ρ] fun z => (z - ρ) ^ m * u z) :
    logDeriv f =ᶠ[𝓝[≠] ρ] fun z => (m : ℂ) / (z - ρ) + logDeriv u z

-- Persistence of double pole after analytic subtraction
theorem double_pole_persistence {G R H Q : ℂ → ℂ} {ρ : ℂ} {m : ℕ}
    (hm : 1 ≤ m) (hR : AnalyticAt ℂ R ρ) (hH : AnalyticAt ℂ H ρ)
    (hQ : AnalyticAt ℂ Q ρ) (hQ0 : Q ρ ≠ 0)
    (hG : G =ᶠ[𝓝[≠] ρ] fun z => -(m : ℂ) / (z - ρ) + R z) :
    meromorphicOrderAt (fun z => Q z * (G z ^ 2 - H z)) ρ = (-2 : ℤ) ∧
      meromorphicTrailingCoeffAt (fun z => Q z * (G z ^ 2 - H z)) ρ = Q ρ * (m : ℂ) ^ 2

-- Finite positive order of zeta zeros
theorem zeta_zero_finite_order {ρ : ℂ} (hρ : ρ ≠ 1) (hz : riemannZeta ρ = 0) :
    ∃ m : ℕ, 1 ≤ m ∧ analyticOrderAt riemannZeta ρ = m

-- Double pole persistence at any off-critical zeta zero
theorem actual_zeta_zero_double_pole {ρ : ℂ} {H : ℂ → ℂ}
    (hρre : (1 : ℝ) / 2 < ρ.re) (hρ : ρ ≠ 1) (hz : riemannZeta ρ = 0)
    (hH : AnalyticAt ℂ H ρ) :
    ∃ m : ℕ, 1 ≤ m ∧ analyticOrderAt riemannZeta ρ = m ∧
      meromorphicOrderAt (fun s => ShiftedZetaMultiplier.M s *
        (centeredZetaLogDerivative s ^ 2 - H s)) ρ = (-2 : ℤ) ∧
      meromorphicTrailingCoeffAt (fun s => ShiftedZetaMultiplier.M s *
        (centeredZetaLogDerivative s ^ 2 - H s)) ρ =
          ShiftedZetaMultiplier.M ρ * (m : ℂ) ^ 2 ∧
      ShiftedZetaMultiplier.M ρ * (m : ℂ) ^ 2 ≠ 0
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 proving that any hypothetical off-critical zeta zero produces an unremovable double pole of order $-2$ in the squared centered logarithmic derivative under any analytic subtraction.
