import Mathlib.Analysis.MellinTransform
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.FunProp
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

open MeasureTheory Set Filter Asymptotics
open scoped Topology

namespace BuildingBlocks.EtaBaselineMellin

noncomputable def step (x : ℝ) : ℂ := (Ioi (1 : ℝ)).indicator (fun _ => 1) x

lemma hasMellin_step {s : ℂ} (hs : s.re < 0) : HasMellin step s (-s⁻¹) := by
  have hp : (s-1).re < -1 := by simp; linarith
  have hi := integrableOn_Ioi_cpow_of_lt hp (by norm_num : (0 : ℝ)<1)
  have he : (fun x : ℝ => (x : ℂ)^(s-1) • step x) =
      (Ioi (1 : ℝ)).indicator (fun x : ℝ => (x : ℂ)^(s-1)) := by
    funext x
    by_cases hx : 1 < x <;> simp [step, hx]
  constructor
  · unfold MellinConvergent
    rw [he]
    exact ((integrable_indicator_iff measurableSet_Ioi).mpr hi).integrableOn
  · unfold mellin
    rw [he, setIntegral_indicator measurableSet_Ioi,
      inter_eq_right.mpr (Ioi_subset_Ioi (by norm_num : (0 : ℝ)≤1)),
      integral_Ioi_cpow_of_lt hp (by norm_num : (0 : ℝ)<1)]
    simp [div_eq_mul_inv]

lemma step_locallyIntegrable : LocallyIntegrableOn step (Ioi 0) :=
  ((locallyIntegrable_const (1 : ℂ)).indicator measurableSet_Ioi).locallyIntegrableOn _

lemma step_bigO_top : step =O[atTop] (fun t : ℝ => t^(-(0 : ℝ))) := by
  refine Asymptotics.isBigO_iff.mpr ⟨1, ?_⟩
  filter_upwards [eventually_gt_atTop (1 : ℝ)] with t ht
  simp [step, ht]

lemma step_bigO_zero (b : ℝ) : step =O[𝓝[>] (0 : ℝ)] (fun t : ℝ => t^(-b)) := by
  refine Asymptotics.isBigO_iff.mpr ⟨1, ?_⟩
  have he : ∀ᶠ t : ℝ in 𝓝[>] (0 : ℝ), t < 1 :=
    (eventually_lt_nhds (by norm_num : (0 : ℝ)<1)).filter_mono nhdsWithin_le_nhds
  filter_upwards [he] with t ht
  simp [step, not_lt.mpr ht.le]

/-- The logarithmic Mellin moment, justified by mathlib's locally dominated
parameter-differentiation theorem rather than a formal derivative of a value. -/
lemma hasMellin_log_step {s : ℂ} (hs : s.re < 0) :
    HasMellin (fun t => Real.log t • step t) s (1/s^2) := by
  have h := mellin_hasDerivAt_of_isBigO_rpow step_locallyIntegrable
    step_bigO_top hs (step_bigO_zero (s.re-1)) (by linarith : s.re-1 < s.re)
  have hs0 : s ≠ 0 := by intro he; simp [he] at hs
  have hd : HasDerivAt (fun z : ℂ => -z⁻¹) (1/s^2) s := by
    have hh := ((hasDerivAt_id s).inv hs0).neg
    change HasDerivAt (fun z : ℂ => -z⁻¹) (-(-1/s^2)) s at hh
    convert hh using 1
    ring
  have he : mellin step =ᶠ[𝓝 s] (fun z : ℂ => -z⁻¹) := by
    have hn : ∀ᶠ z : ℂ in 𝓝 s, z.re < 0 :=
      (isOpen_lt Complex.continuous_re continuous_const).mem_nhds hs
    filter_upwards [hn] with z hz
    exact (hasMellin_step hz).2
  exact ⟨h.1, h.2.unique (hd.congr_of_eventuallyEq he)⟩

/-- The full atom-plus-Lebesgue baseline, including the constant endpoint term. -/
noncomputable def B (x : ℝ) : ℂ :=
  if 1 < x then (x : ℂ)^2 / 2 * (Real.log x : ℂ) + (x : ℂ)^2 / 4 - 1/4
  else 0

lemma B_eq (x : ℝ) :
    B x = (1/2 : ℂ) • ((x : ℂ)^(2 : ℂ) • (Real.log x • step x)) +
      (1/4 : ℂ) • ((x : ℂ)^(2 : ℂ) • step x) - (1/4 : ℂ) • step x := by
  by_cases hx : 1 < x
  · simp [B, step, hx, Complex.cpow_ofNat, smul_eq_mul, Complex.real_smul]
    ring
  · simp [B, step, hx]

lemma hasMellin_cpow_step {s a : ℂ} (hs : (s+a).re < 0) :
    HasMellin (fun x : ℝ => (x : ℂ)^a • step x) s (-(s+a)⁻¹) :=
  ⟨MellinConvergent.cpow_smul.mpr (hasMellin_step hs).1,
    by rw [mellin_cpow_smul]; exact (hasMellin_step hs).2⟩

lemma hasMellin_cpow_log_step {s a : ℂ} (hs : (s+a).re < 0) :
    HasMellin (fun x : ℝ => (x : ℂ)^a • (Real.log x • step x)) s
      (1/(s+a)^2) :=
  ⟨MellinConvergent.cpow_smul.mpr (hasMellin_log_step hs).1,
    by rw [mellin_cpow_smul]; exact (hasMellin_log_step hs).2⟩

/-- Exact Mellin transform of the full baseline, on its absolute-convergence
half-plane. The logarithmic term is integrated using dominated parameter
differentiation; both polynomial endpoint contributions are retained. -/
theorem hasMellin_B {s : ℂ} (hs : 1 < s.re) :
    HasMellin B (-s-1) (s / ((s-1)^2 * (s+1))) := by
  have hshift : (-s-1+(2 : ℂ)).re < 0 := by simp; linarith
  have hneg : (-s-1).re < 0 := by simp; linarith
  have hl := hasMellin_cpow_log_step hshift
  have hp := hasMellin_cpow_step hshift
  have hc := hasMellin_step hneg
  have hl' := hasMellin_const_smul hl.1 (1/2 : ℂ)
  have hp' := hasMellin_const_smul hp.1 (1/4 : ℂ)
  have hc' := hasMellin_const_smul hc.1 (1/4 : ℂ)
  have ha := hasMellin_add hl'.1 hp'.1
  have ht := hasMellin_sub ha.1 hc'.1
  have hb : B = fun x : ℝ =>
      (1/2 : ℂ) • ((x : ℂ)^(2 : ℂ) • (Real.log x • step x)) +
      (1/4 : ℂ) • ((x : ℂ)^(2 : ℂ) • step x) - (1/4 : ℂ) • step x :=
    funext B_eq
  rw [hb]
  refine ⟨ht.1, ?_⟩
  rw [ht.2, ha.2, hl'.2, hp'.2, hc'.2, hl.2, hp.2, hc.2]
  have h1 : s-1 ≠ 0 := by intro h; have := congrArg Complex.re h; simp at this; linarith
  have h2 : s+1 ≠ 0 := by intro h; have := congrArg Complex.re h; simp at this; linarith
  have h3 : -s-1+2 ≠ 0 := by intro h; have := congrArg Complex.re h; simp at this; linarith
  have h4 : -s-1 ≠ 0 := by intro h; have := congrArg Complex.re h; simp at this; linarith
  simp only [smul_eq_mul]
  field_simp
  ring

end BuildingBlocks.EtaBaselineMellin
