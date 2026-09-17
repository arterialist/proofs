import BuildingBlocks.CoarseDyadicBase

open Filter Set MeasureTheory Asymptotics
open scoped Topology BigOperators Interval

namespace BuildingBlocks.CoarsePrimitive

/-- A geometric majorant uniform on each bounded vertical region supplies
uniform absolute summability on every compact subset of the half-plane. -/
theorem coarseMellinBlock_compact_majorant
    (hbound : ∀ a R : ℝ, (1 : ℝ) / 2 < a → 0 ≤ R →
      ∃ M r : ℝ, 0 < M ∧ 0 ≤ r ∧ r < 1 ∧
        ∀ k s, a ≤ s.re → ‖s + 1‖ ≤ R → ‖coarseMellinBlock k s‖ ≤ M * r ^ k)
    {K : Set ℂ} (hK : IsCompact K) (hsub : K ⊆ {s | (1 : ℝ) / 2 < s.re}) :
    ∃ u : ℕ → ℝ, Summable u ∧ ∀ k s, s ∈ K → ‖coarseMellinBlock k s‖ ≤ u k := by
  rcases K.eq_empty_or_nonempty with he | hne
  · subst K
    exact ⟨0, summable_zero, by simp⟩
  obtain ⟨z, hz, hmin⟩ := hK.exists_isMinOn hne Complex.continuous_re.continuousOn
  obtain ⟨w, hw, hmax⟩ := hK.exists_isMaxOn hne
    ((continuous_id.add continuous_const).norm.continuousOn :
      ContinuousOn (fun s : ℂ => ‖s + 1‖) K)
  obtain ⟨M, r, hM, hr, hr1, hb⟩ := hbound z.re ‖w + 1‖ (hsub hz) (norm_nonneg _)
  refine ⟨fun k => M * r ^ k,
    (summable_geometric_of_lt_one hr hr1).mul_left M, ?_⟩
  intro k s hs
  exact hb k s (hmin hs) (hmax hs)

theorem coarseMellinBlock_tendstoLocallyUniformlyOn_of_geometric
    (hbound : ∀ a R : ℝ, (1 : ℝ) / 2 < a → 0 ≤ R →
      ∃ M r : ℝ, 0 < M ∧ 0 ≤ r ∧ r < 1 ∧
        ∀ k s, a ≤ s.re → ‖s + 1‖ ≤ R → ‖coarseMellinBlock k s‖ ≤ M * r ^ k) :
    TendstoLocallyUniformlyOn
      (fun t : Finset ℕ => fun s => ∑ k ∈ t, coarseMellinBlock k s)
      coarseMellinSum atTop {s | (1 : ℝ) / 2 < s.re} := by
  rw [tendstoLocallyUniformlyOn_iff_forall_isCompact
    (isOpen_lt continuous_const Complex.continuous_re)]
  intro K hsub hK
  obtain ⟨u, hu, hmajor⟩ := coarseMellinBlock_compact_majorant hbound hK hsub
  exact tendstoUniformlyOn_tsum hu hmajor

theorem coarseMellinSum_analytic_of_geometric
    (hblock : ∀ k s, AnalyticAt ℂ (coarseMellinBlock k) s)
    (hbound : ∀ a R : ℝ, (1 : ℝ) / 2 < a → 0 ≤ R →
      ∃ M r : ℝ, 0 < M ∧ 0 ≤ r ∧ r < 1 ∧
        ∀ k s, a ≤ s.re → ‖s + 1‖ ≤ R → ‖coarseMellinBlock k s‖ ≤ M * r ^ k) :
    AnalyticOnNhd ℂ coarseMellinSum {s | (1 : ℝ) / 2 < s.re} := by
  have hopen : IsOpen {s : ℂ | (1 : ℝ) / 2 < s.re} :=
    isOpen_lt continuous_const Complex.continuous_re
  apply DifferentiableOn.analyticOnNhd _ hopen
  apply (coarseMellinBlock_tendstoLocallyUniformlyOn_of_geometric hbound).differentiableOn _ hopen
  exact Eventually.of_forall fun t => DifferentiableOn.fun_sum
    (fun k _ => fun s _ => (hblock k s).differentiableAt.differentiableWithinAt)

end BuildingBlocks.CoarsePrimitive
