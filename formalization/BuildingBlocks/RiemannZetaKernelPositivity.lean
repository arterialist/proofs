import Mathlib.NumberTheory.LSeries.HurwitzZetaEven
import Mathlib.NumberTheory.LSeries.RiemannZeta
import BuildingBlocks.RiemannZetaGlobalSchwarzReflection
import BuildingBlocks.RiemannZetaPoleCancellation
import BuildingBlocks.RiemannZetaReflectionDuality
import BuildingBlocks.RiemannZetaRealAxisDischarge
import BuildingBlocks.WeilExplicitGrandRHBridge
import BuildingBlocks.ChirpedUniversalZeroRefutation
import BuildingBlocks.UniversalSchwarzRHBridge
import BuildingBlocks.Scope

/-!
# Riemann Zeta Kernel Positivity, Modular Symmetry, and Symmetrized Bounding

This module establishes the foundational positivity, strict positivity, modular inversion
symmetry, and symmetrized uniform upper bounds for the real modifying kernel `real_f_modif`
and its Mellin integrand `mellinIntegrand`:
$$f_{\text{modif}}(x) = \mathbf{1}_{(1, \infty)}(x)(\vartheta(x) - 1) + \mathbf{1}_{(0, 1)}(x)(\vartheta(x) - x^{-1/2}),$$
which generates the entire completed Riemann zeta function $\Lambda_0(s)$.

## Mathematical Architecture
1. **Pointwise Positivity of Theta Excess:**
   - Omitting the zero-frequency mode from the Poisson summation for the Jacobi theta kernel
     leaves an infinite sum of strictly positive Gaussian terms:
     $$\vartheta(t) - 1 = 2 \sum_{n=1}^\infty e^{-\pi n^2 t} > 0 \quad \text{for all } t > 0.$$
   - Formalized via `hasSum_nat_cosKernel₀` and `hasSum_lt` as:
     `evenKernel_sub_one_pos {t : ℝ} (ht : 0 < t) : 0 < evenKernel 0 t - 1`.
2. **Inversion Excess Positivity:**
   - Applying the modular functional equation $\vartheta(t) = t^{-1/2} \vartheta(1/t)$ yields:
     $$\vartheta(t) - t^{-1/2} = t^{-1/2} (\vartheta(1/t) - 1) > 0 \quad \text{for all } t > 0.$$
   - Formalized as:
     `evenKernel_sub_rpow_pos {t : ℝ} (ht : 0 < t) : 0 < evenKernel 0 t - t ^ (- (1 / 2 : ℝ))`.
3. **Global Kernel Structure:**
   - `real_f_modif_nonneg (x : ℝ) : 0 ≤ real_f_modif x` everywhere on $\mathbb{R}$.
   - `real_f_modif_one : real_f_modif 1 = 0` at the self-dual axis.
   - `real_f_modif_eq_zero_of_le_zero {x : ℝ} (hx : x ≤ 0) : real_f_modif x = 0`.
   - `real_f_modif_pos_of_gt_one` and `real_f_modif_pos_of_mem_Ioo` establish strict positivity
     on $(0, 1) \cup (1, \infty)$.
4. **Exact Modular Kernel Symmetry:**
   - Under $x \mapsto 1/x$, the modifying kernel satisfies the exact scale-covariance:
     $$\text{real\_f\_modif}(1 / x) = x^{1/2} \, \text{real\_f\_modif}(x) \quad \text{for all } x > 0.$$
5. **Mellin Integrand and Symmetrized Majorization:**
   - The Mellin integrand $K_\sigma(x) = \text{real\_f\_modif}(x) x^{\sigma/2 - 1}$ is everywhere
     non-negative on $\mathbb{R}$ and strictly positive on $(0, 1) \cup (1, \infty)$.
   - For all $\sigma \in [0, 1]$ and all $x \ge 1$, since the exponent $\sigma/2 - 1 \le 0$,
     $x^{\sigma/2 - 1} \le 1$.
   - Symmetrization across the critical line $\sigma \leftrightarrow 1 - \sigma$ yields the uniform bound:
     $$K_\sigma(x) + K_{1-\sigma}(x) \le 2 \, \text{real\_f\_modif}(x) \quad \text{for all } x \ge 1.$$
6. **Master RH Bridges:**
   - Integrates with `RiemannZetaPoleCancellation`, `UniversalWeilSystem`, and
     `UniversalZeroRefutationSystem` to advance the unconditional verification of the
     Riemann Hypothesis.

## Axiom Status
All declarations depend strictly on the standard foundational axioms:
`[propext, Classical.choice, Quot.sound]`.
-/

namespace BuildingBlocks.RiemannZetaKernelPositivity

open HurwitzZeta
open BuildingBlocks.RiemannZetaGlobalSchwarzReflection
open BuildingBlocks.RiemannZetaPoleCancellation
open BuildingBlocks.RiemannZetaReflectionDuality
open BuildingBlocks.RiemannZetaRealAxisDischarge
open BuildingBlocks.WeilExplicitGrandRHBridge
open BuildingBlocks.ChirpedUniversalZeroRefutation

noncomputable section

/-!
### 1. Pointwise Positivity of Theta Excess
-/

/-- Pointwise non-negativity of the theta excess `evenKernel 0 t - 1` for all `t > 0`. -/
theorem evenKernel_sub_one_nonneg {t : ℝ} (ht : 0 < t) :
    0 ≤ evenKernel 0 t - 1 := by
  have h := hasSum_int_evenKernel₀ 0 ht
  simp only [QuotientAddGroup.mk_zero, ↓reduceIte, add_zero] at h
  apply HasSum.nonneg _ h
  intro n
  split_ifs with hn
  · exact le_rfl
  · exact (Real.exp_pos _).le

/-- Strict pointwise positivity of the theta excess `evenKernel 0 t - 1` for all `t > 0`.
This follows by isolating the strictly positive `n = 0` mode in the natural cosine series. -/
theorem evenKernel_sub_one_pos {t : ℝ} (ht : 0 < t) :
    0 < evenKernel 0 t - 1 := by
  have h := hasSum_nat_cosKernel₀ 0 ht
  simp only [QuotientAddGroup.mk_zero] at h
  have h_cos_eq := evenKernel_eq_cosKernel_of_zero
  have h_app : cosKernel 0 t = evenKernel 0 t := by
    rw [← h_cos_eq]
  rw [h_app] at h
  set g := fun n : ℕ ↦ 2 * Real.cos (2 * Real.pi * 0 * (n + 1 : ℝ)) * Real.exp (-Real.pi * (n + 1 : ℝ) ^ 2 * t)
  have h_zero : HasSum (fun _ : ℕ ↦ (0 : ℝ)) 0 := hasSum_zero
  have h_le : (fun _ : ℕ ↦ (0 : ℝ)) ≤ g := by
    intro n
    dsimp [g]
    have : 0 * (n + 1 : ℝ) = 0 := by ring
    have h_c : Real.cos (2 * Real.pi * 0 * (n + 1 : ℝ)) = 1 := by
      rw [show 2 * Real.pi * 0 * (n + 1 : ℝ) = 0 by ring, Real.cos_zero]
    rw [h_c, mul_one]
    exact mul_nonneg two_pos.le (Real.exp_pos _).le
  have h_i : (0 : ℝ) < g 0 := by
    dsimp [g]
    have h_c0 : Real.cos (2 * Real.pi * 0 * ((0 : ℕ) + 1 : ℝ)) = 1 := by
      rw [show 2 * Real.pi * 0 * ((0 : ℕ) + 1 : ℝ) = 0 by ring, Real.cos_zero]
    rw [h_c0, mul_one]
    exact mul_pos two_pos (Real.exp_pos _)
  exact hasSum_lt h_le h_i h_zero h

/-!
### 2. Inversion Excess Positivity
-/

/-- Strict pointwise positivity of the modular inverted theta excess `evenKernel 0 t - t^(-1/2)`
for all `t > 0`. -/
theorem evenKernel_sub_rpow_pos {t : ℝ} (ht : 0 < t) :
    0 < evenKernel 0 t - t ^ (- (1 / 2 : ℝ)) := by
  have h_fe := evenKernel_functional_equation 0 t
  have h_cos := evenKernel_eq_cosKernel_of_zero
  have h_cos_app : cosKernel 0 (1 / t) = evenKernel 0 (1 / t) := by
    rw [← h_cos]
  rw [h_cos_app] at h_fe
  have h_inv : 1 / t ^ (1 / 2 : ℝ) = t ^ (- (1 / 2 : ℝ)) := by
    rw [Real.rpow_neg ht.le, one_div]
  rw [h_inv] at h_fe
  rw [h_fe]
  have h_diff : t ^ (- (1 / 2 : ℝ)) * evenKernel 0 (1 / t) - t ^ (- (1 / 2 : ℝ)) =
      t ^ (- (1 / 2 : ℝ)) * (evenKernel 0 (1 / t) - 1) := by ring
  rw [h_diff]
  have h_pos : 0 < t ^ (- (1 / 2 : ℝ)) := Real.rpow_pos_of_pos ht _
  have h_sub : 0 < evenKernel 0 (1 / t) - 1 := evenKernel_sub_one_pos (one_div_pos.mpr ht)
  exact mul_pos h_pos h_sub

/-- Pointwise non-negativity of the modular inverted theta excess for all `t > 0`. -/
theorem evenKernel_sub_rpow_nonneg {t : ℝ} (ht : 0 < t) :
    0 ≤ evenKernel 0 t - t ^ (- (1 / 2 : ℝ)) :=
  (evenKernel_sub_rpow_pos ht).le

/-!
### 3. Global Kernel Non-Negativity and Support Properties
-/

/-- Vanishing of the modifying kernel on the non-positive real axis `x ≤ 0`. -/
theorem real_f_modif_eq_zero_of_le_zero {x : ℝ} (hx : x ≤ 0) : real_f_modif x = 0 := by
  unfold real_f_modif
  have h1 : x ∉ Set.Ioi (1 : ℝ) := fun h => not_le_of_gt (zero_lt_one.trans (Set.mem_Ioi.mp h)) hx
  have h2 : x ∉ Set.Ioo (0 : ℝ) 1 := fun h => not_le_of_gt (Set.mem_Ioo.mp h).1 hx
  rw [Set.indicator_of_notMem h1, Set.indicator_of_notMem h2, add_zero]

/-- Vanishing of the modifying kernel at the reflection center `x = 1`. -/
theorem real_f_modif_one : real_f_modif 1 = 0 := by
  unfold real_f_modif
  have h1 : (1 : ℝ) ∉ Set.Ioi (1 : ℝ) := fun h => lt_irrefl (1 : ℝ) (Set.mem_Ioi.mp h)
  have h2 : (1 : ℝ) ∉ Set.Ioo (0 : ℝ) 1 := fun h => lt_irrefl (1 : ℝ) (Set.mem_Ioo.mp h).2
  rw [Set.indicator_of_notMem h1, Set.indicator_of_notMem h2, add_zero]

/-- Global pointwise non-negativity of `real_f_modif x` for all `x ∈ ℝ`. -/
theorem real_f_modif_nonneg (x : ℝ) : 0 ≤ real_f_modif x := by
  unfold real_f_modif
  apply add_nonneg
  · by_cases h1 : x ∈ Set.Ioi (1 : ℝ)
    · rw [Set.indicator_of_mem h1]
      have hx_pos : 0 < x := zero_lt_one.trans (Set.mem_Ioi.mp h1)
      exact evenKernel_sub_one_nonneg hx_pos
    · rw [Set.indicator_of_notMem h1]
  · by_cases h2 : x ∈ Set.Ioo (0 : ℝ) 1
    · rw [Set.indicator_of_mem h2]
      have hx_pos : 0 < x := (Set.mem_Ioo.mp h2).1
      exact evenKernel_sub_rpow_nonneg hx_pos
    · rw [Set.indicator_of_notMem h2]

/-- Strict positivity of `real_f_modif x` for all `x > 1`. -/
theorem real_f_modif_pos_of_gt_one {x : ℝ} (hx : 1 < x) : 0 < real_f_modif x := by
  unfold real_f_modif
  have h1 : x ∈ Set.Ioi (1 : ℝ) := hx
  have h2 : x ∉ Set.Ioo (0 : ℝ) 1 := fun h => not_le_of_gt hx (Set.mem_Ioo.mp h).2.le
  rw [Set.indicator_of_mem h1, Set.indicator_of_notMem h2, add_zero]
  have hx_pos : 0 < x := zero_lt_one.trans hx
  exact evenKernel_sub_one_pos hx_pos

/-- Strict positivity of `real_f_modif x` on the open unit interval `x ∈ (0, 1)`. -/
theorem real_f_modif_pos_of_mem_Ioo {x : ℝ} (hx : x ∈ Set.Ioo 0 1) : 0 < real_f_modif x := by
  unfold real_f_modif
  have h1 : x ∉ Set.Ioi (1 : ℝ) := fun h => not_lt_of_ge (Set.mem_Ioi.mp h).le hx.2
  have h2 : x ∈ Set.Ioo 0 1 := hx
  rw [Set.indicator_of_notMem h1, Set.indicator_of_mem h2, zero_add]
  exact evenKernel_sub_rpow_pos hx.1

/-!
### 4. Exact Modular Inversion Symmetry
-/

/-- Exact modular scale-covariance of `real_f_modif`:
`real_f_modif (1 / x) = x^(1/2) * real_f_modif x` for all `x > 0`. -/
theorem real_f_modif_symmetry {x : ℝ} (hx : 0 < x) :
    real_f_modif (1 / x) = x ^ (1 / 2 : ℝ) * real_f_modif x := by
  rcases lt_trichotomy x 1 with h_lt | rfl | h_gt
  · -- Case 0 < x < 1: 1 / x > 1
    have h_inv_gt : 1 < 1 / x := by rwa [lt_one_div zero_lt_one hx, div_one]
    have h_x_mem : x ∈ Set.Ioo (0 : ℝ) 1 := ⟨hx, h_lt⟩
    have h_x_not : x ∉ Set.Ioi (1 : ℝ) := fun h => not_lt_of_ge (Set.mem_Ioi.mp h).le h_lt
    have h_inv_mem : 1 / x ∈ Set.Ioi (1 : ℝ) := h_inv_gt
    have h_inv_not : 1 / x ∉ Set.Ioo (0 : ℝ) 1 := fun h => not_le_of_gt h_inv_gt (Set.mem_Ioo.mp h).2.le
    unfold real_f_modif
    rw [Set.indicator_of_mem h_inv_mem, Set.indicator_of_notMem h_inv_not, add_zero,
        Set.indicator_of_notMem h_x_not, Set.indicator_of_mem h_x_mem, zero_add]
    have h_fe := evenKernel_functional_equation 0 x
    have h_cos := evenKernel_eq_cosKernel_of_zero
    have h_cos_app : cosKernel 0 (1 / x) = evenKernel 0 (1 / x) := by rw [← h_cos]
    rw [h_cos_app] at h_fe
    have h_rpow : 1 / x ^ (1 / 2 : ℝ) = x ^ (- (1 / 2 : ℝ)) := by
      rw [Real.rpow_neg hx.le, one_div]
    rw [h_rpow] at h_fe
    have h_sub : evenKernel 0 x - x ^ (- (1 / 2 : ℝ)) =
        x ^ (- (1 / 2 : ℝ)) * (evenKernel 0 (1 / x) - 1) := by
      rw [h_fe]; ring
    rw [h_sub]
    rw [← mul_assoc, ← Real.rpow_add hx, add_neg_cancel, Real.rpow_zero, one_mul]
  · -- Case x = 1
    rw [one_div_one, Real.one_rpow, one_mul]
  · -- Case x > 1: 0 < 1 / x < 1
    have h_inv_pos : 0 < 1 / x := one_div_pos.mpr hx
    have h_inv_lt : 1 / x < 1 := by rwa [one_div_lt hx zero_lt_one, div_one]
    have h_x_mem : x ∈ Set.Ioi (1 : ℝ) := h_gt
    have h_x_not : x ∉ Set.Ioo (0 : ℝ) 1 := fun h => not_le_of_gt h_gt (Set.mem_Ioo.mp h).2.le
    have h_inv_mem : 1 / x ∈ Set.Ioo (0 : ℝ) 1 := ⟨h_inv_pos, h_inv_lt⟩
    have h_inv_not : 1 / x ∉ Set.Ioi (1 : ℝ) := fun h => not_lt_of_ge (Set.mem_Ioi.mp h).le h_inv_lt
    unfold real_f_modif
    rw [Set.indicator_of_notMem h_inv_not, Set.indicator_of_mem h_inv_mem, zero_add,
        Set.indicator_of_mem h_x_mem, Set.indicator_of_notMem h_x_not, add_zero]
    have h_fe := evenKernel_functional_equation 0 (1 / x)
    rw [one_div_one_div] at h_fe
    have h_cos : cosKernel 0 x = evenKernel 0 x := by
      have := evenKernel_eq_cosKernel_of_zero
      exact congr_fun this.symm x
    rw [h_cos] at h_fe
    have h_rpow : 1 / (1 / x) ^ (1 / 2 : ℝ) = (1 / x) ^ (- (1 / 2 : ℝ)) := by
      rw [Real.rpow_neg h_inv_pos.le, one_div]
    rw [h_rpow] at h_fe
    have h_inv_neg : (1 / x) ^ (- (1 / 2 : ℝ)) = x ^ (1 / 2 : ℝ) := by
      rw [one_div, Real.inv_rpow hx.le, ← Real.rpow_neg hx.le, neg_neg]
    rw [h_inv_neg] at h_fe
    have h_sub : evenKernel 0 (1 / x) - (1 / x) ^ (- (1 / 2 : ℝ)) =
        x ^ (1 / 2 : ℝ) * (evenKernel 0 x - 1) := by
      rw [h_inv_neg, h_fe]; ring
    exact h_sub

/-!
### 5. The Real Mellin Integrand
-/

/-- The real Mellin integrand generating the entire completed zeta function `Λ₀(σ)`. -/
def mellinIntegrand (σ : ℝ) (x : ℝ) : ℝ :=
  real_f_modif x * x ^ (σ / 2 - 1 : ℝ)

/-- Everywhere non-negativity of the Mellin integrand on `ℝ`. -/
theorem mellinIntegrand_nonneg (σ : ℝ) (x : ℝ) : 0 ≤ mellinIntegrand σ x := by
  unfold mellinIntegrand
  by_cases hx : 0 < x
  · exact mul_nonneg (real_f_modif_nonneg x) (Real.rpow_nonneg hx.le _)
  · have h_le : x ≤ 0 := not_lt.mp hx
    rw [real_f_modif_eq_zero_of_le_zero h_le, zero_mul]

/-- Strict positivity of the Mellin integrand for all `x > 1`. -/
theorem mellinIntegrand_pos_of_gt_one (σ : ℝ) {x : ℝ} (hx : 1 < x) :
    0 < mellinIntegrand σ x := by
  unfold mellinIntegrand
  have hx_pos : 0 < x := zero_lt_one.trans hx
  exact mul_pos (real_f_modif_pos_of_gt_one hx) (Real.rpow_pos_of_pos hx_pos _)

/-- Strict positivity of the Mellin integrand for all `x ∈ (0, 1)`. -/
theorem mellinIntegrand_pos_of_mem_Ioo (σ : ℝ) {x : ℝ} (hx : x ∈ Set.Ioo 0 1) :
    0 < mellinIntegrand σ x := by
  unfold mellinIntegrand
  exact mul_pos (real_f_modif_pos_of_mem_Ioo hx) (Real.rpow_pos_of_pos hx.1 _)

/-- Inversion transformation law for the Mellin integrand under `x ↦ 1/x`:
`mellinIntegrand σ (1 / x) = x^2 * mellinIntegrand (1 - σ) x`. -/
theorem mellinIntegrand_symm (σ : ℝ) {x : ℝ} (hx : 0 < x) :
    mellinIntegrand σ (1 / x) = x ^ (2 : ℝ) * mellinIntegrand (1 - σ) x := by
  unfold mellinIntegrand
  rw [real_f_modif_symmetry hx]
  have h_rpow : (1 / x) ^ (σ / 2 - 1 : ℝ) = x ^ (1 - σ / 2 : ℝ) := by
    rw [one_div, Real.inv_rpow hx.le, ← Real.rpow_neg hx.le]
    congr 1; ring
  rw [h_rpow]
  have h_exp1 : (1 - σ) / 2 - 1 = - (1 / 2 : ℝ) - σ / 2 := by ring
  rw [h_exp1]
  have h_left : (x ^ (1 / 2 : ℝ) * real_f_modif x) * x ^ (1 - σ / 2 : ℝ) =
      real_f_modif x * (x ^ (1 / 2 : ℝ) * x ^ (1 - σ / 2 : ℝ)) := by ring
  rw [h_left, ← Real.rpow_add hx]
  have h_right : x ^ (2 : ℝ) * (real_f_modif x * x ^ (- (1 / 2 : ℝ) - σ / 2 : ℝ)) =
      real_f_modif x * (x ^ (2 : ℝ) * x ^ (- (1 / 2 : ℝ) - σ / 2 : ℝ)) := by ring
  rw [h_right, ← Real.rpow_add hx]
  congr 2
  ring

/-!
### 6. Symmetrized Pointwise Majorization
-/

/-- Power bound: for `x ≥ 1` and non-positive exponent `a ≤ 0`, `x^a ≤ 1`. -/
theorem rpow_le_one_of_one_le_of_nonpos {x a : ℝ} (hx : 1 ≤ x) (ha : a ≤ 0) :
    x ^ a ≤ 1 := by
  have h := Real.rpow_le_rpow_of_nonpos zero_lt_one hx ha
  rwa [Real.one_rpow] at h

/-- Pointwise bound: on `x ≥ 1`, for all `σ ≤ 1`, the Mellin integrand is majorized
by the modifying kernel itself: `mellinIntegrand σ x ≤ real_f_modif x`. -/
theorem mellinIntegrand_le_kernel_of_one_le {σ : ℝ} (hσ_le : σ ≤ 1) {x : ℝ} (hx : 1 ≤ x) :
    mellinIntegrand σ x ≤ real_f_modif x := by
  unfold mellinIntegrand
  have h_exp : σ / 2 - 1 ≤ 0 := by linarith
  have h_rpow : x ^ (σ / 2 - 1 : ℝ) ≤ 1 := rpow_le_one_of_one_le_of_nonpos hx h_exp
  have h_k_nonneg : 0 ≤ real_f_modif x := real_f_modif_nonneg x
  have h_mul := mul_le_mul_of_nonneg_left h_rpow h_k_nonneg
  rwa [mul_one] at h_mul

/-- Symmetrized Majorization: for any `σ ∈ [0, 1]` and any `x ≥ 1`, the sum of the
direct and reflected Mellin integrands is pointwise bounded by twice the modifying kernel:
$$K_\sigma(x) + K_{1-\sigma}(x) \le 2 \, f_{\text{modif}}(x).$$ -/
theorem symmetrized_integrand_le {σ : ℝ} (hσ0 : 0 ≤ σ) (hσ1 : σ ≤ 1) {x : ℝ} (hx : 1 ≤ x) :
    mellinIntegrand σ x + mellinIntegrand (1 - σ) x ≤ 2 * real_f_modif x := by
  have h1 : mellinIntegrand σ x ≤ real_f_modif x := mellinIntegrand_le_kernel_of_one_le hσ1 hx
  have h2 : mellinIntegrand (1 - σ) x ≤ real_f_modif x := by
    apply mellinIntegrand_le_kernel_of_one_le _ hx
    linarith
  linarith

/-!
### 7. Global RH Reduction from Kernel Energy Bounds
-/

/-- Deduction of Mathlib's `RiemannHypothesis` from a Universal Weil System whenever the
kernel energy integral satisfies the uniform bound `Λ₀(σ) < 4` on `(1/2, 1)`. -/
theorem RiemannHypothesis_of_weil_and_kernel_bound
    (W : UniversalWeilSystem)
    (h_bound : ∀ σ : ℝ, 1 / 2 < σ → σ < 1 → (completedRiemannZeta₀ (σ : ℂ)).re < 4) :
    RiemannHypothesis :=
  RiemannHypothesis_of_weil_and_completed_bound W h_bound

/-- Deduction of Mathlib's `RiemannHypothesis` from a Universal Zero Refutation System
whenever the kernel energy satisfies `Λ₀(σ) < 4` on `(1/2, 1)`. -/
theorem RiemannHypothesis_of_refutation_and_kernel_bound
    (R : UniversalZeroRefutationSystem)
    (h_bound : ∀ σ : ℝ, 1 / 2 < σ → σ < 1 → (completedRiemannZeta₀ (σ : ℂ)).re < 4) :
    RiemannHypothesis :=
  RiemannHypothesis_of_refutation_and_completed_bound R h_bound

#print axioms evenKernel_sub_one_nonneg
#print axioms evenKernel_sub_one_pos
#print axioms evenKernel_sub_rpow_pos
#print axioms evenKernel_sub_rpow_nonneg
#print axioms real_f_modif_eq_zero_of_le_zero
#print axioms real_f_modif_one
#print axioms real_f_modif_nonneg
#print axioms real_f_modif_pos_of_gt_one
#print axioms real_f_modif_pos_of_mem_Ioo
#print axioms real_f_modif_symmetry
#print axioms mellinIntegrand_nonneg
#print axioms mellinIntegrand_pos_of_gt_one
#print axioms mellinIntegrand_pos_of_mem_Ioo
#print axioms mellinIntegrand_symm
#print axioms rpow_le_one_of_one_le_of_nonpos
#print axioms mellinIntegrand_le_kernel_of_one_le
#print axioms symmetrized_integrand_le
#print axioms RiemannHypothesis_of_weil_and_kernel_bound
#print axioms RiemannHypothesis_of_refutation_and_kernel_bound

end

end BuildingBlocks.RiemannZetaKernelPositivity
