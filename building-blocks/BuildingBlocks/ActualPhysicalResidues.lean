import BuildingBlocks.ActualArchimedeanFactor
import BuildingBlocks.FullComplexHistoryMellin
import BuildingBlocks.NarrowPoleNullPacket
import Mathlib.MeasureTheory.Integral.Bochner.Set

open MeasureTheory
open scoped ContDiff
open BuildingBlocks.FullComplexHistoryMellin
open BuildingBlocks.ActualArchimedeanFactor

namespace BuildingBlocks.ActualPhysicalResidues

theorem physical_mellin_continuous {f : ℝ → ℂ} (hf : Continuous f)
    (hfc : HasCompactSupport f) : Continuous (BuildingBlocks.FullComplexHistoryMellin.mellin f) := by
  have hi : Continuous (fun p : ℂ × ℝ => f p.2 * Complex.exp (p.1 * (p.2 : ℂ))) := by
    fun_prop
  have hc := continuous_parametric_integral_of_continuous (μ := volume)
    (f := fun z : ℂ => fun v : ℝ => f v * Complex.exp (z * (v : ℂ))) hi hfc
  have he : BuildingBlocks.FullComplexHistoryMellin.mellin f =
      (fun z : ℂ => ∫ v : ℝ in tsupport f, f v * Complex.exp (z * (v : ℂ))) := by
    funext z
    unfold BuildingBlocks.FullComplexHistoryMellin.mellin
    symm
    exact setIntegral_eq_integral_of_forall_compl_eq_zero
      (fun v hv => by rw [image_eq_zero_of_notMem_tsupport hv, zero_mul])
  rw [he]
  exact hc

theorem physical_paired_weight_continuous {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g) : Continuous (pairedWeight f g) := by
  have hmf := physical_mellin_continuous hf hfc
  have hmg := physical_mellin_continuous hg hgc
  unfold pairedWeight
  fun_prop

theorem finite_block_weight_continuous {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g) (ps : List ℕ) (M : ℕ) :
    Continuous (pairedWeight (blockPhysical ps M f) (blockPhysical ps M g)) := by
  obtain ⟨hbf, hbfc⟩ := block_regular hf hfc ps M
  obtain ⟨hbg, hbgc⟩ := block_regular hg hgc ps M
  exact physical_paired_weight_continuous hbf hbg hbfc hbgc

noncomputable def centeredWeight (f g : ℝ → ℂ) (s : ℂ) : ℂ :=
  pairedWeight f g (s - 1 / 2)

theorem centered_weight_continuous {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g) : Continuous (centeredWeight f g) :=
  (physical_paired_weight_continuous hf hg hfc hgc).comp
    (continuous_id.sub continuous_const)

theorem centered_weight_xi_order {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g) (s : ℂ) :
    Filter.Tendsto (fun w => (w - s) * (centeredWeight f g w * logDeriv xi w))
      (nhdsWithin s {s}ᶜ) (nhds ((analyticOrderNatAt xi s : ℂ) * centeredWeight f g s)) := by
  have ht := ((centered_weight_continuous hf hg hfc hgc).continuousAt.tendsto.mono_left
    nhdsWithin_le_nhds).mul (xi_log_derivative_order s)
  have he : (fun w => (w - s) * (centeredWeight f g w * logDeriv xi w)) =
      (fun w => centeredWeight f g w * ((w - s) * logDeriv xi w)) := by
    funext w
    ring
  rw [he]
  simpa only [mul_comm] using ht

theorem finite_block_xi_order {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g) (ps : List ℕ) (M : ℕ) (s : ℂ) :
    Filter.Tendsto (fun w => (w - s) *
      (centeredWeight (blockPhysical ps M f) (blockPhysical ps M g) w * logDeriv xi w))
      (nhdsWithin s {s}ᶜ)
      (nhds ((analyticOrderNatAt xi s : ℂ) *
        centeredWeight (blockPhysical ps M f) (blockPhysical ps M g) s)) := by
  obtain ⟨hbf, hbfc⟩ := block_regular hf hfc ps M
  obtain ⟨hbg, hbgc⟩ := block_regular hg hgc ps M
  exact centered_weight_xi_order hbf hbg hbfc hbgc s

theorem finite_prime_block_xi_coefficient {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g) (primes : Finset ℕ)
    (hp : ∀ p ∈ primes, 2 ≤ p) (M : ℕ) (s : ℂ) :
    Filter.Tendsto (fun w => (w - s) *
      (centeredWeight (blockPhysical primes.toList M f)
        (blockPhysical primes.toList M g) w * logDeriv xi w))
      (nhdsWithin s {s}ᶜ)
      (nhds ((analyticOrderNatAt xi s : ℂ) *
        (∏ p ∈ primes, BuildingBlocks.GrowingPrimeScatteringBounds.paired p (s - 1 / 2) M) *
          centeredWeight f g s)) := by
  have ht := finite_block_xi_order hf hg hfc hgc primes.toList M s
  have he : centeredWeight (blockPhysical primes.toList M f)
      (blockPhysical primes.toList M g) s =
      (∏ p ∈ primes, BuildingBlocks.GrowingPrimeScatteringBounds.paired p (s - 1 / 2) M) *
        centeredWeight f g s :=
    finite_prime_block_paired_weight hf hg hfc hgc primes hp M (s - 1 / 2)
  rw [he] at ht
  simpa only [mul_assoc] using ht

theorem centered_weight_pole_null {f g : ℝ → ℂ}
    (hm : BuildingBlocks.FullComplexHistoryMellin.mellin f (-1 / 2) = 0)
    (hp : BuildingBlocks.FullComplexHistoryMellin.mellin f (1 / 2) = 0) :
    centeredWeight f g 0 = 0 ∧ centeredWeight f g 1 = 0 := by
  constructor
  · unfold centeredWeight pairedWeight
    have he : (0 : ℂ) - 1 / 2 = -1 / 2 := by ring
    rw [he, hm, zero_mul]
  · norm_num [centeredWeight, pairedWeight, hp]

theorem finite_block_pole_null {f g : ℝ → ℂ}
    (hf : Continuous f) (hfc : HasCompactSupport f) (primes : Finset ℕ)
    (hp : ∀ p ∈ primes, 2 ≤ p) (M : ℕ)
    (hm : BuildingBlocks.FullComplexHistoryMellin.mellin f (-1 / 2) = 0)
    (hplus : BuildingBlocks.FullComplexHistoryMellin.mellin f (1 / 2) = 0) :
    centeredWeight (blockPhysical primes.toList M f) (blockPhysical primes.toList M g) 0 = 0 ∧
      centeredWeight (blockPhysical primes.toList M f) (blockPhysical primes.toList M g) 1 = 0 := by
  have hpl : ∀ p ∈ primes.toList, 2 ≤ p := by simpa using hp
  apply centered_weight_pole_null
  · rw [block_mellin hf hfc primes.toList hpl M (-1 / 2), hm, mul_zero]
  · rw [block_mellin hf hfc primes.toList hpl M (1 / 2), hplus, mul_zero]

theorem weighted_simple_pole_coefficient (F : ℂ → ℂ) (s : ℂ) (hF : ContinuousAt F s) :
    Filter.Tendsto (fun w => (w - s) * (F w / (w - s))) (nhdsWithin s {s}ᶜ)
      (nhds (F s)) := by
  have hn : ∀ᶠ w in nhdsWithin s {s}ᶜ, w ≠ s := by
    simpa only [Set.mem_compl_iff, Set.mem_singleton_iff] using
      (self_mem_nhdsWithin : ∀ᶠ w in nhdsWithin s ({s} : Set ℂ)ᶜ,
        w ∈ ({s} : Set ℂ)ᶜ)
  have he : (fun w => (w - s) * (F w / (w - s))) =ᶠ[nhdsWithin s {s}ᶜ] F := by
    filter_upwards [hn] with w hw
    exact mul_div_cancel₀ _ (sub_ne_zero.mpr hw)
  exact (hF.tendsto.mono_left nhdsWithin_le_nhds).congr' he.symm

theorem centered_weight_pole_corrections_vanish {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g)
    (hm : BuildingBlocks.FullComplexHistoryMellin.mellin f (-1 / 2) = 0)
    (hp : BuildingBlocks.FullComplexHistoryMellin.mellin f (1 / 2) = 0) :
    Filter.Tendsto (fun w => w * (centeredWeight f g w / w))
      (nhdsWithin 0 {0}ᶜ) (nhds 0) ∧
    Filter.Tendsto (fun w => (w - 1) * (centeredWeight f g w / (w - 1)))
      (nhdsWithin 1 {1}ᶜ) (nhds 0) := by
  have hcont := centered_weight_continuous hf hg hfc hgc
  obtain ⟨h0, h1⟩ := centered_weight_pole_null (g := g) hm hp
  constructor
  · simpa only [sub_zero, h0] using
      weighted_simple_pole_coefficient (centeredWeight f g) 0 hcont.continuousAt
  · simpa only [h1] using
      weighted_simple_pole_coefficient (centeredWeight f g) 1 hcont.continuousAt

theorem finite_block_pole_corrections_vanish {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g) (primes : Finset ℕ)
    (hp : ∀ p ∈ primes, 2 ≤ p) (M : ℕ)
    (hm : BuildingBlocks.FullComplexHistoryMellin.mellin f (-1 / 2) = 0)
    (hplus : BuildingBlocks.FullComplexHistoryMellin.mellin f (1 / 2) = 0) :
    Filter.Tendsto (fun w => w * (centeredWeight (blockPhysical primes.toList M f)
      (blockPhysical primes.toList M g) w / w)) (nhdsWithin 0 {0}ᶜ) (nhds 0) ∧
    Filter.Tendsto (fun w => (w - 1) * (centeredWeight (blockPhysical primes.toList M f)
      (blockPhysical primes.toList M g) w / (w - 1))) (nhdsWithin 1 {1}ᶜ) (nhds 0) := by
  obtain ⟨hbf, hbfc⟩ := block_regular hf hfc primes.toList M
  obtain ⟨hbg, hbgc⟩ := block_regular hg hgc primes.toList M
  have hc := centered_weight_continuous hbf hbg hbfc hbgc
  obtain ⟨h0, h1⟩ := finite_block_pole_null (g := g) hf hfc primes hp M hm hplus
  constructor
  · simpa only [sub_zero, h0] using weighted_simple_pole_coefficient
      (centeredWeight (blockPhysical primes.toList M f) (blockPhysical primes.toList M g))
      0 hc.continuousAt
  · simpa only [h1] using weighted_simple_pole_coefficient
      (centeredWeight (blockPhysical primes.toList M f) (blockPhysical primes.toList M g))
      1 hc.continuousAt

theorem finite_prime_block_zeta_coefficient {f g : ℝ → ℂ}
    (hf : Continuous f) (hg : Continuous g) (hfc : HasCompactSupport f)
    (hgc : HasCompactSupport g) (primes : Finset ℕ)
    (hp : ∀ p ∈ primes, 2 ≤ p) (M : ℕ) (s : ℂ) (hs : 0 < s.re) (hs1 : s ≠ 1) :
    Filter.Tendsto (fun w => (w - s) *
      (centeredWeight (blockPhysical primes.toList M f)
        (blockPhysical primes.toList M g) w * logDeriv riemannZeta w))
      (nhdsWithin s {s}ᶜ)
      (nhds ((analyticOrderNatAt xi s : ℂ) *
        (∏ p ∈ primes, BuildingBlocks.GrowingPrimeScatteringBounds.paired p (s - 1 / 2) M) *
          centeredWeight f g s)) := by
  obtain ⟨hbf, hbfc⟩ := block_regular hf hfc primes.toList M
  obtain ⟨hbg, hbgc⟩ := block_regular hg hgc primes.toList M
  have hc := centered_weight_continuous hbf hbg hbfc hbgc
  have ht := (hc.continuousAt.tendsto.mono_left nhdsWithin_le_nhds).mul
    (zeta_log_derivative_order s hs hs1)
  have he : (fun w => (w - s) *
      (centeredWeight (blockPhysical primes.toList M f) (blockPhysical primes.toList M g) w *
        logDeriv riemannZeta w)) =
      (fun w => centeredWeight (blockPhysical primes.toList M f) (blockPhysical primes.toList M g) w *
        ((w - s) * logDeriv riemannZeta w)) := by
    funext w
    ring
  rw [he]
  have hv : centeredWeight (blockPhysical primes.toList M f)
      (blockPhysical primes.toList M g) s =
      (∏ p ∈ primes, BuildingBlocks.GrowingPrimeScatteringBounds.paired p (s - 1 / 2) M) *
        centeredWeight f g s :=
    finite_prime_block_paired_weight hf hg hfc hgc primes hp M (s - 1 / 2)
  rw [hv] at ht
  convert ht using 1
  congr 1
  ring


/-- A constructed nonzero smooth carrier pays both local pole coefficients at every finite depth. -/
theorem exists_physical_pole_null_carrier {L : ℝ} (hL : 0 < L) :
    ∃ f : ℝ → ℂ, HasCompactSupport f ∧ ContDiff ℝ ∞ f ∧ f 0 = 1 ∧
      (∀ v, f v ≠ 0 → -(L / 32) < v ∧ v < 9 * L / 32) ∧
      Integrable (fun v => Complex.normSq (f v)) ∧
      (0 < ∫ v : ℝ, Complex.normSq (f v)) ∧
      ∀ (primes : Finset ℕ) (hp : ∀ p ∈ primes, 2 ≤ p) (M : ℕ),
        Filter.Tendsto (fun w => w * (centeredWeight (blockPhysical primes.toList M f)
          (blockPhysical primes.toList M f) w / w)) (nhdsWithin 0 {0}ᶜ) (nhds 0) ∧
        Filter.Tendsto (fun w => (w - 1) * (centeredWeight (blockPhysical primes.toList M f)
          (blockPhysical primes.toList M f) w / (w - 1))) (nhdsWithin 1 {1}ᶜ) (nhds 0) := by
  obtain ⟨f, hfc, hf, h0, hs, hi, hpos, hplus, hminus⟩ :=
    BuildingBlocks.NarrowPoleNullPacket.exists_narrow_complex_pole_null hL
  refine ⟨f, hfc, hf, h0, hs, hi, hpos, ?_⟩
  intro primes hp M
  apply finite_block_pole_corrections_vanish hf.continuous hf.continuous hfc hfc primes hp M
  · simpa [BuildingBlocks.NarrowPoleNullPacket.complexMoment,
      BuildingBlocks.FullComplexHistoryMellin.mellin, neg_div, div_eq_mul_inv] using hminus
  · simpa [BuildingBlocks.NarrowPoleNullPacket.complexMoment,
      BuildingBlocks.FullComplexHistoryMellin.mellin] using hplus

#print axioms exists_physical_pole_null_carrier
#print axioms physical_mellin_continuous
#print axioms physical_paired_weight_continuous
#print axioms finite_block_weight_continuous
#print axioms centered_weight_continuous
#print axioms centered_weight_xi_order
#print axioms finite_block_xi_order
#print axioms finite_prime_block_xi_coefficient
#print axioms centered_weight_pole_null
#print axioms finite_block_pole_null
#print axioms weighted_simple_pole_coefficient
#print axioms centered_weight_pole_corrections_vanish
#print axioms finite_block_pole_corrections_vanish
#print axioms finite_prime_block_zeta_coefficient
end BuildingBlocks.ActualPhysicalResidues
