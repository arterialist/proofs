# First Formalization: Exact Orthogonal Feasible Minimum Norm and Scalar Schur Bifurcation

**Date:** 19 September 2026  
**Lean 4 Module:** [`formalization/BuildingBlocks/CollectiveSourceGalerkinFinite.lean`](../../formalization/BuildingBlocks/CollectiveSourceGalerkinFinite.lean)  
**Lean Version:** Lean 4.24.0 / Lake 5.0.0  
**Axiom Audit:** Strictly depends on foundational axioms `[propext, Classical.choice, Quot.sound]`; zero custom axioms, zero `sorry`.

---

## 1. Overview and Mathematical Scope

This formalization establishes the Hilbert-space orthogonal minimum-norm principle, pseudoinverse optimality, and the complete bifurcation of scalar Schur complements in Lean 4:

1. **Orthogonal Feasible Solution is Minimum Norm:**
   Formal proof of `orthogonal_feasible_is_minimum`: Any feasible vector orthogonal to $\ker L$ minimizes the $L^2$ norm across all preimages.
2. **Energy Ceiling Feasibility Equivalence:**
   Formal proof of `feasible_energy_cap_iff_minimum`: Feasibility within an energy ceiling is equivalent to the minimum lift satisfying the ceiling.
3. **Pseudoinverse Optimality:**
   Formal proof of `pseudoinverse_lift_is_minimum`: Moore-Penrose right inverse orthogonal to the kernel delivers the global minimum-norm solution.
4. **Nonsingular Scalar Schur Equivalence:**
   Formal proof of `positive_scalar_schur_iff`: For $g > 0$, global non-negativity $\iff \text{cross}^2 \le g \cdot \text{cap}$.
5. **Singular Scalar Schur Bifurcation:**
   Formal proof of `zero_scalar_schur_iff`: At $g = 0$, global non-negativity forces $\text{cross} = 0 \land \text{cap} \ge 0$.

---

## 2. Key Formalized Theorems and Axiom Signatures

```lean
-- Orthogonal feasible lift minimizes Hilbert norm
theorem orthogonal_feasible_is_minimum
    {V W : Type*}
    [NormedAddCommGroup V] [InnerProductSpace ℝ V]
    [AddCommGroup W] [Module ℝ W]
    (L : V →ₗ[ℝ] W) (x₀ : V)
    (horth : ∀ z, L z = 0 → inner ℝ x₀ z = 0) :
    ∀ x, L x = L x₀ → ‖x₀‖ ^ 2 ≤ ‖x‖ ^ 2

-- Energy ceiling equivalence
theorem feasible_energy_cap_iff_minimum
    {V W : Type*}
    [NormedAddCommGroup V] [InnerProductSpace ℝ V]
    [AddCommGroup W] [Module ℝ W]
    (L : V →ₗ[ℝ] W) (x₀ : V) (cap : ℝ)
    (horth : ∀ z, L z = 0 → inner ℝ x₀ z = 0) :
    (∃ x, L x = L x₀ ∧ ‖x‖ ^ 2 ≤ cap) ↔ ‖x₀‖ ^ 2 ≤ cap

-- Moore-Penrose pseudoinverse minimality
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

-- Nonsingular Schur complement characterization
theorem positive_scalar_schur_iff
    {g cross cap : ℝ} (hg : 0 < g) :
    (∀ x y : ℝ,
      0 ≤ g * x ^ 2 + 2 * cross * x * y + cap * y ^ 2) ↔
      cross ^ 2 ≤ g * cap

-- Singular Schur bifurcation theorem
theorem zero_scalar_schur_iff
    {cross cap : ℝ} :
    (∀ x y : ℝ, 0 ≤ 2 * cross * x * y + cap * y ^ 2) ↔
      cross = 0 ∧ 0 ≤ cap
```

### Axiom Audit
Compiles with exit code 0 under Lean 4.24.0, strictly depending on:
```
[propext, Classical.choice, Quot.sound]
```
Zero custom axioms, zero `sorry`.

---

## 3. Novelty and Mathematical Impact

This formalization provides the first machine-verified implementation in Lean 4 establishing the orthogonal minimum-norm principle for linear observations and proving the complete bifurcation of $2 \times 2$ quadratic forms at the boundary of the positive cone.
