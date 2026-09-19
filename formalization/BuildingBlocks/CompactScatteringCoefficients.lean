import BuildingBlocks.CompactScatteringPackets

/-! Exact coefficients of the finite scattering history on a finite phase box. -/
namespace BuildingBlocks.CompactScatteringCoefficients
open BuildingBlocks.CompactLocalScatteringSigns

noncomputable def box (q : ℂ) (J : ℕ) (k : ℤ) : ℂ :=
  if 0 ≤ k ∧ k < (J : ℤ) then q ^ (-k) else 0

noncomputable def historyCoefficient (r : ℝ) (M : ℕ) (c : ℤ → ℂ) (k : ℤ) : ℂ :=
  -(r : ℂ) * c (k - 1) + (1 - (r : ℂ) ^ 2) *
    ∑ m ∈ Finset.range M, (r : ℂ) ^ m * c (k + (m : ℤ))

theorem box_inside (q : ℂ) (J : ℕ) (k : ℤ) (h0 : 0 ≤ k) (hJ : k < J) :
    box q J k = q ^ (-k) := by simp [box, h0, hJ]

theorem history_box_interior (r : ℝ) (q : ℂ) (hq : q ≠ 0) (J M : ℕ) (k : ℤ)
    (hk : 1 ≤ k) (hbulk : k ≤ (J : ℤ) - (M : ℤ)) :
    historyCoefficient r M (box q J) k = q ^ (-k) *
      (-(r : ℂ) * q + (1 - (r : ℂ) ^ 2) *
        ∑ m ∈ Finset.range M, ((r : ℂ) * q⁻¹) ^ m) := by
  have hleft : box q J (k - 1) = q ^ (-k) * q := by
    rw [box_inside q J (k - 1) (by omega) (by omega)]
    rw [show -(k - 1) = -k + 1 by omega, zpow_add₀ hq]
    simp
  have hsum : (∑ m ∈ Finset.range M, (r : ℂ) ^ m * box q J (k + (m : ℤ))) =
      q ^ (-k) * ∑ m ∈ Finset.range M, ((r : ℂ) * q⁻¹) ^ m := by
    rw [Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro m hm
    have hmM := Finset.mem_range.mp hm
    rw [box_inside q J (k + (m : ℤ)) (by omega) (by omega)]
    rw [show -(k + (m : ℤ)) = -k + -(m : ℤ) by omega, zpow_add₀ hq]
    simp only [zpow_neg, zpow_natCast, inv_pow, mul_pow]
    ring
  unfold historyCoefficient
  rw [hleft, hsum]
  ring

theorem phase_inverse (theta : ℝ) : (phase theta)⁻¹ = (starRingEnd ℂ) (phase theta) := by
  have h : phase theta * (starRingEnd ℂ) (phase theta) = 1 := by
    rw [Complex.mul_conj, phase_normSq]
    simp
  exact inv_eq_of_mul_eq_one_right h

theorem history_phase_box_interior (r theta : ℝ) (J M : ℕ) (k : ℤ)
    (hk : 1 ≤ k) (hbulk : k ≤ (J : ℤ) - (M : ℤ)) :
    historyCoefficient r M (box (phase theta) J) k =
      (phase theta) ^ (-k) * compactPhase r theta M := by
  have hq : phase theta ≠ 0 := by
    intro h
    have hn := phase_normSq theta
    simp [h] at hn
  rw [history_box_interior r (phase theta) hq J M k hk hbulk, phase_inverse]
  rfl

theorem phase_zpow_normSq (theta : ℝ) (k : ℤ) :
    Complex.normSq ((phase theta) ^ k) = 1 := by
  have hn : ‖phase theta‖ = 1 := by
    have hs := phase_normSq theta
    rw [Complex.normSq_eq_norm_sq] at hs
    nlinarith [norm_nonneg (phase theta)]
  rw [Complex.normSq_eq_norm_sq, Complex.norm_zpow, hn]
  simp

theorem history_phase_box_normSq (r theta : ℝ) (J M : ℕ) (k : ℤ)
    (hk : 1 ≤ k) (hbulk : k ≤ (J : ℤ) - (M : ℤ)) :
    Complex.normSq (historyCoefficient r M (box (phase theta) J) k) =
      Complex.normSq (compactPhase r theta M) := by
  rw [history_phase_box_interior r theta J M k hk hbulk, map_mul,
    phase_zpow_normSq, one_mul]

theorem prime_interior_amplification (p : ℕ) (hp : p.Prime)
    (J M : ℕ) (hM : 1 ≤ M) (k : ℤ) (hk : 1 ≤ k)
    (hbulk : k ≤ (J : ℤ) - (M : ℤ)) :
    1 < Complex.normSq (historyCoefficient (1 / Real.sqrt (p : ℝ)) M
      (box (phase (Real.pi / (M : ℝ))) J) k) := by
  rw [history_phase_box_normSq _ _ J M k hk hbulk]
  exact (actual_prime_compact_signs p hp hM).2

#print axioms phase_zpow_normSq
#print axioms history_phase_box_normSq
#print axioms prime_interior_amplification
#print axioms box_inside
#print axioms history_box_interior
#print axioms phase_inverse
#print axioms history_phase_box_interior
end BuildingBlocks.CompactScatteringCoefficients
