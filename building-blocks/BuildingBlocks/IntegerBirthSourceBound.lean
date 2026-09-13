import BuildingBlocks.IntegerBirthKernel
import Mathlib.NumberTheory.LSeries.Dirichlet
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Bounds
import Mathlib.Analysis.SpecificLimits.Normed
import Mathlib.Analysis.Normed.Ring.InfiniteSum

open MeasureTheory Set
open scoped BigOperators

namespace BuildingBlocks.IntegerBirthSourceBound

open IntegerBirthKernel

noncomputable def boundConstant : ℝ := Real.pi+1

private theorem q_prebirth_lower {n u : ℝ} (hn : 0 < n) (hu : 0 ≤ u) (hun : u ≤ n) :
    1/Real.sqrt n ≤ q n u := by
  rcases hu.eq_or_lt with rfl | hu
  · simp
  · have hc0 : 0 ≤ Real.sqrt (u/n) := Real.sqrt_nonneg _
    have hc1 : Real.sqrt (u/n) ≤ 1 := Real.sqrt_le_one.mpr ((div_le_one hn).mpr hun)
    have ha0 : 0 ≤ Real.arcsin (Real.sqrt (u/n)) := Real.arcsin_nonneg.mpr hc0
    have ha := Real.sin_le ha0
    rw [Real.sin_arcsin (by linarith) hc1] at ha
    have hdiv := div_le_div_of_nonneg_right ha (Real.sqrt_nonneg u)
    have he : Real.sqrt (u/n)/Real.sqrt u = 1/Real.sqrt n := by
      rw [Real.sqrt_div hu.le]
      field_simp
    rw [he] at hdiv
    simpa [q, ne_of_gt hu, hun] using hdiv

/-- A global linear source bound, uniform in the actual birth n. -/
theorem U_abs_bound {n : ℕ} (hn : 2 ≤ n) {u : ℝ} (hu : 0 ≤ u) :
    |U n u| ≤ boundConstant*u/((n : ℝ)*Real.sqrt n) := by
  have hn0 : (0 : ℝ) < n := by exact_mod_cast (show 0 < n by omega)
  have hs0 : 0 < Real.sqrt (n : ℝ) := Real.sqrt_pos.mpr hn0
  have hC : 0 ≤ boundConstant := by unfold boundConstant; positivity
  by_cases hun : u ≤ n
  · have hU : 0 ≤ U n u := sub_nonneg.mpr (q_prebirth_lower hn0 hu hun)
    rw [abs_of_nonneg hU]
    have ha : 0 ≤ 1-u/(n : ℝ) := sub_nonneg.mpr ((div_le_one hn0).mpr hun)
    have hb : 0 ≤ u/(n : ℝ) := div_nonneg hu hn0.le
    have hab : (1-u/(n : ℝ))+u/(n : ℝ)=1 := by ring
    have hc := (q_convexOn_prebirth hn0).2 (left_mem_Icc.mpr hn0.le)
      (right_mem_Icc.mpr hn0.le) ha hb hab
    simp only [smul_eq_mul, mul_zero, zero_add, div_mul_cancel₀ _ hn0.ne', q_zero] at hc
    rw [q_at_birth hn0] at hc
    have he : (1-u/(n : ℝ))*(1/Real.sqrt n)+(u/(n : ℝ))*(Real.pi/(2*Real.sqrt n))-
        1/Real.sqrt n = (Real.pi/2-1)*u/((n : ℝ)*Real.sqrt n) := by ring
    have hle : U n u ≤ (Real.pi/2-1)*u/((n : ℝ)*Real.sqrt n) := by
      unfold U
      rw [← he]
      linarith
    apply hle.trans
    apply div_le_div_of_nonneg_right _ (mul_nonneg hn0.le hs0.le)
    apply mul_le_mul_of_nonneg_right _ hu
    unfold boundConstant
    linarith [Real.pi_pos]
  · have hnu : (n : ℝ) ≤ u := (lt_of_not_ge hun).le
    rw [U, q_eq_postbirth hn0 hnu]
    have hsq := Real.sqrt_le_sqrt hnu
    have hsU : 0 < Real.sqrt u := hs0.trans_le hsq
    have hinv := one_div_le_one_div_of_le hs0 hsq
    have hfirst : Real.pi/(2*Real.sqrt u) ≤ Real.pi/(2*Real.sqrt n) := by
      have hh := mul_le_mul_of_nonneg_left hinv (show 0 ≤ Real.pi/2 by positivity)
      convert hh using 1 <;> ring
    have habs : |Real.pi/(2*Real.sqrt u)-1/Real.sqrt n| ≤ boundConstant/Real.sqrt n := by
      apply (abs_sub _ _).trans
      rw [abs_of_nonneg (by positivity : 0 ≤ Real.pi/(2*Real.sqrt u)),
        abs_of_nonneg (by positivity : 0 ≤ 1/Real.sqrt n)]
      unfold boundConstant
      have he : (Real.pi+1)/Real.sqrt n = Real.pi/Real.sqrt n+1/Real.sqrt n := by ring
      rw [he]
      have hmore : Real.pi/(2*Real.sqrt n) ≤ Real.pi/Real.sqrt n := by
        have hp := div_nonneg Real.pi_pos.le hs0.le
        have he2 : Real.pi/(2*Real.sqrt n) = (Real.pi/Real.sqrt n)/2 := by ring
        rw [he2]
        linarith
      linarith
    apply habs.trans
    apply (le_div_iff₀ (mul_pos hn0 hs0)).mpr
    have he : boundConstant/Real.sqrt n*((n : ℝ)*Real.sqrt n)=boundConstant*n := by field_simp
    rw [he]
    exact mul_le_mul_of_nonneg_left hnu hC

/-- Linear interpolation preserves the same exact first-moment bound. -/
theorem interpolant_abs_bound {n : ℕ} (hn : 2 ≤ n) {u : ℝ} (hu : 0 ≤ u) :
    |interpolant n u| ≤ boundConstant*u/((n : ℝ)*Real.sqrt n) := by
  let j := ⌊u⌋₊
  have hj0 : (0 : ℝ) ≤ j := Nat.cast_nonneg j
  have hju : (j : ℝ) ≤ u := Nat.floor_le hu
  have huj : u ≤ (j : ℝ)+1 := (Nat.lt_floor_add_one u).le
  have ha : 0 ≤ (j : ℝ)+1-u := by linarith
  have hb : 0 ≤ u-(j : ℝ) := by linarith
  have h1 := U_abs_bound hn hj0
  have h2 := U_abs_bound hn (show 0 ≤ (j : ℝ)+1 by positivity)
  change |((j : ℝ)+1-u)*U n j+(u-(j : ℝ))*U n ((j : ℝ)+1)| ≤ _
  calc
    _ ≤ |((j : ℝ)+1-u)*U n j|+|(u-(j : ℝ))*U n ((j : ℝ)+1)| := abs_add_le _ _
    _ = ((j : ℝ)+1-u)*|U n j|+(u-(j : ℝ))*|U n ((j : ℝ)+1)| := by
      rw [abs_mul, abs_mul, abs_of_nonneg ha, abs_of_nonneg hb]
    _ ≤ ((j : ℝ)+1-u)*(boundConstant*j/((n : ℝ)*Real.sqrt n))+
        (u-(j : ℝ))*(boundConstant*((j : ℝ)+1)/((n : ℝ)*Real.sqrt n)) :=
      add_le_add (mul_le_mul_of_nonneg_left h1 ha) (mul_le_mul_of_nonneg_left h2 hb)
    _ = _ := by ring

/-- Existing actual Mangoldt absolute convergence at 3/2, in the required square-root normalization. -/
theorem summable_mangoldt_bound :
    Summable (fun n : ℕ => ArithmeticFunction.vonMangoldt n / ((n : ℝ)*Real.sqrt n)) := by
  have hh := (ArithmeticFunction.LSeriesSummable_vonMangoldt (s := (3/2 : ℂ)) (by norm_num)).norm
  apply hh.congr
  intro n
  rw [LSeries.norm_term_eq]
  by_cases hn : n = 0
  · simp [hn]
  · rw [if_neg hn]
    have hn0 : (0 : ℝ) < n := by exact_mod_cast (Nat.pos_of_ne_zero hn)
    have hp : (n : ℝ)^(3/2 : ℝ) = (n : ℝ)*Real.sqrt n := by
      rw [show (3/2 : ℝ)=1+1/2 by norm_num, Real.rpow_add hn0, Real.rpow_one,
        ← Real.sqrt_eq_rpow]
    simp only [Complex.div_re, Complex.normSq_ofNat,
      mul_zero, add_zero, Complex.norm_real, Real.norm_eq_abs,
      abs_of_nonneg ArithmeticFunction.vonMangoldt_nonneg]
    norm_num at hp ⊢
    rw [hp]

noncomputable def birthWeight (n : ℕ) : ℝ :=
  ArithmeticFunction.vonMangoldt (n+2)/(((n+2 : ℕ) : ℝ)*Real.sqrt ((n+2 : ℕ) : ℝ))

noncomputable def sourceTerm (n : ℕ) (u : ℝ) : ℝ :=
  ArithmeticFunction.vonMangoldt (n+2)*U (n+2) u

noncomputable def interpolatedTerm (n : ℕ) (u : ℝ) : ℝ :=
  ArithmeticFunction.vonMangoldt (n+2)*interpolant (n+2) u

theorem summable_birthWeight : Summable birthWeight :=
  (summable_nat_add_iff 2).mpr summable_mangoldt_bound

theorem birthWeight_nonnegative (n : ℕ) : 0 ≤ birthWeight n := by
  exact div_nonneg ArithmeticFunction.vonMangoldt_nonneg (by positivity)

theorem sourceTerm_bound (n : ℕ) {u : ℝ} (hu : 0 ≤ u) :
    ‖sourceTerm n u‖ ≤ (boundConstant*u)*birthWeight n := by
  unfold sourceTerm birthWeight
  rw [Real.norm_eq_abs, abs_mul, abs_of_nonneg ArithmeticFunction.vonMangoldt_nonneg]
  have hh := mul_le_mul_of_nonneg_left (U_abs_bound (by omega : 2 ≤ n+2) hu)
    (ArithmeticFunction.vonMangoldt_nonneg (n := n+2))
  convert hh using 1 <;> ring

theorem interpolatedTerm_bound (n : ℕ) {u : ℝ} (hu : 0 ≤ u) :
    ‖interpolatedTerm n u‖ ≤ (boundConstant*u)*birthWeight n := by
  unfold interpolatedTerm birthWeight
  rw [Real.norm_eq_abs, abs_mul, abs_of_nonneg ArithmeticFunction.vonMangoldt_nonneg]
  have hh := mul_le_mul_of_nonneg_left (interpolant_abs_bound (by omega : 2 ≤ n+2) hu)
    (ArithmeticFunction.vonMangoldt_nonneg (n := n+2))
  convert hh using 1 <;> ring

theorem sourceTerm_summable {u : ℝ} (hu : 0 ≤ u) : Summable (fun n => sourceTerm n u) :=
  (summable_birthWeight.mul_left (boundConstant*u)).of_norm_bounded (fun n => sourceTerm_bound n hu)

theorem interpolatedTerm_summable {u : ℝ} (hu : 0 ≤ u) : Summable (fun n => interpolatedTerm n u) :=
  (summable_birthWeight.mul_left (boundConstant*u)).of_norm_bounded (fun n => interpolatedTerm_bound n hu)

/-- Complete actual Mangoldt-weighted interpolation order; both sums are absolutely convergent. -/
theorem actual_source_interpolation_le {u : ℝ} (hu : 0 ≤ u) :
    (∑' n : ℕ, sourceTerm n u) ≤ ∑' n : ℕ, interpolatedTerm n u := by
  apply (sourceTerm_summable hu).tsum_le_tsum _ (interpolatedTerm_summable hu)
  intro n
  exact mul_le_mul_of_nonneg_left (sub_nonneg.mp (interpolation_nonnegative (by omega : 2 ≤ n+2) hu))
    ArithmeticFunction.vonMangoldt_nonneg

theorem defectTerm_summable {u : ℝ} (hu : 0 ≤ u) :
    Summable (fun n => interpolatedTerm n u-sourceTerm n u) :=
  (interpolatedTerm_summable hu).sub (sourceTerm_summable hu)

theorem actual_source_defect_identity {u : ℝ} (hu : 0 ≤ u) :
    (∑' n : ℕ, interpolatedTerm n u)-(∑' n : ℕ, sourceTerm n u) =
      ∑' n : ℕ, ArithmeticFunction.vonMangoldt (n+2)*(interpolant (n+2) u-U (n+2) u) := by
  rw [← (interpolatedTerm_summable hu).tsum_sub (sourceTerm_summable hu)]
  apply tsum_congr
  intro n
  unfold interpolatedTerm sourceTerm
  ring

/-- Full birth/clock product is absolutely summable at each fixed geometric parameter. -/
theorem geometric_source_absolute {r : ℝ} (hr0 : 0 ≤ r) (hr1 : r < 1) :
    Summable (fun z : ℕ × ℕ => ‖r^z.2*sourceTerm z.1 z.2‖) := by
  have hr : ‖r‖ < 1 := by simpa [Real.norm_eq_abs, abs_of_nonneg hr0] using hr1
  have hj : Summable (fun j : ℕ => boundConstant*(j : ℝ)*r^j) := by
    simpa only [pow_one, mul_assoc] using
      (summable_pow_mul_geometric_of_norm_lt_one (R := ℝ) 1 hr).mul_left boundConstant
  have hp := summable_birthWeight.mul_of_nonneg hj birthWeight_nonnegative
    (fun j => mul_nonneg (mul_nonneg (by unfold boundConstant; positivity) (Nat.cast_nonneg j)) (pow_nonneg hr0 j))
  apply hp.of_nonneg_of_le (fun _ => norm_nonneg _)
  intro z
  rw [norm_mul, Real.norm_eq_abs, abs_of_nonneg (pow_nonneg hr0 _)]
  have hh := mul_le_mul_of_nonneg_left (sourceTerm_bound z.1 (Nat.cast_nonneg z.2)) (pow_nonneg hr0 z.2)
  convert hh using 1 <;> ring

theorem geometric_interpolated_absolute {r : ℝ} (hr0 : 0 ≤ r) (hr1 : r < 1) :
    Summable (fun z : ℕ × ℕ => ‖r^z.2*interpolatedTerm z.1 z.2‖) := by
  have hr : ‖r‖ < 1 := by simpa [Real.norm_eq_abs, abs_of_nonneg hr0] using hr1
  have hj : Summable (fun j : ℕ => boundConstant*(j : ℝ)*r^j) := by
    simpa only [pow_one, mul_assoc] using
      (summable_pow_mul_geometric_of_norm_lt_one (R := ℝ) 1 hr).mul_left boundConstant
  have hp := summable_birthWeight.mul_of_nonneg hj birthWeight_nonnegative
    (fun j => mul_nonneg (mul_nonneg (by unfold boundConstant; positivity) (Nat.cast_nonneg j)) (pow_nonneg hr0 j))
  apply hp.of_nonneg_of_le (fun _ => norm_nonneg _)
  intro z
  rw [norm_mul, Real.norm_eq_abs, abs_of_nonneg (pow_nonneg hr0 _)]
  have hh := mul_le_mul_of_nonneg_left (interpolatedTerm_bound z.1 (Nat.cast_nonneg z.2)) (pow_nonneg hr0 z.2)
  convert hh using 1 <;> ring

/-- At each actual t>0 both complete birth/clock sums converge absolutely. -/
theorem exponential_clock_absolute {t : ℝ} (ht : 0 < t) :
    Summable (fun z : ℕ × ℕ => ‖Real.exp (-t*(z.2 : ℝ))*sourceTerm z.1 z.2‖) ∧
    Summable (fun z : ℕ × ℕ => ‖Real.exp (-t*(z.2 : ℝ))*interpolatedTerm z.1 z.2‖) := by
  have hr0 : 0 ≤ Real.exp (-t) := (Real.exp_pos _).le
  have hr1 : Real.exp (-t) < 1 := Real.exp_lt_one_iff.mpr (neg_neg_of_pos ht)
  have he (j : ℕ) : Real.exp (-t*(j : ℝ)) = Real.exp (-t)^j := by
    rw [mul_comm, Real.exp_nat_mul]
  simp_rw [he]
  exact ⟨geometric_source_absolute hr0 hr1, geometric_interpolated_absolute hr0 hr1⟩

#print axioms exponential_clock_absolute
#print axioms actual_source_interpolation_le
#print axioms actual_source_defect_identity
#print axioms geometric_source_absolute
#print axioms U_abs_bound
#print axioms interpolant_abs_bound
#print axioms summable_mangoldt_bound

end BuildingBlocks.IntegerBirthSourceBound
