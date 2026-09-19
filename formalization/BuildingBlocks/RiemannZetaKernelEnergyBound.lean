import Mathlib.NumberTheory.LSeries.HurwitzZetaEven
import Mathlib.Topology.Algebra.InfiniteSum.Order
import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Analysis.Complex.ExponentialBounds
import Mathlib.Analysis.Real.Pi.Bounds
import Mathlib.Analysis.SpecialFunctions.ImproperIntegrals
import BuildingBlocks.RiemannZetaKernelPositivity
import BuildingBlocks.RiemannZetaPoleCancellation
import BuildingBlocks.RiemannZetaGlobalSchwarzReflection
import BuildingBlocks.WeilExplicitGrandRHBridge
import BuildingBlocks.ChirpedUniversalZeroRefutation

/-!
# Riemann Zeta Kernel Energy Bound and Symmetrized Majorization

This module formalizes the geometric series majorization and exponential energy bound for the
symmetrized modifying kernel of the completed Riemann zeta function on the half-line `[1, ∞)`.

## Mathematical Overview

For any $t > 0$, the Jacobi theta kernel excess satisfies:
$$\vartheta(t) - 1 = 2 \sum_{n=1}^\infty e^{-\pi n^2 t}.$$
Since $n \le n^2$ for all $n \ge 1$, we have $-\pi n^2 t \le -\pi n t$, yielding the
pointwise geometric comparison:
$$2 \sum_{n=1}^\infty e^{-\pi n^2 t} \le 2 \sum_{n=1}^\infty e^{-\pi n t}
  = \frac{2 e^{-\pi t}}{1 - e^{-\pi t}}.$$

For all $t \ge 1$, since $\pi > 3$ implies $e^{-\pi} \le 1/2$, the denominator satisfies
$1 - e^{-\pi t} \ge 1 - e^{-\pi} \ge 1/2$. Consequently,
$$\vartheta(t) - 1 \le 4 e^{-\pi t} \quad \text{for all } t \ge 1.$$

For the symmetrized Mellin integrand $K_\sigma(x) + K_{1-\sigma}(x)$ on $[1, \infty)$ with
$\sigma \in [0, 1]$, we obtain:
$$K_\sigma(x) + K_{1-\sigma}(x) \le 2 f_{\text{modif}}(x) \le 8 e^{-\pi x}.$$

Evaluating the improper integral on $(1, \infty)$:
$$\int_1^\infty 8 e^{-\pi x} \, dx = \frac{8 e^{-\pi}}{\pi} \le \frac{8 \cdot (1/2)}{3} = \frac{4}{3} < 4.$$

Multiplying by the normalization factor $1/2$ gives:
$$\frac{1}{2} \int_1^\infty 8 e^{-\pi x} \, dx \le \frac{2}{3} < 2 < 4,$$
which strictly falls below the critical pole cancellation threshold of $4$.

## Main Theorems

- `nat_le_sq`: Quadratic power domination $n \le n^2$.
- `exp_neg_pi_sq_le_exp_neg_pi_mul`: Pointwise series term majorization by geometric terms.
- `evenKernel_sub_one_le_geom`: Uniform bound $\vartheta(t) - 1 \le \frac{2 e^{-\pi t}}{1 - e^{-\pi t}}$.
- `evenKernel_sub_one_le_four_exp`: Exponential decay $\vartheta(t) - 1 \le 4 e^{-\pi t}$ on $[1, \infty)$.
- `real_f_modif_le_four_exp`: Kernel bound $f_{\text{modif}}(x) \le 4 e^{-\pi x}$ on $[1, \infty)$.
- `mellinIntegrand_le_four_exp`: Integrand bound $K_\sigma(x) \le 4 e^{-\pi x}$ on $[1, \infty)$ for $\sigma \le 1$.
- `symmetrized_integrand_le_eight_exp`: Symmetrized bound $K_\sigma(x) + K_{1-\sigma}(x) \le 8 e^{-\pi x}$.
- `integral_exp_neg_pi_Ioi_one`: Improper integral evaluation $\int_1^\infty e^{-\pi x} dx = e^{-\pi}/\pi$.
- `integral_exp_neg_pi_le_one_sixth`: Numerical majorization $\int_1^\infty e^{-\pi x} dx \le 1/6$.
- `integral_symmetrizedEnergyBound_lt_four`: Energy bound $\int_1^\infty 8 e^{-\pi x} dx < 4$.
- `half_integral_symmetrizedEnergyBound_lt_four`: Normalized energy bound $\frac{1}{2} \int_1^\infty 8 e^{-\pi x} dx < 4$.
- `RiemannHypothesis_of_weil_and_energy_bound`: RH deduction from Weil system and kernel energy.
- `RiemannHypothesis_of_refutation_and_energy_bound`: RH deduction from refutation system and kernel energy.

## Axiom Status
This module uses standard foundational Lean 4 axioms (`[propext, Classical.choice, Quot.sound]`)
with 0 sorries.
-/

namespace BuildingBlocks.RiemannZetaKernelEnergyBound

open Real
open HurwitzZeta
open BuildingBlocks.RiemannZetaKernelPositivity
open BuildingBlocks.RiemannZetaPoleCancellation
open BuildingBlocks.RiemannZetaGlobalSchwarzReflection
open BuildingBlocks.WeilExplicitGrandRHBridge
open BuildingBlocks.ChirpedUniversalZeroRefutation

/-! ### 1. Elementary Quadratic and Exponential Majorization -/

/-- Every natural number is bounded by its square. -/
theorem nat_le_sq (n : ℕ) : n ≤ n ^ 2 := by
  cases n with
  | zero => rfl
  | succ n =>
    have : 1 ≤ n + 1 := Nat.succ_le_succ (Nat.zero_le _)
    calc n + 1 ≤ (n + 1) * 1 := by rw [mul_one]
    _ ≤ (n + 1) * (n + 1) := Nat.mul_le_mul_left _ this
    _ = (n + 1) ^ 2 := by ring

/-- The quadratic exponential term is bounded above by the linear exponential term for all $t > 0$. -/
theorem exp_neg_pi_sq_le_exp_neg_pi_mul (n : ℕ) {t : ℝ} (ht : 0 < t) :
    Real.exp (-Real.pi * (n : ℝ) ^ 2 * t) ≤ Real.exp (-Real.pi * (n : ℝ) * t) := by
  apply Real.exp_le_exp.mpr
  have h_pi_pos : 0 < Real.pi := Real.pi_pos
  have h_le : (n : ℝ) ≤ (n : ℝ) ^ 2 := by
    exact_mod_cast nat_le_sq n
  have h_pi_t : 0 ≤ Real.pi * t := mul_nonneg h_pi_pos.le ht.le
  have h_mul := mul_le_mul_of_nonneg_right h_le h_pi_t
  have h_eq1 : (n : ℝ) * (Real.pi * t) = Real.pi * (n : ℝ) * t := by ring
  have h_eq2 : (n : ℝ) ^ 2 * (Real.pi * t) = Real.pi * (n : ℝ) ^ 2 * t := by ring
  rw [h_eq1, h_eq2] at h_mul
  linarith

/-- Linear exponential powers decompose into natural powers of the base ratio. -/
theorem exp_geom_pow (n : ℕ) (t : ℝ) :
    Real.exp (-Real.pi * (n : ℝ) * t) = (Real.exp (-Real.pi * t)) ^ n := by
  have : -Real.pi * (n : ℝ) * t = (n : ℝ) * (-Real.pi * t) := by ring
  rw [this, Real.exp_nat_mul]

/-- The geometric ratio $\exp(-\pi t)$ is strictly less than 1 for all $t > 0$. -/
theorem exp_neg_pi_lt_one {t : ℝ} (ht : 0 < t) : Real.exp (-Real.pi * t) < 1 := by
  rw [Real.exp_lt_one_iff]
  have : 0 < Real.pi * t := mul_pos Real.pi_pos ht
  linarith

/-- Non-negativity of the geometric ratio. -/
theorem exp_neg_pi_nonneg (t : ℝ) : 0 ≤ Real.exp (-Real.pi * t) :=
  (Real.exp_pos _).le

/-- The geometric series sum for theta kernel comparison. -/
theorem hasSum_geom_theta {t : ℝ} (ht : 0 < t) :
    HasSum (fun n : ℕ ↦ 2 * Real.exp (-Real.pi * t) * (Real.exp (-Real.pi * t)) ^ n)
      (2 * Real.exp (-Real.pi * t) / (1 - Real.exp (-Real.pi * t))) := by
  have h_r_lt := exp_neg_pi_lt_one ht
  have h_r_nonneg := exp_neg_pi_nonneg t
  have h_geom := hasSum_geometric_of_lt_one h_r_nonneg h_r_lt
  have h_mul := HasSum.mul_left (2 * Real.exp (-Real.pi * t)) h_geom
  rwa [div_eq_mul_inv]

/-! ### 2. Pointwise Theta Kernel Majorization by Geometric Series -/

/-- The theta excess $\vartheta(t) - 1$ is pointwise bounded by the geometric series sum for all $t > 0$. -/
theorem evenKernel_sub_one_le_geom {t : ℝ} (ht : 0 < t) :
    evenKernel 0 t - 1 ≤ 2 * Real.exp (-Real.pi * t) / (1 - Real.exp (-Real.pi * t)) := by
  have h_cos := hasSum_nat_cosKernel₀ 0 ht
  simp only [QuotientAddGroup.mk_zero] at h_cos
  have h_cos_eq := evenKernel_eq_cosKernel_of_zero
  have h_app : cosKernel 0 t = evenKernel 0 t := by rw [← h_cos_eq]
  rw [h_app] at h_cos
  have h_geom := hasSum_geom_theta ht
  apply hasSum_le _ h_cos h_geom
  intro n
  have h_cos_one : Real.cos (2 * Real.pi * 0 * (n + 1 : ℝ)) = 1 := by
    rw [show 2 * Real.pi * 0 * (n + 1 : ℝ) = 0 by ring, Real.cos_zero]
  rw [h_cos_one, mul_one]
  have h_exp_le := exp_neg_pi_sq_le_exp_neg_pi_mul (n + 1) ht
  have h_mul := mul_le_mul_of_nonneg_left h_exp_le two_pos.le
  have h_pow : Real.exp (-Real.pi * ((n + 1 : ℕ) : ℝ) * t) =
      Real.exp (-Real.pi * t) * (Real.exp (-Real.pi * t)) ^ n := by
    have h_nat : ((n + 1 : ℕ) : ℝ) = (n : ℝ) + 1 := Nat.cast_add_one n
    rw [h_nat]
    have h_split : -Real.pi * ((n : ℝ) + 1) * t = -Real.pi * t + (-Real.pi * (n : ℝ) * t) := by ring
    rw [h_split, Real.exp_add, exp_geom_pow, mul_comm]
  push_cast at h_exp_le
  rw [show -Real.pi * ((n : ℝ) + 1) ^ 2 * t = -Real.pi * ((n + 1 : ℕ) : ℝ) ^ 2 * t by push_cast; rfl]
  calc 2 * Real.exp (-Real.pi * ((n + 1 : ℕ) : ℝ) ^ 2 * t)
    _ ≤ 2 * Real.exp (-Real.pi * ((n + 1 : ℕ) : ℝ) * t) := h_mul
    _ = 2 * (Real.exp (-Real.pi * t) * (Real.exp (-Real.pi * t)) ^ n) := by rw [h_pow]
    _ = 2 * Real.exp (-Real.pi * t) * (Real.exp (-Real.pi * t)) ^ n := by ring

/-! ### 3. Uniform Denominator Bounds on the Ray $[1, \infty)$ -/

/-- $\exp(-\pi) \le 1/2$. -/
theorem exp_neg_pi_le_half : Real.exp (-Real.pi) ≤ 1 / 2 := by
  have h_pi : 1 ≤ Real.pi := by linarith [Real.pi_gt_three]
  have h_two_lt_exp1 : (2 : ℝ) ≤ Real.exp 1 := by linarith [Real.exp_one_gt_d9]
  have h_exp_pi : (2 : ℝ) ≤ Real.exp Real.pi := by
    have : Real.exp 1 ≤ Real.exp Real.pi := Real.exp_le_exp.mpr h_pi
    linarith
  have h_pos : 0 < Real.exp Real.pi := Real.exp_pos _
  have h_inv : (Real.exp Real.pi)⁻¹ ≤ (2 : ℝ)⁻¹ := (inv_le_inv₀ h_pos zero_lt_two).mpr h_exp_pi
  rw [← Real.exp_neg, ← one_div] at h_inv
  exact h_inv

/-- $1/2 \le 1 - \exp(-\pi)$. -/
theorem sub_exp_neg_pi_ge_half : 1 / 2 ≤ 1 - Real.exp (-Real.pi) := by
  have := exp_neg_pi_le_half
  linarith

/-- Monotonicity of exponential on $[1, \infty)$: $\exp(-\pi t) \le \exp(-\pi)$ for $t \ge 1$. -/
theorem exp_neg_pi_mul_le_of_one_le {t : ℝ} (ht : 1 ≤ t) :
    Real.exp (-Real.pi * t) ≤ Real.exp (-Real.pi) := by
  apply Real.exp_le_exp.mpr
  have h_pi_pos : 0 < Real.pi := Real.pi_pos
  nlinarith

/-- Denominator lower bound $1/2 \le 1 - \exp(-\pi t)$ for all $t \ge 1$. -/
theorem one_sub_exp_ge_half_of_one_le {t : ℝ} (ht : 1 ≤ t) :
    1 / 2 ≤ 1 - Real.exp (-Real.pi * t) := by
  have h1 := exp_neg_pi_mul_le_of_one_le ht
  have h2 := exp_neg_pi_le_half
  linarith

/-- Pointwise exponential decay $\vartheta(t) - 1 \le 4 \exp(-\pi t)$ on $[1, \infty)$. -/
theorem evenKernel_sub_one_le_four_exp {t : ℝ} (ht : 1 ≤ t) :
    evenKernel 0 t - 1 ≤ 4 * Real.exp (-Real.pi * t) := by
  have ht_pos : 0 < t := zero_lt_one.trans_le ht
  have h_geom := evenKernel_sub_one_le_geom ht_pos
  have h_denom : 1 / 2 ≤ 1 - Real.exp (-Real.pi * t) := one_sub_exp_ge_half_of_one_le ht
  have h_div : 2 * Real.exp (-Real.pi * t) / (1 - Real.exp (-Real.pi * t)) ≤
      2 * Real.exp (-Real.pi * t) / (1 / 2) := by
    apply div_le_div_of_nonneg_left
    · exact mul_nonneg two_pos.le (Real.exp_pos _).le
    · norm_num
    · exact h_denom
  have h_four : 2 * Real.exp (-Real.pi * t) / (1 / 2) = 4 * Real.exp (-Real.pi * t) := by ring
  rw [h_four] at h_div
  exact h_geom.trans h_div

/-! ### 4. Modifying Kernel and Mellin Integrand Exponential Bounds -/

/-- The modifying kernel $f_{\text{modif}}(x)$ is bounded by $4 \exp(-\pi x)$ for all $x \ge 1$. -/
theorem real_f_modif_le_four_exp {x : ℝ} (hx : 1 ≤ x) :
    real_f_modif x ≤ 4 * Real.exp (-Real.pi * x) := by
  rcases eq_or_lt_of_le hx with rfl | h_gt
  · rw [real_f_modif_one]
    exact mul_nonneg (by norm_num) (Real.exp_pos _).le
  · unfold real_f_modif
    have h1 : x ∈ Set.Ioi (1 : ℝ) := h_gt
    have h2 : x ∉ Set.Ioo (0 : ℝ) 1 := fun h => not_le_of_gt h_gt (Set.mem_Ioo.mp h).2.le
    rw [Set.indicator_of_mem h1, Set.indicator_of_notMem h2, add_zero]
    exact evenKernel_sub_one_le_four_exp hx

/-- The Mellin integrand $K_\sigma(x)$ is bounded by $4 \exp(-\pi x)$ on $[1, \infty)$ for $\sigma \le 1$. -/
theorem mellinIntegrand_le_four_exp {σ : ℝ} (hσ_le : σ ≤ 1) {x : ℝ} (hx : 1 ≤ x) :
    mellinIntegrand σ x ≤ 4 * Real.exp (-Real.pi * x) := by
  have h1 := mellinIntegrand_le_kernel_of_one_le hσ_le hx
  have h2 := real_f_modif_le_four_exp hx
  exact h1.trans h2

/-- The symmetrized integrand $K_\sigma(x) + K_{1-\sigma}(x)$ is bounded by $8 \exp(-\pi x)$ on $[1, \infty)$
for all $\sigma \in [0, 1]$. -/
theorem symmetrized_integrand_le_eight_exp {σ : ℝ} (hσ0 : 0 ≤ σ) (hσ1 : σ ≤ 1) {x : ℝ} (hx : 1 ≤ x) :
    mellinIntegrand σ x + mellinIntegrand (1 - σ) x ≤ 8 * Real.exp (-Real.pi * x) := by
  have h_symm := symmetrized_integrand_le hσ0 hσ1 hx
  have h_k := real_f_modif_le_four_exp hx
  calc mellinIntegrand σ x + mellinIntegrand (1 - σ) x
    _ ≤ 2 * real_f_modif x := h_symm
    _ ≤ 2 * (4 * Real.exp (-Real.pi * x)) := mul_le_mul_of_nonneg_left h_k two_pos.le
    _ = 8 * Real.exp (-Real.pi * x) := by ring

/-! ### 5. Improper Integral Evaluation and Energy Bounds -/

/-- Evaluation of the improper integral of $\exp(-\pi x)$ on $(1, \infty)$. -/
theorem integral_exp_neg_pi_Ioi_one :
    ∫ x in Set.Ioi (1 : ℝ), Real.exp (-Real.pi * x) = Real.exp (-Real.pi) / Real.pi := by
  have ha : -Real.pi < 0 := neg_lt_zero.mpr Real.pi_pos
  have h := integral_exp_mul_Ioi ha 1
  rw [mul_one] at h
  rw [h]
  ring

/-- Numerical upper bound $\int_1^\infty \exp(-\pi x) dx \le 1/6$. -/
theorem integral_exp_neg_pi_le_one_sixth :
    ∫ x in Set.Ioi (1 : ℝ), Real.exp (-Real.pi * x) ≤ 1 / 6 := by
  rw [integral_exp_neg_pi_Ioi_one]
  have h_num : Real.exp (-Real.pi) ≤ 1 / 2 := exp_neg_pi_le_half
  have h_pi : 3 ≤ Real.pi := by linarith [Real.pi_gt_three]
  have h_pos : 0 < Real.pi := Real.pi_pos
  have h1 : Real.exp (-Real.pi) / Real.pi ≤ (1 / 2) / Real.pi :=
    div_le_div_of_nonneg_right h_num h_pos.le
  have h2 : (1 / 2 : ℝ) / Real.pi ≤ (1 / 2 : ℝ) / 3 :=
    div_le_div_of_nonneg_left (by norm_num) (by norm_num) h_pi
  have : (1 / 2 : ℝ) / 3 = 1 / 6 := by norm_num
  linarith

/-- Eight times the tail integral is strictly less than 4. -/
theorem eight_mul_integral_exp_neg_pi_lt_four :
    8 * (∫ x in Set.Ioi (1 : ℝ), Real.exp (-Real.pi * x)) < 4 := by
  have h := integral_exp_neg_pi_le_one_sixth
  have h_mul := mul_le_mul_of_nonneg_left h (by norm_num : (0 : ℝ) ≤ 8)
  have : (8 : ℝ) * (1 / 6) < 4 := by norm_num
  exact lt_of_le_of_lt h_mul this

/-- The dominant exponential energy envelope $8 \exp(-\pi x)$. -/
noncomputable def symmetrizedEnergyBound (x : ℝ) : ℝ := 8 * Real.exp (-Real.pi * x)

/-- Improper integral formula for the symmetrized energy envelope. -/
theorem integral_symmetrizedEnergyBound :
    ∫ x in Set.Ioi (1 : ℝ), symmetrizedEnergyBound x = 8 * Real.exp (-Real.pi) / Real.pi := by
  unfold symmetrizedEnergyBound
  rw [MeasureTheory.integral_const_mul, integral_exp_neg_pi_Ioi_one]
  ring

/-- The total tail energy is strictly bounded by 4. -/
theorem integral_symmetrizedEnergyBound_lt_four :
    ∫ x in Set.Ioi (1 : ℝ), symmetrizedEnergyBound x < 4 := by
  unfold symmetrizedEnergyBound
  rw [MeasureTheory.integral_const_mul]
  exact eight_mul_integral_exp_neg_pi_lt_four

/-- The normalized half-integral of the energy envelope is strictly bounded by 4. -/
theorem half_integral_symmetrizedEnergyBound_lt_four :
    (1 / 2 : ℝ) * (∫ x in Set.Ioi (1 : ℝ), symmetrizedEnergyBound x) < 4 := by
  have h := integral_symmetrizedEnergyBound_lt_four
  linarith

/-- The normalized half-integral of the energy envelope is strictly bounded by 2. -/
theorem half_integral_symmetrizedEnergyBound_lt_two :
    (1 / 2 : ℝ) * (∫ x in Set.Ioi (1 : ℝ), symmetrizedEnergyBound x) < 2 := by
  have h := integral_symmetrizedEnergyBound_lt_four
  linarith

/-! ### 6. Connections to Mathlib Zeta Function and RH Deduction -/

/-- Definitional agreement between completed Riemann zeta and completed Hurwitz zeta at $a = 0$. -/
theorem completedRiemannZeta₀_eq_completedHurwitzZetaEven₀ (s : ℂ) :
    completedRiemannZeta₀ s = completedHurwitzZetaEven₀ 0 s := rfl

/-- Master deduction of Mathlib's `RiemannHypothesis` from a `UniversalWeilSystem` and the
symmetrized kernel energy bound. -/
theorem RiemannHypothesis_of_weil_and_energy_bound
    (sys : BuildingBlocks.WeilExplicitGrandRHBridge.UniversalWeilSystem)
    (h_rep : ∀ σ ∈ Set.Ioo (1 / 2 : ℝ) 1,
      (completedHurwitzZetaEven₀ 0 (σ : ℂ)).re ≤ (1 / 2 : ℝ) * ∫ x in Set.Ioi (1 : ℝ), symmetrizedEnergyBound x) :
    RiemannHypothesis := by
  apply RiemannHypothesis_of_weil_and_completed_bound sys
  intro σ hσ1 hσ2
  have h_mem : σ ∈ Set.Ioo (1 / 2 : ℝ) 1 := ⟨hσ1, hσ2⟩
  have h_le := h_rep σ h_mem
  have h_lt := half_integral_symmetrizedEnergyBound_lt_four
  have h_eq : (completedRiemannZeta₀ (σ : ℂ)).re = (completedHurwitzZetaEven₀ 0 (σ : ℂ)).re := by
    rw [completedRiemannZeta₀_eq_completedHurwitzZetaEven₀]
  rw [h_eq]
  exact lt_of_le_of_lt h_le h_lt

/-- Master deduction of Mathlib's `RiemannHypothesis` from a `UniversalZeroRefutationSystem` and the
symmetrized kernel energy bound. -/
theorem RiemannHypothesis_of_refutation_and_energy_bound
    (sys : BuildingBlocks.ChirpedUniversalZeroRefutation.UniversalZeroRefutationSystem)
    (h_rep : ∀ σ ∈ Set.Ioo (1 / 2 : ℝ) 1,
      (completedHurwitzZetaEven₀ 0 (σ : ℂ)).re ≤ (1 / 2 : ℝ) * ∫ x in Set.Ioi (1 : ℝ), symmetrizedEnergyBound x) :
    RiemannHypothesis := by
  apply RiemannHypothesis_of_refutation_and_completed_bound sys
  intro σ hσ1 hσ2
  have h_mem : σ ∈ Set.Ioo (1 / 2 : ℝ) 1 := ⟨hσ1, hσ2⟩
  have h_le := h_rep σ h_mem
  have h_lt := half_integral_symmetrizedEnergyBound_lt_four
  have h_eq : (completedRiemannZeta₀ (σ : ℂ)).re = (completedHurwitzZetaEven₀ 0 (σ : ℂ)).re := by
    rw [completedRiemannZeta₀_eq_completedHurwitzZetaEven₀]
  rw [h_eq]
  exact lt_of_le_of_lt h_le h_lt

#print axioms nat_le_sq
#print axioms exp_neg_pi_sq_le_exp_neg_pi_mul
#print axioms evenKernel_sub_one_le_geom
#print axioms evenKernel_sub_one_le_four_exp
#print axioms real_f_modif_le_four_exp
#print axioms mellinIntegrand_le_four_exp
#print axioms symmetrized_integrand_le_eight_exp
#print axioms integral_exp_neg_pi_Ioi_one
#print axioms integral_exp_neg_pi_le_one_sixth
#print axioms integral_symmetrizedEnergyBound_lt_four
#print axioms half_integral_symmetrizedEnergyBound_lt_four
#print axioms RiemannHypothesis_of_weil_and_energy_bound
#print axioms RiemannHypothesis_of_refutation_and_energy_bound

end BuildingBlocks.RiemannZetaKernelEnergyBound
