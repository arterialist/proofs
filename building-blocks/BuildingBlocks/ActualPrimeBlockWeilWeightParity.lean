import BuildingBlocks.ActualPrimeBlockMellinParity

namespace BuildingBlocks.ActualPrimeBlockWeilWeightParity

open MeasureTheory
open BuildingBlocks.ActualScatteringMomentSigns BuildingBlocks.ActualScatteringMellinSignBridge
open BuildingBlocks.ActualPrimeBlockMellinParity
open BuildingBlocks.FullComplexHistoryMellin

theorem mellin_reflection_even {f : ℝ → ℂ} (heven : ∀ v, f (-v) = f v) (z : ℂ) :
    BuildingBlocks.FullComplexHistoryMellin.mellin f (-z) =
      BuildingBlocks.FullComplexHistoryMellin.mellin f z := by
  unfold BuildingBlocks.FullComplexHistoryMellin.mellin
  simpa only [heven, Complex.ofReal_neg, mul_neg, neg_mul] using
    integral_neg_eq_self (fun v : ℝ => f v * Complex.exp (z * (v : ℂ))) volume

theorem even_seed_paired_weight {f : ℝ → ℂ} (heven : ∀ v, f (-v) = f v) (b : ℝ) :
    pairedWeight f f (b : ℂ) =
      (Complex.normSq (BuildingBlocks.FullComplexHistoryMellin.mellin f (b : ℂ)) : ℂ) := by
  unfold pairedWeight
  simp only [Complex.conj_ofReal]
  rw [mellin_reflection_even heven]
  exact Complex.mul_conj _

theorem actual_block_paired_weight_parity {f : ℝ → ℂ} (hf : Continuous f)
    (hc : HasCompactSupport f) (ps : List ℕ) (depth : ℕ → ℕ)
    (hprime : ∀ p ∈ ps, p.Prime) (h : ℕ) :
    pairedWeight (physicalBlock ps depth f) (physicalBlock ps depth f) ((h : ℂ) + 1 / 2) =
      (-1 : ℂ) ^ ps.length * (amplitude ps depth h : ℂ) * pairedWeight f f ((h : ℂ) + 1 / 2) := by
  induction ps with
  | nil => simp [physicalBlock, amplitude]
  | cons p qs ih =>
    have hqs : ∀ q ∈ qs, q.Prime := fun q hq => hprime q (by simp [hq])
    have hr := physical_block_regular hf hc qs depth
    rw [physicalBlock, actual_history_paired_weight p (hprime p (by simp)).two_le
      hr.1 hr.1 hr.2 hr.2,
      BuildingBlocks.GrowingPrimeScatteringBounds.actual_paired_original_dictionary
        p (hprime p (by simp)).two_le,
      positive_history_dictionary, negative_history_dictionary, ih hqs]
    simp only [List.length_cons, amplitude, List.map_cons, List.prod_cons, pow_succ]
    push_cast
    ring

/-- The actual conjugate-polarized weight is a real parity-signed magnitude.
This is a Mellin-row identity, not a sign for the entire Weil form. -/
theorem actual_even_seed_block_weight {f : ℝ → ℂ} (hf : Continuous f)
    (hc : HasCompactSupport f) (heven : ∀ v, f (-v) = f v)
    (ps : List ℕ) (depth : ℕ → ℕ) (hprime : ∀ p ∈ ps, p.Prime) (h : ℕ) :
    pairedWeight (physicalBlock ps depth f) (physicalBlock ps depth f) ((h : ℂ) + 1 / 2) =
      (((-1 : ℝ) ^ ps.length * amplitude ps depth h *
        Complex.normSq (BuildingBlocks.FullComplexHistoryMellin.mellin f
          ((h : ℂ) + 1 / 2)) : ℝ) : ℂ) := by
  rw [actual_block_paired_weight_parity hf hc ps depth hprime]
  have he := even_seed_paired_weight heven ((h : ℝ) + 1 / 2)
  push_cast at he
  rw [he]
  push_cast
  rfl

theorem actual_even_seed_parity_signed_weight_nonnegative {f : ℝ → ℂ}
    (hf : Continuous f) (hc : HasCompactSupport f) (heven : ∀ v, f (-v) = f v)
    (ps : List ℕ) (depth : ℕ → ℕ) (hprime : ∀ p ∈ ps, p.Prime)
    (hdepth : ∀ p ∈ ps, 1 ≤ depth p) {h : ℕ} (hh : 1 ≤ h) :
    0 ≤ (-1 : ℝ) ^ ps.length *
      (pairedWeight (physicalBlock ps depth f) (physicalBlock ps depth f)
        ((h : ℂ) + 1 / 2)).re := by
  rw [actual_even_seed_block_weight hf hc heven ps depth hprime]
  simp only [Complex.ofReal_re]
  have ha := actual_block_amplitude_positive ps depth hh hprime hdepth
  have hn := Complex.normSq_nonneg
    (BuildingBlocks.FullComplexHistoryMellin.mellin f ((h : ℂ) + 1 / 2))
  have hp := mul_nonneg (sq_nonneg ((-1 : ℝ) ^ ps.length)) (mul_nonneg ha.le hn)
  calc
    (-1 : ℝ) ^ ps.length *
        ((-1 : ℝ) ^ ps.length * amplitude ps depth h *
          Complex.normSq (BuildingBlocks.FullComplexHistoryMellin.mellin f
            ((h : ℂ) + 1 / 2))) =
      ((-1 : ℝ) ^ ps.length) ^ 2 *
        (amplitude ps depth h * Complex.normSq
          (BuildingBlocks.FullComplexHistoryMellin.mellin f ((h : ℂ) + 1 / 2))) := by ring
    _ ≥ 0 := hp

#print axioms mellin_reflection_even
#print axioms even_seed_paired_weight
#print axioms actual_block_paired_weight_parity
#print axioms actual_even_seed_block_weight
#print axioms actual_even_seed_parity_signed_weight_nonnegative

end BuildingBlocks.ActualPrimeBlockWeilWeightParity
