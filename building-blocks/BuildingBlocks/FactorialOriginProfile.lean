import BuildingBlocks.FactorialOriginNeutralization
import Mathlib.Analysis.Normed.Group.Tannery
import Mathlib.Analysis.SpecificLimits.Basic

open Finset Filter
namespace BuildingBlocks.FactorialOriginProfile

noncomputable def coefficient (n : ℕ) (u : ℝ) : ℝ :=
  (ArithmeticFunction.moebius n : ℝ) * (1 - Real.exp (-(u / n)) - u / n)

noncomputable def finiteCoefficient (N n : ℕ) (u : ℝ) : ℝ :=
  (ArithmeticFunction.moebius n : ℝ) *
    (1 - Real.exp (-(((N / n : ℕ) : ℝ) * (u / N))) - ((N / n : ℕ) : ℝ) * (u / N))

noncomputable def profile (u : ℝ) : ℝ := ∑' n : ℕ, coefficient n u

theorem normalized_quotient_limit (n : ℕ) (hn : 0 < n) :
    Tendsto (fun N : ℕ => ((N / n : ℕ) : ℝ) / N) atTop (nhds (1 / (n : ℝ))) := by
  have hc : Tendsto (fun _ : ℕ => (1 : ℝ)) atTop (nhds 1) := tendsto_const_nhds
  have h := (hc.sub (tendsto_mod_div_atTop_nhds_zero_nat hn)).div_const (n : ℝ)
  have he : (fun N : ℕ => (1 - ((N % n : ℕ) : ℝ) / N) / (n : ℝ)) =ᶠ[atTop]
      (fun N : ℕ => ((N / n : ℕ) : ℝ) / N) := by
    filter_upwards [eventually_ge_atTop 1] with N hN
    have hnR : (n : ℝ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt hn)
    have hNR : (N : ℝ) ≠ 0 := by exact_mod_cast (by omega : N ≠ 0)
    have hm := congrArg (fun k : ℕ => (k : ℝ)) (Nat.mod_add_div N n)
    push_cast at hm
    field_simp
    nlinarith [hm]
  have h' : Tendsto (fun N : ℕ => (1 - ((N % n : ℕ) : ℝ) / N) / (n : ℝ))
      atTop (nhds (1 / (n : ℝ))) := by simpa only [sub_zero] using h
  exact h'.congr' he

theorem finite_coefficient_limit (n : ℕ) (u : ℝ) :
    Tendsto (fun N : ℕ => finiteCoefficient N n u) atTop (nhds (coefficient n u)) := by
  by_cases hn : n = 0
  · subst n
    simp [finiteCoefficient, coefficient]
  have hl := (normalized_quotient_limit n (Nat.pos_of_ne_zero hn)).mul_const u
  have he : (fun N : ℕ => ((N / n : ℕ) : ℝ) / N * u) =
      (fun N : ℕ => ((N / n : ℕ) : ℝ) * (u / N)) := by funext N; ring
  rw [he] at hl
  have hc : Continuous (fun v : ℝ => (ArithmeticFunction.moebius n : ℝ) * (1 - Real.exp (-v) - v)) := by
    fun_prop
  have h := (hc.tendsto (1 / (n : ℝ) * u)).comp hl
  simpa only [finiteCoefficient, coefficient, one_div_mul_eq_div] using h

theorem finite_coefficient_bound (N n : ℕ) (hN : 0 < N) (u : ℝ) (hu : 0 ≤ u) :
    ‖finiteCoefficient N n u‖ ≤ (u^2 / 2) * ((n : ℝ)^2)⁻¹ := by
  by_cases hn : n = 0
  · subst n
    simp [finiteCoefficient]
  have hnR : (0 : ℝ) < n := by exact_mod_cast (Nat.pos_of_ne_zero hn)
  have hNR : (0 : ℝ) < N := by exact_mod_cast hN
  have hm : |(ArithmeticFunction.moebius n : ℝ)| ≤ 1 := by
    exact_mod_cast (ArithmeticFunction.abs_moebius_le_one (n := n))
  have hq : ((N / n : ℕ) : ℝ) * (u / N) ≤ u / n := by
    calc
      _ ≤ ((N : ℝ) / n) * (u / N) := mul_le_mul_of_nonneg_right Nat.cast_div_le (by positivity)
      _ = _ := by field_simp
  have hr := FactorialOriginNeutralization.exponential_remainder_bound
    (((N / n : ℕ) : ℝ) * (u / N)) (by positivity)
  unfold finiteCoefficient
  rw [Real.norm_eq_abs, abs_mul]
  calc
    _ ≤ |(ArithmeticFunction.moebius n : ℝ)| * ((((N / n : ℕ) : ℝ) * (u / N))^2 / 2) :=
      mul_le_mul_of_nonneg_left hr (abs_nonneg _)
    _ ≤ (((N / n : ℕ) : ℝ) * (u / N))^2 / 2 := by
      nlinarith [sq_nonneg (((N / n : ℕ) : ℝ) * (u / N))]
    _ ≤ (u / (n : ℝ))^2 / 2 := by gcongr
    _ = _ := by rw [div_pow, div_eq_mul_inv]; ring

theorem coefficient_bound (n : ℕ) (u : ℝ) (hu : 0 ≤ u) :
    ‖coefficient n u‖ ≤ (u^2 / 2) * ((n : ℝ)^2)⁻¹ :=
  le_of_tendsto (tendsto_norm.comp (finite_coefficient_limit n u)) (by
    filter_upwards [eventually_ge_atTop 1] with N hN
    exact finite_coefficient_bound N n (by omega) u hu)

theorem coefficient_summable (u : ℝ) (hu : 0 ≤ u) : Summable (fun n : ℕ => coefficient n u) := by
  have hs := ((Real.summable_nat_pow_inv (p := 2)).mpr (by norm_num)).mul_left (u^2 / 2)
  exact hs.of_norm_bounded (fun n => coefficient_bound n u hu)

/-- Full actual finite response, represented as a finite-support series without lost histories. -/
theorem actual_response_series (N : ℕ) (hN : 0 < N) (u : ℝ) :
    FactorialBinaryCarry.response N (u / N) = u / N + ∑' n : ℕ, finiteCoefficient N n u := by
  rw [FactorialOriginNeutralization.response_linear_neutralization N hN]
  have he : (∑' n : ℕ, finiteCoefficient N n u) = ∑ n ∈ Icc 1 N, finiteCoefficient N n u := by
    apply tsum_eq_sum
    intro n hn
    by_cases hz : n = 0
    · subst n
      simp [finiteCoefficient]
    have hlarge : N < n := by simp only [mem_Icc] at hn; omega
    simp [finiteCoefficient, Nat.div_eq_of_lt hlarge]
  rw [he]
  simp only [finiteCoefficient, neg_mul]

/-- Fixed scaled-clock convergence of the original actual Möbius response. -/
theorem actual_origin_profile_limit (u : ℝ) (hu : 0 ≤ u) :
    Tendsto (fun N : ℕ => FactorialBinaryCarry.response N (u / N)) atTop (nhds (profile u)) := by
  have hs := ((Real.summable_nat_pow_inv (p := 2)).mpr (by norm_num)).mul_left (u^2 / 2)
  have hl := tendsto_tsum_of_dominated_convergence hs (fun n => finite_coefficient_limit n u) (by
    filter_upwards [eventually_ge_atTop 1] with N hN
    intro n
    exact finite_coefficient_bound N n (by omega) u hu)
  have h := (tendsto_const_div_atTop_nhds_zero_nat u).add hl
  simp only [zero_add] at h
  apply h.congr'
  filter_upwards [eventually_ge_atTop 1] with N hN
  exact (actual_response_series N (by omega) u).symm

#print axioms normalized_quotient_limit
#print axioms finite_coefficient_limit
#print axioms finite_coefficient_bound
#print axioms coefficient_bound
#print axioms coefficient_summable
#print axioms actual_response_series
#print axioms actual_origin_profile_limit
end BuildingBlocks.FactorialOriginProfile
