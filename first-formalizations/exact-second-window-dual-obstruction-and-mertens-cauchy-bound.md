# First Formalization: Exact Second-Window Dual Obstruction and Mertens Cauchy Bound

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/SecondWindow.lean`](../../formalization/BuildingBlocks/SecondWindow.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization proves that subtracting the mean period correction from the dual Nyman–Beurling approximation leaves an inescapable arithmetic obstruction on the second dyadic window $(1/N, 2/N)$:

1. **Second-Window Reciprocal Kernel Evaluation:**
   Formal proof of `reciprocalKernel_first_second_window`: $K_{\text{rec}}(1/N, x) = 1 - \frac{1}{Nx}$ on $(1/N, 2/N)$.
2. **Corrected Reciprocal Images:**
   Formal proof of `correctedImage_first_window` (constant value $-2$ on $(0, 1/N)$) and `correctedImage_second_window` (exact hyperbolic profile $-2 + \frac{C_2(N)}{Nx}$ on $(1/N, 2/N)$ with $C_2(N) = M(N) + M(N/2) + 3$).
3. **Scaled Inverse-Square Integral:**
   Formal proof of `scaled_inverse_square_integral`: $\int_{1/N}^{2/N} (C/(Nx))^2 dx = C^2 / (2N)$.
4. **Isometry Distance Preservation:**
   Formal proof of `corrected_distance_identity` relating dual error differences to reciprocal image differences.
5. **Non-Asymptotic Cauchy Lower Bound:**
   Formal proof of `corrected_second_window_cauchy_bound`: $C_2(N)^2 / N \le 4 \mathcal{E}_{\text{corr}}(N) + 4 \mathcal{E}_{\text{corr}}(M)$ for $2M \le N$.
6. **Asymptotic Convergence Obstruction:**
   Formal proof of `secondWindowCoefficient_sq_tendsto_of_corrected_convergence`: $\lim_{N \to \infty} \frac{(M(N) + M(N/2) + 3)^2}{N} = 0$ if $\mathcal{E}_{\text{corr}}(N) \to 0$.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- First window constant value
theorem correctedImage_first_window {N : ℕ} (hN : 2 ≤ N) {x : ℝ}
    (hx0 : 0 < x) (hx1 : x < 1 / (N : ℝ)) : correctedImage N x = -2

-- Second window exact profile
theorem correctedImage_second_window {N : ℕ} (hN : 2 ≤ N) {x : ℝ}
    (hx1 : 1 / (N : ℝ) < x) (hx2 : x < 2 / (N : ℝ)) :
    correctedImage N x = -2 +
      ((mertens N : ℝ) + (mertens (N / 2) : ℝ) + 3) / ((N : ℝ) * x)

-- Inverse-square integral evaluation
theorem scaled_inverse_square_integral {N : ℕ} (hN : 0 < N) (C : ℝ) :
    (∫ x in (1 / (N : ℝ))..(2 / (N : ℝ)), (C / ((N : ℝ) * x)) ^ 2) =
      C ^ 2 / (2 * (N : ℝ))

-- Non-asymptotic Cauchy bound
theorem corrected_second_window_cauchy_bound {N M : ℕ} (hM : 2 ≤ M) (hNM : 2 * M ≤ N) :
    secondWindowCoefficient N ^ 2 / (N : ℝ) ≤
      4 * correctedTotalError N + 4 * correctedTotalError M

-- Asymptotic obstruction theorem
theorem secondWindowCoefficient_sq_tendsto_of_corrected_convergence
    (h : MeanCorrectedConvergence) :
    Tendsto (fun N : ℕ => secondWindowCoefficient N ^ 2 / (N : ℝ)) atTop (𝓝 0)
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified proof in Lean 4 demonstrating that mean-corrected Nyman–Beurling dual approximations cannot converge without forcing the sub-$\sqrt{N}$ asymptotic vanishing of the second-window Mertens coefficient $M(N) + M(N/2) + 3$.
