import Mathlib.Analysis.Complex.ExponentialBounds
import Mathlib.Analysis.Real.Pi.Bounds
import Mathlib.Data.Real.Sqrt

/-! Scalar inputs to the written gamma-plus-binary partial-form counterexample.
No digamma identity or analytic counterexample is assumed as an axiom. -/
namespace BuildingBlocks.DigammaBinaryScalarBounds
noncomputable def laplaceKernel (t : ℝ) : ℝ := 1/t-1/(1-Real.exp (-t))

lemma laplaceKernel_nonpositive {t : ℝ} (ht : 0 < t) : laplaceKernel t ≤ 0 := by
  have hd : 0 < 1-Real.exp (-t) := by
    have he := Real.exp_lt_one_iff.2 (show -t<0 by linarith)
    linarith
  have he := Real.add_one_le_exp (-t)
  have hdt : 1-Real.exp (-t) ≤ t := by linarith
  dsimp [laplaceKernel]
  have hi := one_div_le_one_div_of_le hd hdt
  linarith

lemma laplaceKernel_ge_neg_one {t : ℝ} (ht : 0 < t) : -1 ≤ laplaceKernel t := by
  have hd : 0 < 1-Real.exp (-t) := by
    have he := Real.exp_lt_one_iff.2 (show -t<0 by linarith)
    linarith
  have he : (1+t)*Real.exp (-t) ≤ 1 := by
    calc
      _ ≤ Real.exp t * Real.exp (-t) :=
        mul_le_mul_of_nonneg_right (by linarith [Real.add_one_le_exp t]) (Real.exp_pos _).le
      _ = 1 := by rw [← Real.exp_add]; simp
  have hdt : t ≤ (1+t)*(1-Real.exp (-t)) := by nlinarith
  have hp : 1 ≤ (1/t+1)*(1-Real.exp (-t)) := by
    calc
      _ = t/t := (div_self ht.ne').symm
      _ ≤ ((1+t)*(1-Real.exp (-t)))/t := div_le_div_of_nonneg_right hdt ht.le
      _ = _ := by field_simp
  have hi : 1/(1-Real.exp (-t)) ≤ 1/t+1 := (div_le_iff₀ hd).2 hp
  dsimp [laplaceKernel]
  linarith

lemma log_three_lt_six_fifths : Real.log 3 < (6/5 : ℝ) := by
  have hs := Real.log_le_sub_one_of_pos (show (0 : ℝ)<3/2 by norm_num)
  have he : Real.log (3 : ℝ)=Real.log 2+Real.log (3/2) := by
    rw [← Real.log_mul (by norm_num) (by norm_num)]
    norm_num
  rw [he]
  linarith [Real.log_two_lt_d9]

lemma gamma_upper_scalar {D : ℝ} (hD : 0 ≤ D) (hD300 : D < 300) :
    (1/2 : ℝ)*Real.log (25/16+D/4)+4/5-Real.log Real.pi < 2 := by
  have hx : 0 < (25/16 : ℝ)+D/4 := by positivity
  have hx81 : (25/16 : ℝ)+D/4 < 81 := by linarith
  have hlog := Real.log_lt_log hx hx81
  have he : Real.log (81 : ℝ)=4*Real.log 3 := by
    have hh := Real.log_pow (3 : ℝ) 4
    norm_num at hh
    exact hh
  have hp := Real.log_lt_log (show (0 : ℝ)<3 by norm_num) Real.pi_gt_three
  rw [he] at hlog
  nlinarith [log_three_lt_six_fifths]

lemma binary_coupling_gt_three : 3 < 2*Real.log 2/(Real.sqrt 2-1) := by
  have hs : 0 ≤ Real.sqrt (2 : ℝ) := Real.sqrt_nonneg _
  have he := Real.sq_sqrt (show (0 : ℝ) ≤ 2 by norm_num)
  have hl : 0 < Real.sqrt (2 : ℝ)-1 := by nlinarith
  have hu : Real.sqrt (2 : ℝ) < 10/7 := by nlinarith
  rw [lt_div_iff₀ hl]
  linarith [Real.log_two_gt_d9]

#print axioms laplaceKernel_nonpositive
#print axioms laplaceKernel_ge_neg_one
#print axioms log_three_lt_six_fifths
#print axioms gamma_upper_scalar
#print axioms binary_coupling_gt_three
end BuildingBlocks.DigammaBinaryScalarBounds
