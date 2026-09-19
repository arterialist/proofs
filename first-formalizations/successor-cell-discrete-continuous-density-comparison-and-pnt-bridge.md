# First Formalization: Successor-Cell Discrete-Continuous Density Comparison and PNT Bridge

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/SuccessorCellDensityComparison.lean`](../../formalization/BuildingBlocks/SuccessorCellDensityComparison.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the non-asymptotic density approximation and PNT summation bridge in successor cells in Lean 4:

1. **One-Sided Riemann Sum Error:**
   Formal proof that the continuous density integral strictly exceeds the discrete sum by at most $1/\sqrt{a} - 1/\sqrt{b}$ (`inv_sqrt_integer_density_error`).
2. **Fractional Endpoint Bounds:**
   Formal proof of error $\le 1/\sqrt{A}$ for real cell intervals bracketed by integers (`inv_sqrt_fractional_density_error`).
3. **Prime vs. Continuous Density Comparison:**
   Formal proof bounding the error between discrete von Mangoldt sums and continuous density integrals by $2H/\sqrt{A+1} + 1/\sqrt{A}$ (`actual_prime_continuous_density_bound`).
4. **Normalized Successor Cell Row Bounds:**
   Formal deduction of the child dilation error bound under physical logarithmic-cell normalization (`normalized_child_dilation_continuous_density_bound`, `normalized_child_dilation_integral_density_bound`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Integer density error with telescoping bound
theorem inv_sqrt_integer_density_error
    {a b : ℕ} (ha : 1 ≤ a) (hab : a ≤ b) :
    0 ≤ (∫ x in (a : ℝ)..(b : ℝ), 1 / Real.sqrt x) -
      ∑ d ∈ Finset.Ioc a b, 1 / Real.sqrt (d : ℝ) ∧
    (∫ x in (a : ℝ)..(b : ℝ), 1 / Real.sqrt x) -
      ∑ d ∈ Finset.Ioc a b, 1 / Real.sqrt (d : ℝ) ≤
        1 / Real.sqrt (a : ℝ) - 1 / Real.sqrt (b : ℝ)

-- Master PNT prime row bound
theorem actual_prime_continuous_density_bound
    {A B : ℕ} (hA : 1 ≤ A) (hAB : A < B)
    {a b : ℝ} (ha0 : (A : ℝ) ≤ a) (ha1 : a ≤ (A : ℝ) + 1)
    (hb0 : (B : ℝ) ≤ b) (hb1 : b ≤ (B : ℝ) + 1)
    {H : ℝ} (hH : 0 ≤ H)
    (hE : ∀ k ∈ Finset.Icc A B, |integerError k| ≤ H) :
    |(∑ d ∈ Finset.Ioc A B,
        ArithmeticFunction.vonMangoldt d / Real.sqrt (d : ℝ)) -
      2 * (Real.sqrt b - Real.sqrt a)| ≤
      2 * H / Real.sqrt (A + 1 : ℕ) + 1 / Real.sqrt (A : ℝ)

-- Normalized successor cell interval integral bound
theorem normalized_child_dilation_integral_density_bound
    {r n D : ℕ} (hn : 0 < n)
    (hA : 1 ≤ r / (n + 1))
    (hAB : r / (n + 1) < r / n)
    (hD : D ≤ r / (n + 1))
    {H : ℝ} (hH : 0 ≤ H)
    (hE : ∀ k ∈ Finset.Icc (r / (n + 1)) (r / n),
      |integerError k| ≤ H) :
    |Real.sqrt (cellLength r / cellLength n) *
        (∑ d ∈ highParentChildren r n D,
          ArithmeticFunction.vonMangoldt d / Real.sqrt (d : ℝ)) -
      Real.sqrt (cellLength r / cellLength n) *
        (∫ x in ((r : ℝ) / ((n + 1 : ℕ) : ℝ))..((r : ℝ) / (n : ℝ)),
          1 / Real.sqrt x)| ≤
      Real.sqrt (cellLength r / cellLength n) *
        (2 * H / Real.sqrt (r / (n + 1) + 1 : ℕ) +
          1 / Real.sqrt ((r / (n + 1) : ℕ) : ℝ))
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified proof bounding discrete prime child dilation transfers against continuous successor cell integral operators with explicit non-asymptotic remainder terms.
