# First Formalization: Exact Joint-Mellin Principal Part at Arbitrary-Multiplicity Zeta Zeros

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ZetaPole.lean`](../../formalization/BuildingBlocks/ZetaPole.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the analytic continuation, global non-vanishing, logarithmic derivative Laurent expansion, and the exact residue $-m/\rho$ of the joint Mellin transform at any zeta zero in Lean 4:

1. **Zeta Analyticity Off Pole:**
   Formal proof that $\zeta(s)$ is analytic on $\mathbb{C} \setminus \{1\}$ (`zeta_analytic_off_pole`).
2. **Global Non-Vanishing:**
   Formal deduction that $\zeta(s)$ is not locally zero around any $s \ne 1$ via domain connectedness and $\zeta(2) \ne 0$ (`zeta_not_locally_zero`).
3. **Logarithmic Derivative Principal Part:**
   Formal derivation of $\frac{f'(z)}{f(z)} = \frac{m}{z - \rho} + a(z)$ for any non-trivial zero of multiplicity $m \ge 1$ (`analytic_logDerivative_principal_part`).
4. **Joint Mellin Principal Part and Residue:**
   Formal derivation of the exact Laurent expansion $\mathcal{M}(s) = \frac{-m/\rho}{s - \rho} + A(s)$ and residue limit $\lim_{s \to \rho} (s - \rho)\mathcal{M}(s) = -m/\rho \ne 0$ (`zeta_jointMellin_principal_part`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Analyticity of zeta away from s = 1
theorem zeta_analytic_off_pole :
    AnalyticOnNhd ℂ riemannZeta ({1}ᶜ : Set ℂ)

-- Non-identity-zero of zeta
theorem zeta_not_locally_zero {s : ℂ} (hs : s ≠ 1) :
    ¬ ∀ᶠ z in 𝓝 s, riemannZeta z = 0

-- Laurent principal part of logarithmic derivatives
theorem analytic_logDerivative_principal_part {f : ℂ → ℂ} {ρ : ℂ}
    (hf : AnalyticAt ℂ f ρ) (hn : ¬ ∀ᶠ z in 𝓝 ρ, f z = 0)
    (hzero : f ρ = 0) :
    ∃ m : ℕ, 0 < m ∧ ∃ a : ℂ → ℂ, AnalyticAt ℂ a ρ ∧
      ∀ᶠ z in 𝓝[≠] ρ, deriv f z / f z = (m : ℂ) / (z - ρ) + a z

-- Exact joint Mellin principal part and non-zero residue
theorem zeta_jointMellin_principal_part {ρ : ℂ} (hρ0 : ρ ≠ 0) (hρ1 : ρ ≠ 1)
    (hzero : riemannZeta ρ = 0) :
    ∃ m : ℕ, 0 < m ∧ ∃ a : ℂ → ℂ, AnalyticAt ℂ a ρ ∧
      (∀ᶠ s in 𝓝[≠] ρ,
        -deriv riemannZeta s / (s * riemannZeta s) - 1 / (s - 1) +
          (2 * (Real.eulerMascheroniConstant : ℂ)) / s =
        (-(m : ℂ) / ρ) / (s - ρ) + a s) ∧
      Tendsto (fun s : ℂ => (s - ρ) *
        (-deriv riemannZeta s / (s * riemannZeta s) - 1 / (s - 1) +
          (2 * (Real.eulerMascheroniConstant : ℂ)) / s))
        (𝓝[≠] ρ) (𝓝 (-(m : ℂ) / ρ)) ∧ -(m : ℂ) / ρ ≠ 0
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 establishing the exact Laurent principal part and residue $-m/\rho$ of the joint arithmetic Mellin operator at any zeta zero without assuming zero simplicity.
