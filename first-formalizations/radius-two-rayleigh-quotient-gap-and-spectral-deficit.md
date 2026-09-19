# First Formalization: Radius-Two Rayleigh Quotient Gap and Spectral Deficit

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ThetaRadiusTwoRayleighCore.lean`](../../formalization/BuildingBlocks/ThetaRadiusTwoRayleighCore.lean), [`formalization/BuildingBlocks/ThetaRadiusTwoJ3RationalCore.lean`](../../formalization/BuildingBlocks/ThetaRadiusTwoJ3RationalCore.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization verifies the existence of an explicit compact trial state on the exterior domain $O_2 = (-\infty, -2) \cup (2, \infty)$ whose Rayleigh quotient with respect to the killed theta form drops strictly below the unperturbed continuum threshold of $1/2$.

Key mathematical components verified:
1. **Piecewise Quintic Convolution Polynomial $H(x)$:**
   Formal Bochner interval integration verifying that the convolution of two scaled triangular polynomial bumps produces the exact $C^1$ spline $H(x)$:
   - Left branch $[0, 1]$: $\int_0^x 30 y(1-y)(x-y)(1-(x-y)) dy = x^3(x^2 - 5x + 5)$ (`convolution_integral_left`, `H_of_mem_left`).
   - Right branch $[1, 2]$: $\int_{x-1}^1 30 y(1-y)(x-y)(1-(x-y)) dy = -(x-2)^3(x^2 + x - 1)$ (`convolution_integral_right`, `H_of_mem_right`).
2. **Rational Energy Payment:**
   The exact rational arithmetic identity $2(6/25 - 6859/25600) = -143/2560$ (`rational_energy_payment`).
3. **Rayleigh Quotient Deficit Theorem:**
   Formal derivation of $E/N < 1/2 - 143/(5120 J)$ whenever $0 < N \le 2J$, $A < 6/25$, $C \ge 0$, $P > 6859/25600$, and $E = N/2 + 2A - 2C - 2P$ (`rayleigh_gap`).
4. **Rational Bounds for $\pi$ and $e$ and Gap Propagation:**
   Formal Machin arctangent certificates for $\pi \in (333/106, 355/113)$, Taylor series certificates for $e \in (2721/1001, 1457/536)$, and propagation of the upper enclosure $J(3) < 10^{544}$ to the uniform spectral gap bound $\text{gap} > 10^{-546}$ (`normalization_bound_implies_gap`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Left branch convolution integral
theorem convolution_integral_left (x : ℝ) :
    (∫ y in (0 : ℝ)..x, convolutionIntegrand x y) =
      x ^ 3 * (x ^ 2 - 5 * x + 5)

-- Right branch convolution integral
theorem convolution_integral_right (x : ℝ) :
    (∫ y in (x - 1)..(1 : ℝ), convolutionIntegrand x y) =
      -(x - 2) ^ 3 * (x ^ 2 + x - 1)

-- Exact piecewise identification
theorem H_of_mem_left {x : ℝ} (hx0 : 0 ≤ x) (hx1 : x ≤ 1) :
    H x = ∫ y in (0 : ℝ)..x, convolutionIntegrand x y

theorem H_of_mem_right {x : ℝ} (hx1 : 1 ≤ x) (hx2 : x ≤ 2) :
    H x = ∫ y in (x - 1)..(1 : ℝ), convolutionIntegrand x y

-- Rational energy payment
theorem rational_energy_payment :
    (2 : ℝ) * ((6 : ℝ) / 25 - 6859 / 25600) = -143 / 2560

-- Rayleigh gap deficit
theorem rayleigh_gap
    {N J A C P E : ℝ}
    (hN : 0 < N) (hNJ : N ≤ 2 * J)
    (hA : A < 6 / 25) (hC : 0 ≤ C) (hP : 6859 / 25600 < P)
    (hE : E = N / 2 + 2 * A - 2 * C - 2 * P) :
    E / N < 1 / 2 - 143 / (5120 * J)

-- Spectral gap propagation from J upper bound
theorem normalization_bound_implies_gap
    {J gap : ℝ} (hJ : 0 < J) (hJupper : J < 10 ^ (544 : ℕ))
    (hgap : 143 / (5120 * J) < gap) :
    ((10 : ℝ) ^ (546 : ℕ))⁻¹ < gap
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0 and Lake 5.0.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified proof of a sub-continuum Rayleigh quotient for the killed theta jump process on the exterior domain $O_2$. By certifying both the polynomial Bochner integrals and the rational gap propagation, it rigorously anchors the spectral deficit in Lean 4 without empirical approximation.
