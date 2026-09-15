import BuildingBlocks.ActualFiniteHeatSource
import BuildingBlocks.AdditiveHeatPairing
import Mathlib.MeasureTheory.Integral.Prod

open MeasureTheory Set
open BuildingBlocks.ActualFiniteHeatSource BuildingBlocks.AdditiveHeatPairing

namespace BuildingBlocks.ActualHeatDensityPairing

theorem mixed_joint_integrable (N : ℕ) (hN : 1 ≤ N) (x : ℝ) (hx : 1 ≤ x) :
    Integrable (fun p : ℝ × ℝ => Real.exp (-x * p.2) * Real.exp (-p.1 * p.2))
      ((volume.restrict (uIoc (1 : ℝ) (N : ℝ))).prod (volume.restrict (Ioi (0 : ℝ)))) := by
  have hNr : (1 : ℝ) ≤ N := by exact_mod_cast hN
  letI : IsFiniteMeasure (volume.restrict (uIoc (1 : ℝ) (N : ℝ))) := by
    rw [uIoc_of_le hNr]
    infer_instance
  have hf : AEStronglyMeasurable
      (fun p : ℝ × ℝ => Real.exp (-x * p.2) * Real.exp (-p.1 * p.2))
      ((volume.restrict (uIoc (1 : ℝ) (N : ℝ))).prod (volume.restrict (Ioi (0 : ℝ)))) :=
    (show Continuous (fun p : ℝ × ℝ => Real.exp (-x * p.2) * Real.exp (-p.1 * p.2))
      from by fun_prop).aestronglyMeasurable
  apply (integrable_prod_iff hf).mpr
  constructor
  · filter_upwards [ae_restrict_mem measurableSet_uIoc] with y hy
    rw [uIoc_of_le hNr] at hy
    exact exponential_pair_integrable (by linarith) (by linarith [hy.1])
  · have heq : (fun y : ℝ => ∫ t : ℝ in Ioi 0,
        ‖Real.exp (-x * t) * Real.exp (-y * t)‖) =ᵐ[volume.restrict (uIoc (1 : ℝ) (N : ℝ))]
          (fun y => 1 / (x + y)) := by
      filter_upwards [ae_restrict_mem measurableSet_uIoc] with y hy
      rw [uIoc_of_le hNr] at hy
      have hp : (fun t : ℝ => ‖Real.exp (-x * t) * Real.exp (-y * t)‖) =
          (fun t => Real.exp (-x * t) * Real.exp (-y * t)) := by
        funext t
        rw [Real.norm_eq_abs, abs_of_pos (mul_pos (Real.exp_pos _) (Real.exp_pos _))]
      rw [hp, exponential_pair_integral (by linarith) (by linarith [hy.1])]
    have hm : Measurable (fun y : ℝ => 1 / (x + y)) := by fun_prop
    have hb : Integrable (fun _ : ℝ => (1 / 2 : ℝ))
        (volume.restrict (uIoc (1 : ℝ) (N : ℝ))) := integrable_const _
    have hi : Integrable (fun y : ℝ => 1 / (x + y))
        (volume.restrict (uIoc (1 : ℝ) (N : ℝ))) := by
      apply hb.mono' hm.aestronglyMeasurable.restrict
      filter_upwards [ae_restrict_mem measurableSet_uIoc] with y hy
      rw [uIoc_of_le hNr] at hy
      have hd : 0 < x + y := by linarith [hy.1]
      rw [Real.norm_eq_abs, abs_of_pos (div_pos (by norm_num) hd)]
      apply (div_le_iff₀ hd).mpr
      linarith [hy.1]
    exact hi.congr heq.symm

theorem mixed_density_integral (N : ℕ) (hN : 1 ≤ N) (x : ℝ) (hx : 1 ≤ x) :
    (∫ t : ℝ in Ioi 0, Real.exp (-x * t) * density N t) =
      Real.log ((x + N) / (x + 1)) := by
  have hNr : (1 : ℝ) ≤ N := by exact_mod_cast hN
  have hs := intervalIntegral_integral_swap
    (μ := volume.restrict (Ioi (0 : ℝ)))
    (f := fun y t : ℝ => Real.exp (-x * t) * Real.exp (-y * t))
    (mixed_joint_integrable N hN x hx)
  have hleft : (∫ y : ℝ in (1 : ℝ)..(N : ℝ),
      ∫ t : ℝ in Ioi 0, Real.exp (-x * t) * Real.exp (-y * t)) =
      ∫ y : ℝ in (1 : ℝ)..(N : ℝ), 1 / (x + y) := by
    apply intervalIntegral.integral_congr
    intro y hy
    rw [uIcc_of_le hNr] at hy
    exact exponential_pair_integral (by linarith) (by linarith [hy.1])
  have hright : ∀ t : ℝ, (∫ y : ℝ in (1 : ℝ)..(N : ℝ),
      Real.exp (-x * t) * Real.exp (-y * t)) = Real.exp (-x * t) * density N t := by
    intro t
    rw [intervalIntegral.integral_const_mul]
    simp [density, mul_comm]
  simp_rw [hright] at hs
  rw [hleft, intervalIntegral.integral_comp_add_left,
    integral_one_div_of_pos (by linarith : 0 < x + 1) (by linarith : 0 < x + N)] at hs
  exact hs.symm

theorem density_stronglyMeasurable (N : ℕ) (hN : 1 ≤ N) :
    StronglyMeasurable (density N) := by
  have hc : Continuous (fun p : ℝ × ℝ => Real.exp (-p.1 * p.2)) := by fun_prop
  have hm := hc.stronglyMeasurable.integral_prod_right'
    (ν := volume.restrict (Icc (1 : ℝ) (N : ℝ)))
  convert hm using 1
  funext t
  exact density_set_integral N hN t

theorem density_joint_integrable (N : ℕ) (hN : 1 ≤ N) :
    Integrable (fun p : ℝ × ℝ => Real.exp (-p.1 * p.2) * density N p.2)
      ((volume.restrict (uIoc (1 : ℝ) (N : ℝ))).prod (volume.restrict (Ioi (0 : ℝ)))) := by
  have hNr : (1 : ℝ) ≤ N := by exact_mod_cast hN
  letI : IsFiniteMeasure (volume.restrict (uIoc (1 : ℝ) (N : ℝ))) := by
    rw [uIoc_of_le hNr]
    infer_instance
  have hc : Continuous (fun p : ℝ × ℝ => Real.exp (-p.1 * p.2)) := by fun_prop
  have hf := hc.stronglyMeasurable.mul
    ((density_stronglyMeasurable N hN).comp_measurable measurable_snd)
  have hi := (integrable_const ((N : ℝ) - 1)
    (μ := volume.restrict (uIoc (1 : ℝ) (N : ℝ)))).mul_prod
    (integrableOn_exp_mul_Ioi (a := (-2 : ℝ)) (by norm_num) 0)
  apply hi.mono' hf.aestronglyMeasurable
  apply (Measure.ae_prod_iff_ae_ae (by
    exact measurableSet_le hf.measurable.norm (by fun_prop))).mpr
  filter_upwards [ae_restrict_mem measurableSet_uIoc] with x hx
  rw [uIoc_of_le hNr] at hx
  filter_upwards [ae_restrict_mem measurableSet_Ioi] with t ht
  have ht0 : 0 < t := ht
  have hd := density_norm_bound N hN t ht.le
  have he : Real.exp (-x * t) ≤ Real.exp (-t) := by
    apply Real.exp_le_exp.mpr
    nlinarith [hx.1]
  calc
    ‖Real.exp (-x * t) * density N t‖ = Real.exp (-x * t) * ‖density N t‖ := by
      rw [norm_mul, Real.norm_eq_abs, abs_of_pos (Real.exp_pos _)]
    _ ≤ Real.exp (-t) * (((N : ℝ) - 1) * Real.exp (-t)) :=
      mul_le_mul he hd (norm_nonneg _) (Real.exp_pos _).le
    _ = ((N : ℝ) - 1) * Real.exp (-2 * t) := by
      rw [← mul_assoc, mul_comm (Real.exp (-t)) ((N : ℝ) - 1), mul_assoc, ← Real.exp_add]
      congr 2
      ring

theorem density_square_integral (N : ℕ) (hN : 1 ≤ N) :
    (∫ t : ℝ in Ioi 0, density N t ^ 2) =
      ∫ x : ℝ in (1 : ℝ)..(N : ℝ), Real.log ((x + N) / (x + 1)) := by
  have hNr : (1 : ℝ) ≤ N := by exact_mod_cast hN
  have hs := intervalIntegral_integral_swap
    (μ := volume.restrict (Ioi (0 : ℝ)))
    (f := fun x t : ℝ => Real.exp (-x * t) * density N t)
    (density_joint_integrable N hN)
  have hleft : (∫ x : ℝ in (1 : ℝ)..(N : ℝ),
      ∫ t : ℝ in Ioi 0, Real.exp (-x * t) * density N t) =
      ∫ x : ℝ in (1 : ℝ)..(N : ℝ), Real.log ((x + N) / (x + 1)) := by
    apply intervalIntegral.integral_congr
    intro x hx
    rw [uIcc_of_le hNr] at hx
    exact mixed_density_integral N hN x hx.1
  have hright : ∀ t : ℝ, (∫ x : ℝ in (1 : ℝ)..(N : ℝ),
      Real.exp (-x * t) * density N t) = density N t ^ 2 := by
    intro t
    rw [intervalIntegral.integral_mul_const]
    simp [density, mul_comm, pow_two]
  simp_rw [hright] at hs
  rw [hleft] at hs
  exact hs.symm

theorem shifted_log_interval_integrable (N : ℕ) (hN : 1 ≤ N) (c : ℝ) (hc : 1 ≤ c) :
    IntervalIntegrable (fun x : ℝ => Real.log (x + c)) volume (1 : ℝ) (N : ℝ) := by
  have hNr : (1 : ℝ) ≤ N := by exact_mod_cast hN
  have hcont : ContinuousOn (fun x : ℝ => Real.log (x + c)) (uIcc (1 : ℝ) (N : ℝ)) := by
    intro x hx
    rw [uIcc_of_le hNr] at hx
    have hp : 0 < x + c := by linarith [hx.1]
    exact ((continuousAt_id.add continuousAt_const).log hp.ne').continuousWithinAt
  exact hcont.intervalIntegrable

theorem density_square_closed_formula (N : ℕ) (hN : 1 ≤ N) :
    (∫ t : ℝ in Ioi 0, density N t ^ 2) =
      2 * (N : ℝ) * Real.log (2 * (N : ℝ)) -
        2 * ((N : ℝ) + 1) * Real.log ((N : ℝ) + 1) + 2 * Real.log 2 := by
  have hNr : (1 : ℝ) ≤ N := by exact_mod_cast hN
  rw [density_square_integral N hN]
  calc
    _ = ∫ x : ℝ in (1 : ℝ)..(N : ℝ),
        Real.log (x + N) - Real.log (x + 1) := by
      apply intervalIntegral.integral_congr
      intro x hx
      rw [uIcc_of_le hNr] at hx
      have ha : 0 < x + N := by linarith [hx.1]
      have hb : 0 < x + 1 := by linarith [hx.1]
      exact Real.log_div ha.ne' hb.ne'
    _ = (∫ x : ℝ in (1 : ℝ)..(N : ℝ), Real.log (x + N)) -
        (∫ x : ℝ in (1 : ℝ)..(N : ℝ), Real.log (x + 1)) :=
      intervalIntegral.integral_sub (shifted_log_interval_integrable N hN N hNr)
        (shifted_log_interval_integrable N hN 1 le_rfl)
    _ = _ := by
      rw [intervalIntegral.integral_comp_add_right, intervalIntegral.integral_comp_add_right,
        integral_log, integral_log]
      have hnn : (N : ℝ) + N = 2 * (N : ℝ) := by ring
      have hon : (1 : ℝ) + N = (N : ℝ) + 1 := by ring
      norm_num only [hnn, hon]
      ring

theorem mixed_density_integrable (N : ℕ) (hN : 1 ≤ N) (x : ℝ) (hx : 1 ≤ x) :
    IntegrableOn (fun t : ℝ => Real.exp (-x * t) * density N t) (Ioi 0) := by
  have hNr : (1 : ℝ) ≤ N := by exact_mod_cast hN
  have hi := (mixed_joint_integrable N hN x hx).integral_prod_right
  simp only [uIoc_of_le hNr] at hi
  apply hi.congr
  filter_upwards with t
  rw [← intervalIntegral.integral_of_le hNr, intervalIntegral.integral_const_mul]
  simp [density, mul_comm]

theorem density_square_integrable (N : ℕ) (hN : 1 ≤ N) :
    IntegrableOn (fun t : ℝ => density N t ^ 2) (Ioi 0) := by
  have hNr : (1 : ℝ) ≤ N := by exact_mod_cast hN
  have hi := (density_joint_integrable N hN).integral_prod_right
  simp only [uIoc_of_le hNr] at hi
  apply hi.congr
  filter_upwards with t
  rw [← intervalIntegral.integral_of_le hNr, intervalIntegral.integral_mul_const]
  simp [density, mul_comm, pow_two]

theorem complete_density_gram {ι : Type*} (s : Finset ι) (x c : ι → ℝ)
    (hx : ∀ i ∈ s, 1 ≤ x i) (N : ℕ) (hN : 1 ≤ N) :
    (∫ t : ℝ in Ioi 0, (profile s x c t - density N t) ^ 2) =
      (∑ i ∈ s, ∑ j ∈ s, c i * c j / (x i + x j)) -
        2 * (∑ i ∈ s, c i * Real.log ((x i + N) / (x i + 1))) +
          (2 * (N : ℝ) * Real.log (2 * (N : ℝ)) -
            2 * ((N : ℝ) + 1) * Real.log ((N : ℝ) + 1) + 2 * Real.log 2) := by
  have hx0 : ∀ i ∈ s, 0 < x i := by intro i hi; linarith [hx i hi]
  have hp : IntegrableOn (fun t : ℝ => profile s x c t ^ 2) (Ioi 0) := by
    simp_rw [profile_square]
    apply integrable_finset_sum
    intro i hi
    apply integrable_finset_sum
    intro j hj
    exact (exponential_pair_integrable (hx0 i hi) (hx0 j hj)).const_mul _
  have hm : IntegrableOn (fun t : ℝ => profile s x c t * density N t) (Ioi 0) := by
    simp_rw [profile, Finset.sum_mul, mul_assoc]
    apply integrable_finset_sum
    intro i hi
    exact (mixed_density_integrable N hN (x i) (hx i hi)).const_mul _
  have hmval : (∫ t : ℝ in Ioi 0, profile s x c t * density N t) =
      ∑ i ∈ s, c i * Real.log ((x i + N) / (x i + 1)) := by
    simp_rw [profile, Finset.sum_mul, mul_assoc]
    rw [integral_finset_sum s (fun i hi =>
      (mixed_density_integrable N hN (x i) (hx i hi)).const_mul (c i))]
    apply Finset.sum_congr rfl
    intro i hi
    rw [integral_const_mul, mixed_density_integral N hN (x i) (hx i hi)]
  have hd := density_square_integrable N hN
  have heq : (fun t : ℝ => (profile s x c t - density N t) ^ 2) =
      (fun t => profile s x c t ^ 2 - 2 * (profile s x c t * density N t) + density N t ^ 2) := by
    funext t
    ring
  have hadd := integral_add (hp.sub (hm.const_mul (2 : ℝ))) hd
  have hsub := integral_sub hp (hm.const_mul (2 : ℝ))
  simp only [Pi.sub_apply] at hadd hsub
  rw [heq, hadd, hsub, integral_const_mul, finite_heat_gram s x c hx0,
    hmval, density_square_closed_formula N hN]

noncomputable def atomicCoordinate (n : ℕ) : ℝ := max (n : ℝ) 1

noncomputable def atomicCoefficient (n : ℕ) : ℝ :=
  ArithmeticFunction.vonMangoldt n - if n = 1 then 1 else 0

theorem actual_source_profile (N : ℕ) (hN : 1 ≤ N) (t : ℝ) :
    source N t = profile (Finset.range (N + 1)) atomicCoordinate atomicCoefficient t - density N t := by
  have hlam : (∑ n ∈ Finset.range (N + 1),
      ArithmeticFunction.vonMangoldt n * Real.exp (-atomicCoordinate n * t)) =
      ∑ n ∈ Finset.range (N + 1), ArithmeticFunction.vonMangoldt n * Real.exp (-(n : ℝ) * t) := by
    apply Finset.sum_congr rfl
    intro n hn
    by_cases hn0 : n = 0
    · simp [hn0]
    have hn1 : (1 : ℝ) ≤ n := by exact_mod_cast Nat.one_le_iff_ne_zero.mpr hn0
    simp only [atomicCoordinate, max_eq_left hn1]
  have hseed : (∑ n ∈ Finset.range (N + 1),
      (if n = 1 then (1 : ℝ) else 0) * Real.exp (-atomicCoordinate n * t)) = Real.exp (-t) := by
    rw [Finset.sum_eq_single 1]
    · norm_num [atomicCoordinate]
    · intro n hn hn1
      simp [hn1]
    · intro hnot
      exact False.elim (hnot (Finset.mem_range.mpr (by omega)))
  have hp : profile (Finset.range (N + 1)) atomicCoordinate atomicCoefficient t =
      (∑ n ∈ Finset.range (N + 1), ArithmeticFunction.vonMangoldt n * Real.exp (-(n : ℝ) * t)) -
        Real.exp (-t) := by
    unfold profile atomicCoefficient
    simp_rw [sub_mul]
    rw [Finset.sum_sub_distrib, hlam, hseed]
  rw [hp, source]
  ring

theorem actual_source_gram (N : ℕ) (hN : 1 ≤ N) :
    (∫ t : ℝ in Ioi 0, source N t ^ 2) =
      (∑ i ∈ Finset.range (N + 1), ∑ j ∈ Finset.range (N + 1),
        atomicCoefficient i * atomicCoefficient j / (atomicCoordinate i + atomicCoordinate j)) -
      2 * (∑ i ∈ Finset.range (N + 1), atomicCoefficient i *
        Real.log ((atomicCoordinate i + N) / (atomicCoordinate i + 1))) +
      (2 * (N : ℝ) * Real.log (2 * (N : ℝ)) -
        2 * ((N : ℝ) + 1) * Real.log ((N : ℝ) + 1) + 2 * Real.log 2) := by
  simp_rw [actual_source_profile N hN]
  exact complete_density_gram (Finset.range (N + 1)) atomicCoordinate atomicCoefficient
    (fun i _ => le_max_right (i : ℝ) 1) N hN

#print axioms mixed_joint_integrable
#print axioms mixed_density_integral
#print axioms density_stronglyMeasurable
#print axioms density_joint_integrable
#print axioms density_square_integral
#print axioms density_square_closed_formula
#print axioms mixed_density_integrable
#print axioms density_square_integrable
#print axioms complete_density_gram
#print axioms actual_source_profile
#print axioms actual_source_gram

end BuildingBlocks.ActualHeatDensityPairing
