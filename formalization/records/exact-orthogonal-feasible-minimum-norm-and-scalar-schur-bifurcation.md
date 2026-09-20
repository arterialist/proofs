# Contribution 268: Exact Orthogonal Feasible Minimum Norm and Scalar Schur Bifurcation

**Date:** 19 September 2026  
**Primary Source Documents:** [`formalization/BuildingBlocks/CollectiveSourceGalerkinFinite.lean`](../../formalization/BuildingBlocks/CollectiveSourceGalerkinFinite.lean), [`building-blocks/spectral/collective-source-galerkin-finite.md`](../../building-blocks/spectral/collective-source-galerkin-finite.md)  
**Classification:** Functional Analysis / Hilbert Spaces / Optimization / Moore-Penrose Pseudoinverse / Schur Complements / Formalized Mathematics

---

## 1. Executive Summary and Mathematical Statement

In the variational construction of source lifts for observation equations $L x = y$ on a real Hilbert space $V$, the minimum-norm solution governs whether the source energy can satisfy a designated ceiling. Furthermore, the semi-definiteness of the resulting $2 \times 2$ Galerkin blocks exhibits an exact bifurcation depending on whether the leading diagonal vanishes.

This contribution proves:

1. **Orthogonal Feasible Solution is Global Minimum:**  
   For any linear map $L : V \to W$ on an inner product space $V$, if $x_0 \in V$ is feasible ($L x_0 = y$) and orthogonal to the kernel ($z \in \ker L \implies \langle x_0, z \rangle = 0$), then for any feasible vector $x$ ($L x = L x_0$):
   $$
   \|x_0\|^2 \le \|x\|^2.
   $$
2. **Energy Ceiling Feasibility Equivalence:**  
   The existence of any feasible solution within an energy bound $\text{cap}$ is equivalent to the minimum lift satisfying the bound:
   $$
   (\exists x, \, L x = L x_0 \land \|x\|^2 \le \text{cap}) \iff \|x_0\|^2 \le \text{cap}.
   $$
3. **Moore-Penrose Pseudoinverse Optimality:**  
   If $\text{pinv}$ is a right inverse on $\text{range}(L)$ and maps into $(\ker L)^\perp$, then $x_0 = \text{pinv}(y)$ achieves the exact global minimum norm among all preimages of $y$.
4. **Nonsingular Scalar Schur Equivalence ($g > 0$):**  
   For $g > 0$, global non-negativity of the quadratic form $g x^2 + 2 \text{cross} x y + \text{cap} y^2 \ge 0$ for all $x, y \in \mathbb{R}$ is strictly equivalent to:
   $$
   \text{cross}^2 \le g \cdot \text{cap}.
   $$
   Proven in both directions without matrix square roots.
5. **Singular Scalar Schur Bifurcation ($g = 0$):**  
   At the singular boundary $g = 0$, global non-negativity of $2 \text{cross} x y + \text{cap} y^2 \ge 0$ for all $x, y \in \mathbb{R}$ forces:
   $$
   \text{cross} = 0 \quad \text{and} \quad \text{cap} \ge 0.
   $$
   Any non-zero off-diagonal cross coupling immediately produces negative energy when tested along $x = -(\text{cap} + 1) / (2 \cdot \text{cross})$.

---

## 2. Mathematical Proof

### 2.1. Minimality of Orthogonal Feasible Lift
Let $x \in V$ satisfy $L x = L x_0$. Define $z = x - x_0$.
Then $L z = L x - L x_0 = 0$, so $z \in \ker L$.
By orthogonality, $\langle x_0, z \rangle = 0$.
Decomposing $x = x_0 + z$:
$$
\|x\|^2 = \|x_0 + z\|^2 = \|x_0\|^2 + 2 \langle x_0, z \rangle + \|z\|^2 = \|x_0\|^2 + \|z\|^2.
$$
Since $\|z\|^2 \ge 0$, $\|x_0\|^2 \le \|x\|^2$.

### 2.2. Singular Schur Bifurcation
Assume $2 \text{cross} x y + \text{cap} y^2 \ge 0$ for all $x, y$.
Setting $x = 0, y = 1$ gives $\text{cap} \ge 0$.
If $\text{cross} \neq 0$, choose $y = 1$ and $x = -\frac{\text{cap} + 1}{2 \cdot \text{cross}}$.
Then:
$$
2 \text{cross} x y + \text{cap} y^2 = 2 \text{cross} \left( -\frac{\text{cap} + 1}{2 \cdot \text{cross}} \right) + \text{cap} = -(\text{cap} + 1) + \text{cap} = -1 < 0,
$$
a contradiction. Thus $\text{cross} = 0$.

---

## 3. Machine Verification and Axiom Audit

Formally verified in Lean 4.24.0 (`PaidThetaCompensation` in `formalization/BuildingBlocks/CollectiveSourceGalerkinFinite.lean`):
```lean
theorem orthogonal_feasible_is_minimum
    {V W : Type*}
    [NormedAddCommGroup V] [InnerProductSpace ℝ V]
    [AddCommGroup W] [Module ℝ W]
    (L : V →ₗ[ℝ] W) (x₀ : V)
    (horth : ∀ z, L z = 0 → inner ℝ x₀ z = 0) :
    ∀ x, L x = L x₀ → ‖x₀‖ ^ 2 ≤ ‖x‖ ^ 2

theorem feasible_energy_cap_iff_minimum
    {V W : Type*}
    [NormedAddCommGroup V] [InnerProductSpace ℝ V]
    [AddCommGroup W] [Module ℝ W]
    (L : V →ₗ[ℝ] W) (x₀ : V) (cap : ℝ)
    (horth : ∀ z, L z = 0 → inner ℝ x₀ z = 0) :
    (∃ x, L x = L x₀ ∧ ‖x‖ ^ 2 ≤ cap) ↔ ‖x₀‖ ^ 2 ≤ cap

theorem pseudoinverse_lift_is_minimum
    {V W : Type*}
    [NormedAddCommGroup V] [InnerProductSpace ℝ V]
    [AddCommGroup W] [Module ℝ W]
    (L : V →ₗ[ℝ] W) (pinv : W → V) (y : W)
    (hrange : y ∈ Set.range L)
    (hright : ∀ w ∈ Set.range L, L (pinv w) = w)
    (horth : ∀ w ∈ Set.range L, ∀ z, L z = 0 →
      inner ℝ (pinv w) z = 0) :
    L (pinv y) = y ∧
      ∀ x, L x = y → ‖pinv y‖ ^ 2 ≤ ‖x‖ ^ 2

theorem positive_scalar_schur_iff
    {g cross cap : ℝ} (hg : 0 < g) :
    (∀ x y : ℝ,
      0 ≤ g * x ^ 2 + 2 * cross * x * y + cap * y ^ 2) ↔
      cross ^ 2 ≤ g * cap

theorem zero_scalar_schur_iff
    {cross cap : ℝ} :
    (∀ x y : ℝ, 0 ≤ 2 * cross * x * y + cap * y ^ 2) ↔
      cross = 0 ∧ 0 ≤ cap
```
Axioms audit confirms strict dependence on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 4. Literature Context and Target Venues

- **Prior Literature:** Moore-Penrose pseudoinverses, minimum norm least squares, and Schur complement conditions for positive semidefiniteness (Campbell-Meyer 2009, Boyd-Vandenberghe 2004). Priority for the exact result and its formalization is provisional; no exhaustive search is documented.
- **Advancement:** Establishes the exact variational foundation for source-range feasibility checks and provides a complete bifurcation analysis of $2 \times 2$ quadratic forms.
- **Target Venues:** *SIAM Journal on Optimization* or *Linear Algebra and its Applications*.
