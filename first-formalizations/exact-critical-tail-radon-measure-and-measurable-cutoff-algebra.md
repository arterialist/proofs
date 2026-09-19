# First Formalization: Exact Critical Tail Radon Measure and Measurable Cutoff Algebra

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ActualCriticalMeasure.lean`](../../formalization/BuildingBlocks/ActualCriticalMeasure.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the Borel measurability of floor-cutoff sums, the construction of the non-negative critical tail Radon measure, the mass-to-Mellin-norm identity, and the non-emptiness of the Laplace convergence set in Lean 4:

1. **Measurability of Floor Cutoffs:**
   Formal proof that $x \mapsto \sum_{n < \lfloor x \rfloor} F(n, x)$ is measurable, establishing measurability of $W$ and its negative tail (`measurable_cutoff`, `measurable_W`, `measurable_negativeWTail`).
2. **Construction of Critical Tail Measure:**
   Formal definition of non-negative density $\rho_A(x)$ and measure $\mu_A$ on $(1, \infty)$ (`tailDensity`, `tailMeasure`, `measurable_tailDensity`).
3. **Mass-to-Norm Identity:**
   Formal proof that the Laplace mass equals the $L^1$ Bochner norm of the Mellin integrand (`laplace_mass_eq_norm`, `real_weight_identity`, `density_exp_eq_enorm`).
4. **Non-Empty Convergence Set:**
   Formal proof that $\sigma = 2$ belongs to the Laplace convergence set (`laplace_integrable`, `convergenceSet_nonempty`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Measurability of floor sums
theorem measurable_cutoff (F : ℕ → ℝ → ℂ) (hF : ∀ n, Measurable (F n)) :
    Measurable (fun x : ℝ => ∑ n ∈ Finset.range ⌊x⌋₊, F n x)

-- Measurability of critical aggregation W
theorem measurable_W : Measurable ActualCriticalMellin.W

-- Power-exponential weight identity
lemma real_weight_identity {x : ℝ} (hx : 0 < x) (σ : ℝ) :
    x ^ (-2 : ℝ) * Real.exp (-σ * Real.log x) = x ^ (-σ - 2)

-- Laplace mass equals Mellin L^1 norm
theorem laplace_mass_eq_norm {A : ℝ}
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0) (σ : ℝ) :
    LaplaceConvergenceAbscissa.mass (tailMeasure A) time σ =
      ∫⁻ x : ℝ in Ioi 1, ‖(x : ℂ) ^ (-(σ : ℂ) - 2) *
        MellinCompactCorrection.negativeWTail A x‖ₑ

-- Laplace integrability on Re(s) > 1
theorem laplace_integrable {A : ℝ} (hA : 1 ≤ A)
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0)
    {σ : ℝ} (hσ : 1 < σ) :
    Integrable (fun x => Real.exp (-σ * time x)) (tailMeasure A)

-- Non-emptiness of convergence set
theorem convergenceSet_nonempty {A : ℝ} (hA : 1 ≤ A)
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0) :
    (LaplaceConvergenceAbscissa.convergenceSet (tailMeasure A) time).Nonempty
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 establishing the Borel measurability of arithmetic floor-cutoff sums and constructing the non-negative Radon measure with verified mass-to-Mellin-norm equivalence.
