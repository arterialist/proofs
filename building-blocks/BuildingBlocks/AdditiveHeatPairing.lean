import Mathlib.Analysis.SpecialFunctions.ImproperIntegrals
import Mathlib.MeasureTheory.Function.L2Space
import Mathlib.Tactic

open MeasureTheory Set

namespace BuildingBlocks.AdditiveHeatPairing

theorem exponential_pair_integrable {x y : ℝ} (hx : 0 < x) (hy : 0 < y) :
    IntegrableOn (fun t : ℝ => Real.exp (-x * t) * Real.exp (-y * t)) (Ioi 0) := by
  have h := integrableOn_exp_mul_Ioi (a := -(x + y)) (by linarith) 0
  convert h using 1
  ext t
  rw [← Real.exp_add]
  congr 1
  ring

theorem exponential_pair_integral {x y : ℝ} (hx : 0 < x) (hy : 0 < y) :
    (∫ t : ℝ in Ioi 0, Real.exp (-x * t) * Real.exp (-y * t)) = 1 / (x + y) := by
  simp_rw [← Real.exp_add, ← add_mul, ← neg_add]
  rw [integral_exp_mul_Ioi (by linarith)]
  simp only [mul_zero, Real.exp_zero]
  field_simp

noncomputable def profile {ι : Type*} (s : Finset ι) (x c : ι → ℝ) (t : ℝ) : ℝ :=
  ∑ i ∈ s, c i * Real.exp (-x i * t)

theorem profile_square {ι : Type*} (s : Finset ι) (x c : ι → ℝ) (t : ℝ) :
    profile s x c t ^ 2 =
      ∑ i ∈ s, ∑ j ∈ s, (c i * c j) *
        (Real.exp (-x i * t) * Real.exp (-x j * t)) := by
  unfold profile
  rw [pow_two, Finset.sum_mul]
  apply Finset.sum_congr rfl
  intro i hi
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro j hj
  ring

theorem finite_heat_gram {ι : Type*} (s : Finset ι) (x c : ι → ℝ)
    (hx : ∀ i ∈ s, 0 < x i) :
    (∫ t : ℝ in Ioi 0, profile s x c t ^ 2) =
      ∑ i ∈ s, ∑ j ∈ s, c i * c j / (x i + x j) := by
  have hint : ∀ i ∈ s, ∀ j ∈ s, IntegrableOn
      (fun t : ℝ => (c i * c j) *
        (Real.exp (-x i * t) * Real.exp (-x j * t))) (Ioi 0) := by
    intro i hi j hj
    exact (exponential_pair_integrable (hx i hi) (hx j hj)).const_mul _
  simp_rw [profile_square]
  rw [integral_finset_sum s (fun i hi => integrable_finset_sum s (hint i hi))]
  apply Finset.sum_congr rfl
  intro i hi
  rw [integral_finset_sum s (hint i hi)]
  apply Finset.sum_congr rfl
  intro j hj
  rw [integral_const_mul, exponential_pair_integral (hx i hi) (hx j hj)]
  ring

theorem finite_additive_gram_nonnegative {ι : Type*} (s : Finset ι)
    (x c : ι → ℝ) (hx : ∀ i ∈ s, 0 < x i) :
    0 ≤ ∑ i ∈ s, ∑ j ∈ s, c i * c j / (x i + x j) := by
  rw [← finite_heat_gram s x c hx]
  exact integral_nonneg (fun t => sq_nonneg _)

theorem exponential_difference_square_integrable {x y : ℝ}
    (hx : 0 < x) (hy : 0 < y) :
    IntegrableOn (fun t : ℝ => (Real.exp (-x * t) - Real.exp (-y * t)) ^ 2) (Ioi 0) := by
  have hxx := exponential_pair_integrable hx hx
  have hxy := (exponential_pair_integrable hx hy).const_mul (2 : ℝ)
  have hyy := exponential_pair_integrable hy hy
  apply ((hxx.sub hxy).add hyy).congr
  filter_upwards with t
  dsimp
  ring

theorem exponential_difference_square_integral {x y : ℝ}
    (hx : 0 < x) (hy : 0 < y) :
    (∫ t : ℝ in Ioi 0, (Real.exp (-x * t) - Real.exp (-y * t)) ^ 2) =
      (x - y) ^ 2 / (2 * x * y * (x + y)) := by
  have hxx := exponential_pair_integrable hx hx
  have hxy := (exponential_pair_integrable hx hy).const_mul (2 : ℝ)
  have hyy := exponential_pair_integrable hy hy
  have heq : (fun t : ℝ => (Real.exp (-x * t) - Real.exp (-y * t)) ^ 2) =
      (fun t => (Real.exp (-x * t) * Real.exp (-x * t) -
        2 * (Real.exp (-x * t) * Real.exp (-y * t))) +
          Real.exp (-y * t) * Real.exp (-y * t)) := by
    funext t
    ring
  have hadd := integral_add (hxx.sub hxy) hyy
  have hsub := integral_sub hxx hxy
  simp only [Pi.sub_apply] at hadd hsub
  rw [heq, hadd, hsub,
    integral_const_mul, exponential_pair_integral hx hx,
    exponential_pair_integral hx hy, exponential_pair_integral hy hy]
  have hsum : x + y ≠ 0 := by positivity
  field_simp
  ring

theorem exponential_difference_square_bound {x y : ℝ}
    (hx : 1 ≤ x) (hy : 1 ≤ y) :
    (∫ t : ℝ in Ioi 0, (Real.exp (-x * t) - Real.exp (-y * t)) ^ 2) ≤
      (x - y) ^ 2 / 4 := by
  have hx0 : 0 < x := by linarith
  have hy0 : 0 < y := by linarith
  rw [exponential_difference_square_integral hx0 hy0]
  have hxy : 1 ≤ x * y := by nlinarith [mul_nonneg (sub_nonneg.mpr hx) (sub_nonneg.mpr hy)]
  have hd : 4 ≤ 2 * x * y * (x + y) := by
    nlinarith [mul_nonneg (sub_nonneg.mpr hxy) (by linarith : 0 ≤ x + y)]
  apply (div_le_div_iff₀ (by positivity : 0 < 2 * x * y * (x + y))
    (by norm_num : (0 : ℝ) < 4)).mpr
  nlinarith [mul_nonneg (sq_nonneg (x - y)) (sub_nonneg.mpr hd)]

theorem exponential_memLp {x : ℝ} (hx : 0 < x) :
    MemLp (fun t : ℝ => Real.exp (-x * t)) 2 (volume.restrict (Ioi 0)) := by
  have hc : Continuous (fun t : ℝ => Real.exp (-x * t)) := by fun_prop
  apply (memLp_two_iff_integrable_sq hc.aestronglyMeasurable.restrict).mpr
  simpa [pow_two] using exponential_pair_integrable hx hx

noncomputable def birth (x : Ici (1 : ℝ)) : Lp ℝ 2 (volume.restrict (Ioi (0 : ℝ))) :=
  (exponential_memLp (x := (x : ℝ))
    (lt_of_lt_of_le (by norm_num : (0 : ℝ) < 1) x.property)).toLp
    (fun t : ℝ => Real.exp (-(x : ℝ) * t))

theorem birth_ae (x : Ici (1 : ℝ)) :
    birth x =ᵐ[volume.restrict (Ioi 0)] (fun t : ℝ => Real.exp (-(x : ℝ) * t)) :=
  MemLp.coeFn_toLp _

theorem birth_distance_square (x y : Ici (1 : ℝ)) :
    ‖birth x - birth y‖ ^ 2 =
      ((x : ℝ) - (y : ℝ)) ^ 2 / (2 * (x : ℝ) * (y : ℝ) * ((x : ℝ) + (y : ℝ))) := by
  rw [← real_inner_self_eq_norm_sq, L2.inner_def]
  calc
    _ = ∫ t : ℝ in Ioi 0, (Real.exp (-(x : ℝ) * t) - Real.exp (-(y : ℝ) * t)) ^ 2 := by
      apply integral_congr_ae
      filter_upwards [Lp.coeFn_sub (birth x) (birth y), birth_ae x, birth_ae y] with t ht hx hy
      simp only [ht, Pi.sub_apply, hx, hy]
      simp [pow_two]
    _ = _ := exponential_difference_square_integral
      (lt_of_lt_of_le (by norm_num : (0 : ℝ) < 1) x.property)
      (lt_of_lt_of_le (by norm_num : (0 : ℝ) < 1) y.property)

theorem birth_distance_bound (x y : Ici (1 : ℝ)) :
    ‖birth x - birth y‖ ≤ ‖(x : ℝ) - (y : ℝ)‖ / 2 := by
  have h := exponential_difference_square_bound x.property y.property
  rw [exponential_difference_square_integral
    (lt_of_lt_of_le (by norm_num : (0 : ℝ) < 1) x.property)
    (lt_of_lt_of_le (by norm_num : (0 : ℝ) < 1) y.property), ← birth_distance_square] at h
  have hn := norm_nonneg (birth x - birth y)
  have hr := norm_nonneg ((x : ℝ) - (y : ℝ))
  have he : ‖(x : ℝ) - (y : ℝ)‖ ^ 2 = ((x : ℝ) - (y : ℝ)) ^ 2 := by
    simp [Real.norm_eq_abs]
  nlinarith

theorem birth_lipschitz : LipschitzWith (1 / 2 : NNReal) birth := by
  apply LipschitzWith.of_dist_le_mul
  intro x y
  simpa [dist_eq_norm, Subtype.dist_eq, div_eq_mul_inv, mul_comm] using birth_distance_bound x y

#print axioms exponential_pair_integrable
#print axioms exponential_pair_integral
#print axioms finite_heat_gram
#print axioms finite_additive_gram_nonnegative
#print axioms exponential_difference_square_integrable
#print axioms exponential_difference_square_integral
#print axioms exponential_difference_square_bound
#print axioms exponential_memLp
#print axioms birth_distance_square
#print axioms birth_distance_bound
#print axioms birth_lipschitz

end BuildingBlocks.AdditiveHeatPairing
