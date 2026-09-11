import Mathlib.Analysis.SpecialFunctions.Stirling
import Mathlib.NumberTheory.Harmonic.EulerMascheroni

/-!
An explicit floor-correction expansion derived from classical Stirling bounds.

Proofs drafted in the RH Proof task under the repository owner's direction,
then extracted by the coordinating task. Definitions and proof bodies are
retained; only imports and namespace change. This is a useful building block,
with no mathematical novelty or first-formalization priority claim.
See ../README.md and ../verification/floor-correction.json for attribution,
scope and verification.
-/

open Filter Finset Set
open scoped Topology BigOperators

namespace BuildingBlocks.FloorCorrection

noncomputable def logFactorial (N : ℕ) : ℝ :=
  ∑ n ∈ Finset.Icc 1 N, Real.log n

theorem logFactorial_eq_log (N : ℕ) : logFactorial N = Real.log (N.factorial : ℝ) := by
  induction N with
  | zero => simp [logFactorial]
  | succ N ih =>
    rw [logFactorial, Finset.sum_Icc_succ_top (by omega)]
    rw [← logFactorial, ih, Nat.factorial_succ, Nat.cast_mul,
      Real.log_mul (by positivity) (by positivity)]
    ring

noncomputable def divisorSum (N : ℕ) : ℝ :=
  ∑ a ∈ Finset.Icc 1 N, ((N / a : ℕ) : ℝ)

noncomputable def centeredDivisorForcing (N : ℕ) : ℝ :=
  logFactorial N - divisorSum N + 2 * Real.eulerMascheroniConstant * N

noncomputable def divisorMainTerm (x : ℝ) : ℝ :=
  x * Real.log x + (2 * Real.eulerMascheroniConstant - 1) * x

noncomputable def realDivisorError (x : ℝ) : ℝ :=
  divisorSum ⌊x⌋₊ - divisorMainTerm x

noncomputable def factorialIntegralRemainder (q : ℕ) : ℝ :=
  logFactorial q - (q : ℝ) * Real.log q + q

/-- A quantitative tail bound obtained from mathlib's successive Stirling bounds. -/
theorem log_stirlingSeq_upper {n : ℕ} (hn : n ≠ 0) :
    Real.log (Stirling.stirlingSeq n) - Real.log (Real.sqrt Real.pi) ≤
      1 / (2 * (n : ℝ)) := by
  let f : ℕ → ℝ := fun k => Real.log (Stirling.stirlingSeq (k + 1)) -
    1 / (2 * ((k : ℝ) + 1))
  have hm : Monotone f := by
    apply monotone_nat_of_le_succ
    intro k
    have hb := Stirling.log_stirlingSeq_sub_log_stirlingSeq_succ k
    have hk : (0 : ℝ) ≤ k := Nat.cast_nonneg k
    have hr : (1 : ℝ) / (4 * ((k : ℝ) + 1) ^ 2) ≤
        1 / (2 * ((k : ℝ) + 1)) - 1 / (2 * ((k : ℝ) + 2)) := by
      field_simp
      nlinarith
    simp only [Nat.cast_add, Nat.cast_one] at hb
    dsimp [f]
    norm_num only [Nat.cast_add, Nat.cast_one]
    have he : k + 1 + 1 = k + 2 := by omega
    rw [he]
    have hden : (k : ℝ) + 1 + 1 = (k : ℝ) + 2 := by ring
    rw [hden]
    linarith
  have hs : Tendsto (fun k : ℕ => Real.log (Stirling.stirlingSeq (k + 1)))
      atTop (𝓝 (Real.log (Real.sqrt Real.pi))) :=
    (Real.continuousAt_log (by positivity)).tendsto.comp
      (Stirling.tendsto_stirlingSeq_sqrt_pi.comp (tendsto_add_atTop_nat 1))
  have hi : Tendsto (fun k : ℕ => 1 / (2 * ((k : ℝ) + 1))) atTop (𝓝 0) := by
    have ht : Tendsto (fun k : ℕ => 2 * ((k : ℝ) + 1)) atTop atTop :=
      (tendsto_atTop_add_const_right atTop 1 tendsto_natCast_atTop_atTop).const_mul_atTop
        (by norm_num)
    exact tendsto_const_nhds.div_atTop ht
  have hf : Tendsto f atTop (𝓝 (Real.log (Real.sqrt Real.pi))) := by
    simpa only [sub_zero] using hs.sub hi
  obtain ⟨m, rfl⟩ := Nat.exists_eq_succ_of_ne_zero hn
  have hh := hm.ge_of_tendsto hf m
  dsimp [f] at hh
  push_cast
  linarith

/-- A coarse explicit Stirling remainder sufficient for removing the floor correction. -/
theorem factorialIntegralRemainder_stirling_bounds {q : ℕ} (hq : 1 ≤ q) :
    0 ≤ factorialIntegralRemainder q -
      (Real.log q + Real.log (2 * Real.pi)) / 2 ∧
    factorialIntegralRemainder q -
      (Real.log q + Real.log (2 * Real.pi)) / 2 ≤ 1 / (2 * (q : ℝ)) := by
  have hq0 : q ≠ 0 := by omega
  have hqR : (0 : ℝ) < q := by exact_mod_cast (Nat.zero_lt_of_ne_zero hq0)
  have hl := Stirling.le_log_factorial_stirling hq0
  rw [Real.log_mul (by norm_num : (2 : ℝ) ≠ 0) Real.pi_pos.ne'] at hl
  have hu := log_stirlingSeq_upper hq0
  rw [Stirling.log_stirlingSeq_formula] at hu
  rw [Real.log_div hqR.ne' (by positivity), Real.log_exp,
    Real.log_mul (by norm_num : (2 : ℝ) ≠ 0) hqR.ne',
    Real.log_sqrt Real.pi_pos.le] at hu
  rw [Real.log_mul (by norm_num : (2 : ℝ) ≠ 0) Real.pi_pos.ne']
  dsimp [factorialIntegralRemainder]
  rw [logFactorial_eq_log]
  constructor <;> linarith

/-- The actual correction between the integer forcing and the real divisor error. -/
noncomputable def realFloorCorrection (x : ℝ) : ℝ :=
  centeredDivisorForcing ⌊x⌋₊ + realDivisorError x

/-- The constant coefficient in the real-index floor expansion. -/
noncomputable def floorCorrectionMean : ℝ :=
  Real.log (2 * Real.pi) / 2 - Real.eulerMascheroniConstant

/-- Keep the sawtooth term explicit, including at integer arguments. -/
theorem floorCorrection_centered_remainder {x : ℝ} (hx : 1 ≤ x) :
    |realFloorCorrection x - floorCorrectionMean +
      (x - (⌊x⌋₊ : ℕ) - 1 / 2) *
        (Real.log x + 2 * Real.eulerMascheroniConstant)| ≤ 2 / x := by
  let q : ℕ := ⌊x⌋₊
  have hq : 1 ≤ q := by simpa [q] using Nat.floor_mono hx
  have hq1 : (1 : ℝ) ≤ q := by exact_mod_cast hq
  have hqpos : (0 : ℝ) < q := by linarith
  have hxpos : 0 < x := by linarith
  have hqx : (q : ℝ) ≤ x := Nat.floor_le hxpos.le
  have hxq : x < (q : ℝ) + 1 := Nat.lt_floor_add_one x
  have hx2q : x ≤ 2 * (q : ℝ) := by linarith
  let L := Real.log x - Real.log q
  let E := factorialIntegralRemainder q -
    (Real.log q + Real.log (2 * Real.pi)) / 2
  obtain ⟨hE0, hE1⟩ := factorialIntegralRemainder_stirling_bounds hq
  change 0 ≤ E at hE0
  change E ≤ 1 / (2 * (q : ℝ)) at hE1
  have hL0 : 0 ≤ L := sub_nonneg.mpr (Real.log_le_log hqpos hqx)
  have hLu : L ≤ (x - (q : ℝ)) / q := by
    have hh := Real.log_le_sub_one_of_pos (div_pos hxpos hqpos)
    rw [Real.log_div hxpos.ne' hqpos.ne'] at hh
    change L ≤ _ at hh
    convert hh using 1
    field_simp
  have hLl : (x - (q : ℝ)) / x ≤ L := by
    have hh := Real.log_le_sub_one_of_pos (div_pos hqpos hxpos)
    rw [Real.log_div hqpos.ne' hxpos.ne'] at hh
    have he : (x - (q : ℝ)) / x = 1 - (q : ℝ) / x := by
      field_simp
    dsimp [L]
    rw [he]
    linarith
  have hqL : (q : ℝ) * L ≤ x - q := by
    simpa [mul_comm] using (le_div_iff₀ hqpos).mp hLu
  have hxL : x - (q : ℝ) ≤ x * L := by
    simpa [mul_comm] using (div_le_iff₀ hxpos).mp hLl
  have hr0 : 0 ≤ (x - (q : ℝ)) - q * L := by linarith
  have hr1 : (x - (q : ℝ)) - q * L ≤ 1 / x := by
    apply (le_div_iff₀ hxpos).mpr
    have hh := mul_le_mul_of_nonneg_left hxL hqpos.le
    have hs : (x - (q : ℝ)) ^ 2 ≤ 1 := by nlinarith
    nlinarith
  have hiq : 1 / (2 * (q : ℝ)) ≤ 1 / x :=
    one_div_le_one_div_of_le hxpos hx2q
  have hhalf : L / 2 ≤ 1 / x := by
    have hgap : (x - (q : ℝ)) / q ≤ 1 / q :=
      div_le_div_of_nonneg_right (by linarith) hqpos.le
    have hh : L / 2 ≤ 1 / (2 * (q : ℝ)) := by
      have hL1 := hLu.trans hgap
      have he : (1 : ℝ) / (2 * (q : ℝ)) = (1 / q) / 2 := by ring
      rw [he]
      linarith
    exact hh.trans hiq
  have heq : realFloorCorrection x - floorCorrectionMean +
      (x - (⌊x⌋₊ : ℕ) - 1 / 2) *
        (Real.log x + 2 * Real.eulerMascheroniConstant) =
      E + ((x - (q : ℝ)) - q * L) - L / 2 := by
    dsimp [realFloorCorrection, floorCorrectionMean, E, L, q,
      centeredDivisorForcing, realDivisorError, divisorMainTerm,
      factorialIntegralRemainder]
    ring
  rw [heq, abs_le]
  rw [show (2 : ℝ) / x = 2 * (1 / x) by ring]
  have hE := hE1.trans hiq
  have hix : 0 ≤ 1 / x := by positivity
  constructor <;> linarith

end BuildingBlocks.FloorCorrection
