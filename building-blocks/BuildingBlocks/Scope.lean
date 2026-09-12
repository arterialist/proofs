import BuildingBlocks.Bridge

namespace BuildingBlocks

/-- The pole is excluded because this concerns the mathematical zeta function. -/
def RightHalfZeroFree : Prop :=
  ∀ s : ℂ, (1 : ℝ) / 2 < s.re → s ≠ 1 → riemannZeta s ≠ 0

theorem zeta_zero_ne_origin {s : ℂ} (hz : riemannZeta s = 0) : s ≠ 0 := by
  intro hs
  subst s
  rw [riemannZeta_zero] at hz
  norm_num at hz

theorem gamma_ne_zero_at_nontrivial_zero {s : ℂ} (hz : riemannZeta s = 0)
    (ht : ¬ ∃ n : ℕ, s = -2 * (n + 1)) : Complex.Gammaℝ s ≠ 0 := by
  intro hg
  obtain ⟨n, hn⟩ := Complex.Gammaℝ_eq_zero_iff.mp hg
  cases n with
  | zero =>
      apply zeta_zero_ne_origin hz
      simpa using hn
  | succ n =>
      apply ht
      refine ⟨n, ?_⟩
      simpa [Nat.cast_add, Nat.cast_one, neg_mul] using hn

theorem reflect_nontrivial_zero {s : ℂ} (hz : riemannZeta s = 0)
    (ht : ¬ ∃ n : ℕ, s = -2 * (n + 1)) (hs : s ≠ 1) :
    riemannZeta (1 - s) = 0 := by
  have hg := gamma_ne_zero_at_nontrivial_zero hz ht
  have hc : completedRiemannZeta s = 0 := by
    have hq := hz
    rw [riemannZeta_def_of_ne_zero (zeta_zero_ne_origin hz)] at hq
    exact (div_eq_zero_iff.mp hq).resolve_right hg
  rw [riemannZeta_def_of_ne_zero (sub_ne_zero.mpr hs.symm),
    completedRiemannZeta_one_sub, hc, zero_div]

/-- This is an equivalence of full-scope statements, not a proof of either. -/
theorem target_iff_rightHalfZeroFree : Target ↔ RightHalfZeroFree := by
  constructor
  · intro h s hsr hs hz
    have ht : ¬ ∃ n : ℕ, s = -2 * (n + 1) := by
      rintro ⟨n, rfl⟩
      norm_num at hsr
      have : (0 : ℝ) ≤ n := Nat.cast_nonneg n
      linarith
    have := h s hz ht hs
    linarith
  · intro h s hz ht hs
    by_contra he
    rcases lt_or_gt_of_ne he with hlt | hgt
    · have hzero := reflect_nontrivial_zero hz ht hs
      apply h (1 - s) _ _ hzero
      · simp only [Complex.sub_re, Complex.one_re]
        linarith
      · intro hsub
        apply zeta_zero_ne_origin hz
        linear_combination -hsub
    · exact h s hgt hs hz

end BuildingBlocks
