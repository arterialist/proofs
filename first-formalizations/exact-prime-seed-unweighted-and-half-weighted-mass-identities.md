# First Formalization: Exact Prime Seed Unweighted and Half-Weighted Mass Identities

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/PrimeSeedMass.lean`](../../formalization/BuildingBlocks/PrimeSeedMass.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the clock-cell partition architecture, the exact unweighted seed mass $\int_{\mathbb{R}} \text{seed}_{\log p} = \frac{2}{p}$, and the half-weighted Dirichlet seed mass $\int_{\mathbb{R}} e^{-v/2}\text{seed}_{\log p} = \frac{\log p}{p(p-1)}$ in Lean 4:

1. **Clock-Cell Partition Decomposition:**
   Formal proof that non-negative causal functions with summable cell integrals are globally integrable (`integral_of_clock_cells`).
2. **Total Unweighted Mass:**
   Formal proof that $\int_{\mathbb{R}} \text{seed}_L(v) \, dv = 2 e^{-L}$ and $\int_{\mathbb{R}} \text{seed}_{\log p}(v) \, dv = \frac{2}{p}$ (`integrable_seed_and_integral`, `integral_prime_seed`).
3. **Half-Weighted Mass and Classical Dirichlet Matching:**
   Formal proof that $\int_{\mathbb{R}} e^{-v/2}\text{seed}_L(v) \, dv = \frac{L e^{-2L}}{1 - e^{-L}}$ and $\int_{\mathbb{R}} e^{-v/2}\text{seed}_{\log p}(v) \, dv = \frac{\log p}{p(p-1)}$ (`integrable_weighted_seed_and_integral`, `integral_prime_weighted_seed`).
4. **Power-Floor Identification:**
   Formal proof of pointwise equivalence with the published floor formula (`seed_log_eq`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Pointwise equivalence with power-floor formula
theorem seed_log_eq {p : ℝ} (hp : 0 < p) (v : ℝ) :
    seed (log p) v = if log p ≤ v then
      exp (v / 2) / p ^ (⌊v / log p⌋₊ + 1) else 0

-- Clock-cell decomposition architecture
theorem integral_of_clock_cells {L M : ℝ} {f : ℝ → ℝ} (hL : 0 < L)
    (hnonneg : ∀ v, 0 ≤ f v) (hzero : ∀ v < L, f v = 0)
    (hi : ∀ j : ℕ, IntegrableOn f
      (Set.Ico ((j + 1 : ℝ) * L) ((j + 2 : ℝ) * L)))
    (hs : HasSum (fun j : ℕ => ∫ v in
      Set.Ico ((j + 1 : ℝ) * L) ((j + 2 : ℝ) * L), f v) M) :
    Integrable f ∧ (∫ v, f v) = M

-- Unweighted total seed mass
theorem integrable_seed_and_integral {L : ℝ} (hL : 0 < L) :
    Integrable (seed L) ∧ (∫ v, seed L v) = 2 * exp (-L)

theorem integral_prime_seed {p : ℝ} (hp : 1 < p) :
    (∫ v, seed (log p) v) = 2 / p

-- Half-weighted Dirichlet mass
theorem integrable_weighted_seed_and_integral {L : ℝ} (hL : 0 < L) :
    Integrable (fun v => exp (-v / 2) * seed L v) ∧
      (∫ v, exp (-v / 2) * seed L v) =
        L * exp (-L) ^ 2 / (1 - exp (-L))

theorem integral_prime_weighted_seed {p : ℝ} (hp : 1 < p) :
    (∫ v, exp (-v / 2) * seed (log p) v) = log p / (p * (p - 1))
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 proving that continuous causal prime seeds integrate to $\frac{2}{p}$ (unweighted) and $\frac{\log p}{p(p-1)}$ (half-weighted), linking continuous semigroup dynamics to classical Dirichlet prime-power coefficients.
