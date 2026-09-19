# Unique Contribution 114: Frustrated-Cycle Energy Decomposition and Harmonic Conductance Lower Bound

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/OddTriangleConductance.lean`](../../formalization/BuildingBlocks/OddTriangleConductance.lean), [`building-blocks/conductance-and-geometry/odd-cycle-dirichlet-energy.md`](../../building-blocks/conductance-and-geometry/odd-cycle-dirichlet-energy.md)  
**Classification:** Spectral Graph Theory / Signed Graphs / Frustrated Cycle Energy / Harmonic Conductances / Dirichlet Forms

---

## 1. Executive Summary and Mathematical Statement

In the spectral theory of signed networks, graph Laplacians with negative edge signatures exhibit frustration: the Dirichlet quadratic form cannot vanish on non-trivial potentials due to the presence of odd cycles with an odd number of negative edges.

This contribution proves:

1. **Exact Frustrated Triangle Energy Decomposition:**  
   On a triangle cycle with signature $(-, +, -)$ across edges $(z, x)$, $(x, y)$, and $(z, y)$, the quadratic energy decomposes identically as:
   \[
   (z - x)^2 + (x + y)^2 + (z - y)^2 = \frac{4}{3} z^2 + \frac{1}{3} \left( ((z - x) - (x + y))^2 + ((z - x) - (z - y))^2 + ((x + y) - (z - y))^2 \right).
   \]
   This isolates the irreducible topological ground-state energy $\frac{4}{3} z^2$ from the edge discrepancy squares without any approximations.
2. **Exact Weighted Parallel Route Decomposition:**  
   For arbitrary positive edge conductances $w_1, w_2 > 0$ and boundary potentials $A, B$, the series-parallel energy across an intermediate node $Z$ satisfies:
   \[
   (w_1 + w_2) \left( w_1 (A - Z)^2 + w_2 (Z + B)^2 \right) = w_1 w_2 (A + B)^2 + \Big( (w_1 + w_2) Z - w_1 A + w_2 B \Big)^2.
   \]
3. **Exact Harmonic Conductance Lower Bound:**  
   Minimizing over the internal potential $Z$ yields the sharp lower bound:
   \[
   \frac{w_1 w_2}{w_1 + w_2} (A + B)^2 \le w_1 (A - Z)^2 + w_2 (Z + B)^2,
   \]
   with equality attained uniquely at the harmonic equilibrium potential:
   \[
   Z^* = \frac{w_1 A - w_2 B}{w_1 + w_2}.
   \]

---

## 2. Mathematical Proof

### 2.1. Triangle Cycle Algebraic Decomposition
Expanding the left-hand side:
\[
E = (z - x)^2 + (x + y)^2 + (z - y)^2 = 2 z^2 + 2 x^2 + 2 y^2 - 2 z x - 2 z y + 2 x y.
\]
Expanding the cycle differences:
\[
\Delta_1 = (z - x) - (x + y) = z - 2x - y \implies \Delta_1^2 = z^2 + 4x^2 + y^2 - 4zx - 2zy + 4xy,
\]
\[
\Delta_2 = (z - x) - (z - y) = y - x \implies \Delta_2^2 = x^2 - 2xy + y^2,
\]
\[
\Delta_3 = (x + y) - (z - y) = x + 2y - z \implies \Delta_3^2 = x^2 + 4y^2 + z^2 + 4xy - 2zx - 4zy.
\]
Summing:
\[
\Delta_1^2 + \Delta_2^2 + \Delta_3^2 = 2 z^2 + 6 x^2 + 6 y^2 - 6 z x - 6 z y + 6 x y.
\]
Dividing by $3$ and adding $\frac{4}{3} z^2$:
\[
\frac{4}{3} z^2 + \frac{2}{3} z^2 + 2 x^2 + 2 y^2 - 2 z x - 2 z y + 2 x y = 2 z^2 + 2 x^2 + 2 y^2 - 2 z x - 2 z y + 2 x y = E.
\]

### 2.2. Weighted Route Identity
Completing the square in $Z$:
\[
w_1 (A - Z)^2 + w_2 (Z + B)^2 = (w_1 + w_2) Z^2 - 2(w_1 A - w_2 B) Z + w_1 A^2 + w_2 B^2.
\]
Multiplying by $w_1 + w_2$:
\[
(w_1 + w_2) \left[ (w_1 + w_2) Z^2 - 2(w_1 A - w_2 B) Z + w_1 A^2 + w_2 B^2 \right] = \Big( (w_1 + w_2) Z - (w_1 A - w_2 B) \Big)^2 + (w_1 + w_2)(w_1 A^2 + w_2 B^2) - (w_1 A - w_2 B)^2.
\]
Expanding the constant:
\[
(w_1^2 A^2 + w_1 w_2 B^2 + w_1 w_2 A^2 + w_2^2 B^2) - (w_1^2 A^2 - 2 w_1 w_2 A B + w_2^2 B^2) = w_1 w_2 (A^2 + 2 A B + B^2) = w_1 w_2 (A + B)^2.
\]
Since the squared term is non-negative and $w_1 + w_2 > 0$, dividing by $w_1 + w_2$ gives the sharp lower bound.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.OddTriangleConductance`):
```lean
theorem triangle_cycle_decomposition (x y z : ℝ) :
    (z - x)^2 + (x + y)^2 + (z - y)^2 =
      (4 / 3 : ℝ) * z^2 + (1 / 3 : ℝ) *
        (((z - x) - (x + y))^2 + ((z - x) - (z - y))^2 +
          ((x + y) - (z - y))^2)

theorem weighted_route_decomposition (w₁ w₂ A B Z : ℝ) :
    (w₁ + w₂) * (w₁ * (A - Z)^2 + w₂ * (Z + B)^2) =
      w₁ * w₂ * (A + B)^2 + ((w₁ + w₂) * Z - w₁ * A + w₂ * B)^2

theorem weighted_route_lower_bound {w₁ w₂ : ℝ} (h₁ : 0 < w₁) (h₂ : 0 < w₂)
    (A B Z : ℝ) :
    w₁ * w₂ / (w₁ + w₂) * (A + B)^2 ≤ w₁ * (A - Z)^2 + w₂ * (Z + B)^2
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Dirichlet forms on networks and signed graph Laplacians (Zaslavsky 1982, Kunegis et al. 2010, Gallier 2016). The exact quadratic decomposition isolating the $\frac{4}{3} z^2$ topological ground state on frustrated odd cycles alongside exact harmonic-mean route identities in Lean 4 is novel.
- **Advancement:** Machine-verified algebraic decomposition of frustrated cycle energy and sharp parallel conductance lower bounds.
- **Target Venues:** *Linear Algebra and its Applications* or *Electronic Journal of Linear Algebra*.
