import BuildingBlocks.ActualScatteringMomentMagnitude
import BuildingBlocks.ActualPrimeBlockMellinParity
import Mathlib.Algebra.Order.BigOperators.GroupWithZero.List

namespace BuildingBlocks.ActualPrimeBlockMagnitude

open BuildingBlocks.ActualScatteringMomentSigns
open BuildingBlocks.ActualPrimeBlockMellinParity
open BuildingBlocks.ActualScatteringMomentMagnitude

noncomputable section

theorem actual_block_amplitude_bounds (ps : List ℕ) (depth : ℕ → ℕ)
    {h : ℕ} (hh : 1 ≤ h) (hprime : ∀ p ∈ ps, p.Prime)
    (hdepth : ∀ p ∈ ps, 1 ≤ depth p) :
    (1 / 8 : ℝ) ^ ps.length *
        (ps.map (fun p : ℕ => (p : ℝ) ^ (h * depth p))).prod ≤
      amplitude ps depth h ∧
    amplitude ps depth h ≤
      (2 : ℝ) ^ ps.length *
        (ps.map (fun p : ℕ => (p : ℝ) ^ (h * depth p))).prod := by
  induction ps with
  | nil => simp [amplitude]
  | cons p qs ih =>
    have hp : p.Prime := hprime p (by simp)
    have hd : 1 ≤ depth p := hdepth p (by simp)
    have hqs : ∀ q ∈ qs, q.Prime := fun q hq => hprime q (by simp [hq])
    have hdqs : ∀ q ∈ qs, 1 ≤ depth q := fun q hq => hdepth q (by simp [hq])
    have hlocal := actual_prime_multiplier_magnitude hp hh hd
    have htail := ih hqs hdqs
    let P : ℝ := (p : ℝ) ^ (h * depth p)
    let W : ℝ := -(positiveMultiplier (p : ℝ) h (depth p) *
      negativeMultiplier (p : ℝ) h (depth p))
    let L : ℝ := (1 / 8 : ℝ) ^ qs.length *
      (qs.map (fun q : ℕ => (q : ℝ) ^ (h * depth q))).prod
    let U : ℝ := (2 : ℝ) ^ qs.length *
      (qs.map (fun q : ℕ => (q : ℝ) ^ (h * depth q))).prod
    have hProd0 : 0 ≤ (qs.map (fun q : ℕ => (q : ℝ) ^ (h * depth q))).prod := by
      apply List.prod_nonneg
      intro x hx
      rw [List.mem_map] at hx
      obtain ⟨q, -, rfl⟩ := hx
      positivity
    have hP0 : 0 ≤ P := by positivity
    have hL0 : 0 ≤ L := mul_nonneg (by positivity) hProd0
    have hU0 : 0 ≤ U := mul_nonneg (by positivity) hProd0
    have hW0 : 0 ≤ W := le_trans (div_nonneg hP0 (by norm_num)) hlocal.1
    have hA0 : 0 ≤ amplitude qs depth h := hL0.trans htail.1
    constructor
    · have hm := mul_le_mul hlocal.1 htail.1 hL0 hW0
      calc
        _ = P / 8 * L := by simp only [P, L, List.length_cons, List.map_cons,
          List.prod_cons, pow_succ]; ring
        _ ≤ W * amplitude qs depth h := hm
        _ = amplitude (p :: qs) depth h := by
          simp only [amplitude, W, List.map_cons, List.prod_cons]
    · have hm := mul_le_mul hlocal.2 htail.2 hA0 (by positivity : 0 ≤ 2 * P)
      calc
        amplitude (p :: qs) depth h = W * amplitude qs depth h := by
          simp only [amplitude, W, List.map_cons, List.prod_cons]
        _ ≤ 2 * P * U := hm
        _ = (2 : ℝ) ^ (p :: qs).length *
            ((p :: qs).map (fun q : ℕ => (q : ℝ) ^ (h * depth q))).prod := by
          simp only [P, U, List.length_cons, List.map_cons,
            List.prod_cons, pow_succ]
          ring

#print axioms actual_block_amplitude_bounds

end
end BuildingBlocks.ActualPrimeBlockMagnitude
