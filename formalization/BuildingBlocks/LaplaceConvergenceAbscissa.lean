import Mathlib.MeasureTheory.Integral.Bochner.Basic
import Mathlib.Analysis.SpecialFunctions.ExpDeriv

open MeasureTheory Set Filter
open scoped ENNReal

namespace BuildingBlocks.LaplaceConvergenceAbscissa

variable {α : Type*} [MeasurableSpace α] (μ : Measure α) (τ : α → ℝ)

/-- The nonnegative Laplace integral; no sigma-finiteness is required. -/
noncomputable def mass (σ : ℝ) : ℝ≥0∞ :=
  ∫⁻ y, ENNReal.ofReal (Real.exp (-σ * τ y)) ∂μ

def convergenceSet : Set ℝ := {σ | mass μ τ σ < ∞}

theorem mass_antitone (hτ : ∀ᵐ y ∂μ, 0 ≤ τ y) : Antitone (mass μ τ) := by
  intro σ ρ hσρ
  apply lintegral_mono_ae
  filter_upwards [hτ] with y hy
  exact ENNReal.ofReal_le_ofReal (Real.exp_le_exp.mpr
    (mul_le_mul_of_nonneg_right (neg_le_neg hσρ) hy))

theorem convergence_upward (hτ : ∀ᵐ y ∂μ, 0 ≤ τ y)
    {σ ρ : ℝ} (hσρ : σ ≤ ρ) (hσ : σ ∈ convergenceSet μ τ) :
    ρ ∈ convergenceSet μ τ :=
  lt_of_le_of_lt (mass_antitone μ τ hτ hσρ) hσ

theorem integrable_iff_mem (hτ : Measurable τ) (σ : ℝ) :
    Integrable (fun y => Real.exp (-σ * τ y)) μ ↔ σ ∈ convergenceSet μ τ := by
  have hm : AEStronglyMeasurable (fun y => Real.exp (-σ * τ y)) μ := by
    exact (Real.measurable_exp.comp (measurable_const.mul hτ)).aestronglyMeasurable
  rw [Integrable, hasFiniteIntegral_iff_ofReal
    (Eventually.of_forall (fun y => (Real.exp_pos (-σ * τ y)).le))]
  exact and_iff_right hm

theorem integrable_mono (hτm : Measurable τ) (hτ : ∀ᵐ y ∂μ, 0 ≤ τ y)
    {σ ρ : ℝ} (hσρ : σ ≤ ρ)
    (hσ : Integrable (fun y => Real.exp (-σ * τ y)) μ) :
    Integrable (fun y => Real.exp (-ρ * τ y)) μ := by
  rw [integrable_iff_mem μ τ hτm] at hσ ⊢
  exact convergence_upward μ τ hτ hσρ hσ

/-- Both finite-abscissa hypotheses are explicit. Nothing is asserted about
convergence at the abscissa itself. -/
theorem converges_above_inf (hτ : ∀ᵐ y ∂μ, 0 ≤ τ y)
    (hne : (convergenceSet μ τ).Nonempty) (hb : BddBelow (convergenceSet μ τ))
    {σ : ℝ} (hσ : sInf (convergenceSet μ τ) < σ) :
    σ ∈ convergenceSet μ τ := by
  obtain ⟨ρ, hρ, hρσ⟩ := (csInf_lt_iff hb hne).mp hσ
  exact convergence_upward μ τ hτ hρσ.le hρ

theorem not_converges_below_inf (hb : BddBelow (convergenceSet μ τ))
    {b : ℝ} (hb_lt : b < sInf (convergenceSet μ τ)) :
    b ∉ convergenceSet μ τ :=
  notMem_of_lt_csInf hb_lt hb

theorem integrable_above_inf (hτm : Measurable τ) (hτ : ∀ᵐ y ∂μ, 0 ≤ τ y)
    (hne : (convergenceSet μ τ).Nonempty) (hb : BddBelow (convergenceSet μ τ))
    {σ : ℝ} (hσ : sInf (convergenceSet μ τ) < σ) :
    Integrable (fun y => Real.exp (-σ * τ y)) μ :=
  (integrable_iff_mem μ τ hτm σ).mpr (converges_above_inf μ τ hτ hne hb hσ)

theorem not_integrable_below_inf (hτm : Measurable τ)
    (hb : BddBelow (convergenceSet μ τ)) {b : ℝ}
    (hb_lt : b < sInf (convergenceSet μ τ)) :
    ¬ Integrable (fun y => Real.exp (-b * τ y)) μ := by
  rw [integrable_iff_mem μ τ hτm]
  exact not_converges_below_inf μ τ hb hb_lt

/-- An unbounded-below convergence set means convergence at every real parameter,
not a finite real abscissa. -/
theorem convergenceSet_eq_univ_of_not_bddBelow (hτ : ∀ᵐ y ∂μ, 0 ≤ τ y)
    (hb : ¬ BddBelow (convergenceSet μ τ)) : convergenceSet μ τ = univ := by
  apply Set.eq_univ_of_forall
  intro σ
  obtain ⟨ρ, hρ, hρσ⟩ := not_bddBelow_iff.mp hb σ
  exact convergence_upward μ τ hτ hρσ.le hρ

/-- The complete order classification includes empty and all-real convergence.
Only the remaining case uses a finite infimum, with either endpoint convention. -/
theorem convergenceSet_cases (hτ : ∀ᵐ y ∂μ, 0 ≤ τ y) :
    convergenceSet μ τ = ∅ ∨ convergenceSet μ τ = univ ∨
      ((convergenceSet μ τ).Nonempty ∧ BddBelow (convergenceSet μ τ) ∧
        (convergenceSet μ τ = Ioi (sInf (convergenceSet μ τ)) ∨
         convergenceSet μ τ = Ici (sInf (convergenceSet μ τ)))) := by
  classical
  by_cases hne : (convergenceSet μ τ).Nonempty
  · by_cases hb : BddBelow (convergenceSet μ τ)
    · right; right
      refine ⟨hne, hb, ?_⟩
      by_cases ha : sInf (convergenceSet μ τ) ∈ convergenceSet μ τ
      · right
        ext σ
        exact ⟨fun hσ => csInf_le hb hσ,
          fun hσ => convergence_upward μ τ hτ hσ ha⟩
      · left
        ext σ
        constructor
        · intro hσ
          exact lt_of_le_of_ne (csInf_le hb hσ) (fun he => ha (he ▸ hσ))
        · exact converges_above_inf μ τ hτ hne hb
    · exact Or.inr (Or.inl (convergenceSet_eq_univ_of_not_bddBelow μ τ hτ hb))
  · exact Or.inl (Set.not_nonempty_iff_eq_empty.mp hne)

end BuildingBlocks.LaplaceConvergenceAbscissa
