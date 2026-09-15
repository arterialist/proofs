import Mathlib.Analysis.SpecialFunctions.Log.Basic

import Mathlib.Algebra.Ring.GeomSum
import Mathlib.Analysis.Complex.Trigonometric
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Deriv
import Mathlib.Tactic.Positivity
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.LinearCombination
import Mathlib.Tactic.Ring
import Lean.Elab.Tactic.Omega
namespace BuildingBlocks.PairedScatteringDefect
/-- Literal finite local multiplier. -/
noncomputable def multiplier (r x y : ℂ) (M : ℕ) : ℂ :=
  -r*x + (1-r^2) * ∑ j ∈ Finset.range M, (r*y)^j
lemma multiplier_succ (r x y : ℂ) (h : x*y=1) (M : ℕ) :
    multiplier r x y (M+1) = r*y*multiplier r x y M + (1-r*x) := by
  unfold multiplier
  rw [Finset.sum_range_succ]
  have hg : (r*y) * (∑ j ∈ Finset.range M, (r*y)^j) =
      (∑ j ∈ Finset.range M, (r*y)^j) + (r*y)^M - 1 := by
    have := geom_sum_mul (r*y) M
    linear_combination this
  have hh : r^2*x*y=r^2 := by rw [mul_assoc, h, mul_one]
  linear_combination -(1-r^2)*hg + hh
lemma multiplier_geometric (r x y : ℂ) (h : x*y=1) (M : ℕ) :
    (1-r*y)*multiplier r x y M = 1-r*x-(1-r^2)*(r*y)^M := by
  unfold multiplier
  have := geom_sum_mul (r*y) M
  have hh : r^2*x*y=r^2 := by rw [mul_assoc, h, mul_one]
  linear_combination -(1-r^2)*this + hh
lemma paired_succ (r x y : ℂ) (h : x*y=1) (M : ℕ) :
    multiplier r x y (M+1)*multiplier r y x (M+1) =
      r^2*(multiplier r x y M*multiplier r y x M)+(1-r^2) -
      (1-r^2)*r^(M+1)*(x^(M+1)+y^(M+1)) := by
  have hy : y*x=1 := by simpa [mul_comm] using h
  rw [multiplier_succ r x y h, multiplier_succ r y x hy]
  have hxg := multiplier_geometric r x y h M
  have hyg := multiplier_geometric r y x hy M
  simp only [mul_pow, pow_succ] at *
  have hh : r*r*x*y=r*r := by rw [mul_assoc, h, mul_one]
  linear_combination r*y*hxg + r*x*hyg +
    (multiplier r x y M*multiplier r y x M-1)*hh
/-- Exact identity including endpoint phase exponent M, valid also at depth zero. -/
theorem paired_identity (r x y : ℂ) (h : x*y=1) (M : ℕ) :
    multiplier r x y M * multiplier r y x M =
      1-(1-r^2)*r^(2*M) - (1-r^2)*
        ∑ j ∈ Finset.range M, r^(2*M-(j+1))*(x^(j+1)+y^(j+1)) := by
  induction M with
  | zero => simp [multiplier]; linear_combination r^2*h
  | succ M ih =>
    rw [paired_succ r x y h M, ih, Finset.sum_range_succ]
    have hp : r^(2*(M+1)) = r^2*r^(2*M) := by
      rw [show 2*(M+1)=2+2*M by omega, pow_add]
    have he : r^(2*(M+1)-(M+1)) = r^(M+1) := by congr 1; omega
    have hs : (∑ j ∈ Finset.range M,
        r^(2*(M+1)-(j+1))*(x^(j+1)+y^(j+1))) =
        r^2 * ∑ j ∈ Finset.range M,
        r^(2*M-(j+1))*(x^(j+1)+y^(j+1)) := by
      rw [Finset.mul_sum]
      apply Finset.sum_congr rfl
      intro j hj
      have hj' := Finset.mem_range.mp hj
      rw [show 2*(M+1)-(j+1)=2+(2*M-(j+1)) by omega, pow_add]
      ring
    rw [hp, he, hs]
    ring
/-- Entire exponential specialization; no rational denominator is used. -/
theorem paired_exp (r z : ℂ) (M : ℕ) :
    multiplier r (Complex.exp z) (Complex.exp (-z)) M *
      multiplier r (Complex.exp (-z)) (Complex.exp z) M =
      1-(1-r^2)*r^(2*M) - (1-r^2)*
        ∑ j ∈ Finset.range M, r^(2*M-(j+1))*
          ((Complex.exp z)^(j+1)+(Complex.exp (-z))^(j+1)) := by
  apply paired_identity
  rw [← Complex.exp_add]
  simp

/-- Half-strip moment after substituting q=r² and exp(L/2)=1/r.
The reverse geometric powers encode the positive symmetric defect atoms. -/
def halfStripMoment (q : ℝ) (M : ℕ) : ℝ :=
  (1-q)*q^M + (1-q)*∑ j ∈ Finset.range M, (q^M+q^j)

theorem halfStripMoment_nonneg (q : ℝ) (hq0 : 0 ≤ q) (hq1 : q ≤ 1) (M : ℕ) :
    0 ≤ halfStripMoment q M := by
  unfold halfStripMoment
  have hc : 0 ≤ 1-q := sub_nonneg.mpr hq1
  positivity

theorem halfStripMoment_eq (q : ℝ) (M : ℕ) :
    halfStripMoment q M = 1+(((M+1 : ℕ) : ℝ)*(1-q)-1)*q^M := by
  unfold halfStripMoment
  rw [Finset.sum_add_distrib]
  simp only [Finset.sum_const, Finset.card_range, nsmul_eq_mul, Nat.cast_add,
    Nat.cast_one]
  have hg := geom_sum_mul_neg q M
  linear_combination hg

theorem halfStripMoment_le_two (q : ℝ) (hq0 : 0 ≤ q) (hq1 : q ≤ 1) (M : ℕ) :
    halfStripMoment q M ≤ 2 := by
  have hc : 0 ≤ 1-q := sub_nonneg.mpr hq1
  have hs : (((M+1 : ℕ) : ℝ)*q^M) ≤ ∑ j ∈ Finset.range (M+1), q^j := by
    calc
      _ = ∑ j ∈ Finset.range (M+1), q^M := by simp
      _ ≤ _ := by
        apply Finset.sum_le_sum
        intro j hj
        exact pow_le_pow_of_le_one hq0 hq1 (by have := Finset.mem_range.mp hj; omega)
  have hb := mul_le_mul_of_nonneg_left hs hc
  have hg := geom_sum_mul_neg q (M+1)
  have hpos : 0 ≤ q^(M+1) := pow_nonneg hq0 _
  have hposM : 0 ≤ q^M := pow_nonneg hq0 _
  rw [halfStripMoment_eq]
  nlinarith

/-- Actual exponential half-strip moment, with endpoint M included. -/
noncomputable def exponentialMoment (r L : ℝ) (M : ℕ) : ℝ :=
  (1-r^2)*r^(2*M)+(1-r^2)*∑ j ∈ Finset.range M,
    r^(2*M-(j+1))*(Real.exp ((j+1)* (L/2))+Real.exp (-((j+1)*(L/2))))

theorem exponentialMoment_eq (r L : ℝ) (hr : r ≠ 0)
    (hL : Real.exp (L/2)=r⁻¹) (M : ℕ) :
    exponentialMoment r L M = halfStripMoment (r^2) M := by
  have ht (j : ℕ) (hj : j < M) :
      r^(2*M-(j+1))*(Real.exp ((j+1)*(L/2))+Real.exp (-((j+1)*(L/2)))) =
        (r^2)^M+(r^2)^(M-1-j) := by
    rw [Real.exp_neg, ← Nat.cast_add_one, Real.exp_nat_mul, hL, inv_pow, inv_inv]
    have ha : 2*M-(j+1)=2*(M-1-j)+(j+1) := by omega
    have hb : 2*(M-1-j)+2*(j+1)=2*M := by omega
    have hn : r^(j+1) ≠ 0 := pow_ne_zero _ hr
    rw [ha, pow_add]
    calc
      _ = r^(2*(M-1-j))+r^(2*(M-1-j)+2*(j+1)) := by
        rw [pow_add, pow_mul]
        field_simp
        ring
      _ = (r^2)^M+(r^2)^(M-1-j) := by rw [hb]; simp [pow_mul]; ring
  unfold exponentialMoment halfStripMoment
  have hs : (∑ j ∈ Finset.range M,
    r^(2*M-(j+1))*(Real.exp ((j+1)*(L/2))+Real.exp (-((j+1)*(L/2))))) =
      ∑ j ∈ Finset.range M, ((r^2)^M+(r^2)^j) := by
    calc
      _ = ∑ j ∈ Finset.range M, ((r^2)^M+(r^2)^(M-1-j)) := by
        apply Finset.sum_congr rfl
        intro j hj
        exact ht j (Finset.mem_range.mp hj)
      _ = _ := by
        rw [Finset.sum_add_distrib, Finset.sum_add_distrib, Finset.sum_range_reflect]
  rw [hs, pow_mul]

theorem exponentialMoment_le_two (r L : ℝ) (hr : 0 < r) (hr1 : r ≤ 1)
    (hL : Real.exp (L/2)=r⁻¹) (M : ℕ) : exponentialMoment r L M ≤ 2 := by
  rw [exponentialMoment_eq r L (ne_of_gt hr) hL]
  apply halfStripMoment_le_two
  · positivity
  · nlinarith

lemma symmetric_exp_bound (w : ℂ) (L : ℝ) (hL0 : 0 ≤ L)
    (hw : |w.re| ≤ L/2) (n : ℕ) :
    ‖(Complex.exp w)^n+(Complex.exp (-w))^n‖ ≤
      Real.exp ((n : ℝ)*(L/2))+Real.exp (-((n : ℝ)*(L/2))) := by
  have hn : 0 ≤ (n : ℝ) := Nat.cast_nonneg n
  have ha : |(n : ℝ)*w.re| ≤ |(n : ℝ)*(L/2)| := by
    rw [abs_mul, abs_mul, abs_of_nonneg hn, abs_of_nonneg (by positivity : 0 ≤ L/2)]
    exact mul_le_mul_of_nonneg_left hw hn
  have hc := Real.cosh_le_cosh.mpr ha
  rw [Real.cosh_eq, Real.cosh_eq] at hc
  calc
    _ ≤ ‖(Complex.exp w)^n‖+‖(Complex.exp (-w))^n‖ := norm_add_le _ _
    _ = Real.exp ((n : ℝ)*w.re)+Real.exp (-((n : ℝ)*w.re)) := by
      simp [norm_pow, Complex.norm_exp, ← Real.exp_nat_mul, mul_neg]
    _ ≤ _ := by linarith

/-- Uniform entire paired bound for every finite depth throughout the half strip. -/
theorem norm_paired_exp_le_three (r L : ℝ) (w : ℂ) (hr : 0 < r)
    (hr1 : r ≤ 1) (hL0 : 0 ≤ L) (hL : Real.exp (L/2)=r⁻¹)
    (hw : |w.re| ≤ L/2) (M : ℕ) :
    ‖multiplier (r : ℂ) (Complex.exp w) (Complex.exp (-w)) M *
      multiplier (r : ℂ) (Complex.exp (-w)) (Complex.exp w) M‖ ≤ 3 := by
  rw [paired_exp]
  have hc : 0 ≤ 1-r^2 := by nlinarith
  have hterm (j : ℕ) :
      ‖(r : ℂ)^(2*M-(j+1))*((Complex.exp w)^(j+1)+(Complex.exp (-w))^(j+1))‖ ≤
      r^(2*M-(j+1))*(Real.exp ((j+1)*(L/2))+Real.exp (-((j+1)*(L/2)))) := by
    rw [norm_mul, norm_pow, Complex.norm_real, Real.norm_eq_abs, abs_of_pos hr]
    exact mul_le_mul_of_nonneg_left (by simpa using symmetric_exp_bound w L hL0 hw (j+1)) (pow_nonneg (le_of_lt hr) _)
  have hs := Finset.sum_le_sum (fun j (_ : j ∈ Finset.range M) => hterm j)
  have hsn := norm_sum_le (Finset.range M)
    (fun j => (r : ℂ)^(2*M-(j+1))*((Complex.exp w)^(j+1)+(Complex.exp (-w))^(j+1)))
  have hb := exponentialMoment_le_two r L hr hr1 hL M
  unfold exponentialMoment at hb
  have hn : ‖(1-(r : ℂ)^2)‖ = 1-r^2 := by
    norm_cast
    rw [Real.norm_eq_abs, abs_of_nonneg hc]
  calc
    _ ≤ ‖(1 : ℂ)-(1-(r : ℂ)^2)*(r : ℂ)^(2*M)‖ +
      ‖(1-(r : ℂ)^2)*∑ j ∈ Finset.range M,
        (r : ℂ)^(2*M-(j+1))*((Complex.exp w)^(j+1)+(Complex.exp (-w))^(j+1))‖ := norm_sub_le _ _
    _ ≤ 1+(1-r^2)*r^(2*M)+(1-r^2)*∑ j ∈ Finset.range M,
        r^(2*M-(j+1))*(Real.exp ((j+1)*(L/2))+Real.exp (-((j+1)*(L/2)))) := by
      rw [norm_mul, hn]
      have hfirst := norm_sub_le (1 : ℂ) ((1-(r : ℂ)^2)*(r : ℂ)^(2*M))
      simp only [norm_one, norm_mul, hn, norm_pow, Complex.norm_real, Real.norm_eq_abs, abs_of_pos hr] at hfirst
      have hsum := mul_le_mul_of_nonneg_left (le_trans hsn hs) hc
      linarith
    _ ≤ 3 := by linarith

theorem norm_paired_scaled_exp_le_three (r L : ℝ) (z : ℂ) (hr : 0 < r)
    (hr1 : r ≤ 1) (hL0 : 0 ≤ L) (hL : Real.exp (L/2)=r⁻¹)
    (hz : |z.re| ≤ 1/2) (M : ℕ) :
    ‖multiplier (r : ℂ) (Complex.exp (z*L)) (Complex.exp (-(z*L))) M *
      multiplier (r : ℂ) (Complex.exp (-(z*L))) (Complex.exp (z*L)) M‖ ≤ 3 := by
  apply norm_paired_exp_le_three r L (z*L) hr hr1 hL0 hL
  simp only [Complex.mul_re, Complex.ofReal_re, Complex.ofReal_im, mul_zero, sub_zero,
    abs_mul, abs_of_nonneg hL0]
  have hh := mul_le_mul_of_nonneg_right hz hL0
  linarith

/-- Actual parameters for every integer p≥2; primality is unnecessary. -/
theorem actual_parameters (p : ℕ) (hp : 2 ≤ p) :
    0 < 1/Real.sqrt (p : ℝ) ∧ 1/Real.sqrt (p : ℝ) ≤ 1 ∧
      0 ≤ Real.log (p : ℝ) ∧
      Real.exp (Real.log (p : ℝ)/2) = (1/Real.sqrt (p : ℝ))⁻¹ := by
  have hp1 : (1 : ℝ) ≤ p := by exact_mod_cast (show 1 ≤ p by omega)
  have hp0 : (0 : ℝ) < p := by linarith
  have hs : 0 < Real.sqrt (p : ℝ) := Real.sqrt_pos.mpr hp0
  have hs1 : 1 ≤ Real.sqrt (p : ℝ) := Real.one_le_sqrt.mpr hp1
  refine ⟨one_div_pos.mpr hs, ?_, Real.log_nonneg hp1, ?_⟩
  · exact (div_le_one hs).mpr hs1
  · rw [Real.exp_half, Real.exp_log hp0]
    simp

/-- Actual p-dependent entire paired bound, uniform in history depth. -/
theorem norm_paired_actual_prime_le_three (p : ℕ) (hp : 2 ≤ p) (z : ℂ)
    (hz : |z.re| ≤ 1/2) (M : ℕ) :
    ‖multiplier ((1/Real.sqrt (p : ℝ) : ℝ) : ℂ)
        (Complex.exp (z*Real.log (p : ℝ))) (Complex.exp (-(z*Real.log (p : ℝ)))) M *
      multiplier ((1/Real.sqrt (p : ℝ) : ℝ) : ℂ)
        (Complex.exp (-(z*Real.log (p : ℝ)))) (Complex.exp (z*Real.log (p : ℝ))) M‖ ≤ 3 := by
  obtain ⟨hr, hr1, hL0, hL⟩ := actual_parameters p hp
  exact norm_paired_scaled_exp_le_three _ _ z hr hr1 hL0 hL hz M

#print axioms actual_parameters
#print axioms norm_paired_actual_prime_le_three
#print axioms norm_paired_scaled_exp_le_three
#print axioms norm_paired_exp_le_three
#print axioms exponentialMoment_eq
#print axioms exponentialMoment_le_two
#print axioms paired_identity
#print axioms paired_exp
#print axioms halfStripMoment_nonneg
#print axioms halfStripMoment_eq
#print axioms halfStripMoment_le_two
end BuildingBlocks.PairedScatteringDefect
