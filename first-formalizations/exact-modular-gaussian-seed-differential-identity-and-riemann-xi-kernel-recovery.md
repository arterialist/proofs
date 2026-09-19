# First Formalization: Exact Modular Gaussian Seed Differential Identity and Riemann Xi Kernel Recovery

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/PhysicalThetaSeed.lean`](../../formalization/BuildingBlocks/PhysicalThetaSeed.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact individual summand differential identity mapping the modular Gaussian seed $s_n(u) = e^{u/2} e^{-\pi n^2 e^{2u}}$ to the Riemann Xi kernel summand $\text{term}(n, u)$ under the shifted Helmholtz operator $\frac{d^2}{du^2} - \frac{1}{4}$ in Lean 4:

1. **Classical Summand Differentiation:**
   Formal proof of the first derivative $s_n'(u) = (1/2 - 2 a_n) s_n$ (`seed_hasDerivAt`) and second derivative $s_n''(u) = (1/4 - 6a_n + 4a_n^2) s_n$ (`slope_hasDerivAt`).
2. **Exact Summand Differential Identity:**
   Formal proof that $s_n''(u) - \frac{1}{4} s_n(u) = \text{term}(n, u)$ for all $n \in \mathbb{N}$ and $u \in \mathbb{R}$ (`differential_identity`).
3. **Absolute Convergence and Global Xi Recovery:**
   Formal proofs that $\sum s_n$ (`seed_summable`) and $\sum s_n''$ (`curvature_summable`) converge absolutely, and that $\sum s_n''(u) - \frac{1}{4} \sum s_n(u) = \phi(u)$ (`curvature_tsum_minus_quarter_seed`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Classical first derivative of seed summand
theorem seed_hasDerivAt (n : ℕ) (u : ℝ) : HasDerivAt (seed n) (slope n u) u

-- Classical second derivative (curvature)
theorem slope_hasDerivAt (n : ℕ) (u : ℝ) :
    HasDerivAt (slope n) (curvature n u) u

-- Individual summand differential identity
theorem differential_identity (n : ℕ) (u : ℝ) :
    deriv (deriv (seed n)) u - seed n u / 4 = term n u

-- Absolute summability of seed series
theorem seed_summable (u : ℝ) : Summable (fun n => seed n u)

-- Absolute summability of curvature series
theorem curvature_summable (u : ℝ) : Summable (fun n => curvature n u)

-- Exact global recovery of Riemann Xi kernel
theorem curvature_tsum_minus_quarter_seed (u : ℝ) :
    (∑' n : ℕ, curvature n u) - (∑' n : ℕ, seed n u) / 4 = phi u
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified implementation in Lean 4 proving that the shifted Helmholtz operator $(d^2/du^2 - 1/4)$ acting on the modular Gaussian seed $e^{u/2} e^{-\pi n^2 e^{2u}}$ produces the Riemann Xi kernel summand, and recovering the full Riemann kernel $\phi(u)$ term-by-term without interchange hypotheses.
