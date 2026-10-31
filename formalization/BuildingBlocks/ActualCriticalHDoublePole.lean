import BuildingBlocks.PrimePowerLogSeries
import BuildingBlocks.ActualCriticalSharpConstant

/-!
# The double pole of `H` at `1/2`, and the unconditional sharp constant

`H(σ) = ∑_p (log p)^2 p^{-2σ}/(1-p^{-σ})^2` satisfies `(2σ-1)^2 H(σ) → 1` as `σ → 1/2⁺`:

* `S(σ) = ∑_p (log p)^2 p^{-2σ} ≤ H(σ) ≤ S(σ) + C₁`, since the factor `(1-p^{-σ})^{-2}` is
  `1 + O(p^{-σ})` and `∑_p (log p)^2 p^{-3σ}` is bounded for `σ ≥ 1/2`;
* `S(σ) ≤ T(2σ) ≤ S(σ) + C₂` and `(2σ-1)^2 T(2σ) → 1` (`PrimePowerLogSeries`).

This discharges the hypothesis `HDoublePole` of `ActualCriticalSharpConstant`, so the sharp
lower constant holds unconditionally: for every `C < 1/6`, `Re W(x) < -C x^{3/2} log^2 x` for
arbitrarily large `x`. Equivalently `liminf W(x)/(x^{3/2} log^2 x) ≤ -1/6`, the constant of the
RH main term.
-/

open Filter Topology

namespace BuildingBlocks.ActualCriticalHDoublePole

open PrimePowerLogSeries SamePrimeDirichlet ActualCriticalLowerExcursion ActualCriticalSharpConstant

/-- `S(σ) = ∑_p (log p)^2 p^{-2σ}`. -/
noncomputable def S (σ : ℝ) : ℝ := ∑' p : Nat.Primes, primeMajorant σ p

/-! ### Comparison of `H` with `S` -/

theorem primeMajorant_eq_sq (p : Nat.Primes) (σ : ℝ) :
    primeMajorant σ p = (Real.log (p : ℕ)) ^ 2 * (((p : ℕ) : ℝ) ^ (-σ)) ^ 2 := by
  unfold primeMajorant
  have hp0 : (0 : ℝ) ≤ ((p : ℕ) : ℝ) := Nat.cast_nonneg _
  have h : (((p : ℕ) : ℝ) ^ (-σ)) ^ 2 = 1 / ((p : ℕ) : ℝ) ^ (2 * σ) := by
    rw [← Real.rpow_natCast (((p : ℕ) : ℝ) ^ (-σ)) 2, ← Real.rpow_mul hp0, one_div, ← Real.rpow_neg hp0]
    congr 1
    push_cast
    ring
  rw [h]
  ring

theorem ratio_le {σ : ℝ} (hσ : 1 / 2 ≤ σ) (p : Nat.Primes) : ((p : ℕ) : ℝ) ^ (-σ) ≤ 3 / 4 := by
  have hp2 : (2 : ℝ) ≤ ((p : ℕ) : ℝ) := by exact_mod_cast p.prop.two_le
  have h1 : ((p : ℕ) : ℝ) ^ (-σ) ≤ (2 : ℝ) ^ (-σ) :=
    Real.rpow_le_rpow_of_nonpos (by norm_num) hp2 (by linarith)
  have h2 : (2 : ℝ) ^ (-σ) ≤ (2 : ℝ) ^ (-(1 / 2 : ℝ)) :=
    Real.rpow_le_rpow_of_exponent_le (by norm_num) (by linarith)
  have h3 : (2 : ℝ) ^ (-(1 / 2 : ℝ)) ≤ 3 / 4 := by
    have hsq : ((2 : ℝ) ^ (-(1 / 2 : ℝ))) ^ 2 = 1 / 2 := by
      rw [← Real.rpow_natCast, ← Real.rpow_mul (by norm_num)]
      norm_num
    have hnn : 0 ≤ (2 : ℝ) ^ (-(1 / 2 : ℝ)) := Real.rpow_nonneg (by norm_num) _
    nlinarith
  linarith

/-- Pointwise: `0 ≤ Re(samePrimeTerm p σ) - primeMajorant σ p ≤ 32 (log p)^2 / p^{3/2}`. -/
theorem term_sub_majorant_bounds {σ : ℝ} (hσ : 1 / 2 < σ) (p : Nat.Primes) :
    0 ≤ (samePrimeTerm p (σ : ℂ)).re - primeMajorant σ p ∧
      (samePrimeTerm p (σ : ℂ)).re - primeMajorant σ p ≤
        32 * ((Real.log (p : ℕ)) ^ 2 / ((p : ℕ) : ℝ) ^ ((3 : ℝ) / 2)) := by
  have hp2 : (2 : ℝ) ≤ ((p : ℕ) : ℝ) := by exact_mod_cast p.prop.two_le
  have hp0 : (0 : ℝ) < ((p : ℕ) : ℝ) := by linarith
  have hp1 : (1 : ℝ) ≤ ((p : ℕ) : ℝ) := by linarith
  rw [samePrimeTerm_ofReal, Complex.ofReal_re, primeMajorant_eq_sq]
  set r : ℝ := ((p : ℕ) : ℝ) ^ (-σ) with hr
  set L : ℝ := (Real.log (p : ℕ)) ^ 2 with hL
  have hr0 : 0 < r := Real.rpow_pos_of_pos hp0 _
  have hr34 : r ≤ 3 / 4 := ratio_le hσ.le p
  have hL0 : 0 ≤ L := sq_nonneg _
  have h1r : 0 < 1 - r := by linarith
  have h1r2 : (1 / 16 : ℝ) ≤ (1 - r) ^ 2 := by nlinarith
  have hr3 : r ^ 3 ≤ 1 / ((p : ℕ) : ℝ) ^ ((3 : ℝ) / 2) := by
    rw [hr, ← Real.rpow_natCast, ← Real.rpow_mul hp0.le, one_div, ← Real.rpow_neg hp0.le]
    apply Real.rpow_le_rpow_of_exponent_le hp1
    push_cast
    linarith
  -- the difference is L r^2 (2r - r^2)/(1-r)^2
  have hdiff : L * r ^ 2 / (1 - r) ^ 2 - L * r ^ 2 = L * r ^ 2 * (2 * r - r ^ 2) / (1 - r) ^ 2 := by
    field_simp
    ring
  rw [hdiff]
  constructor
  · apply div_nonneg _ (sq_nonneg _)
    apply mul_nonneg (mul_nonneg hL0 (sq_nonneg _))
    nlinarith
  · have hnum : L * r ^ 2 * (2 * r - r ^ 2) ≤ L * r ^ 3 * 2 := by nlinarith [mul_nonneg hL0 (pow_nonneg hr0.le 3)]
    calc L * r ^ 2 * (2 * r - r ^ 2) / (1 - r) ^ 2
        ≤ L * r ^ 3 * 2 / (1 / 16) := by
          apply div_le_div₀ (by positivity) hnum (by norm_num) h1r2
      _ = 32 * (L * r ^ 3) := by ring
      _ ≤ 32 * (L * (1 / ((p : ℕ) : ℝ) ^ ((3 : ℝ) / 2))) := by
          gcongr
      _ = 32 * ((Real.log (p : ℕ)) ^ 2 / ((p : ℕ) : ℝ) ^ ((3 : ℝ) / 2)) := by
          rw [hL]
          ring

/-- The constant `C₁ = 32 ∑_p (log p)^2 / p^{3/2}`. -/
noncomputable def C₁ : ℝ := 32 * ∑' p : Nat.Primes, (Real.log (p : ℕ)) ^ 2 / ((p : ℕ) : ℝ) ^ ((3 : ℝ) / 2)

theorem summable_log_sq_div_three_halves :
    Summable (fun p : Nat.Primes => (Real.log (p : ℕ)) ^ 2 / ((p : ℕ) : ℝ) ^ ((3 : ℝ) / 2)) :=
  (summable_log_sq_div_rpow (t := 3 / 2) (by norm_num)).subtype _

theorem summable_re_term {σ : ℝ} (hσ : 1 / 2 < σ) :
    Summable (fun p : Nat.Primes => (samePrimeTerm p (σ : ℂ)).re) :=
  (Complex.hasSum_re (samePrimeTerm_summable_ofReal hσ).hasSum).summable

theorem H_re_eq_tsum {σ : ℝ} (hσ : 1 / 2 < σ) :
    (H (σ : ℂ)).re = ∑' p : Nat.Primes, (samePrimeTerm p (σ : ℂ)).re := by
  unfold H
  exact Complex.re_tsum (samePrimeTerm_summable_ofReal hσ)

theorem S_le_H_re {σ : ℝ} (hσ : 1 / 2 < σ) : S σ ≤ (H (σ : ℂ)).re := by
  rw [H_re_eq_tsum hσ]
  unfold S
  exact (primeMajorant_summable hσ).tsum_le_tsum (fun p => by linarith [(term_sub_majorant_bounds hσ p).1])
    (summable_re_term hσ)

theorem H_re_le {σ : ℝ} (hσ : 1 / 2 < σ) : (H (σ : ℂ)).re ≤ S σ + C₁ := by
  rw [H_re_eq_tsum hσ]
  unfold S C₁
  have hs1 := summable_re_term hσ
  have hs2 := primeMajorant_summable hσ
  have hdiff : (∑' p : Nat.Primes, (samePrimeTerm p (σ : ℂ)).re) - ∑' p : Nat.Primes, primeMajorant σ p =
      ∑' p : Nat.Primes, ((samePrimeTerm p (σ : ℂ)).re - primeMajorant σ p) :=
    (hs1.tsum_sub hs2).symm
  have hsum_diff : Summable (fun p : Nat.Primes => (samePrimeTerm p (σ : ℂ)).re - primeMajorant σ p) :=
    hs1.sub hs2
  have hle : (∑' p : Nat.Primes, ((samePrimeTerm p (σ : ℂ)).re - primeMajorant σ p)) ≤
      ∑' p : Nat.Primes, 32 * ((Real.log (p : ℕ)) ^ 2 / ((p : ℕ) : ℝ) ^ ((3 : ℝ) / 2)) :=
    hsum_diff.tsum_le_tsum (fun p => (term_sub_majorant_bounds hσ p).2)
      (summable_log_sq_div_three_halves.mul_left 32)
  rw [tsum_mul_left] at hle
  linarith

/-! ### The double pole -/

theorem tendsto_two_mul : Tendsto (fun σ : ℝ => 2 * σ) (𝓝[>] ((1 : ℝ) / 2)) (𝓝[>] (1 : ℝ)) := by
  apply tendsto_nhdsWithin_of_tendsto_nhds_of_eventually_within
  · have : Tendsto (fun σ : ℝ => 2 * σ) (𝓝 ((1 : ℝ) / 2)) (𝓝 (2 * ((1 : ℝ) / 2))) :=
      (continuous_const.mul continuous_id).continuousAt.tendsto
    rw [show 2 * ((1 : ℝ) / 2) = 1 by norm_num] at this
    exact this.mono_left nhdsWithin_le_nhds
  · filter_upwards [self_mem_nhdsWithin] with σ hσ
    have : (1 : ℝ) / 2 < σ := hσ
    show (1 : ℝ) < 2 * σ
    linarith

theorem tendsto_sq_mul_T_two : Tendsto (fun σ : ℝ => (2 * σ - 1) ^ 2 * T (2 * σ)) (𝓝[>] ((1 : ℝ) / 2)) (𝓝 1) :=
  tendsto_sq_mul_T.comp tendsto_two_mul

theorem tendsto_sq_mul_const (c : ℝ) :
    Tendsto (fun σ : ℝ => (2 * σ - 1) ^ 2 * c) (𝓝[>] ((1 : ℝ) / 2)) (𝓝 0) := by
  have h : Tendsto (fun σ : ℝ => (2 * σ - 1) ^ 2 * c) (𝓝 ((1 : ℝ) / 2)) (𝓝 ((2 * ((1 : ℝ) / 2) - 1) ^ 2 * c)) :=
    (((continuous_const.mul continuous_id).sub continuous_const).pow 2).mul continuous_const
      |>.continuousAt.tendsto
  rw [show (2 * ((1 : ℝ) / 2) - 1) ^ 2 * c = 0 by norm_num] at h
  exact h.mono_left nhdsWithin_le_nhds

/-- **The double pole of `H` at `1/2`**: `(2σ-1)^2 Re H(σ) → 1` as `σ → 1/2⁺`. -/
theorem hDoublePole : HDoublePole := by
  unfold HDoublePole
  have hlow : Tendsto (fun σ : ℝ => (2 * σ - 1) ^ 2 * T (2 * σ) - (2 * σ - 1) ^ 2 * C₂)
      (𝓝[>] ((1 : ℝ) / 2)) (𝓝 1) := by
    have := tendsto_sq_mul_T_two.sub (tendsto_sq_mul_const C₂)
    simpa using this
  have hup : Tendsto (fun σ : ℝ => (2 * σ - 1) ^ 2 * T (2 * σ) + (2 * σ - 1) ^ 2 * C₁)
      (𝓝[>] ((1 : ℝ) / 2)) (𝓝 1) := by
    have := tendsto_sq_mul_T_two.add (tendsto_sq_mul_const C₁)
    simpa using this
  refine tendsto_of_tendsto_of_tendsto_of_le_of_le' hlow hup ?_ ?_
  · filter_upwards [self_mem_nhdsWithin] with σ hσ
    have h1 : (1 : ℝ) / 2 < σ := hσ
    have hw : (1 : ℝ) < 2 * σ := by linarith
    have hT := (S_le_T_le hw).2
    rw [show 2 * σ / 2 = σ by ring] at hT
    have hS := S_le_H_re h1
    have hsq : 0 ≤ (2 * σ - 1) ^ 2 := sq_nonneg _
    unfold S at hS
    nlinarith
  · filter_upwards [self_mem_nhdsWithin] with σ hσ
    have h1 : (1 : ℝ) / 2 < σ := hσ
    have hw : (1 : ℝ) < 2 * σ := by linarith
    have hT := (S_le_T_le hw).1
    rw [show 2 * σ / 2 = σ by ring] at hT
    have hH := H_re_le h1
    have hsq : 0 ≤ (2 * σ - 1) ^ 2 := sq_nonneg _
    unfold S at hH
    nlinarith

/-! ### The unconditional sharp constant -/

/-- **Unconditional sharp lower constant.** For every `C < 1/6` and `A ≥ 1`, the bound
`-C x^{3/2} log^2 x ≤ Re W(x)` fails for some `x > A`. -/
theorem not_eventually_lower_log_growth {C A : ℝ} (hA : 1 ≤ A) (hC : C < 1 / 6) :
    ¬ (∀ x : ℝ, A < x → -(C * x ^ ((3 : ℝ) / 2) * (Real.log x) ^ 2) ≤ (ActualCriticalMellin.W x).re) :=
  not_eventually_lower_log_growth_of_HDoublePole hDoublePole hA hC

/-- For every `C < 1/6` and every `B` there is `x > B` with `Re W(x) < -C x^{3/2} log^2 x`:
`liminf W(x)/(x^{3/2} log^2 x) ≤ -1/6`, unconditionally. -/
theorem exists_sharp_lower_excursion {C : ℝ} (hC : C < 1 / 6) (B : ℝ) :
    ∃ x : ℝ, B < x ∧ (ActualCriticalMellin.W x).re < -(C * x ^ ((3 : ℝ) / 2) * (Real.log x) ^ 2) :=
  exists_sharp_lower_excursion_of_HDoublePole hDoublePole hC B

end BuildingBlocks.ActualCriticalHDoublePole

#print axioms BuildingBlocks.ActualCriticalHDoublePole.hDoublePole
#print axioms BuildingBlocks.ActualCriticalHDoublePole.not_eventually_lower_log_growth
#print axioms BuildingBlocks.ActualCriticalHDoublePole.exists_sharp_lower_excursion
