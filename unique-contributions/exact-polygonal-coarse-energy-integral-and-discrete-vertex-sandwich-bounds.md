# Unique Contribution 244: Exact Polygonal Coarse Energy Integral and Discrete Vertex Sandwich Bounds

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/PolygonalCoarseEnergy.lean`](../../formalization/BuildingBlocks/PolygonalCoarseEnergy.lean), [`building-blocks/coarse/polygonal-coarse-energy.md`](../../building-blocks/coarse/polygonal-coarse-energy.md)  
**Classification:** Numerical Analysis / Finite Element Methods / Quadrature / Piecewise Linear Interpolation / Energy Inequalities / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

Computing and verifying coarse primitive energy bounds on continuous intervals requires discretizing the continuous $L^2$ energy of piecewise affine interpolants without losing rigorous upper and lower bounds. Given a sequence of nodal values $f_i$ on a grid with step sizes $h_i$ and a total terminal mass $A$, the continuous cell energy over the unit interval $[0, 1]$ involves quadratic forms of both the prefix and complementary suffix.

This contribution proves:

1. **Exact Cell Energy Integral Formula:**  
   For any constant terminal mass $A \in \mathbb{R}$ and end-point values $p, q \in \mathbb{R}$, the integral of the two-sided continuous affine energy on $[0, 1]$ evaluates exactly to the rational quadratic polynomial:
   \[
   \int_0^1 \left( ((1-u)p + uq)^2 + (A - ((1-u)p + uq))^2 \right) du = \text{cellEnergy}(A, p, q),
   \]
   where:
   \[
   \text{cellEnergy}(A, p, q) = \frac{p^2 + pq + q^2 + (A-p)^2 + (A-p)(A-q) + (A-q)^2}{3}.
   \]
2. **Sharp Nonlinear Vertex Sandwich Bounds:**  
   For all $A, p, q \in \mathbb{R}$, the exact continuous cell energy is strictly bounded between $1/6$ and $1/2$ of the sum of vertex squares:
   \[
   \frac{p^2 + (A-p)^2 + q^2 + (A-q)^2}{6} \le \text{cellEnergy}(A, p, q) \le \frac{p^2 + (A-p)^2 + q^2 + (A-q)^2}{2}.
   \]
   The constants $1/6$ and $1/2$ are optimal.
3. **Grand Weighted Polygonal Energy Comparison Theorem:**  
   For any partition with non-negative weights $h_i \ge 0$, the total continuous polygonal energy is bounded above and below by discrete vertex sums:
   \[
   \frac{1}{6} \sum_{i=0}^{m-1} h_i V(A, f_i, f_{i+1}) \le \sum_{i=0}^{m-1} h_i \text{cellEnergy}(A, f_i, f_{i+1}) \le \frac{1}{2} \sum_{i=0}^{m-1} h_i V(A, f_i, f_{i+1}),
   \]
   where $V(A, p, q) = p^2 + (A-p)^2 + q^2 + (A-q)^2$. This enables direct certified interval verification of coarse energy bounds via discrete matrix arithmetic.

---

## 2. Mathematical Proof

### 2.1. Exact Affine Integration
Setting $x(u) = (1-u)p + uq = p + (q-p)u$:
\[
x(u)^2 + (A - x(u))^2 = (p^2 + (A-p)^2) + 2(p(q-p) - (A-p)(q-p)) u + 2(q-p)^2 u^2.
\]
Integrating $u \in [0, 1]$ using $\int_0^1 du = 1$, $\int_0^1 u du = 1/2$, and $\int_0^1 u^2 du = 1/3$:
\[
\int_0^1 (x(u)^2 + (A-x(u))^2) du = (p^2 + (A-p)^2) + (p(q-p) - (A-p)(q-p)) + \frac{2}{3}(q-p)^2.
\]
Expanding and collecting terms yields:
\[
= \frac{p^2 + pq + q^2 + (A-p)^2 + (A-p)(A-q) + (A-q)^2}{3} = \text{cellEnergy}(A, p, q).
\]

### 2.2. Nonlinear Vertex Sandwich
Notice that:
\[
p^2 + pq + q^2 = \frac{1}{2}(p+q)^2 + \frac{1}{2}(p^2 + q^2) \ge \frac{1}{2}(p^2 + q^2) - \frac{1}{4}(p+q)^2.
\]
More directly, using $(p-q)^2 \ge 0 \implies pq \le \frac{1}{2}(p^2 + q^2)$:
\[
p^2 + pq + q^2 \le \frac{3}{2}(p^2 + q^2) \implies \frac{p^2 + pq + q^2}{3} \le \frac{p^2 + q^2}{2}.
\]
Similarly, $(p+q)^2 \ge 0 \implies pq \ge -\frac{1}{2}(p^2 + q^2)$:
\[
p^2 + pq + q^2 \ge \frac{1}{2}(p^2 + q^2) \implies \frac{p^2 + pq + q^2}{3} \ge \frac{p^2 + q^2}{6}.
\]
Applying these identical inequalities to $(A-p)$ and $(A-q)$ and summing establishes the sharp bounds with constants $1/6$ and $1/2$.

### 2.3. Partition Summation
Multiplying by $h_i \ge 0$ and summing over $i \in \{0, \dots, m-1\}$ yields `polygonal_energy_bounds`.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`BuildingBlocks.PolygonalCoarse` in `formalization/BuildingBlocks/PolygonalCoarseEnergy.lean`):
```lean
theorem cellEnergy_integral (A p q : ℝ) :
    (∫ u in (0 : ℝ)..1,
      ((1-u)*p+u*q)^2 + (A-((1-u)*p+u*q))^2) = cellEnergy A p q

theorem cellEnergy_lower (A p q : ℝ) :
    (p^2 + (A-p)^2 + q^2 + (A-q)^2) / 6 ≤ cellEnergy A p q

theorem cellEnergy_upper (A p q : ℝ) :
    cellEnergy A p q ≤ (p^2 + (A-p)^2 + q^2 + (A-q)^2) / 2

theorem polygonal_energy_bounds (m : ℕ) (h f : ℕ → ℝ) (A : ℝ)
    (hh : ∀ i ∈ Finset.range m, 0 ≤ h i) :
    (∑ i ∈ Finset.range m, h i *
      ((f i)^2 + (A-f i)^2 + (f (i+1))^2 + (A-f (i+1))^2) / 6) ≤
      (∑ i ∈ Finset.range m, h i * cellEnergy A (f i) (f (i+1))) ∧
    (∑ i ∈ Finset.range m, h i * cellEnergy A (f i) (f (i+1))) ≤
      (∑ i ∈ Finset.range m, h i *
        ((f i)^2 + (A-f i)^2 + (f (i+1))^2 + (A-f (i+1))^2) / 2)
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Piecewise linear finite elements, mass and stiffness matrix evaluation (Ciarlet 1978, Brenner-Scott 2008). The explicit derivation and machine verification of two-sided complementary coarse energy integrals with universal $1/6$ and $1/2$ conditioning bounds in Lean 4 is new.
- **Advancement:** Bridges continuous Sobolev/Dirichlet energy bounds to computationally checkable discrete quadratic forms for prime error approximations.
- **Target Venues:** *Numerische Mathematik* or *Mathematics of Computation*.
