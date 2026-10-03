import BuildingBlocks.CoarsePrimeBounds
import BuildingBlocks.ActualPrimePowerWindowGeometry
import Mathlib.Tactic

/-!
A causal trace bound for the actual von Mangoldt staircase.
The jump, integrability and interval Cauchy facts are proved in this module.
-/

open Set MeasureTheory
open scoped Interval

namespace BuildingBlocks.ActualPrimeErrorCausalTrace

open CoarsePrimitive ActualPrimePowerWindowGeometry

noncomputable def centeredError (c t : ℝ) : ℝ := primeErrorReal t + c

noncomputable def preError (c : ℝ) (n : ℕ) : ℝ := psi (n - 1) - (n : ℝ) + c

noncomputable def windowEnergy (c sigma : ℝ) (n : ℕ) : ℝ :=
  ∫ t in ((n : ℝ) - Real.sqrt (n : ℝ))..(n : ℝ),
    (centeredError c t / t) ^ 2 * t ^ (1 - 2 * sigma)

theorem psi_increment_le {M N n : ℕ} (hMN : M ≤ N) (hNn : N ≤ n) :
    psi N - psi M ≤ ((N : ℝ) - (M : ℝ)) * Real.log (n : ℝ) := by
  have haux : ∀ j, M ≤ j → j ≤ n →
      psi j - psi M ≤ ((j : ℝ) - (M : ℝ)) * Real.log (n : ℝ) := by
    intro j hj
    induction j, hj using Nat.le_induction with
    | base => intro _; simp
    | succ j hj ih =>
      intro hjn
      have hjlog : Real.log (j + 1 : ℕ) ≤ Real.log (n : ℝ) :=
        Real.log_le_log (by positivity) (by exact_mod_cast hjn)
      have hv := ArithmeticFunction.vonMangoldt_le_log (n := j + 1)
      have hi := ih (by omega : j ≤ n)
      rw [psi_succ]
      push_cast
      nlinarith
  exact haux N hMN hNn

theorem centeredError_intervalIntegrable (c a b : ℝ) :
    IntervalIntegrable (centeredError c) volume a b := by
  exact (primeErrorReal_intervalIntegrable a b).add
    (intervalIntegrable_const (c := c))

theorem centeredError_measurable (c : ℝ) : Measurable (centeredError c) :=
  primeErrorReal_measurable.add measurable_const

theorem causal_difference_le {n : ℕ} (hn : 4 ≤ n) (c : ℝ)
    {t : ℝ} (ht : t ∈ leftWindow n) :
    |preError c n - centeredError c t| ≤
      Real.sqrt (n : ℝ) * (1 + Real.log (n : ℝ)) := by
  have hnR : (4 : ℝ) ≤ n := by exact_mod_cast hn
  have ht1 : 1 ≤ t := (leftWindow_subset_one_to_n hn ht).1
  have htN : t ≤ (n : ℝ) := ht.2
  have hlog : 0 ≤ Real.log (n : ℝ) := Real.log_nonneg (by linarith)
  have hsqrt : 1 ≤ Real.sqrt (n : ℝ) := by
    exact (Real.le_sqrt (by norm_num) (by norm_num)).2 (by nlinarith)
  rcases htN.eq_or_lt with hte | htlt
  · subst t
    have he : preError c n - centeredError c (n : ℝ) =
        -ArithmeticFunction.vonMangoldt n := by
      simp only [preError, centeredError, primeErrorReal, Nat.floor_natCast]
      have hstep := psi_succ (n - 1)
      have hn1 : n - 1 + 1 = n := by omega
      rw [hn1] at hstep
      linarith
    rw [he, abs_neg, abs_of_nonneg ArithmeticFunction.vonMangoldt_nonneg]
    calc
      ArithmeticFunction.vonMangoldt n ≤ Real.log (n : ℝ) :=
        ArithmeticFunction.vonMangoldt_le_log
      _ ≤ Real.sqrt (n : ℝ) * (1 + Real.log (n : ℝ)) := by nlinarith
  · have hf : ⌊t⌋₊ < n := (Nat.floor_lt (by linarith : 0 ≤ t)).2 htlt
    have hfm : ⌊t⌋₊ ≤ n - 1 := by omega
    have hp0 : 0 ≤ psi (n - 1) - psi ⌊t⌋₊ := sub_nonneg.mpr (psi_mono hfm)
    have hp1 := psi_increment_le hfm (show n - 1 ≤ n by omega)
    have hncast : ((n - 1 : ℕ) : ℝ) = (n : ℝ) - 1 := by
      rw [Nat.cast_sub (by omega : 1 ≤ n)]; norm_num
    have hfloor := Nat.lt_floor_add_one t
    have hcount : ((n - 1 : ℕ) : ℝ) - (⌊t⌋₊ : ℝ) ≤ (n : ℝ) - t := by
      rw [hncast]; linarith
    have hp2 : psi (n - 1) - psi ⌊t⌋₊ ≤ ((n : ℝ) - t) * Real.log (n : ℝ) :=
      hp1.trans (mul_le_mul_of_nonneg_right hcount hlog)
    have he : preError c n - centeredError c t =
        (psi (n - 1) - psi ⌊t⌋₊) - ((n : ℝ) - t) := by
      simp only [preError, centeredError, primeErrorReal]; ring
    rw [he]
    calc
      |(psi (n - 1) - psi ⌊t⌋₊) - ((n : ℝ) - t)|
          ≤ ((n : ℝ) - t) * (1 + Real.log (n : ℝ)) := by
        apply abs_le.mpr
        constructor <;> nlinarith
      _ ≤ Real.sqrt (n : ℝ) * (1 + Real.log (n : ℝ)) := by
        apply mul_le_mul_of_nonneg_right _ (by linarith)
        linarith [ht.1]

theorem centeredError_abs_le {n : ℕ} (hn : 4 ≤ n) (c : ℝ)
    {t : ℝ} (ht : t ∈ leftWindow n) :
    |centeredError c t| ≤ psi n + (n : ℝ) + |c| := by
  have ht1 := (leftWindow_subset_one_to_n hn ht).1
  have hfloor : ⌊t⌋₊ ≤ n := by
    simpa only [Nat.floor_natCast] using Nat.floor_mono ht.2
  have hp := psi_mono hfloor
  have hp0 := psi_nonneg ⌊t⌋₊
  have hc := le_abs_self c
  have hcn := neg_abs_le c
  unfold centeredError primeErrorReal
  apply abs_le.mpr
  constructor <;> linarith [psi_nonneg n, ht.2]

theorem centeredError_sq_intervalIntegrable {n : ℕ} (hn : 4 ≤ n) (c : ℝ) :
    IntervalIntegrable (fun t => centeredError c t ^ 2) volume
      ((n : ℝ) - Real.sqrt (n : ℝ)) (n : ℝ) := by
  let B := psi n + (n : ℝ) + |c|
  have hB : 0 ≤ B := by dsimp [B]; linarith [psi_nonneg n, abs_nonneg c, Nat.cast_nonneg (α := ℝ) n]
  have hlen : (n : ℝ) - Real.sqrt (n : ℝ) ≤ (n : ℝ) := by
    linarith [Real.sqrt_nonneg (n : ℝ)]
  have hm : Measurable (fun t => centeredError c t ^ 2) := by
    have hc := centeredError_measurable c
    fun_prop
  apply (intervalIntegrable_const (c := B ^ 2)).mono_fun'
    hm.stronglyMeasurable.aestronglyMeasurable
  filter_upwards [ae_restrict_mem measurableSet_uIoc] with t ht
  rw [uIoc_of_le hlen] at ht
  have hb := centeredError_abs_le hn c (show t ∈ leftWindow n from ⟨ht.1.le, ht.2⟩)
  rw [Real.norm_of_nonneg (sq_nonneg _)]
  nlinarith [sq_abs (centeredError c t), abs_nonneg (centeredError c t)]

theorem energyDensity_eq (c sigma t : ℝ) (ht : 0 < t) :
    (centeredError c t / t) ^ 2 * t ^ (1 - 2 * sigma) =
      centeredError c t ^ 2 * t ^ (-1 - 2 * sigma) := by
  have he : (1 - 2 * sigma : ℝ) = (-1 - 2 * sigma) + 2 := by ring
  rw [he, Real.rpow_add ht, Real.rpow_two]
  field_simp

theorem energyDensity_intervalIntegrable {n : ℕ} (hn : 4 ≤ n) (c sigma : ℝ) :
    IntervalIntegrable
      (fun t => (centeredError c t / t) ^ 2 * t ^ (1 - 2 * sigma)) volume
      ((n : ℝ) - Real.sqrt (n : ℝ)) (n : ℝ) := by
  have hlen : (n : ℝ) - Real.sqrt (n : ℝ) ≤ (n : ℝ) := by
    linarith [Real.sqrt_nonneg (n : ℝ)]
  have hc : ContinuousOn (fun t : ℝ => t ^ (-1 - 2 * sigma))
      [[(n : ℝ) - Real.sqrt (n : ℝ), (n : ℝ)]] := by
    apply continuousOn_id.rpow_const
    intro t ht
    rw [uIcc_of_le hlen] at ht
    exact Or.inl (ne_of_gt (by linarith [one_le_window_left hn, ht.1] : 0 < t))
  have hi := (centeredError_sq_intervalIntegrable hn c).mul_continuousOn hc
  apply hi.congr
  intro t ht
  rw [uIoc_of_le hlen] at ht
  exact (energyDensity_eq c sigma t (by linarith [one_le_window_left hn, ht.1])).symm

theorem interval_abs_integral_sq_le_integrable {f : ℝ → ℝ} {a b : ℝ}
    (hab : a ≤ b) (hf : IntervalIntegrable f volume a b)
    (hf2 : IntervalIntegrable (fun x => f x ^ 2) volume a b) :
    (∫ x in a..b, |f x|) ^ 2 ≤ (b - a) * ∫ x in a..b, f x ^ 2 := by
  rcases hab.eq_or_lt with he | he
  · subst b; simp
  let L := b - a
  let M := ∫ x in a..b, |f x|
  have hL : 0 < L := sub_pos.mpr he
  have hnonneg : 0 ≤ ∫ x in a..b, (L * |f x| - M) ^ 2 :=
    intervalIntegral.integral_nonneg hab (fun x _ => sq_nonneg _)
  have hid : (fun x => (L * |f x| - M) ^ 2) =
      (fun x => L ^ 2 * f x ^ 2 - 2 * L * M * |f x| + M ^ 2) := by
    funext x
    nlinarith [sq_abs (f x)]
  have hi1 := hf2.const_mul (L ^ 2)
  have hi2 := hf.abs.const_mul (2 * L * M)
  have hi3 : IntervalIntegrable (fun _ : ℝ => M ^ 2) volume a b := intervalIntegrable_const
  rw [hid, intervalIntegral.integral_add (hi1.sub hi2) hi3,
    intervalIntegral.integral_sub hi1 hi2,
    intervalIntegral.integral_const_mul, intervalIntegral.integral_const_mul,
    intervalIntegral.integral_const] at hnonneg
  simp only [smul_eq_mul] at hnonneg
  change 0 ≤ L ^ 2 * (∫ x in a..b, f x ^ 2) - 2 * L * M * M + L * M ^ 2 at hnonneg
  change M ^ 2 ≤ L * (∫ x in a..b, f x ^ 2)
  nlinarith

theorem windowEnergy_nonneg {n : ℕ} (hn : 4 ≤ n) (c sigma : ℝ) :
    0 ≤ windowEnergy c sigma n := by
  apply intervalIntegral.integral_nonneg
    (by linarith [Real.sqrt_nonneg (n : ℝ)])
  intro t ht
  exact mul_nonneg (sq_nonneg _) (Real.rpow_nonneg (by
    linarith [one_le_window_left hn, ht.1]) _)

theorem energyDensity_mul (c sigma t : ℝ) (ht : 0 < t) :
    ((centeredError c t / t) ^ 2 * t ^ (1 - 2 * sigma)) * t ^ (1 + 2 * sigma) =
      centeredError c t ^ 2 := by
  rw [energyDensity_eq c sigma t ht, mul_assoc, ← Real.rpow_add ht]
  simp only [show (-1 - 2 * sigma) + (1 + 2 * sigma) = (0 : ℝ) by ring,
    Real.rpow_zero, mul_one]

theorem unnormalized_square_integral_le {n : ℕ} (hn : 4 ≤ n)
    (c sigma : ℝ) (hsigma : (1 : ℝ) / 2 ≤ sigma) :
    (∫ t in ((n : ℝ) - Real.sqrt (n : ℝ))..(n : ℝ), centeredError c t ^ 2) ≤
      (n : ℝ) ^ (1 + 2 * sigma) * windowEnergy c sigma n := by
  have hlen : (n : ℝ) - Real.sqrt (n : ℝ) ≤ (n : ℝ) := by
    linarith [Real.sqrt_nonneg (n : ℝ)]
  have hi := intervalIntegral.integral_mono_on hlen
    (centeredError_sq_intervalIntegrable hn c)
    ((energyDensity_intervalIntegrable hn c sigma).const_mul ((n : ℝ) ^ (1 + 2 * sigma)))
    (fun t ht => by
      have ht1 : 1 ≤ t := (one_le_window_left hn).trans ht.1
      have ht0 : 0 < t := by linarith
      have hp := Real.rpow_le_rpow ht0.le ht.2 (by linarith : 0 ≤ 1 + 2 * sigma)
      have hd : 0 ≤ (centeredError c t / t) ^ 2 * t ^ (1 - 2 * sigma) :=
        mul_nonneg (sq_nonneg _) (Real.rpow_nonneg ht0.le _)
      calc
        centeredError c t ^ 2 =
            ((centeredError c t / t) ^ 2 * t ^ (1 - 2 * sigma)) * t ^ (1 + 2 * sigma) :=
          (energyDensity_mul c sigma t ht0).symm
        _ ≤ (n : ℝ) ^ (1 + 2 * sigma) *
            ((centeredError c t / t) ^ 2 * t ^ (1 - 2 * sigma)) := by
          nlinarith [mul_le_mul_of_nonneg_left hp hd])
  simpa only [intervalIntegral.integral_const_mul, windowEnergy] using hi

theorem normalization_factor (n sigma : ℝ) (hn : 0 < n) :
    Real.sqrt (Real.sqrt n * n ^ (1 + 2 * sigma)) =
      Real.sqrt n * n * n ^ (sigma - 3 / 4) := by
  calc
    Real.sqrt (Real.sqrt n * n ^ (1 + 2 * sigma)) =
        n ^ (((1 : ℝ) / 2 + (1 + 2 * sigma)) * (1 / 2)) := by
      rw [Real.sqrt_eq_rpow, Real.sqrt_eq_rpow, ← Real.rpow_add hn,
        ← Real.rpow_mul hn.le]
    _ = n ^ ((1 : ℝ) / 2 + 1 + (sigma - 3 / 4)) := by congr 1; ring
    _ = Real.sqrt n * n * n ^ (sigma - 3 / 4) := by
      rw [Real.rpow_add hn, Real.rpow_add hn, Real.rpow_one, Real.sqrt_eq_rpow]

theorem normalized_remainder_factor (n : ℝ) (hn : 0 < n) :
    n * n ^ (-(1 : ℝ) / 2) = Real.sqrt n := by
  rw [Real.sqrt_eq_rpow]
  nth_rw 1 [← Real.rpow_one n]
  rw [← Real.rpow_add hn]
  congr 1
  ring

theorem actual_causal_trace {n : ℕ} (hn : 4 ≤ n)
    (c sigma : ℝ) (hsigma : (1 : ℝ) / 2 ≤ sigma) :
    |preError c n / (n : ℝ)| ≤
      (n : ℝ) ^ (sigma - 3 / 4) * Real.sqrt (windowEnergy c sigma n) +
      (n : ℝ) ^ (-(1 : ℝ) / 2) * (1 + Real.log (n : ℝ)) := by
  have hn0 : (0 : ℝ) < n := by exact_mod_cast (show 0 < n by omega)
  have hh : 0 < Real.sqrt (n : ℝ) := Real.sqrt_pos.2 hn0
  have hlen : (n : ℝ) - Real.sqrt (n : ℝ) ≤ (n : ℝ) := by linarith
  have hf := centeredError_intervalIntegrable c ((n : ℝ) - Real.sqrt (n : ℝ)) (n : ℝ)
  have hf2 := centeredError_sq_intervalIntegrable hn c
  have hE := windowEnergy_nonneg hn c sigma
  have haverage := intervalIntegral.integral_mono_on hlen
    (intervalIntegrable_const (c := |preError c n|))
    (hf.abs.add (intervalIntegrable_const
      (c := Real.sqrt (n : ℝ) * (1 + Real.log (n : ℝ)))))
    (fun t ht => by
      have hd := causal_difference_le hn c (show t ∈ leftWindow n from ht)
      calc
        |preError c n| = |(preError c n - centeredError c t) + centeredError c t| := by congr 1; ring
        _ ≤ |preError c n - centeredError c t| + |centeredError c t| := abs_add_le _ _
        _ ≤ |centeredError c t| + Real.sqrt (n : ℝ) * (1 + Real.log (n : ℝ)) := by linarith)
  rw [intervalIntegral.integral_const, intervalIntegral.integral_add hf.abs
    (intervalIntegrable_const), intervalIntegral.integral_const] at haverage
  simp only [smul_eq_mul, sub_sub_cancel] at haverage
  have hcs := interval_abs_integral_sq_le_integrable hlen hf hf2
  simp only [sub_sub_cancel] at hcs
  have hsq := unnormalized_square_integral_le hn c sigma hsigma
  have hcs2 : (∫ t in ((n : ℝ) - Real.sqrt (n : ℝ))..(n : ℝ), |centeredError c t|) ^ 2 ≤
      Real.sqrt (n : ℝ) * ((n : ℝ) ^ (1 + 2 * sigma) * windowEnergy c sigma n) :=
    hcs.trans (mul_le_mul_of_nonneg_left hsq hh.le)
  have hroot := Real.le_sqrt_of_sq_le hcs2
  rw [show Real.sqrt (n : ℝ) * ((n : ℝ) ^ (1 + 2 * sigma) * windowEnergy c sigma n) =
      (Real.sqrt (n : ℝ) * (n : ℝ) ^ (1 + 2 * sigma)) * windowEnergy c sigma n by ring,
    Real.sqrt_mul (by positivity), normalization_factor (n : ℝ) sigma hn0] at hroot
  have havg : |preError c n| ≤
      (n : ℝ) * (n : ℝ) ^ (sigma - 3 / 4) * Real.sqrt (windowEnergy c sigma n) +
      Real.sqrt (n : ℝ) * (1 + Real.log (n : ℝ)) := by
    nlinarith
  rw [abs_div, abs_of_pos hn0]
  apply (div_le_iff₀ hn0).2
  rw [← normalized_remainder_factor (n : ℝ) hn0] at havg
  convert havg using 1; ring

theorem actual_causal_trace_literal {n : ℕ} (hn : 4 ≤ n)
    (c sigma : ℝ) (hsigma : (1 : ℝ) / 2 ≤ sigma) :
    |(psi (n - 1) - (n : ℝ) + c) / (n : ℝ)| ≤
      (n : ℝ) ^ (sigma - 3 / 4) *
        Real.sqrt (∫ t in ((n : ℝ) - Real.sqrt (n : ℝ))..(n : ℝ),
          ((psi ⌊t⌋₊ - t + c) / t) ^ 2 * t ^ (1 - 2 * sigma)) +
      (n : ℝ) ^ (-(1 : ℝ) / 2) * (1 + Real.log (n : ℝ)) := by
  simpa only [preError, centeredError, windowEnergy, primeErrorReal] using
    actual_causal_trace hn c sigma hsigma

end BuildingBlocks.ActualPrimeErrorCausalTrace
