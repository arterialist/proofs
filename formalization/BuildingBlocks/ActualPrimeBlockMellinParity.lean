import BuildingBlocks.ActualScatteringMellinSignBridge

namespace BuildingBlocks.ActualPrimeBlockMellinParity

open BuildingBlocks.ActualScatteringMomentSigns BuildingBlocks.ActualScatteringMellinSignBridge
open BuildingBlocks.FullComplexHistoryMellin
open BuildingBlocks.CompactScatteringOperator

noncomputable section

def physicalBlock (ps : List ℕ) (depth : ℕ → ℕ) (f : ℝ → ℂ) : ℝ → ℂ :=
  match ps with
  | [] => f
  | p :: qs => historyPhysical (1 / Real.sqrt (p : ℝ)) (depth p)
      (Real.log (p : ℝ)) (physicalBlock qs depth f)

def amplitude (ps : List ℕ) (depth : ℕ → ℕ) (h : ℕ) : ℝ :=
  (ps.map (fun (p : ℕ) => -(positiveMultiplier (p : ℝ) h (depth p) *
    negativeMultiplier (p : ℝ) h (depth p)))).prod

theorem physical_block_regular {f : ℝ → ℂ} (hf : Continuous f)
    (hc : HasCompactSupport f) (ps : List ℕ) (depth : ℕ → ℕ) :
    Continuous (physicalBlock ps depth f) ∧ HasCompactSupport (physicalBlock ps depth f) := by
  induction ps with
  | nil => exact ⟨hf, hc⟩
  | cons p qs ih => exact history_regular ih.1 ih.2 _ _ _

theorem actual_block_mellin {f : ℝ → ℂ} (hf : Continuous f)
    (hc : HasCompactSupport f) (ps : List ℕ) (depth : ℕ → ℕ)
    (hprime : ∀ p ∈ ps, p.Prime) (z : ℂ) :
    BuildingBlocks.FullComplexHistoryMellin.mellin (physicalBlock ps depth f) z =
      (ps.map (fun (p : ℕ) => BuildingBlocks.GrowingPrimeScatteringBounds.originalHistory
        (p : ℝ) z (depth p))).prod * BuildingBlocks.FullComplexHistoryMellin.mellin f z := by
  induction ps with
  | nil => simp [physicalBlock]
  | cons p qs ih =>
    have hqs : ∀ q ∈ qs, q.Prime := fun q hq => hprime q (by simp [hq])
    have hr := physical_block_regular hf hc qs depth
    rw [physicalBlock, actual_history_mellin p (hprime p (by simp)).two_le hr.1 hr.2,
      ih hqs]
    simp only [List.map_cons, List.prod_cons]
    ring

theorem actual_block_preserves_zero_moment {f : ℝ → ℂ} (hf : Continuous f)
    (hc : HasCompactSupport f) (ps : List ℕ) (depth : ℕ → ℕ)
    (hprime : ∀ p ∈ ps, p.Prime) (z : ℂ)
    (hz : BuildingBlocks.FullComplexHistoryMellin.mellin f z = 0) :
    BuildingBlocks.FullComplexHistoryMellin.mellin (physicalBlock ps depth f) z = 0 := by
  rw [actual_block_mellin hf hc ps depth hprime, hz, mul_zero]

theorem actual_block_amplitude_positive (ps : List ℕ) (depth : ℕ → ℕ)
    {h : ℕ} (hh : 1 ≤ h) (hprime : ∀ p ∈ ps, p.Prime)
    (hdepth : ∀ p ∈ ps, 1 ≤ depth p) : 0 < amplitude ps depth h := by
  induction ps with
  | nil => simp [amplitude]
  | cons p qs ih =>
    have hqs : ∀ q ∈ qs, q.Prime := fun q hq => hprime q (by simp [hq])
    have hdqs : ∀ q ∈ qs, 1 ≤ depth q := fun q hq => hdepth q (by simp [hq])
    have hpneg := actual_prime_multiplier_product_negative (hprime p (by simp))
      hh (hdepth p (by simp))
    simpa only [amplitude, List.map_cons, List.prod_cons] using
      mul_pos (neg_pos.mpr hpneg) (ih hqs hdqs)

theorem actual_block_two_sided_mellin_parity {f : ℝ → ℂ} (hf : Continuous f)
    (hc : HasCompactSupport f) (ps : List ℕ) (depth : ℕ → ℕ)
    (hprime : ∀ p ∈ ps, p.Prime) (h : ℕ) :
    BuildingBlocks.FullComplexHistoryMellin.mellin (physicalBlock ps depth f) ((h : ℂ) + 1 / 2) *
    BuildingBlocks.FullComplexHistoryMellin.mellin (physicalBlock ps depth f) (-((h : ℂ) + 1 / 2)) =
      (-1 : ℂ) ^ ps.length * (amplitude ps depth h : ℂ) *
        (BuildingBlocks.FullComplexHistoryMellin.mellin f ((h : ℂ) + 1 / 2) *
          BuildingBlocks.FullComplexHistoryMellin.mellin f (-((h : ℂ) + 1 / 2))) := by
  induction ps with
  | nil => simp [physicalBlock, amplitude]
  | cons p qs ih =>
    have hqs : ∀ q ∈ qs, q.Prime := fun q hq => hprime q (by simp [hq])
    have hr := physical_block_regular hf hc qs depth
    rw [physicalBlock, actual_physical_two_sided_mellin p h (depth p)
      (hprime p (by simp)) hr.1 hr.2, ih hqs]
    simp only [List.length_cons, amplitude, List.map_cons, List.prod_cons, pow_succ]
    push_cast
    ring

#print axioms physical_block_regular
#print axioms actual_block_mellin
#print axioms actual_block_preserves_zero_moment
#print axioms actual_block_amplitude_positive
#print axioms actual_block_two_sided_mellin_parity

end
end BuildingBlocks.ActualPrimeBlockMellinParity
