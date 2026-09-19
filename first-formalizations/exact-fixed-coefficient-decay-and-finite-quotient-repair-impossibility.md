# First Formalization: Exact Fixed-Coefficient Decay and Finite-Quotient Repair Impossibility

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/FixedCoefficient.lean`](../../formalization/BuildingBlocks/FixedCoefficient.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes that no finite modification of the quotient dual coefficients can repair the $L^2(0, \infty)$ Cauchy property under Mertens oscillation in Lean 4:

1. **Window Moment Lower Bound:**
   Formal proof of `array_window_distance_lower`: $W_j(c, N)^2 / N \le 24(j+1)^4 \int_0^\infty (\Delta F)^2 dx$.
2. **Window Moment Asymptotic Vanishing:**
   Formal proof of `windowMoment_sq_tendsto_of_cauchy`: $W_j(c, N)^2 / N \to 0$ for all $j \ge 1$ whenever $c$ is Cauchy.
3. **Triangular Normalized Split:**
   Formal proof of `windowMoment_normalized_split`: triangular decomposition of $W_j / \sqrt{N}$ into strictly lower coefficients and $j \cdot c_N(j) / \sqrt{N}$.
4. **Universal Coefficient $\sqrt{N}$ Vanishing:**
   Formal proof of `fixed_coefficient_tendsto_of_cauchy`: $c_N(j)/\sqrt{N} \to 0$ by strong mathematical induction on $j$.
5. **Finite Quotient Repair Impossibility:**
   Formal proof of `finite_quotient_repair_not_cauchy` and `finite_quotient_repair_not_convergent`: modifying any finite initial block cannot produce Cauchy or convergent sequences in $L^2$.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Non-asymptotic window moment lower bound
theorem array_window_distance_lower (c : ℕ → ℕ → ℝ) {N M j : ℕ}
    (hM : 0 < M) (hj : 0 < j) (hNM : (j + 1) * M ≤ N) :
    windowMoment c N j ^ 2 / (N : ℝ) ≤ 24 * ((j : ℝ) + 1) ^ 4 *
      ∫ x in Set.Ioi (0 : ℝ), (arrayFraction c N x - arrayFraction c M x) ^ 2

-- Window moment decay
theorem windowMoment_sq_tendsto_of_cauchy (c : ℕ → ℕ → ℝ) (h : ArrayCauchy c)
    {j : ℕ} (hj : 0 < j) :
    Tendsto (fun N : ℕ => windowMoment c N j ^ 2 / (N : ℝ)) atTop (𝓝 0)

-- Inductive fixed coefficient decay
theorem fixed_coefficient_tendsto_of_cauchy (c : ℕ → ℕ → ℝ) (h : ArrayCauchy c)
    {j : ℕ} (hj : 0 < j) :
    Tendsto (fun N : ℕ => c N j / Real.sqrt (N : ℝ)) atTop (𝓝 0)

-- Impossibility of Cauchy property under finite repair
theorem finite_quotient_repair_not_cauchy (c : ℕ → ℕ → ℝ) (K : ℕ)
    (heq : ∀ᶠ N : ℕ in atTop, ∀ q, K < q → q ≤ N → c N q = (quotientCoefficient N q : ℝ))
    (hM : ¬ Tendsto (fun N : ℕ => (mertens N : ℝ) ^ 2 / (N : ℝ)) atTop (𝓝 0)) :
    ¬ ArrayCauchy c

-- Impossibility of convergence to any target limit
theorem finite_quotient_repair_not_convergent (c : ℕ → ℕ → ℝ) (K : ℕ) (g : ℝ → ℝ)
    (heq : ∀ᶠ N : ℕ in atTop, ∀ q, K < q → q ≤ N → c N q = (quotientCoefficient N q : ℝ))
    (hI : ∀ N : ℕ, 0 < N →
      IntegrableOn (fun x => (arrayFraction c N x - g x) ^ 2) (Set.Ioi (0 : ℝ)))
    (hM : ¬ Tendsto (fun N : ℕ => (mertens N : ℝ) ^ 2 / (N : ℝ)) atTop (𝓝 0)) :
    ¬ Tendsto (fun N : ℕ =>
      ∫ x in Set.Ioi (0 : ℝ), (arrayFraction c N x - g x) ^ 2) atTop (𝓝 0)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified proof in Lean 4 demonstrating that the Mertens oscillation obstruction cannot be bypassed by any finite-rank modifications to the quotient array coefficients.
