import BuildingBlocks.PrimeSeedMass

/-! The literal initial interval and complete delay history of the prime seed.
The endpoint convention is the same half-open convention as the floor formula.
-/

open Real

namespace BuildingBlocks.PrimeSeedMass

/-- The actual nonzero first interval of the seed, before any further delay. -/
noncomputable def initialCell (L v : ℝ) : ℝ :=
  if v ∈ Set.Ico L (2 * L) then exp (v / 2 - 2 * L) else 0

theorem seed_add_clock {L v : ℝ} (hL : 0 < L) (hv : L ≤ v) :
    seed L (v + L) = exp (-L / 2) * seed L v := by
  have hv0 : 0 ≤ v / L := div_nonneg (le_trans hL.le hv) hL.le
  have heq : (v + L) / L = v / L + 1 := by field_simp
  simp only [seed, if_pos hv, if_pos (show L ≤ v + L by linarith),
    heq, Nat.floor_add_one hv0]
  rw [← exp_add]
  congr 1
  push_cast
  ring

/-- The complete causal seed solves the delay equation with its literal first
interval. The source remains present at `v=L` and is absent at `v=2L`. -/
theorem seed_delay_equation {L : ℝ} (hL : 0 < L) (v : ℝ) :
    seed L v = initialCell L v + exp (-L / 2) * seed L (v - L) := by
  by_cases hv : v < L
  · rw [seed_eq_zero hv, seed_eq_zero (show v - L < L by linarith)]
    simp [initialCell, not_le.mpr hv]
  · have hvL : L ≤ v := le_of_not_gt hv
    by_cases hv2 : v < 2 * L
    · have hc : seed L v = cellDensity L 0 v :=
        seed_eq_cellDensity hL 0 (by constructor <;> norm_num <;> assumption)
      rw [hc, seed_eq_zero (show v - L < L by linarith)]
      simp [initialCell, hvL, hv2, cellDensity]
    · have hprev : L ≤ v - L := by linarith
      have h := seed_add_clock hL hprev
      rw [sub_add_cancel] at h
      rw [h]
      simp [initialCell, hv2]

/-- Every finite iteration retains its actual delayed terminal history. -/
theorem iterate_delay {f g : ℝ → ℝ} {L r : ℝ}
    (h : ∀ v, f v = g v + r * f (v - L)) (N : ℕ) (v : ℝ) :
    f v = (∑ j ∈ Finset.range N, r ^ j * g (v - j * L)) +
      r ^ N * f (v - N * L) := by
  induction N generalizing v with
  | zero => simp
  | succ N ih =>
    rw [Finset.sum_range_succ]
    have hi := ih v
    rw [h (v - N * L)] at hi
    rw [hi]
    push_cast
    rw [pow_succ]
    have heq : v - N * L - L = v - (N + 1) * L := by ring
    rw [heq]
    ring

/-- The actual seed has a finite complete-history expansion at every finite
observation point. No tail is discarded unless its causal support is empty. -/
theorem seed_finite_history {L v : ℝ} (hL : 0 < L) (N : ℕ)
    (hv : v < (N + 1 : ℝ) * L) :
    seed L v = ∑ j ∈ Finset.range N,
      exp (-L / 2) ^ j * initialCell L (v - j * L) := by
  have h := iterate_delay (seed_delay_equation hL) N v
  rw [seed_eq_zero (show v - N * L < L by linarith), mul_zero, add_zero] at h
  exact h

/-- Causality and the actual first interval uniquely determine the whole seed.
No boundedness, square-integrability, or RH hypothesis is needed. -/
theorem seed_unique {L : ℝ} (hL : 0 < L) {f : ℝ → ℝ}
    (hzero : ∀ v < L, f v = 0)
    (hdelay : ∀ v, f v = initialCell L v + exp (-L / 2) * f (v - L)) :
    f = seed L := by
  funext v
  obtain ⟨N, hN⟩ := exists_nat_gt (v / L)
  have hv : v < (N + 1 : ℝ) * L := by
    have : v < N * L := (div_lt_iff₀ hL).1 hN
    nlinarith
  have hf := iterate_delay hdelay N v
  rw [hzero _ (show v - N * L < L by linarith), mul_zero, add_zero] at hf
  rw [hf, seed_finite_history hL N hv]

end BuildingBlocks.PrimeSeedMass
