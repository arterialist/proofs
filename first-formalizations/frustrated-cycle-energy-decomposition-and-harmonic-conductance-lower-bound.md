# First Formalization: Frustrated-Cycle Energy Decomposition and Harmonic Conductance Lower Bound

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/OddTriangleConductance.lean`](../../formalization/BuildingBlocks/OddTriangleConductance.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the exact algebraic decomposition of Dirichlet quadratic energy on signed/frustrated triangle cycles and parallel weighted conductances in Lean 4:

1. **Frustrated Triangle Decomposition:**
   Formal identity decomposing $(z-x)^2 + (x+y)^2 + (z-y)^2$ into $\frac{4}{3} z^2$ plus positive cycle differences (`triangle_cycle_decomposition`).
2. **Parallel Weighted Route Decomposition:**
   Exact completion-of-the-square identity for parallel conductances $w_1, w_2$ (`weighted_route_decomposition`).
3. **Harmonic Conductance Bound:**
   Sharp lower bound $\frac{w_1 w_2}{w_1 + w_2} (A + B)^2 \le w_1 (A - Z)^2 + w_2 (Z + B)^2$ (`weighted_route_lower_bound`).

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Frustrated triangle cycle energy decomposition
theorem triangle_cycle_decomposition (x y z : ℝ) :
    (z - x)^2 + (x + y)^2 + (z - y)^2 =
      (4 / 3 : ℝ) * z^2 + (1 / 3 : ℝ) *
        (((z - x) - (x + y))^2 + ((z - x) - (z - y))^2 +
          ((x + y) - (z - y))^2)

-- Weighted parallel route decomposition
theorem weighted_route_decomposition (w₁ w₂ A B Z : ℝ) :
    (w₁ + w₂) * (w₁ * (A - Z)^2 + w₂ * (Z + B)^2) =
      w₁ * w₂ * (A + B)^2 + ((w₁ + w₂) * Z - w₁ * A + w₂ * B)^2

-- Exact harmonic conductance lower bound
theorem weighted_route_lower_bound {w₁ w₂ : ℝ} (h₁ : 0 < w₁) (h₂ : 0 < w₂)
    (A B Z : ℝ) :
    w₁ * w₂ / (w₁ + w₂) * (A + B)^2 ≤ w₁ * (A - Z)^2 + w₂ * (Z + B)^2
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Scope and verification status

This entry documents a machine-verified proof in Lean 4 of the exact ground-state topological energy decomposition $\frac{4}{3} z^2$ on signed frustrated cycles and the harmonic-mean series-parallel conductance inequality.
