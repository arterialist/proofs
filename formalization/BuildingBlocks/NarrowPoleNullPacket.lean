import Mathlib.Analysis.Calculus.BumpFunction.FiniteDimension
import Mathlib.Tactic.Linarith
import Mathlib.MeasureTheory.Group.Integral
import Mathlib.MeasureTheory.Measure.Lebesgue.Basic
import Mathlib.Tactic.Ring
import Mathlib.MeasureTheory.Integral.Bochner.ContinuousLinearMap

open Function
open scoped ContDiff

namespace BuildingBlocks.NarrowPoleNullPacket

theorem exists_narrow_bump {delta : ℝ} (hd : 0 < delta) :
    ∃ kappa : ℝ → ℝ, HasCompactSupport kappa ∧ ContDiff ℝ ∞ kappa ∧
      (∀ v, 0 ≤ kappa v ∧ kappa v ≤ 1) ∧ kappa 0 = 1 ∧
      (∀ v, kappa v ≠ 0 → -delta < v ∧ v < delta) := by
  have hn : Set.Ioo (-delta) delta ∈ nhds (0 : ℝ) :=
    IsOpen.mem_nhds isOpen_Ioo ⟨by linarith, hd⟩
  obtain ⟨kappa, hs, hc, hdif, hvals, hzero⟩ := exists_smooth_tsupport_subset hn
  refine ⟨kappa, hc, hdif, ?_, hzero, ?_⟩
  · intro v
    exact hvals ⟨v, rfl⟩
  · intro v hv
    exact hs (subset_tsupport kappa hv)

def carrier (kappa : ℝ → ℝ) (epsilon C v : ℝ) : ℝ :=
  kappa v - C * kappa (v - epsilon) + kappa (v - 2 * epsilon)

theorem carrier_geometry {kappa : ℝ → ℝ} {delta epsilon : ℝ}
    (hd : 0 < delta) (he : delta < epsilon) (hzero : kappa 0 = 1)
    (hs : ∀ v, kappa v ≠ 0 → -delta < v ∧ v < delta) (C : ℝ) :
    carrier kappa epsilon C 0 = 1 ∧
      (∀ v, carrier kappa epsilon C v ≠ 0 →
        -delta < v ∧ v < 2 * epsilon + delta) := by
  have h1 : kappa (-epsilon) = 0 := by
    by_contra h
    have hi := hs _ h
    linarith
  have h2 : kappa (-(2 * epsilon)) = 0 := by
    by_contra h
    have hi := hs _ h
    linarith
  refine ⟨by simp [carrier, hzero, h1, h2], ?_⟩
  intro v hv
  by_cases hv0 : kappa v ≠ 0
  · have hi := hs _ hv0
    constructor <;> linarith
  by_cases hv1 : kappa (v - epsilon) ≠ 0
  · have hi := hs _ hv1
    constructor <;> linarith
  by_cases hv2 : kappa (v - 2 * epsilon) ≠ 0
  · have hi := hs _ hv2
    constructor <;> linarith
  simp [carrier, not_ne_iff.mp hv0, not_ne_iff.mp hv1, not_ne_iff.mp hv2] at hv

theorem carrier_contDiff {kappa : ℝ → ℝ} (hk : ContDiff ℝ ∞ kappa)
    (epsilon C : ℝ) : ContDiff ℝ ∞ (carrier kappa epsilon C) := by
  exact (hk.sub (contDiff_const.mul (hk.comp (contDiff_id.sub contDiff_const)))).add
    (hk.comp (contDiff_id.sub contDiff_const))

theorem carrier_hasCompactSupport {kappa : ℝ → ℝ} {delta epsilon : ℝ}
    (hd : 0 < delta) (he : delta < epsilon) (hzero : kappa 0 = 1)
    (hs : ∀ v, kappa v ≠ 0 → -delta < v ∧ v < delta) (C : ℝ) :
    HasCompactSupport (carrier kappa epsilon C) := by
  have hgeom := (carrier_geometry hd he hzero hs C).2
  have hsub : support (carrier kappa epsilon C) ⊆ Set.Icc (-delta) (2 * epsilon + delta) := by
    intro v hv
    have h := hgeom v hv
    exact ⟨h.1.le, h.2.le⟩
  exact isCompact_Icc.of_isClosed_subset isClosed_closure
    (closure_minimal hsub isClosed_Icc)

noncomputable def moment (kappa : ℝ → ℝ) (s : ℝ) : ℝ :=
  ∫ v : ℝ, kappa v * Real.exp (s * v)

theorem weighted_integrable {kappa : ℝ → ℝ} (hk : Continuous kappa)
    (hc : HasCompactSupport kappa) (s : ℝ) :
    MeasureTheory.Integrable (fun v => kappa v * Real.exp (s * v)) := by
  exact (hk.mul (Real.continuous_exp.comp (continuous_const.mul continuous_id))).integrable_of_hasCompactSupport
    hc.mul_right

theorem shifted_compact {kappa : ℝ → ℝ} (hc : HasCompactSupport kappa) (d : ℝ) :
    HasCompactSupport (fun v => kappa (v - d)) := by
  simpa [Function.comp_def, sub_eq_add_neg] using hc.comp_homeomorph (Homeomorph.addRight (-d))

theorem moment_translate (kappa : ℝ → ℝ) (s d : ℝ) :
    moment (fun v => kappa (v - d)) s = moment kappa s * Real.exp (s * d) := by
  unfold moment
  calc
    _ = ∫ v : ℝ, (kappa (v - d) * Real.exp (s * (v - d))) * Real.exp (s * d) := by
      apply MeasureTheory.integral_congr_ae
      apply Filter.Eventually.of_forall
      intro v
      change kappa (v - d) * Real.exp (s * v) =
        (kappa (v - d) * Real.exp (s * (v - d))) * Real.exp (s * d)
      rw [mul_assoc, ← Real.exp_add]
      congr 2
      ring
    _ = (∫ v : ℝ, kappa (v - d) * Real.exp (s * (v - d))) * Real.exp (s * d) :=
      MeasureTheory.integral_mul_const _ _
    _ = _ := by
      congr 1
      exact MeasureTheory.integral_sub_right_eq_self (fun v => kappa v * Real.exp (s * v)) d

theorem carrier_moment {kappa : ℝ → ℝ} (hk : Continuous kappa)
    (hc : HasCompactSupport kappa) (epsilon C s : ℝ) :
    moment (carrier kappa epsilon C) s = moment kappa s *
      (1 - C * Real.exp (s * epsilon) + Real.exp (s * (2 * epsilon))) := by
  have h0 := weighted_integrable hk hc s
  have h1 : MeasureTheory.Integrable (fun v => kappa (v - epsilon) * Real.exp (s * v)) :=
    weighted_integrable (hk.comp (continuous_id.sub continuous_const))
    (shifted_compact hc epsilon) s
  have h2 : MeasureTheory.Integrable (fun v => kappa (v - 2 * epsilon) * Real.exp (s * v)) :=
    weighted_integrable (hk.comp (continuous_id.sub continuous_const))
    (shifted_compact hc (2 * epsilon)) s
  unfold moment carrier
  simp_rw [add_mul, sub_mul, mul_assoc]
  have ha := MeasureTheory.integral_add (h0.sub (h1.const_mul C)) h2
  have hb := MeasureTheory.integral_sub h0 (h1.const_mul C)
  simp only [Pi.sub_apply] at ha
  rw [ha, hb, MeasureTheory.integral_const_mul]
  change moment kappa s - C * moment (fun v => kappa (v - epsilon)) s +
    moment (fun v => kappa (v - 2 * epsilon)) s = moment kappa s *
      (1 - C * Real.exp (s * epsilon) + Real.exp (s * (2 * epsilon)))
  rw [moment_translate, moment_translate]
  ring

theorem pole_polynomial (epsilon s : ℝ) (hs : s = 1 / 2 ∨ s = -(1 / 2)) :
    1 - (Real.exp (epsilon / 2) + Real.exp (-epsilon / 2)) * Real.exp (s * epsilon) +
      Real.exp (s * (2 * epsilon)) = 0 := by
  have hprod : Real.exp (epsilon / 2) * Real.exp (-epsilon / 2) = 1 := by
    rw [← Real.exp_add]
    have he : epsilon / 2 + -epsilon / 2 = 0 := by ring
    rw [he, Real.exp_zero]
  rcases hs with rfl | rfl
  · have harg : (1 / 2 : ℝ) * epsilon = epsilon / 2 := by ring
    have harg2 : (1 / 2 : ℝ) * (2 * epsilon) = epsilon / 2 + epsilon / 2 := by ring
    rw [harg, harg2, Real.exp_add]
    nlinarith
  · have harg : -(1 / 2 : ℝ) * epsilon = -epsilon / 2 := by ring
    have harg2 : -(1 / 2 : ℝ) * (2 * epsilon) = -epsilon / 2 + -epsilon / 2 := by ring
    rw [harg, harg2, Real.exp_add]
    nlinarith

theorem carrier_pole_moments {kappa : ℝ → ℝ} (hk : Continuous kappa)
    (hc : HasCompactSupport kappa) (epsilon : ℝ) :
    moment (carrier kappa epsilon (Real.exp (epsilon / 2) + Real.exp (-epsilon / 2))) (1 / 2) = 0 ∧
    moment (carrier kappa epsilon (Real.exp (epsilon / 2) + Real.exp (-epsilon / 2))) (-(1 / 2)) = 0 := by
  constructor
  · rw [carrier_moment hk hc, pole_polynomial epsilon (1 / 2) (Or.inl rfl), mul_zero]
  · rw [carrier_moment hk hc, pole_polynomial epsilon (-(1 / 2)) (Or.inr rfl), mul_zero]

theorem exists_narrow_pole_null {L : ℝ} (hL : 0 < L) :
    ∃ eta : ℝ → ℝ, HasCompactSupport eta ∧ ContDiff ℝ ∞ eta ∧ eta 0 = 1 ∧
      (∀ v, eta v ≠ 0 → -(L / 32) < v ∧ v < 9 * L / 32) ∧
      moment eta (1 / 2) = 0 ∧ moment eta (-(1 / 2)) = 0 := by
  have hd : 0 < L / 32 := by linarith
  have he : L / 32 < L / 8 := by linarith
  obtain ⟨kappa, hc, hk, hvals, hzero, hs⟩ := exists_narrow_bump hd
  let C := Real.exp ((L / 8) / 2) + Real.exp (-(L / 8) / 2)
  have hg := carrier_geometry hd he hzero hs C
  refine ⟨carrier kappa (L / 8) C,
    carrier_hasCompactSupport hd he hzero hs C, carrier_contDiff hk _ _, hg.1, ?_, ?_⟩
  · intro v hv
    have hi := hg.2 v hv
    constructor <;> linarith
  · exact carrier_pole_moments hk.continuous hc (L / 8)

noncomputable def complexMoment (eta : ℝ → ℂ) (s : ℝ) : ℂ :=
  ∫ v : ℝ, eta v * Complex.exp ((s : ℂ) * (v : ℂ))

theorem complex_lift_moment (eta : ℝ → ℝ) (s : ℝ) :
    complexMoment (fun v => (eta v : ℂ)) s = (moment eta s : ℂ) := by
  unfold complexMoment moment
  simp only [← Complex.ofReal_mul, ← Complex.ofReal_exp]
  exact integral_complex_ofReal

theorem complex_lift_compact {eta : ℝ → ℝ} (hc : HasCompactSupport eta) :
    HasCompactSupport (fun v => (eta v : ℂ)) := by
  have he : support (fun v => (eta v : ℂ)) = support eta := by
    apply Set.ext
    intro v
    simp
  simpa only [HasCompactSupport, tsupport, he] using hc

theorem complex_lift_square {eta : ℝ → ℝ} (hk : Continuous eta)
    (hc : HasCompactSupport eta) (h0 : eta 0 = 1) :
    MeasureTheory.Integrable (fun v => Complex.normSq (eta v : ℂ)) ∧
      0 < ∫ v : ℝ, Complex.normSq (eta v : ℂ) := by
  have hcont : Continuous (fun v => eta v * eta v) := hk.mul hk
  have hi : MeasureTheory.Integrable (fun v => eta v * eta v) :=
    hcont.integrable_of_hasCompactSupport hc.mul_right
  have hp : 0 < ∫ v : ℝ, eta v * eta v :=
    MeasureTheory.integral_pos_of_integrable_nonneg_nonzero hcont hi
      (fun v => mul_self_nonneg _) (show eta 0 * eta 0 ≠ 0 by rw [h0]; norm_num)
  simpa only [Complex.normSq_ofReal] using And.intro hi hp

theorem exists_narrow_complex_pole_null {L : ℝ} (hL : 0 < L) :
    ∃ eta : ℝ → ℂ, HasCompactSupport eta ∧ ContDiff ℝ ∞ eta ∧ eta 0 = 1 ∧
      (∀ v, eta v ≠ 0 → -(L / 32) < v ∧ v < 9 * L / 32) ∧
      MeasureTheory.Integrable (fun v => Complex.normSq (eta v)) ∧
      (0 < ∫ v : ℝ, Complex.normSq (eta v)) ∧
      complexMoment eta (1 / 2) = 0 ∧ complexMoment eta (-(1 / 2)) = 0 := by
  obtain ⟨f, hc, hk, h0, hs, hm1, hm2⟩ := exists_narrow_pole_null hL
  have hsq := complex_lift_square hk.continuous hc h0
  refine ⟨fun v => (f v : ℂ), complex_lift_compact hc,
    Complex.ofRealCLM.contDiff.comp hk, by simp [h0], ?_, hsq.1, hsq.2, ?_, ?_⟩
  · intro v hv
    apply hs v
    intro hf
    exact hv (by simp [hf])
  · rw [complex_lift_moment, hm1]
    simp
  · rw [complex_lift_moment, hm2]
    simp

#print axioms complex_lift_moment
#print axioms complex_lift_compact
#print axioms complex_lift_square
#print axioms exists_narrow_complex_pole_null
#print axioms exists_narrow_pole_null
#print axioms carrier_hasCompactSupport
#print axioms weighted_integrable
#print axioms shifted_compact
#print axioms moment_translate
#print axioms carrier_moment
#print axioms pole_polynomial
#print axioms carrier_pole_moments
#print axioms exists_narrow_bump
#print axioms carrier_geometry
#print axioms carrier_contDiff

end BuildingBlocks.NarrowPoleNullPacket
