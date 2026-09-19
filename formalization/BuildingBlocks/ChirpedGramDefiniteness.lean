import BuildingBlocks.CriticalChirpedGramFinite
import BuildingBlocks.ChirpedGrandSynthesis
import BuildingBlocks.ChirpedSpectralArithmeticExclusion
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Real

/-!
# Scalar Gram-Lower-Bound Algebra

This module proves finite-dimensional norm identities and scalar coercivity consequences from
an assumed lower form `gramLower`.  The functions called arithmetic and spectral margins are
real expressions; no Weil quadratic form, Gram matrix, or zeta-zero coupling is constructed.
The exclusion theorem is an incompatibility among its explicit scalar inequalities.
-/

namespace BuildingBlocks.ChirpedGramDefiniteness

open scoped BigOperators
open Filter
open scoped Topology
open BuildingBlocks.CriticalChirpedGramFinite
open BuildingBlocks.ChirpedGrandSynthesis
open BuildingBlocks.ChirpedSpectralArithmeticExclusion

noncomputable section

variable {ι : Type*} [Fintype ι]

/-- The energy of any coefficient vector is non-negative. -/
theorem energy_nonneg (c : ι → ℂ) : 0 ≤ energy c := by
  unfold energy
  apply Finset.sum_nonneg
  intro i _
  positivity

/-- The energy of any non-zero coefficient vector is strictly positive. -/
theorem energy_pos_of_ne_zero [Nonempty ι] (c : ι → ℂ) (hc : c ≠ 0) :
    0 < energy c := by
  unfold energy
  have hne : ∃ i, c i ≠ 0 := by
    by_contra h
    push_neg at h
    apply hc
    ext i
    exact h i
  obtain ⟨i, hi⟩ := hne
  have hpos : 0 < ‖c i‖ ^ 2 := by
    have hnorm : 0 < ‖c i‖ := norm_pos_iff.mpr hi
    exact sq_pos_of_pos hnorm
  have hle : ‖c i‖ ^ 2 ≤ ∑ j, ‖c j‖ ^ 2 := by
    apply Finset.single_le_sum (f := fun j => ‖c j‖ ^ 2)
    · intro j _
      positivity
    · exact Finset.mem_univ i
  exact lt_of_lt_of_le hpos hle

/-- Net margin decomposition for general diagonal floor and cross row budget. -/
theorem net_margin_decomp (logT C_D C_geom B C_0 : ℝ) :
    (logT - C_D) - (C_geom * Real.exp (-B / 2) * logT + C_0) =
      (1 - C_geom * Real.exp (-B / 2)) * logT - (C_D + C_0) := by
  ring

/-- Under the canonical buffer `B = canonicalBuffer C_geom`, the geometric factor simplifies. -/
theorem canonical_margin_decomp (logT C_D C_geom C_0 : ℝ) (hC : 0 < C_geom) :
    (logT - C_D) - (C_geom * Real.exp (-canonicalBuffer C_geom / 2) * logT + C_0) =
      (1 - Real.exp (-(1 / 2 : ℝ))) * logT - (C_D + C_0) := by
  have hprod : C_geom * Real.exp (-canonicalBuffer C_geom / 2) = Real.exp (-(1 / 2 : ℝ)) :=
    canonical_buffer_geom_product hC
  have hterm : C_geom * Real.exp (-canonicalBuffer C_geom / 2) * logT =
      Real.exp (-(1 / 2 : ℝ)) * logT := by rw [hprod]
  rw [hterm]
  ring

/-- The canonical net margin coefficient `1 - exp(-1/2)` is strictly positive. -/
def canonicalCoeff : ℝ := 1 - Real.exp (-(1 / 2 : ℝ))

/-- Proof that `canonicalCoeff > 0`. -/
theorem canonicalCoeff_pos : 0 < canonicalCoeff := by
  unfold canonicalCoeff
  have := exp_neg_half_lt_one
  linarith

/-- For sufficiently large `T`, the net Rayleigh quotient floor is strictly positive. -/
theorem rayleigh_floor_pos (logT C_tot : ℝ)
    (hlog : C_tot / canonicalCoeff < logT) :
    0 < canonicalCoeff * logT - C_tot := by
  have hc_pos := canonicalCoeff_pos
  have hmul : C_tot < canonicalCoeff * logT := by
    calc
      C_tot = (C_tot / canonicalCoeff) * canonicalCoeff := by
        rw [div_mul_cancel₀ _ (ne_of_gt hc_pos)]
      _ < logT * canonicalCoeff := mul_lt_mul_of_pos_right hlog hc_pos
      _ = canonicalCoeff * logT := mul_comm _ _
  linarith

/-- Positivity of the defined lower form for a nonzero vector under the threshold hypothesis. -/
theorem gramLower_strictly_positive [Nonempty ι]
    (d R C_tot : ℝ) (p : ι → ι → ℂ) (c : ι → ℂ)
    (hc : c ≠ 0)
    (hfloor : C_tot < d - R)
    (hC_tot : 0 ≤ C_tot)
    (hrow : ∀ i, ∑ j, ‖p i j‖ ≤ R)
    (hcol : ∀ j, ∑ i, ‖p i j‖ ≤ R) :
    0 < gramLower d p c := by
  have hmargin : (d - R) * energy c ≤ gramLower d p c :=
    gramLower_ge_margin d R p c hrow hcol
  have he_pos : 0 < energy c := energy_pos_of_ne_zero c hc
  have hdiff_pos : 0 < d - R := by linarith
  have hprod_pos : 0 < (d - R) * energy c := mul_pos hdiff_pos he_pos
  exact lt_of_lt_of_le hprod_pos hmargin

/-- Coercive lower bound: the Gram lower form scales at least with the energy norm. -/
theorem gramLower_coercive (d R : ℝ) (p : ι → ι → ℂ) (v : ι → ℂ)
    (hrow : ∀ i, ∑ j, ‖p i j‖ ≤ R)
    (hcol : ∀ j, ∑ i, ‖p i j‖ ≤ R) :
    (d - R) * energy v ≤ gramLower d p v :=
  gramLower_ge_margin d R p v hrow hcol

/-- The Rayleigh quotient of the Gram lower form with respect to the energy norm. -/
def rayleighQuotient (d : ℝ) (p : ι → ι → ℂ) (c : ι → ℂ) : ℝ :=
  gramLower d p c / energy c

/-- The Rayleigh quotient is bounded below by the Gershgorin/Schur margin `d - R`. -/
theorem rayleighQuotient_ge_margin [Nonempty ι]
    (d R : ℝ) (p : ι → ι → ℂ) (c : ι → ℂ)
    (hc : c ≠ 0)
    (hrow : ∀ i, ∑ j, ‖p i j‖ ≤ R)
    (hcol : ∀ j, ∑ i, ‖p i j‖ ≤ R) :
    d - R ≤ rayleighQuotient d p c := by
  have he := energy_pos_of_ne_zero c hc
  have hmargin := gramLower_ge_margin d R p c hrow hcol
  exact (le_div_iff₀ he).mpr hmargin

/-- A positive power eventually exceeds the stated logarithmic background. -/
theorem offline_deficit_eventual (C_crit M b d_disp c_0 C_tot : ℝ)
    (hb : 0 < b) (hd : 0 < d_disp) :
    ∀ᶠ (T : ℝ) in atTop,
      C_crit * Real.log T + 6 * M - 2 * b * T^(2 * d_disp) < c_0 * Real.log T - C_tot := by
  have h2d : 0 < 2 * d_disp := by linarith
  have h2b : 0 < 2 * b := by linarith
  have hdom := power_dominance_over_log h2d h2b (A := C_crit - c_0) (C := 6 * M + C_tot)
  filter_upwards [hdom] with T hT
  linarith

/-- The two supplied scalar bounds are incompatible for sufficiently large `T`. -/
theorem spectral_arithmetic_positivity_exclusion
    {C_crit M b d_disp c_0 C_tot : ℝ}
    (hb : 0 < b) (hd : 0 < d_disp) :
    ∀ᶠ (T : ℝ) in atTop,
      ¬ (c_0 * Real.log T - C_tot ≤ C_crit * Real.log T + 6 * M - 2 * b * T^(2 * d_disp)) := by
  have hdef := offline_deficit_eventual C_crit M b d_disp c_0 C_tot hb hd
  filter_upwards [hdef] with T hT hle
  linarith

/-- Certificate bundling scalar constants and their positivity properties. -/
structure ChirpedGramDefinitenessCertificate where
  C_tot : ℝ
  C_tot_nonneg : 0 ≤ C_tot
  coeff : ℝ
  coeff_pos : 0 < coeff
  threshold_log : ℝ
  threshold_spec : C_tot / coeff ≤ threshold_log

/-- Builder for the scalar certificate using `canonicalCoeff`. -/
def makeCanonicalGramDefinitenessCertificate (C_tot : ℝ) (hC : 0 ≤ C_tot) :
    ChirpedGramDefinitenessCertificate where
  C_tot := C_tot
  C_tot_nonneg := hC
  coeff := canonicalCoeff
  coeff_pos := canonicalCoeff_pos
  threshold_log := C_tot / canonicalCoeff
  threshold_spec := le_rfl

end

end BuildingBlocks.ChirpedGramDefiniteness

#print axioms BuildingBlocks.ChirpedGramDefiniteness.energy_nonneg
#print axioms BuildingBlocks.ChirpedGramDefiniteness.energy_pos_of_ne_zero
#print axioms BuildingBlocks.ChirpedGramDefiniteness.net_margin_decomp
#print axioms BuildingBlocks.ChirpedGramDefiniteness.canonical_margin_decomp
#print axioms BuildingBlocks.ChirpedGramDefiniteness.canonicalCoeff_pos
#print axioms BuildingBlocks.ChirpedGramDefiniteness.rayleigh_floor_pos
#print axioms BuildingBlocks.ChirpedGramDefiniteness.gramLower_strictly_positive
#print axioms BuildingBlocks.ChirpedGramDefiniteness.gramLower_coercive
#print axioms BuildingBlocks.ChirpedGramDefiniteness.rayleighQuotient_ge_margin
#print axioms BuildingBlocks.ChirpedGramDefiniteness.offline_deficit_eventual
#print axioms BuildingBlocks.ChirpedGramDefiniteness.spectral_arithmetic_positivity_exclusion
#print axioms BuildingBlocks.ChirpedGramDefiniteness.makeCanonicalGramDefinitenessCertificate
