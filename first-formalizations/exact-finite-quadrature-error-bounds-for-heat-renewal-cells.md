# First Formalization: Exact Finite Quadrature Error Bounds for Heat Renewal Cells

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ActualHeatRenewalRectangle.lean`](../../formalization/BuildingBlocks/ActualHeatRenewalRectangle.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes exact total-variation error bounds for right-endpoint Riemann sums and composite trapezoid quadrature rules in Lean 4:

1. **Right-Endpoint Quadrature Error Bound:**
   Formal proof that $|\delta \sum_{m=0}^{N-1} G((m+1)\delta) - \int_0^{N\delta} G(t) dt| \le \delta \int_0^{N\delta} |G'(t)| dt$ (`finite_right_rectangle`, `finite_right_rectangle_div`).
2. **Exact Peano Kernel Identity for Trapezoid Cells:**
   Formal derivation of the integration-by-parts identity $\frac{b-a}{2}(G(a)+G(b)) - \int_a^b G = \int_a^b \frac{(t-a)(b-t)}{2} G''(t) dt$ (`trap_cell_identity`).
3. **Composite Trapezoid Second-Order Error Bound:**
   Formal proof of the $O(\delta^2)$ total variation bound for composite trapezoid quadrature (`finite_trapezoid_cells`, `finite_trapezoid_endpoints`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- First-order right-endpoint rectangle error bound
theorem finite_right_rectangle (G : ℝ → ℝ) (hG : ContDiff ℝ 1 G)
    (δ : ℝ) (hδ : 0 ≤ δ) (N : ℕ) :
    |δ * ∑ m ∈ range N, G (((m + 1 : ℕ) : ℝ) * δ) -
      ∫ t in (0 : ℝ)..(N : ℝ) * δ, G t| ≤
      δ * ∫ t in (0 : ℝ)..(N : ℝ) * δ, |deriv G t|

-- Right-endpoint error in mesh 1/X form
theorem finite_right_rectangle_div (G : ℝ → ℝ) (hG : ContDiff ℝ 1 G)
    (X : ℝ) (hX : 0 < X) (N : ℕ) :
    |(1 / X) * ∑ m ∈ range N, G (((m + 1 : ℕ) : ℝ) / X) -
      ∫ t in (0 : ℝ)..(N : ℝ) * δ, G t| ≤
      (1 / X) * ∫ t in (0 : ℝ)..(N : ℝ) / X, |deriv G t|

-- Second-order composite trapezoid error bound
theorem finite_trapezoid_endpoints (G : ℝ → ℝ) (hG : ContDiff ℝ 2 G)
    (δ : ℝ) (hδ : 0 ≤ δ) (N : ℕ) :
    |δ / 2 * (G 0 + G (((N + 1 : ℕ) : ℝ) * δ)) +
        δ * ∑ m ∈ Ico 1 (N + 1), G ((m : ℝ) * δ) -
      ∫ t in (0 : ℝ)..((N + 1 : ℕ) : ℝ) * δ, G t| ≤
      δ ^ 2 / 4 * ∫ t in (0 : ℝ)..((N + 1 : ℕ) : ℝ) * δ,
        |deriv (deriv G) t|
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified proof in Lean 4 of non-asymptotic total-variation error bounds for right-endpoint and composite trapezoid quadrature rules.
