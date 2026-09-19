/-
Copyright (c) 2026 Arterialist RH Research Team. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: Arterialist RH Research Team
-/
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Analysis.SpecialFunctions.Pow.Deriv
import Mathlib.Analysis.Calculus.Deriv.MeanValue
import Mathlib.Analysis.PSeries
import Mathlib.Topology.Algebra.InfiniteSum.Basic
import Mathlib.Topology.Algebra.InfiniteSum.Order
import Mathlib.Topology.Algebra.InfiniteSum.Real
import BuildingBlocks.RiemannZetaRealNonvanishing
import BuildingBlocks.UniversalSchwarzRHBridge

/-!
# Module 278: Grouped Dirichlet Eta Convergence and Positivity

This module formalizes the grouped Dirichlet eta series, proving its absolute convergence
and strict positivity on the open half-line $\sigma > 0$.

## Mathematical Architecture

For $\sigma > 0$, the classical alternating Dirichlet eta series:
$$\eta(\sigma) = \sum_{n=1}^\infty \frac{(-1)^{n-1}}{n^\sigma}$$
can be grouped into consecutive pairs:
$$u_n(\sigma) = \frac{1}{(2n+1)^\sigma} - \frac{1}{(2n+2)^\sigma} \quad (n \ge 0).$$

1. **Pointwise Positivity:**
   Since $2n+1 < 2n+2$ and $\sigma > 0$, we have $(2n+2)^{-\sigma} < (2n+1)^{-\sigma}$, so
   $$u_n(\sigma) > 0 \quad \text{for all } n \in \mathbb{N}.$$
2. **First Term Bound:**
   $u_0(\sigma) = 1 - 2^{-\sigma} > 0$.
3. **Mean Value Theorem Bound:**
   By Lagrange's Mean Value Theorem applied to $t \mapsto t^{-\sigma}$ on $[2n+1, 2n+2]$, there
   exists $c \in (2n+1, 2n+2)$ such that:
   $$u_n(\sigma) = \sigma c^{-\sigma - 1} \le \sigma (2n+1)^{-\sigma - 1} \le \sigma (n+1)^{-(\sigma + 1)}.$$
4. **Summability:**
   Since $\sigma > 0$, $\sigma + 1 > 1$. By Mathlib's `Real.summable_one_div_nat_add_rpow`,
   $\sum_{n=0}^\infty (n+1)^{-(\sigma + 1)}$ converges. By the comparison test, $\sum u_n(\sigma)$
   is summable.
5. **Strict Positivity:**
   The sum `groupedDirichletEta σ` satisfies:
   $$\operatorname{groupedDirichletEta}(\sigma) = \sum_{n=0}^\infty u_n(\sigma) \ge u_0(\sigma) = 1 - 2^{-\sigma} > 0.$$
6. **Real Non-Vanishing Bridge:**
   Given the functional relation $(1 - 2^{1-\sigma}) \operatorname{Re}(\zeta(\sigma)) = \operatorname{groupedDirichletEta}(\sigma)$,
   we construct the explicit `DirichletEtaIdentity σ` (where imaginary part vanishing is discharged
   by `UniversalSchwarzRHBridge.riemannZeta_ofReal_im_zero`) and deduce:
   $$\operatorname{Re}(\zeta(\sigma)) < 0 \quad \text{and} \quad \zeta(\sigma) \ne 0 \quad \text{for all } \sigma \in (0, 1).$$

## Foundational Axiom Status

All declarations depend strictly on Lean 4's standard foundational axioms:
`[propext, Classical.choice, Quot.sound]`.
-/

namespace BuildingBlocks.DirichletEtaGroupedConvergence

open Real Set
open BuildingBlocks.RiemannZetaRealNonvanishing
open BuildingBlocks.UniversalSchwarzRHBridge

noncomputable section

/-!
### 1. Grouped Eta Pairs and Pointwise Positivity
-/

/-- The $n$-th grouped pair in the Dirichlet eta series:
$u_n(\sigma) = (2n+1)^{-\sigma} - (2n+2)^{-\sigma}$. -/
def etaPair (σ : ℝ) (n : ℕ) : ℝ :=
  (2 * (n : ℝ) + 1)^(-σ) - (2 * (n : ℝ) + 2)^(-σ)

/-- Each grouped pair is strictly positive for any $\sigma > 0$. -/
theorem etaPair_pos {σ : ℝ} (hσ : 0 < σ) (n : ℕ) : 0 < etaPair σ n := by
  have h1 : 0 < 2 * (n : ℝ) + 1 := by positivity
  have h2 : 0 < 2 * (n : ℝ) + 2 := by positivity
  have hlt : 2 * (n : ℝ) + 1 < 2 * (n : ℝ) + 2 := by linarith
  have h_rpow : (2 * (n : ℝ) + 2)^(-σ) < (2 * (n : ℝ) + 1)^(-σ) := by
    rw [rpow_neg (le_of_lt h2), rpow_neg (le_of_lt h1)]
    rw [inv_lt_inv₀ (rpow_pos_of_pos h2 σ) (rpow_pos_of_pos h1 σ)]
    exact rpow_lt_rpow (le_of_lt h1) hlt hσ
  exact sub_pos.mpr h_rpow

/-- Non-negativity of grouped pairs. -/
theorem etaPair_nonneg {σ : ℝ} (hσ : 0 < σ) (n : ℕ) : 0 ≤ etaPair σ n :=
  le_of_lt (etaPair_pos hσ n)

/-- Value of the leading grouped pair at $n = 0$: $u_0(\sigma) = 1 - 2^{-\sigma}$. -/
theorem etaPair_zero {σ : ℝ} : etaPair σ 0 = 1 - (2 : ℝ)^(-σ) := by
  unfold etaPair
  simp only [Nat.cast_zero, mul_zero, zero_add]
  rw [one_rpow]

/-- The leading grouped pair is strictly positive for $\sigma > 0$. -/
theorem first_term_pos {σ : ℝ} (hσ : 0 < σ) : 0 < etaPair σ 0 := by
  rw [etaPair_zero]
  have h2 : (1 : ℝ) < 2 := by norm_num
  have h_pow_lt : (2 : ℝ)^(-σ) < (2 : ℝ)^(0 : ℝ) := by
    apply rpow_lt_rpow_of_exponent_lt h2
    linarith
  rw [rpow_zero] at h_pow_lt
  linarith

/-!
### 2. Mean Value Theorem Bound and Comparison
-/

/-- Mean Value Theorem bound: $u_n(\sigma) \le \sigma (2n+1)^{-\sigma - 1}$. -/
theorem etaPair_bound {σ : ℝ} (hσ : 0 < σ) (n : ℕ) :
    etaPair σ n ≤ σ * (2 * (n : ℝ) + 1)^(-σ - 1) := by
  let a := 2 * (n : ℝ) + 1
  let b := 2 * (n : ℝ) + 2
  have hab : a < b := by linarith
  have ha_pos : 0 < a := by positivity
  have h_ne : ∀ x ∈ Icc a b, x ≠ 0 := by
    intro x hx
    linarith [hx.1]
  have h_deriv : ∀ x ∈ Icc a b, HasDerivAt (fun t => t ^ (-σ)) ((-σ) * x ^ (-σ - 1)) x := by
    intro x hx
    exact hasDerivAt_rpow_const (Or.inl (h_ne x hx))
  have h_cont : ContinuousOn (fun t => t ^ (-σ)) (Icc a b) := by
    intro x hx
    exact (h_deriv x hx).continuousAt.continuousWithinAt
  have h_mvt := exists_hasDerivAt_eq_slope (fun t => t ^ (-σ)) (fun t => (-σ) * t ^ (-σ - 1)) hab h_cont
    (fun x hx => h_deriv x (Ioo_subset_Icc_self hx))
  rcases h_mvt with ⟨c, hc, hd⟩
  have h_ba : b - a = 1 := by
    dsimp [a, b]
    ring
  rw [h_ba, div_one] at hd
  have h_slope : (b ^ (-σ) - a ^ (-σ)) = - etaPair σ n := by
    dsimp [etaPair, a, b]
    ring
  rw [h_slope] at hd
  have h_eta_eq : etaPair σ n = σ * c ^ (-σ - 1) := by
    linarith
  rw [h_eta_eq]
  have hc_gt : a < c := hc.1
  have hc_pos : 0 < c := lt_trans ha_pos hc_gt
  have h_exp_neg : -σ - 1 < 0 := by linarith
  have hc_pow : c ^ (-σ - 1) ≤ a ^ (-σ - 1) := by
    have h_neg_exp : -σ - 1 = - (σ + 1) := by ring
    rw [h_neg_exp]
    rw [rpow_neg (le_of_lt hc_pos), rpow_neg (le_of_lt ha_pos)]
    have h_exp_pos : 0 < σ + 1 := by linarith
    rw [inv_le_inv₀ (rpow_pos_of_pos hc_pos _) (rpow_pos_of_pos ha_pos _)]
    exact rpow_le_rpow (le_of_lt ha_pos) (le_of_lt hc_gt) (le_of_lt h_exp_pos)
  exact mul_le_mul_of_nonneg_left hc_pow (le_of_lt hσ)

/-- Comparison bound with the standard shifted $p$-series:
$u_n(\sigma) \le \sigma (n+1)^{-(\sigma + 1)}$. -/
theorem etaPair_le_inv_nat_add_one {σ : ℝ} (hσ : 0 < σ) (n : ℕ) :
    etaPair σ n ≤ σ * (1 / (n + 1 : ℝ) ^ (σ + 1)) := by
  have h_bound := etaPair_bound hσ n
  have h_neg_exp : -σ - 1 = - (σ + 1) := by ring
  have ha_pos : 0 < 2 * (n : ℝ) + 1 := by positivity
  have hn_pos : 0 < (n : ℝ) + 1 := by positivity
  have h_le : (n : ℝ) + 1 ≤ 2 * (n : ℝ) + 1 := by linarith
  have h_pow_inv : (2 * (n : ℝ) + 1)^(-σ - 1) ≤ ((n : ℝ) + 1)^(-σ - 1) := by
    rw [h_neg_exp]
    rw [rpow_neg (le_of_lt ha_pos), rpow_neg (le_of_lt hn_pos)]
    have h_exp_pos : 0 < σ + 1 := by linarith
    rw [inv_le_inv₀ (rpow_pos_of_pos ha_pos _) (rpow_pos_of_pos hn_pos _)]
    exact rpow_le_rpow (le_of_lt hn_pos) h_le (le_of_lt h_exp_pos)
  have h_mul := mul_le_mul_of_nonneg_left h_pow_inv (le_of_lt hσ)
  have h_rpow_neg : ((n : ℝ) + 1)^(-σ - 1) = 1 / ((n : ℝ) + 1)^(σ + 1) := by
    rw [h_neg_exp, rpow_neg (le_of_lt hn_pos), one_div]
  rw [h_rpow_neg] at h_mul
  exact le_trans h_bound h_mul

/-!
### 3. Summability and Grouped Eta Function
-/

/-- Absolute summability of the grouped Dirichlet eta sequence for $\sigma > 0$. -/
theorem summable_etaPair {σ : ℝ} (hσ : 0 < σ) : Summable (etaPair σ) := by
  have h_exp : 1 < σ + 1 := by linarith
  have h_sum_base : Summable (fun n : ℕ ↦ 1 / |(n : ℝ) + 1| ^ (σ + 1)) :=
    (Real.summable_one_div_nat_add_rpow 1 (σ + 1)).mpr h_exp
  have h_sum_simpl : Summable (fun n : ℕ ↦ 1 / ((n : ℝ) + 1) ^ (σ + 1)) := by
    apply h_sum_base.congr
    intro n
    have hn : 0 ≤ (n : ℝ) + 1 := by positivity
    rw [abs_of_nonneg hn]
  have h_sum_mul : Summable (fun n : ℕ ↦ σ * (1 / ((n : ℝ) + 1) ^ (σ + 1))) :=
    h_sum_simpl.mul_left σ
  apply Summable.of_nonneg_of_le
  · intro n
    exact etaPair_nonneg hσ n
  · intro n
    exact etaPair_le_inv_nat_add_one hσ n
  · exact h_sum_mul

/-- The grouped Dirichlet eta function for positive real values $\sigma > 0$. -/
def groupedDirichletEta (σ : ℝ) : ℝ := ∑' (n : ℕ), etaPair σ n

/-- Lower bound by the first term: $1 - 2^{-\sigma} \le \operatorname{groupedDirichletEta}(\sigma)$. -/
theorem groupedDirichletEta_ge_first {σ : ℝ} (hσ : 0 < σ) :
    1 - (2 : ℝ)^(-σ) ≤ groupedDirichletEta σ := by
  unfold groupedDirichletEta
  have h_sum := summable_etaPair hσ
  have h_le := h_sum.le_tsum 0 (fun n _ => etaPair_nonneg hσ n)
  rw [etaPair_zero] at h_le
  exact h_le

/-- Strict positivity of the grouped Dirichlet eta sum for all $\sigma > 0$. -/
theorem groupedDirichletEta_pos {σ : ℝ} (hσ : 0 < σ) : 0 < groupedDirichletEta σ := by
  have h_t0 := first_term_pos hσ
  rw [etaPair_zero] at h_t0
  have h_le := groupedDirichletEta_ge_first hσ
  exact lt_of_lt_of_le h_t0 h_le

/-!
### 4. Integration with the Real Non-Vanishing Pipeline
-/

/-- Constructive generation of a `DirichletEtaIdentity` from the functional relation
between $\zeta$ and the grouped eta sum. -/
def dirichletEtaIdentity_of_rel {σ : ℝ} (hσ : 0 < σ)
    (h_rel : (1 - (2 : ℝ)^(1 - σ)) * (riemannZeta (σ : ℂ)).re = groupedDirichletEta σ) :
    DirichletEtaIdentity σ where
  eta_val := groupedDirichletEta σ
  h_eta_pos := groupedDirichletEta_pos hσ
  h_zeta_rel := h_rel
  h_zeta_im := riemannZeta_ofReal_im_zero hσ

/-- Under the grouped eta relation, $\zeta(\sigma)$ has strictly negative real part for $\sigma \in (0, 1)$. -/
theorem riemannZeta_re_neg_of_rel {σ : ℝ} (hσ_pos : 0 < σ) (hσ_lt : σ < 1)
    (h_rel : (1 - (2 : ℝ)^(1 - σ)) * (riemannZeta (σ : ℂ)).re = groupedDirichletEta σ) :
    (riemannZeta (σ : ℂ)).re < 0 :=
  riemannZeta_re_neg_of_eta hσ_lt (dirichletEtaIdentity_of_rel hσ_pos h_rel)

/-- Under the grouped eta relation, $\zeta(\sigma) \ne 0$ for all $\sigma \in (0, 1)$. -/
theorem riemannZeta_ne_zero_of_rel {σ : ℝ} (hσ_pos : 0 < σ) (hσ_lt : σ < 1)
    (h_rel : (1 - (2 : ℝ)^(1 - σ)) * (riemannZeta (σ : ℂ)).re = groupedDirichletEta σ) :
    riemannZeta (σ : ℂ) ≠ 0 :=
  riemannZeta_ne_zero_of_eta hσ_lt (dirichletEtaIdentity_of_rel hσ_pos h_rel)

#print axioms etaPair_pos
#print axioms etaPair_bound
#print axioms summable_etaPair
#print axioms groupedDirichletEta_pos
#print axioms dirichletEtaIdentity_of_rel
#print axioms riemannZeta_re_neg_of_rel
#print axioms riemannZeta_ne_zero_of_rel

end

end BuildingBlocks.DirichletEtaGroupedConvergence
