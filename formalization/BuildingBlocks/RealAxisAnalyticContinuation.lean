import Mathlib.Analysis.Complex.Basic
import Mathlib.Analysis.Analytic.IsolatedZeros
import Mathlib.Analysis.NormedSpace.Connected

open Set Filter
open scoped Topology

namespace BuildingBlocks.RealAxisAnalyticContinuation

/-- A real ray supplies complex accumulation points, although it has empty
complex interior. -/
theorem mem_closure_eq_of_right_ray {F L : ℂ → ℂ} {σ : ℝ}
    (heq : ∀ t : ℝ, σ < t → F (t : ℂ) = L (t : ℂ)) :
    (σ : ℂ) ∈ closure ({z | F z = L z} \ {(σ : ℂ)}) := by
  rw [Metric.mem_closure_iff]
  intro ε hε
  refine ⟨((σ + ε / 2 : ℝ) : ℂ), ⟨heq _ (by linarith), ?_⟩, ?_⟩
  · simp only [mem_singleton_iff]
    intro he
    have : σ + ε / 2 = σ := Complex.ofReal_injective he
    linarith
  · rw [dist_eq_norm, ← Complex.ofReal_sub, Complex.norm_real, Real.norm_eq_abs]
    rw [show σ - (σ + ε / 2) = -(ε / 2) by ring, abs_neg,
      abs_of_pos (by linarith : 0 < ε / 2)]
    linarith

/-- Local complex analyticity along a connected real ray already propagates
equality from any terminal real ray. No open half-plane for `F` is assumed. -/
theorem eq_real_of_eq_terminal_ray {F L : ℂ → ℂ} {a β B : ℝ}
    (hF : ∀ σ : ℝ, β < σ → AnalyticAt ℂ F (σ : ℂ))
    (hL : ∀ σ : ℝ, a < σ → AnalyticAt ℂ L (σ : ℂ))
    (heq : ∀ σ : ℝ, B < σ → F (σ : ℂ) = L (σ : ℂ))
    {σ : ℝ} (hσ : max a β < σ) : F (σ : ℂ) = L (σ : ℂ) := by
  let U : Set ℂ := Complex.ofReal '' Ioi (max a β)
  have hFU : AnalyticOnNhd ℂ F U := by
    rintro z ⟨t, ht, rfl⟩
    exact hF t (lt_of_le_of_lt (le_max_right a β) ht)
  have hLU : AnalyticOnNhd ℂ L U := by
    rintro z ⟨t, ht, rfl⟩
    exact hL t (lt_of_le_of_lt (le_max_left a β) ht)
  have hU : IsPreconnected U :=
    isPreconnected_Ioi.image _ Complex.continuous_ofReal.continuousOn
  let c : ℝ := max (max a β) B + 1
  have hc : max a β < c := by dsimp [c]; linarith [le_max_left (max a β) B]
  have hBc : B < c := by dsimp [c]; linarith [le_max_right (max a β) B]
  have hclosure := mem_closure_eq_of_right_ray (σ := c)
    (fun t ht => heq t (hBc.trans ht))
  exact hFU.eqOn_of_preconnected_of_mem_closure hLU hU
    (show (c : ℂ) ∈ U from ⟨c, hc, rfl⟩) hclosure ⟨σ, hσ, rfl⟩

/-- Equality on the real ray identifies the entire complex analytic germ at
each real point where both functions are analytic. -/
theorem germs_eq_of_eq_terminal_ray {F L : ℂ → ℂ} {a β B : ℝ}
    (hF : ∀ σ : ℝ, β < σ → AnalyticAt ℂ F (σ : ℂ))
    (hL : ∀ σ : ℝ, a < σ → AnalyticAt ℂ L (σ : ℂ))
    (heq : ∀ σ : ℝ, B < σ → F (σ : ℂ) = L (σ : ℂ))
    {σ : ℝ} (hσ : max a β < σ) : F =ᶠ[𝓝 (σ : ℂ)] L := by
  apply ((hF σ (lt_of_le_of_lt (le_max_right a β) hσ)).frequently_eq_iff_eventually_eq
    (hL σ (lt_of_le_of_lt (le_max_left a β) hσ))).mp
  apply mem_closure_ne_iff_frequently_within.mp
  exact mem_closure_eq_of_right_ray (fun t ht =>
    eq_real_of_eq_terminal_ray hF hL heq (hσ.trans ht))

/-- At a boundary where `F` is still analytic, compatibility propagates to
the right half of one actual disk. The integral need not converge at its center. -/
theorem exists_right_disk_agreement {F L : ℂ → ℂ} {a β B : ℝ}
    (hF : ∀ σ : ℝ, β < σ → AnalyticAt ℂ F (σ : ℂ))
    (hL : AnalyticOnNhd ℂ L {z : ℂ | a < z.re})
    (heq : ∀ σ : ℝ, B < σ → F (σ : ℂ) = L (σ : ℂ))
    (hβa : β < a) :
    ∃ R : ℝ, 0 < R ∧ DifferentiableOn ℂ F (Metric.ball (a : ℂ) R) ∧
      ∀ z ∈ Metric.ball (a : ℂ) R, a < z.re → F z = L z := by
  obtain ⟨R, hR, hFR⟩ := (hF a hβa).exists_ball_analyticOnNhd
  refine ⟨R, hR, hFR.differentiableOn, ?_⟩
  let U : Set ℂ := Metric.ball (a : ℂ) R ∩ {z : ℂ | a < z.re}
  have hU : IsPreconnected U :=
    ((convex_ball (a : ℂ) R).inter ((convex_Ioi a).linear_preimage Complex.reLm)).isPreconnected
  let c : ℝ := a + R / 2
  have hac : a < c := by dsimp [c]; linarith
  have hc : (c : ℂ) ∈ U := by
    constructor
    · change dist (c : ℂ) (a : ℂ) < R
      rw [dist_eq_norm, ← Complex.ofReal_sub, Complex.norm_real, Real.norm_eq_abs]
      dsimp [c]
      rw [add_sub_cancel_left, abs_of_pos (by linarith : 0 < R / 2)]
      linarith
    · exact hac
  have hgerm : F =ᶠ[𝓝 (c : ℂ)] L := germs_eq_of_eq_terminal_ray hF
    (fun σ hσ => hL (σ : ℂ) hσ) heq (by rw [max_eq_left hβa.le]; exact hac)
  have hEq : EqOn F L U :=
    (hFR.mono inter_subset_left).eqOn_of_preconnected_of_eventuallyEq
      (hL.mono inter_subset_right) hU hc hgerm
  intro z hz hza
  exact hEq ⟨hz, hza⟩

end BuildingBlocks.RealAxisAnalyticContinuation
