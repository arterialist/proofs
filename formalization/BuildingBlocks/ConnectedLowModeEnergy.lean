import BuildingBlocks.ConnectedDyadicLowMode
import Mathlib.Tactic

/-!
Finite transfer of the written third-height-power bound for the actual
connected prime-error modes to their low-mode energy. The named analytic
hypothesis is precisely the unformalized first-Riesz/zero-sum estimate for
each mode; this module proves the complete, uniform finite summation with
the literal von Mangoldt mode from `ConnectedDyadicLowMode`.
-/

namespace BuildingBlocks.ConnectedLowModeEnergy

open BuildingBlocks.ConnectedLowModeFinite
open BuildingBlocks.ConnectedDyadicLowMode

noncomputable def actualMode (X j : ℕ) : ℂ :=
  weightedActualError X (phasePrimitive (freq X (j : ℤ)))

noncomputable def lowEnergy (X J : ℕ) : ℝ :=
  ∑ j ∈ Finset.Icc 1 J, ‖actualMode X j‖ ^ 2 / (j : ℝ) ^ 2

theorem actualMode_eq_complete_prime_row (X j : ℕ)
    (hX : 1 ≤ X) (hj : 1 ≤ j) :
    actualMode X j =
      (X : ℂ) / modeDenom (j : ℤ) * actualB X (j : ℤ) -
        (BuildingBlocks.coarseTerminalMassFinite X : ℂ) := by
  unfold actualMode
  exact connected_mode_actual X (j : ℤ) hX (by exact_mod_cast (by omega : j ≠ 0))

/-- The pointwise third-height-power analytic input, with its complete
prime-power actual mode and uniform frequency dependence explicitly named. -/
def ThirdHeightModeBound (X : ℕ) (A : ℝ) : Prop :=
  ∀ j : ℕ, 1 ≤ j → ‖actualMode X j‖ ≤ (1 + (j : ℝ) ^ 2) * A

/-- The arithmetic energy transfer: the cubic frequency loss is valid for
every block length, including block lengths depending on `X`. -/
theorem lowEnergy_le_cubic (X J : ℕ) (A : ℝ)
    (hA : 0 ≤ A) (hModes : ThirdHeightModeBound X A) :
    lowEnergy X J ≤ 4 * A ^ 2 * (J : ℝ) ^ 3 := by
  unfold lowEnergy
  calc
    _ ≤ ∑ _j ∈ Finset.Icc 1 J, 4 * A ^ 2 * (J : ℝ) ^ 2 := by
      apply Finset.sum_le_sum
      intro j hj
      obtain ⟨hj1, hjJ⟩ := Finset.mem_Icc.mp hj
      have hjr : (1 : ℝ) ≤ j := by exact_mod_cast hj1
      have hjJr : (j : ℝ) ≤ J := by exact_mod_cast hjJ
      have hjpos : (0 : ℝ) < j := by linarith
      have hj2pos : (0 : ℝ) < (j : ℝ) ^ 2 := sq_pos_of_pos hjpos
      have hpoint := hModes j hj1
      have hscale : (1 + (j : ℝ) ^ 2) * A ≤ 2 * (j : ℝ) ^ 2 * A := by
        have hsq : (1 : ℝ) ≤ (j : ℝ) ^ 2 := by nlinarith
        nlinarith
      have hnorm : ‖actualMode X j‖ ≤ 2 * (j : ℝ) ^ 2 * A :=
        hpoint.trans hscale
      have hnorm0 : 0 ≤ ‖actualMode X j‖ := norm_nonneg _
      have hbound0 : 0 ≤ 2 * (j : ℝ) ^ 2 * A := by positivity
      have hsquare : ‖actualMode X j‖ ^ 2 ≤
          (2 * (j : ℝ) ^ 2 * A) ^ 2 :=
        (sq_le_sq₀ hnorm0 hbound0).2 hnorm
      have hjsq : (j : ℝ) ^ 2 ≤ (J : ℝ) ^ 2 := by nlinarith
      have hprod : (j : ℝ) ^ 2 * (j : ℝ) ^ 2 ≤
          (J : ℝ) ^ 2 * (j : ℝ) ^ 2 :=
        mul_le_mul_of_nonneg_right hjsq (sq_nonneg _)
      have hscaled : (2 * (j : ℝ) ^ 2 * A) ^ 2 ≤
          4 * A ^ 2 * (J : ℝ) ^ 2 * (j : ℝ) ^ 2 := by
        nlinarith [mul_nonneg (sq_nonneg A) (sub_nonneg.mpr hprod)]
      apply (div_le_iff₀ hj2pos).2
      exact hsquare.trans hscaled
    _ = ((Finset.Icc 1 J).card : ℝ) * (4 * A ^ 2 * (J : ℝ) ^ 2) := by
      simp
    _ ≤ 4 * A ^ 2 * (J : ℝ) ^ 3 := by
      have hcard : (Finset.Icc 1 J).card ≤ J := by
        simp
      have hcardR : ((Finset.Icc 1 J).card : ℝ) ≤ J := by exact_mod_cast hcard
      have hnonneg : 0 ≤ 4 * A ^ 2 * (J : ℝ) ^ 2 := by positivity
      nlinarith

/-- The Vinogradov--Korobov scale used in the written analytic estimate.
The asymptotic theorem applies only for sufficiently large `X`, which is
carried as the named `X₀` hypothesis below. -/
noncomputable def phi (X : ℕ) : ℝ :=
  (Real.log (X : ℝ)) ^ (3 / 5 : ℝ) /
    (Real.log (Real.log (X : ℝ))) ^ (1 / 5 : ℝ)

noncomputable def analyticAmplitude
    (X : ℕ) (C c ε : ℝ) : ℝ :=
  C * (X : ℝ) ^ 2 * Real.exp (-(c - ε) * phi X)

/-- The only analytic input not kernel checked in this file: the independently
written first-Riesz formula and three-power zero-sum estimate imply this
uniform bound for the literal complete-prime-power mode. -/
def ThirdHeightAnalyticInput (X₀ : ℕ) (C c ε : ℝ) : Prop :=
  ∀ X : ℕ, X₀ ≤ X →
    ∀ j : ℕ, 1 ≤ j →
      ‖actualMode X j‖ ≤
        (1 + (j : ℝ) ^ 2) * analyticAmplitude X C c ε

/-- Exact growing-block low-mode energy inequality for the actual prime
error, conditional in Lean on the named analytic zero-sum input. The written
source proof establishes that input unconditionally with `c=3^(2/5)d`. -/
theorem actual_lowEnergy_third_height
    (X₀ X J : ℕ) (C c ε : ℝ)
    (hC : 0 ≤ C) (hX : X₀ ≤ X)
    (hAnalytic : ThirdHeightAnalyticInput X₀ C c ε) :
    lowEnergy X J ≤
      4 * C ^ 2 * (J : ℝ) ^ 3 * (X : ℝ) ^ 4 *
        Real.exp (-2 * (c - ε) * phi X) := by
  have hA : 0 ≤ analyticAmplitude X C c ε := by
    unfold analyticAmplitude
    positivity
  have hM : ThirdHeightModeBound X (analyticAmplitude X C c ε) :=
    hAnalytic X hX
  have h := lowEnergy_le_cubic X J (analyticAmplitude X C c ε) hA hM
  unfold analyticAmplitude at h
  have hexp : Real.exp (-(c - ε) * phi X) ^ 2 =
      Real.exp (-2 * (c - ε) * phi X) := by
    rw [pow_two, ← Real.exp_add]
    congr 1
    ring
  convert h using 1
  rw [mul_pow, mul_pow, hexp]
  ring

/-- Exact comparison with the previous terminal-constant scale. This
separately identifies the growing frequency range on which the new bound
actually improves the old one. -/
theorem growing_block_improves_old_scale
    (J : ℕ) (Φ κ c₃ cM : ℝ)
    (hΦ : 0 ≤ Φ) (hκ : 3 * κ ≤ 2 * (c₃ - cM))
    (hJ : (J : ℝ) ≤ Real.exp (κ * Φ)) :
    (J : ℝ) ^ 3 * Real.exp (-2 * c₃ * Φ) ≤
      Real.exp (-2 * cM * Φ) := by
  have hJ0 : (0 : ℝ) ≤ J := Nat.cast_nonneg _
  have hpow : (J : ℝ) ^ 3 ≤ (Real.exp (κ * Φ)) ^ 3 :=
    pow_le_pow_left₀ hJ0 hJ _
  have hexp : (Real.exp (κ * Φ)) ^ 3 =
      Real.exp (3 * κ * Φ) := by
    rw [← Real.exp_nat_mul]
    congr 1
    ring
  rw [hexp] at hpow
  have hfirst := mul_le_mul_of_nonneg_right hpow
    (Real.exp_pos (-2 * c₃ * Φ)).le
  have hscaled : (3 * κ - 2 * c₃) * Φ ≤ -2 * cM * Φ := by
    nlinarith [mul_nonneg (sub_nonneg.mpr hκ) hΦ]
  calc
    _ ≤ Real.exp (3 * κ * Φ) * Real.exp (-2 * c₃ * Φ) := hfirst
    _ = Real.exp ((3 * κ - 2 * c₃) * Φ) := by rw [← Real.exp_add]; congr 1; ring
    _ ≤ _ := Real.exp_le_exp.mpr hscaled

#print axioms actualMode_eq_complete_prime_row
#print axioms lowEnergy_le_cubic
#print axioms actual_lowEnergy_third_height
#print axioms growing_block_improves_old_scale

end BuildingBlocks.ConnectedLowModeEnergy
