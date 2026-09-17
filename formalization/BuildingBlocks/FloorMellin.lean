import BuildingBlocks.Continuation
import BuildingBlocks.CoarsePrimeBounds
import Mathlib.Analysis.MellinTransform

open Filter Set MeasureTheory Asymptotics
open scoped Topology BigOperators

namespace BuildingBlocks

open CoarsePrimitive

noncomputable def floorRemainder : ℝ → ℂ :=
  (Set.Ici (1 : ℝ)).indicator (fun x : ℝ => ((Int.fract x : ℝ) : ℂ))

theorem floorRemainder_norm_le (x : ℝ) : ‖floorRemainder x‖ ≤ 1 := by
  by_cases hx : 1 ≤ x
  · simp only [floorRemainder, Set.indicator_of_mem (show x ∈ Set.Ici (1 : ℝ) from hx), Complex.norm_real,
      Real.norm_eq_abs, abs_of_nonneg (Int.fract_nonneg x)]
    exact (Int.fract_lt_one x).le
  · simp only [floorRemainder, Set.indicator_of_notMem (show x ∉ Set.Ici (1 : ℝ) from hx), norm_zero, zero_le_one]

theorem floorRemainder_locallyIntegrable : LocallyIntegrableOn floorRemainder (Set.Ioi (0 : ℝ)) := by
  have hm : AEStronglyMeasurable floorRemainder volume := by
    apply Measurable.aestronglyMeasurable
    unfold floorRemainder
    apply Measurable.indicator _ measurableSet_Ici
    fun_prop
  exact ((memLp_top_of_bound hm 1 (Eventually.of_forall floorRemainder_norm_le)).locallyIntegrable
    le_top).locallyIntegrableOn _

theorem floorRemainder_of_one_le {x : ℝ} (hx : 1 ≤ x) :
    floorRemainder x = (x : ℂ) - (⌊x⌋₊ : ℂ) := by
  rw [floorRemainder, Set.indicator_of_mem (show x ∈ Set.Ici (1 : ℝ) from hx)]
  have he : Int.fract x = x - (⌊x⌋₊ : ℝ) := by
    rw [natCast_floor_eq_intCast_floor (by linarith : 0 ≤ x)]
    rfl
  rw [he]
  push_cast
  rfl

theorem floorRemainder_bigO_top :
    floorRemainder =O[atTop] (fun x : ℝ => x ^ (0 : ℝ)) := by
  apply isBigO_iff.mpr
  refine ⟨1, Eventually.of_forall fun x => ?_⟩
  simpa only [Real.rpow_zero, norm_one, mul_one] using floorRemainder_norm_le x

theorem floorRemainder_bigO_zero (b : ℝ) :
    floorRemainder =O[𝓝[>] 0] (fun x : ℝ => x ^ (-b)) := by
  apply isBigO_iff.mpr
  refine ⟨0, ?_⟩
  filter_upwards [eventually_nhdsWithin_of_eventually_nhds
    (gt_mem_nhds (show (0 : ℝ) < 1 by norm_num))] with x hx
  simp [floorRemainder, Set.indicator_of_notMem
    (show x ∉ Set.Ici (1 : ℝ) from not_le.mpr hx)]

theorem floorRemainder_mellinConvergent {s : ℂ} (hs : 0 < s.re) :
    MellinConvergent floorRemainder (-s) := by
  apply mellinConvergent_of_isBigO_rpow floorRemainder_locallyIntegrable (a := 0) (b := -s.re - 1)
  · simpa only [neg_zero] using floorRemainder_bigO_top
  · simp only [Complex.neg_re]; linarith
  · exact floorRemainder_bigO_zero _
  · simp only [Complex.neg_re]; linarith

noncomputable def floorMellin (s : ℂ) : ℂ := mellin floorRemainder (-s)

theorem floorMellin_analytic : AnalyticOnNhd ℂ floorMellin {s | 0 < s.re} := by
  apply DifferentiableOn.analyticOnNhd _ (isOpen_lt continuous_const Complex.continuous_re)
  intro s hs
  apply DifferentiableAt.differentiableWithinAt
  have hm : DifferentiableAt ℂ (mellin floorRemainder) (-s) := by
    apply mellin_differentiableAt_of_isBigO_rpow floorRemainder_locallyIntegrable (a := 0) (b := -s.re - 1)
    · simpa only [neg_zero] using floorRemainder_bigO_top
    · simp only [Complex.neg_re]; dsimp at hs; linarith
    · exact floorRemainder_bigO_zero _
    · simp only [Complex.neg_re]; linarith
  exact hm.comp s differentiableAt_id.neg

theorem floorMellin_eq_integral (s : ℂ) :
    floorMellin s = ∫ x : ℝ in Set.Ioi 1,
      ((x : ℂ) - (⌊x⌋₊ : ℂ)) * (x : ℂ) ^ (-(s + 1)) := by
  unfold floorMellin mellin
  have hi : Set.Ioi (0 : ℝ) ∩ Set.Ici 1 = Set.Ici 1 :=
    Set.inter_eq_right.mpr (fun x hx => by change 1 ≤ x at hx; change 0 < x; linarith)
  unfold floorRemainder
  simp_rw [← indicator_smul]
  rw [setIntegral_indicator measurableSet_Ici, hi, integral_Ici_eq_integral_Ioi]
  apply setIntegral_congr_fun measurableSet_Ioi
  intro x hx
  change 1 < x at hx
  have he := floorRemainder_of_one_le (le_of_lt hx)
  simp only [floorRemainder, Set.indicator_of_mem
    (show x ∈ Set.Ici (1 : ℝ) from le_of_lt hx)] at he
  simp only [smul_eq_mul, he]
  rw [show -s - 1 = -(s + 1) by ring]
  ring

theorem floorRemainder_kernel_integrable {s : ℂ} (hs : 0 < s.re) :
    IntegrableOn (fun x : ℝ =>
      ((x : ℂ) - (⌊x⌋₊ : ℂ)) * (x : ℂ) ^ (-(s + 1))) (Set.Ioi 1) := by
  have hh := (floorRemainder_mellinConvergent hs).mono_set
    (show Set.Ioi (1 : ℝ) ⊆ Set.Ioi 0 from fun x hx => by change 1 < x at hx; change 0 < x; linarith)
  apply (integrableOn_congr_fun (s := Set.Ioi (1 : ℝ)) (fun x hx => ?_) measurableSet_Ioi).mp hh
  rw [floorRemainder_of_one_le (le_of_lt hx)]
  simp only [smul_eq_mul]
  rw [show -s - 1 = -(s + 1) by ring]
  ring

theorem zeta_eq_floor_integral {s : ℂ} (hs : 1 < s.re) :
    riemannZeta s = s * ∫ x : ℝ in Set.Ioi 1, (⌊x⌋₊ : ℂ) * (x : ℂ) ^ (-(s + 1)) := by
  have ho : (fun N : ℕ => ∑ k ∈ Finset.Icc 1 N, (1 : ℝ)) =O[atTop]
      (fun N : ℕ => (N : ℝ) ^ (1 : ℝ)) := by
    simpa using (isBigO_refl (fun N : ℕ => (N : ℝ)) atTop)
  have hh := LSeries_eq_mul_integral_of_nonneg (fun _ : ℕ => (1 : ℝ))
    (r := 1) zero_le_one hs ho (fun _ => zero_le_one)
  simpa only [Complex.ofReal_one, ← Pi.one_def, LSeries_one_eq_riemannZeta hs,
    Finset.sum_const, nsmul_eq_mul, Nat.card_Icc, Nat.add_sub_cancel, mul_one] using hh

theorem zeta_eq_floorMellin_initial {s : ℂ} (hs : 1 < s.re) :
    riemannZeta s = s / (s - 1) - s * floorMellin s := by
  have hneg : (-s).re < -1 := by simp only [Complex.neg_re]; linarith
  have he := floorRemainder_kernel_integrable (show 0 < s.re by linarith)
  have hl : IntegrableOn (fun x : ℝ => (x : ℂ) * (x : ℂ) ^ (-(s + 1))) (Set.Ioi 1) := by
    apply (integrableOn_congr_fun (s := Set.Ioi (1 : ℝ)) (fun x hx => ?_) measurableSet_Ioi).mpr
      (integrableOn_Ioi_cpow_of_lt hneg zero_lt_one)
    exact linear_kernel_eq (by change 1 < x at hx; linarith)
  have hp : IntegrableOn (fun x : ℝ => (⌊x⌋₊ : ℂ) * (x : ℂ) ^ (-(s + 1))) (Set.Ioi 1) := by
    apply (integrableOn_congr_fun (s := Set.Ioi (1 : ℝ)) (fun x _ => ?_) measurableSet_Ioi).mp (hl.sub he)
    dsimp only [Pi.sub_apply]
    ring
  have hli : (∫ x : ℝ in Set.Ioi 1, (x : ℂ) * (x : ℂ) ^ (-(s + 1))) = 1 / (s - 1) := by
    rw [setIntegral_congr_fun measurableSet_Ioi
      (fun x hx => linear_kernel_eq (s := s) (by change 1 < x at hx; linarith)),
      integral_Ioi_cpow_of_lt hneg zero_lt_one]
    simp only [Complex.ofReal_one, Complex.one_cpow]
    convert (neg_div_neg_eq (1 : ℂ) (s - 1)) using 1; congr 1; ring
  rw [floorMellin_eq_integral, zeta_eq_floor_integral hs]
  simp_rw [sub_mul]
  rw [integral_sub hl hp, hli]
  ring

/-- Rescaling the proved continuation domain covers the entire positive
half-plane, with the pole removed. -/
theorem identity_on_positiveDomain {F : ℂ → ℂ}
    (hF : AnalyticOnNhd ℂ F {s | 0 < s.re ∧ s ≠ 1})
    (hzero : ∀ s : ℂ, 1 < s.re → F s = 0) :
    ∀ s : ℂ, 0 < s.re → s ≠ 1 → F s = 0 := by
  have hext := identity_on_rightDomain (F := fun z => F (2 * z - 1))
    (fun z hz => by
      have hz' : 0 < (2 * z - 1).re ∧ 2 * z - 1 ≠ 1 := by
        constructor
        · norm_num [Complex.sub_re, Complex.mul_re]
          linarith [hz.1]
        · intro he
          apply hz.2
          linear_combination he / 2
      exact (hF _ hz').comp (f := fun z : ℂ => 2 * z - 1)
        (analyticAt_const.mul analyticAt_id |>.sub analyticAt_const))
    (fun z hz => hzero _ (by
      norm_num [Complex.sub_re, Complex.mul_re]
      linarith))
  intro s hs hne
  let z : ℂ := (s + 1) / 2
  have hinv : 2 * z - 1 = s := by dsimp [z]; ring
  have hz : z ∈ rightDomain := by
    constructor
    · have hre : z.re = (s.re + 1) / 2 := by
        dsimp [z]
        norm_num [Complex.div_re]
      rw [hre]
      linarith
    · intro he
      apply hne
      rw [he] at hinv
      linear_combination -hinv
  simpa only [hinv] using hext z hz

/-- The fractional-part integral continues the actual zeta function, without
any assumption about its zeros. -/
theorem zeta_eq_floorMellin {s : ℂ} (hs : 0 < s.re) (hne : s ≠ 1) :
    riemannZeta s = s / (s - 1) - s * floorMellin s := by
  have hh := identity_on_positiveDomain
    (F := fun z => riemannZeta z - z / (z - 1) + z * floorMellin z)
    (fun z hz => ((zeta_analytic_off_pole z hz.2).sub
      (analyticAt_id.div (analyticAt_id.sub analyticAt_const)
        (sub_ne_zero.mpr hz.2))).add (analyticAt_id.mul (floorMellin_analytic z hz.1)))
    (fun z hz => by dsimp only; rw [zeta_eq_floorMellin_initial hz]; ring)
    s hs hne
  linear_combination hh

end BuildingBlocks
