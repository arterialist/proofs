import Mathlib.Tactic
import Mathlib.Analysis.Calculus.Deriv.MeanValue
import Mathlib.Analysis.SpecialFunctions.Complex.LogBounds

namespace BuildingBlocks.KappaCoefficientPositivity

noncomputable section
open Real Filter
open scoped BigOperators Topology

/-- Continuous interpolation of the telescoping primitive. -/
def tau (x : ℝ) := x * (Real.log (x+1) - Real.log x)

/-- The coefficient, with the convention `0 * log 0 = 0` supplied by real multiplication. -/
def kappa (m:ℕ) : ℝ := (m:ℝ)*log m - (2*(m:ℝ)+1)*log (m+1) + ((m:ℝ)+1)*log (m+2)

lemma hasDerivAt_tau_raw {x:ℝ} (hx:0<x) : HasDerivAt tau
    ((log (x+1)-log x) + x * (1/(x+1) - 1/x)) x := by
  unfold tau
  have h1 := (hasDerivAt_id x).const_add 1
  have hl1 := h1.log (by simpa only [id_eq] using (ne_of_gt (by linarith : 0 < 1+x)))
  have hl := Real.hasDerivAt_log hx.ne'
  have hprod := (hasDerivAt_id x).mul (hl1.sub hl)
  convert hprod using 1
  · funext y
    simp only [tau, id_eq, Pi.sub_apply, Pi.mul_apply]
    rw [add_comm 1 y]
  · simp only [id_eq, Pi.sub_apply, Pi.mul_apply, one_mul, one_div]
    rw [add_comm 1 x]

lemma hasDerivAt_tau {x:ℝ} (hx:0<x) : HasDerivAt tau (log (x+1)-log x - 1/(x+1)) x := by
  convert hasDerivAt_tau_raw hx using 1
  field_simp
  ring

lemma tau_derivative_pos {x:ℝ} (hx:0<x) : 0 < log (x+1)-log x - 1/(x+1) := by
  have hrpos : 0 < x / (x+1) := div_pos hx (by linarith)
  have hrne : x / (x+1) ≠ 1 := by
    apply ne_of_lt
    exact (div_lt_one (by linarith)).2 (by linarith)
  have hlog := Real.log_lt_sub_one_of_pos hrpos hrne
  rw [Real.log_div hx.ne' (by linarith : x+1 ≠ 0)] at hlog
  have : log (x+1) - log x > 1/(x+1) := by
    have hid : x/(x+1)-1 = -1/(x+1) := by field_simp; ring
    rw [hid] at hlog
    calc
      1 / (x + 1) = -(-1 / (x + 1)) := by ring
      _ < -(log x - log (x + 1)) := neg_lt_neg hlog
      _ = log (x + 1) - log x := by ring
  linarith

lemma continuousOn_tau : ContinuousOn tau (Set.Ioi 0) := by
  intro x hx
  have hx' : 0 < x := hx
  apply ContinuousAt.continuousWithinAt
  unfold tau
  exact continuousAt_id.mul
    (((continuousAt_id.add continuousAt_const).log (by
      simpa only [id_eq, add_comm] using (ne_of_gt (by linarith : 0 < x + 1)))).sub
      (continuousAt_log hx'.ne'))

theorem strictMonoOn_tau : StrictMonoOn tau (Set.Ioi 0) := by
  apply strictMonoOn_of_deriv_pos (convex_Ioi 0) continuousOn_tau
  intro x hx
  rw [interior_Ioi] at hx
  rw [(hasDerivAt_tau hx).deriv]
  exact tau_derivative_pos hx

theorem kappa_eq_tau_succ_sub (m:ℕ) : kappa m = tau (m+1) - tau m := by
  unfold kappa tau
  push_cast
  ring

theorem kappa_pos (m:ℕ) : 0 < kappa m := by
  rw [kappa_eq_tau_succ_sub]
  by_cases hm:m=0
  · subst m
    norm_num [tau, kappa, Real.log_pos]
  · have hmpos : (0:ℝ)<m := by exact_mod_cast Nat.pos_of_ne_zero hm
    have hlt : (m:ℝ) < m+1 := by norm_num
    exact sub_pos.mpr (strictMonoOn_tau hmpos (show (0 : ℝ) < m + 1 by positivity) hlt)


/-- The endpoint convention gives the advertised first coefficient. -/
lemma kappa_zero : kappa 0 = Real.log 2 := by
  norm_num [kappa]

/-- Natural-number version of the telescoping primitive. -/
def tauNat (n : ℕ) : ℝ := tau n

lemma kappa_eq_tauNat_succ_sub (m : ℕ) :
    kappa m = tauNat (m + 1) - tauNat m := by
  simpa [tauNat, Nat.cast_add, Nat.cast_one] using kappa_eq_tau_succ_sub m

/-- Exact finite telescoping. -/
theorem sum_kappa_range (N : ℕ) :
    (∑ m ∈ Finset.range N, kappa m) = tauNat N := by
  simp_rw [kappa_eq_tauNat_succ_sub]
  rw [Finset.sum_range_sub]
  simp [tauNat, tau]

/-- Closed form for the partial sum through index `N`. -/
theorem sum_kappa_through (N : ℕ) :
    (∑ m ∈ Finset.range (N + 1), kappa m) =
      ((N : ℝ) + 1) * Real.log (((N : ℝ) + 2) / ((N : ℝ) + 1)) := by
  rw [sum_kappa_range]
  unfold tauNat tau
  push_cast
  rw [Real.log_div (by positivity : (N : ℝ) + 2 ≠ 0)
    (by positivity : (N : ℝ) + 1 ≠ 0)]
  ring

lemma tau_eq_mul_log_one_add_inv {x : ℝ} (hx : 0 < x) :
    tau x = x * Real.log (1 + 1 / x) := by
  unfold tau
  rw [← Real.log_div (by linarith : x + 1 ≠ 0) hx.ne']
  congr 2
  field_simp

lemma tendsto_tauNat : Tendsto tauNat atTop (𝓝 1) := by
  have h := (Real.tendsto_mul_log_one_add_div_atTop (1 : ℝ)).comp
    tendsto_natCast_atTop_atTop
  apply h.congr'
  filter_upwards [eventually_gt_atTop (0 : ℕ)] with n hn
  symm
  simpa [tauNat] using tau_eq_mul_log_one_add_inv (x := (n : ℝ)) (by exact_mod_cast hn)

/-- The positive coefficients have total mass exactly one. -/
theorem hasSum_kappa_one : HasSum kappa 1 := by
  rw [hasSum_iff_tendsto_nat_of_nonneg (fun m => (kappa_pos m).le)]
  simpa only [sum_kappa_range] using tendsto_tauNat

end
end BuildingBlocks.KappaCoefficientPositivity

#print axioms BuildingBlocks.KappaCoefficientPositivity.kappa_pos
#print axioms BuildingBlocks.KappaCoefficientPositivity.sum_kappa_range
#print axioms BuildingBlocks.KappaCoefficientPositivity.sum_kappa_through
#print axioms BuildingBlocks.KappaCoefficientPositivity.hasSum_kappa_one
