import Mathlib.Analysis.MellinTransform
import Mathlib.Tactic.FieldSimp
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

open MeasureTheory Set
open scoped BigOperators

namespace BuildingBlocks.RieszTentMellin

/-- The first Riesz tent, with its exact zero-weight birth endpoint. -/
noncomputable def tent (a x : ℝ) : ℂ := (max (x - a) 0 : ℝ)

theorem tent_power_eq {x : ℝ} (hx : 0 < x) (a : ℝ) (s : ℂ) :
    ((x - a : ℝ) : ℂ) * (x : ℂ) ^ (-s - 2) =
      (x : ℂ) ^ (-s - 1) - (a : ℂ) * (x : ℂ) ^ (-s - 2) := by
  have hpow : (x : ℂ) ^ (-s - 1) = (x : ℂ) * (x : ℂ) ^ (-s - 2) := by
    rw [show -s - 1 = 1 + (-s - 2) by ring,
      Complex.cpow_add _ _ (Complex.ofReal_ne_zero.mpr hx.ne'), Complex.cpow_one]
  rw [hpow, Complex.ofReal_sub]
  ring

theorem integrableOn_tent_power {a : ℝ} (ha : 0 < a) {s : ℂ} (hs : 0 < s.re) :
    IntegrableOn (fun x : ℝ => ((x - a : ℝ) : ℂ) * (x : ℂ) ^ (-s - 2)) (Ioi a) := by
  have h1 := integrableOn_Ioi_cpow_of_lt
    (show (-s - 1).re < -1 by simp; linarith) ha
  have h2 := integrableOn_Ioi_cpow_of_lt
    (show (-s - 2).re < -1 by simp; linarith) ha
  have hsum : IntegrableOn (fun x : ℝ => (x : ℂ) ^ (-s - 1) -
      (a : ℂ) * (x : ℂ) ^ (-s - 2)) (Ioi a) := h1.sub (h2.const_mul (a : ℂ))
  exact hsum.congr_fun (fun x hx => (tent_power_eq (ha.trans hx) a s).symm)
    measurableSet_Ioi

/-- The denominator retains both Riesz factors, including the initial endpoint. -/
theorem integral_tent_power {a : ℝ} (ha : 0 < a) {s : ℂ} (hs : 0 < s.re) :
    (∫ x : ℝ in Ioi a, ((x - a : ℝ) : ℂ) * (x : ℂ) ^ (-s - 2)) =
      (a : ℂ) ^ (-s) / (s * (s + 1)) := by
  have h1 : (-s - 1).re < -1 := by simp; linarith
  have h2 : (-s - 2).re < -1 := by simp; linarith
  have hs0 : s ≠ 0 := by intro he; simp [he] at hs
  have hs1 : s + 1 ≠ 0 := by
    intro he
    have := congrArg Complex.re he
    simp at this
    linarith
  have ha0 : (a : ℂ) ≠ 0 := Complex.ofReal_ne_zero.mpr ha.ne'
  have heq : (∫ x : ℝ in Ioi a, ((x - a : ℝ) : ℂ) * (x : ℂ) ^ (-s - 2)) =
      (∫ x : ℝ in Ioi a, (x : ℂ) ^ (-s - 1)) -
        (a : ℂ) * (∫ x : ℝ in Ioi a, (x : ℂ) ^ (-s - 2)) := by
    rw [← integral_const_mul, ← integral_sub
      (integrableOn_Ioi_cpow_of_lt h1 ha)
      ((integrableOn_Ioi_cpow_of_lt h2 ha).const_mul (a : ℂ))]
    exact setIntegral_congr_fun measurableSet_Ioi (fun x hx => tent_power_eq (ha.trans hx) a s)
  rw [heq, integral_Ioi_cpow_of_lt h1 ha, integral_Ioi_cpow_of_lt h2 ha]
  have hpow : (a : ℂ) * (a : ℂ) ^ (-s - 1) = (a : ℂ) ^ (-s) := by
    nth_rw 1 [← Complex.cpow_one (a : ℂ)]
    rw [← Complex.cpow_add _ _ ha0]
    congr 1
    ring
  rw [show -s - 1 + 1 = -s by ring, show -s - 2 + 1 = -s - 1 by ring]
  have hsecond : -(a : ℂ) ^ (-s - 1) / (-s - 1) =
      (a : ℂ) ^ (-s - 1) / (s + 1) := by
    rw [show -s - 1 = -(s + 1) by ring, neg_div_neg_eq]
  rw [neg_div_neg_eq, hsecond, ← mul_div_assoc, hpow]
  field_simp
  ring

theorem mellin_integrand_tent (a : ℝ) (s : ℂ) :
    (fun x : ℝ => (x : ℂ) ^ ((-s - 1) - 1) • tent a x) =
      (Ioi a).indicator (fun x : ℝ => ((x - a : ℝ) : ℂ) * (x : ℂ) ^ (-s - 2)) := by
  funext x
  rw [show (-s - 1) - 1 = -s - 2 by ring]
  by_cases hx : a < x
  · simp [tent, hx, max_eq_left (sub_nonneg.mpr hx.le), mul_comm]
  · simp [tent, hx, max_eq_right (sub_nonpos.mpr (le_of_not_gt hx))]

theorem hasMellin_tent {a : ℝ} (ha : 0 < a) {s : ℂ} (hs : 0 < s.re) :
    HasMellin (tent a) (-s - 1) ((a : ℂ) ^ (-s) / (s * (s + 1))) := by
  have hi := integrableOn_tent_power ha hs
  have hsubset : Ioi a ⊆ Ioi (0 : ℝ) := Ioi_subset_Ioi ha.le
  constructor
  · unfold MellinConvergent
    rw [mellin_integrand_tent a s]
    have hglobal : Integrable ((Ioi a).indicator
        (fun x : ℝ => ((x - a : ℝ) : ℂ) * (x : ℂ) ^ (-s - 2))) :=
      (integrable_indicator_iff measurableSet_Ioi).2 hi
    exact hglobal.integrableOn
  · unfold mellin
    rw [mellin_integrand_tent a s, setIntegral_indicator measurableSet_Ioi,
      inter_eq_right.mpr hsubset]
    exact integral_tent_power ha hs

theorem hasMellin_weighted_tent {a : ℝ} (ha : 0 < a) {s : ℂ} (hs : 0 < s.re)
    (c : ℂ) :
    HasMellin (fun x => c * tent a x) (-s - 1)
      (c * (a : ℂ) ^ (-s) / (s * (s + 1))) := by
  have h := hasMellin_tent ha hs
  constructor
  · exact h.1.const_smul c
  · rw [show (fun x => c * tent a x) = (fun x => c • tent a x) by rfl,
      mellin_const_smul, h.2]
    simp only [smul_eq_mul, mul_div_assoc]

/-- Every atom and every coefficient survives finite superposition. -/
theorem hasMellin_finite_tents {ι : Type*} (t : Finset ι) (a : ι → ℝ) (c : ι → ℂ)
    (ha : ∀ i ∈ t, 0 < a i) {s : ℂ} (hs : 0 < s.re) :
    HasMellin (fun x => ∑ i ∈ t, c i * tent (a i) x) (-s - 1)
      ((∑ i ∈ t, c i * (a i : ℂ) ^ (-s)) / (s * (s + 1))) := by
  classical
  revert ha
  induction t using Finset.induction_on with
  | empty =>
      intro _
      simp [HasMellin, MellinConvergent, mellin]
  | @insert i t hi ih =>
      intro ha
      have hai := hasMellin_weighted_tent (ha i (Finset.mem_insert_self i t)) hs (c i)
      have hat := ih (fun j hj => ha j (Finset.mem_insert_of_mem hj))
      have hsum := hasMellin_add hai.1 hat.1
      simp_rw [Finset.sum_insert hi]
      constructor
      · exact hsum.1
      · rw [hsum.2, hai.2, hat.2, add_div]

theorem norm_tent_integrand {x : ℝ} (hx : 0 < x) (a : ℝ) (s : ℂ) :
    ‖(x : ℂ) ^ (-s - 2) * tent a x‖ =
      ((x : ℂ) ^ (-(s.re : ℂ) - 2) * tent a x).re := by
  have he : -(s.re : ℂ) - 2 = ((-s.re - 2 : ℝ) : ℂ) := by push_cast; rfl
  rw [he, ← Complex.ofReal_cpow hx.le]
  simp [Complex.norm_cpow_eq_rpow_re_of_pos hx, tent,
    abs_of_nonneg (le_max_right (x - a) 0)]

/-- Absolute convergence is quantified by the real-axis Riesz kernel. -/
theorem integral_norm_tent {a : ℝ} (ha : 0 < a) {s : ℂ} (hs : 0 < s.re) :
    (∫ x : ℝ in Ioi 0, ‖(x : ℂ) ^ (-s - 2) * tent a x‖) =
      a ^ (-s.re) / (s.re * (s.re + 1)) := by
  have hr := hasMellin_tent ha (show 0 < (s.re : ℂ).re from hs)
  have hi : IntegrableOn (fun x : ℝ =>
      (x : ℂ) ^ (-(s.re : ℂ) - 2) * tent a x) (Ioi 0) := by
    simpa only [MellinConvergent, smul_eq_mul,
      show (-(s.re : ℂ) - 1) - 1 = -(s.re : ℂ) - 2 by ring] using hr.1
  have heq : (∫ x : ℝ in Ioi 0, ‖(x : ℂ) ^ (-s - 2) * tent a x‖) =
      (∫ x : ℝ in Ioi 0, (x : ℂ) ^ (-(s.re : ℂ) - 2) * tent a x).re := by
    have hre : (∫ x : ℝ in Ioi 0,
        ((x : ℂ) ^ (-(s.re : ℂ) - 2) * tent a x).re) =
        (∫ x : ℝ in Ioi 0, (x : ℂ) ^ (-(s.re : ℂ) - 2) * tent a x).re :=
      integral_re hi
    exact (setIntegral_congr_fun measurableSet_Ioi
      (fun x hx => norm_tent_integrand hx a s)).trans hre
  have hval : (∫ x : ℝ in Ioi 0,
      (x : ℂ) ^ (-(s.re : ℂ) - 2) * tent a x) =
      (a : ℂ) ^ (-(s.re : ℂ)) / ((s.re : ℂ) * ((s.re : ℂ) + 1)) := by
    convert hr.2 using 1
    unfold mellin
    congr 1
    funext x
    simp only [smul_eq_mul]
    congr 2
    ring
  rw [heq, hval]
  have hp : (a : ℂ) ^ (-(s.re : ℂ)) = ((a ^ (-s.re) : ℝ) : ℂ) := by
    rw [← Complex.ofReal_neg, ← Complex.ofReal_cpow ha.le]
  rw [hp]
  norm_cast

end BuildingBlocks.RieszTentMellin
