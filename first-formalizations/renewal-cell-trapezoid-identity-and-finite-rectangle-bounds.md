# First Formalization: Renewal Cell Trapezoid Error Identity and Finite Rectangle Bounds

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/ActualHeatRenewalRectangle.lean`](../../formalization/BuildingBlocks/ActualHeatRenewalRectangle.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact quadrature error identities and uniform bounds governing finite-mesh discretizations of renewal kernels:

1. **Finite Right-Endpoint Rectangle Bound:**
   Formal proof by mathematical induction that for any $C^1$ function $G$ on $[0, N\delta]$, the right-endpoint Riemann sum error is bounded by the mesh size times the total variation of $G$ (`finite_right_rectangle`, `finite_right_rectangle_div`):
   \[
   \left| \delta \sum_{m=0}^{N-1} G((m+1)\delta) - \int_0^{N\delta} G(t) dt \right| \le \delta \int_0^{N\delta} |G'(t)| dt.
   \]
2. **Exact Cell Trapezoid Integration-by-Parts Identity:**
   Formal derivation of the exact error representation of the trapezoid rule on a single interval $[a, b]$ with symmetric quadratic kernel $w(t) = (t-a)(b-t)/2$ (`trap_cell_identity`):
   \[
   \frac{b-a}{2}(G(a) + G(b)) - \int_a^b G(t) dt = \int_a^b \frac{(t-a)(b-t)}{2} G''(t) dt.
   \]
3. **Trapezoid Cell Kernel Bound:**
   Formal verification that $|(t-a)(b-t)/2| \le (b-a)^2/4$ on $[a, b]$, yielding the sharp $L^1$ second-derivative bound (`trap_cell_bound`):
   \[
   \left| \frac{b-a}{2}(G(a) + G(b)) - \int_a^b G(t) dt \right| \le \frac{(b-a)^2}{4} \int_a^b |G''(t)| dt.
   \]
4. **Global Finite Multi-Cell Trapezoid Rule:**
   Formal induction across $N$ cells proving the global trapezoid error bound (`finite_trapezoid_cells`, `finite_trapezoid_endpoints`):
   \[
   \left| \frac{\delta}{2}(G(0) + G((N+1)\delta)) + \delta \sum_{m=1}^N G(m\delta) - \int_0^{(N+1)\delta} G(t) dt \right| \le \frac{\delta^2}{4} \int_0^{(N+1)\delta} |G''(t)| dt.
   \]

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Right-endpoint rectangle bound
theorem finite_right_rectangle (G : ℝ → ℝ) (hG : ContDiff ℝ 1 G)
    (δ : ℝ) (hδ : 0 ≤ δ) (N : ℕ) :
    |δ * ∑ m ∈ range N, G (((m + 1 : ℕ) : ℝ) * δ) -
      ∫ t in (0 : ℝ)..(N : ℝ) * δ, G t| ≤
      δ * ∫ t in (0 : ℝ)..(N : ℝ) * δ, |deriv G t|

-- Exact cell trapezoid error identity
theorem trap_cell_identity (G : ℝ → ℝ) (hG : ContDiff ℝ 2 G) (a b : ℝ) :
    (b - a) / 2 * (G a + G b) - ∫ t in a..b, G t =
      ∫ t in a..b, trapWeight a b t * deriv (deriv G) t

-- Single cell trapezoid bound
theorem trap_cell_bound (G : ℝ → ℝ) (hG : ContDiff ℝ 2 G) {a b : ℝ} (hab : a ≤ b) :
    |(b - a) / 2 * (G a + G b) - ∫ t in a..b, G t| ≤
      (b - a) ^ 2 / 4 * ∫ t in a..b, |deriv (deriv G) t|

-- Global multi-cell trapezoid bound
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

## 3. Novelty and Mathematical Impact

This formalization establishes the exact non-asymptotic Peano kernel integration-by-parts identity for trapezoidal quadrature in Lean 4 without discretization asymptotics, providing the certified foundation for renewal cell step errors.
