import BuildingBlocks.GoldbachCofactorParityFinite
import Mathlib.Tactic

/-!
# The convergent Goldbach cofactor ratio series

The finite Abel endpoint disappears inside the open unit disk by
absolute convergence of the complete prime-error ratio source.
This module identifies the resulting infinite source equation;
no boundary estimate at `z = 1` is assumed.
-/

namespace BuildingBlocks.GoldbachCofactorParitySeries

open Real Classical
open scoped BigOperators
open BuildingBlocks.GoldbachCofactorParityFinite

noncomputable section

abbrev Λ (n : ℕ) : ℝ := ArithmeticFunction.vonMangoldt n

def ratioSeries (z : ℝ) : ℝ :=
  ∑' n : ℕ, q (n + 2) * z ^ (n + 2)

def ratioBirthSeries (z : ℝ) : ℝ :=
  ∑' n : ℕ, (q (n + 3) - q (n + 2)) * z ^ (n + 3)

def primeSeries (z : ℝ) : ℝ :=
  ∑' n : ℕ, Λ (n + 2) * z ^ (n + 2)

def cofactorSeries (z : ℝ) : ℝ :=
  ∑' k : ℕ, Q (k + 4) * z ^ (k + 4)

def evenCofactorSeries (z : ℝ) : ℝ :=
  ∑' k : ℕ, if Even (k + 4) then Q (k + 4) * z ^ (k + 4) else 0

def oddCofactorSeries (z : ℝ) : ℝ :=
  ∑' k : ℕ, if Odd (k + 4) then Q (k + 4) * z ^ (k + 4) else 0

/-- The complete centered prime-error ratio has an absolutely
convergent geometric series at every real point inside the unit disk. -/
theorem ratioSeries_summable {z : ℝ} (hz : |z| < 1) :
    Summable (fun n : ℕ => q (n + 2) * z ^ (n + 2)) := by
  have hgeo : Summable (fun n : ℕ => |z| ^ (n + 2)) := by
    have hz' : ‖|z|‖ < 1 := by simpa [Real.norm_eq_abs] using hz
    exact (summable_nat_add_iff 2).2 (summable_geometric_of_norm_lt_one hz')
  apply Summable.of_norm_bounded
    (hgeo.mul_left (4 * Real.log 2 + 1))
  intro n
  rw [norm_mul, Real.norm_eq_abs, Real.norm_eq_abs, abs_pow]
  exact mul_le_mul_of_nonneg_right
    (abs_ratioError_le (n + 2) (by omega)) (pow_nonneg (abs_nonneg z) _)

/-- The shifted birth series also converges absolutely; boundedness
of both neighboring complete ratios suffices in the open disk. -/
theorem ratioBirthSeries_summable {z : ℝ} (hz : |z| < 1) :
    Summable (fun n : ℕ => (q (n + 3) - q (n + 2)) * z ^ (n + 3)) := by
  have hgeo : Summable (fun n : ℕ => |z| ^ (n + 3)) := by
    have hz' : ‖|z|‖ < 1 := by simpa [Real.norm_eq_abs] using hz
    exact (summable_nat_add_iff 3).2 (summable_geometric_of_norm_lt_one hz')
  apply Summable.of_norm_bounded
    (hgeo.mul_left (2 * (4 * Real.log 2 + 1)))
  intro n
  rw [norm_mul, Real.norm_eq_abs, Real.norm_eq_abs, abs_pow]
  have hq1 := abs_ratioError_le (n + 3) (by omega)
  have hq0 := abs_ratioError_le (n + 2) (by omega)
  have hdiff : |q (n + 3) - q (n + 2)| ≤
      2 * (4 * Real.log 2 + 1) := by
    have htri : |q (n + 3) - q (n + 2)| ≤
        |q (n + 3)| + |q (n + 2)| := by
      simpa using (abs_sub_le (q (n + 3)) (0 : ℝ) (q (n + 2)))
    linarith
  exact mul_le_mul_of_nonneg_right hdiff (pow_nonneg (abs_nonneg z) _)

/-- Infinite Abel identity for the actual centered ratio source.
The finite terminal term has vanished, while the initial two-leg
endpoint remains exactly `q 2 * z^2`. -/
theorem ratioSeries_abel {z : ℝ} (hz : |z| < 1) :
    (1 - z) * ratioSeries z = q 2 * z ^ 2 + ratioBirthSeries z := by
  have hA := ratioSeries_summable hz
  have hshift : Summable (fun n : ℕ => q (n + 3) * z ^ (n + 3)) := by
    simpa only [Nat.add_assoc, Nat.add_comm, Nat.add_left_comm] using
      ((summable_nat_add_iff 1).2 hA)
  have hright : Summable (fun n : ℕ => q (n + 2) * z ^ (n + 3)) := by
    have h := hA.mul_right z
    simpa only [pow_succ, mul_assoc] using h
  have hfirst : ratioSeries z = q 2 * z ^ 2 +
      ∑' n : ℕ, q (n + 3) * z ^ (n + 3) := by
    simpa only [ratioSeries, Nat.zero_add, Nat.add_assoc,
      Nat.add_comm, Nat.add_left_comm] using hA.tsum_eq_zero_add
  have hsecond : z * ratioSeries z =
      ∑' n : ℕ, q (n + 2) * z ^ (n + 3) := by
    unfold ratioSeries
    rw [← tsum_mul_left]
    apply tsum_congr
    intro n
    rw [pow_succ]
    ring
  have hdiff :
      (∑' n : ℕ, q (n + 3) * z ^ (n + 3)) -
        (∑' n : ℕ, q (n + 2) * z ^ (n + 3)) =
          ratioBirthSeries z := by
    unfold ratioBirthSeries
    rw [← hshift.tsum_sub hright]
    apply tsum_congr
    intro n
    ring
  rw [ratioSeries, ratioBirthSeries] at *
  linear_combination hfirst + hdiff - hsecond

/-- Every prime power is retained in the absolutely convergent
von Mangoldt series inside the open unit disk. -/
theorem primeSeries_summable {z : ℝ} (hz : |z| < 1) :
    Summable (fun n : ℕ => Λ (n + 2) * z ^ (n + 2)) := by
  have hz' : ‖|z|‖ < 1 := by simpa [Real.norm_eq_abs] using hz
  have hgeo : Summable (fun n : ℕ => ((n + 2 : ℕ) : ℝ) * |z| ^ (n + 2)) := by
    have hbase : Summable (fun n : ℕ => (n : ℝ) * |z| ^ n) := by
      simpa only [pow_one] using
        (summable_pow_mul_geometric_of_norm_lt_one (R := ℝ) 1 hz')
    exact (summable_nat_add_iff 2).2 hbase
  apply Summable.of_norm_bounded hgeo
  intro n
  rw [norm_mul, Real.norm_eq_abs, Real.norm_eq_abs, abs_pow,
    abs_of_nonneg (ArithmeticFunction.vonMangoldt_nonneg)]
  have hnpos : 0 < (((n + 2 : ℕ) : ℝ)) := by positivity
  have hΛ : Λ (n + 2) ≤ ((n + 2 : ℕ) : ℝ) := by
    exact ArithmeticFunction.vonMangoldt_le_log.trans
      ((log_le_sub_one_of_pos hnpos).trans (by linarith))
  exact mul_le_mul_of_nonneg_right hΛ (pow_nonneg (abs_nonneg z) _)

/-- Including the label-one endpoint changes nothing: the actual
von Mangoldt coefficient there is exactly zero. -/
theorem primeSeries_eq_one_shift {z : ℝ} (hz : |z| < 1) :
    primeSeries z = ∑' n : ℕ, Λ (n + 1) * z ^ (n + 1) := by
  let f : ℕ → ℝ := fun n => Λ (n + 1) * z ^ (n + 1)
  have htail : Summable (fun n : ℕ => f (n + 1)) := by
    simpa only [f, Nat.add_assoc, Nat.add_comm, Nat.add_left_comm] using
      primeSeries_summable hz
  have hf : Summable f := (summable_nat_add_iff 1).mp htail
  have hzero : f 0 = 0 := by
    simp [f, Λ, ArithmeticFunction.vonMangoldt_apply_one]
  have hshift : (∑' n : ℕ, f (n + 1)) = primeSeries z := by
    unfold primeSeries
    apply tsum_congr
    intro n
    simp only [f, Nat.add_comm, Nat.add_left_comm]
  have hsplit := hf.tsum_eq_zero_add
  rw [hzero, zero_add, hshift] at hsplit
  exact hsplit.symm

/-- The actual signed cofactor at total `k+4` is precisely the
complete prime-power antidiagonal with both legs at least two. -/
theorem cofactor_eq_antidiagonal (k : ℕ) :
    Q (k + 4) =
      ∑ p ∈ Finset.antidiagonal k, Λ (p.1 + 2) * q (p.2 + 2) := by
  have hQ : Q (k + 4) =
      ∑ m ∈ Finset.Icc 2 (k + 2), Λ m * q (k + 4 - m) := by
    simpa only [Q, q, show k + 4 - 2 = k + 2 by omega] using
      (BuildingBlocks.GoldbachCofactorSuccessorFinite.cofactorConvolution_eq_signed
        (k + 4)).symm
  rw [hQ, Finset.Nat.sum_antidiagonal_eq_sum_range_succ_mk]
  have hIcc : Finset.Icc 2 (k + 2) = Finset.Ico 2 (k + 3) := by
    ext m
    simp only [Finset.mem_Icc, Finset.mem_Ico]
    omega
  rw [hIcc, Finset.sum_Ico_eq_sum_range]
  apply Finset.sum_congr rfl
  intro m hm
  simp only [Finset.mem_range] at hm
  have hsub : k + 4 - (2 + m) = (k - m) + 2 := by omega
  rw [hsub]
  simp only [add_comm]

theorem cofactor_antidiagonal (k : ℕ) (z : ℝ) :
    (∑ p ∈ Finset.antidiagonal k,
      (Λ (p.1 + 2) * z ^ (p.1 + 2)) *
        (q (p.2 + 2) * z ^ (p.2 + 2))) =
      Q (k + 4) * z ^ (k + 4) := by
  rw [cofactor_eq_antidiagonal, Finset.sum_mul]
  apply Finset.sum_congr rfl
  intro p hp
  have hk : p.1 + p.2 = k := Finset.mem_antidiagonal.mp hp
  have hpow : z ^ (p.1 + 2) * z ^ (p.2 + 2) = z ^ (k + 4) := by
    rw [← pow_add]
    congr 1
    omega
  calc
    (Λ (p.1 + 2) * z ^ (p.1 + 2)) *
        (q (p.2 + 2) * z ^ (p.2 + 2)) =
      (Λ (p.1 + 2) * q (p.2 + 2)) *
        (z ^ (p.1 + 2) * z ^ (p.2 + 2)) := by ring
    _ = (Λ (p.1 + 2) * q (p.2 + 2)) * z ^ (k + 4) := by rw [hpow]

/-- The literal signed cofactor heat series is absolutely convergent
at every real point of the open unit disk. -/
theorem cofactorSeries_abs_summable {z : ℝ} (hz : |z| < 1) :
    Summable (fun k : ℕ => |Q (k + 4) * z ^ (k + 4)|) := by
  have hp := (primeSeries_summable hz).norm
  have hq := (ratioSeries_summable hz).norm
  simpa only [cofactor_antidiagonal, Real.norm_eq_abs] using
    summable_norm_sum_mul_antidiagonal_of_summable_norm hp hq

theorem cofactorSeries_summable {z : ℝ} (hz : |z| < 1) :
    Summable (fun k : ℕ => Q (k + 4) * z ^ (k + 4)) := by
  have hnorm : Summable (fun k : ℕ => ‖Q (k + 4) * z ^ (k + 4)‖) := by
    simpa only [Real.norm_eq_abs] using cofactorSeries_abs_summable hz
  exact hnorm.of_norm

/-- Complete prime-power convolution for the actual signed cofactor,
including the first admissible additive total four. -/
theorem cofactorSeries_eq_mul {z : ℝ} (hz : |z| < 1) :
    cofactorSeries z = primeSeries z * ratioSeries z := by
  have hp := (primeSeries_summable hz).norm
  have hq := (ratioSeries_summable hz).norm
  unfold cofactorSeries primeSeries ratioSeries
  rw [tsum_mul_tsum_eq_tsum_sum_antidiagonal_of_summable_norm hp hq]
  simp only [cofactor_antidiagonal]

theorem evenCofactorSeries_summable {z : ℝ} (hz : |z| < 1) :
    Summable (fun k : ℕ =>
      if Even (k + 4) then Q (k + 4) * z ^ (k + 4) else 0) := by
  apply Summable.of_norm_bounded (cofactorSeries_abs_summable hz)
  intro k
  split_ifs <;> simp [Real.norm_eq_abs]
  positivity

theorem oddCofactorSeries_summable {z : ℝ} (hz : |z| < 1) :
    Summable (fun k : ℕ =>
      if Odd (k + 4) then Q (k + 4) * z ^ (k + 4) else 0) := by
  apply Summable.of_norm_bounded (cofactorSeries_abs_summable hz)
  intro k
  split_ifs <;> simp [Real.norm_eq_abs]
  positivity

/-- The even-cutoff series is exactly the positive parity projection
of the complete actual signed cofactor series. -/
theorem evenCofactorSeries_projection {z : ℝ} (hz : |z| < 1) :
    2 * evenCofactorSeries z = cofactorSeries z + cofactorSeries (-z) := by
  have hQ := cofactorSeries_summable hz
  have hzneg : |-z| < 1 := by simpa only [abs_neg] using hz
  have hQneg := cofactorSeries_summable hzneg
  unfold evenCofactorSeries cofactorSeries
  rw [← tsum_mul_left, ← hQ.tsum_add hQneg]
  apply tsum_congr
  intro k
  by_cases he : Even (k + 4)
  · simp [he, he.neg_pow]
    ring
  · have ho : Odd (k + 4) := Nat.not_even_iff_odd.mp he
    simp [he, ho.neg_pow]

/-- The odd-cutoff series is exactly the negative parity projection
of the complete actual signed cofactor series. -/
theorem oddCofactorSeries_projection {z : ℝ} (hz : |z| < 1) :
    2 * oddCofactorSeries z = cofactorSeries z - cofactorSeries (-z) := by
  have hQ := cofactorSeries_summable hz
  have hzneg : |-z| < 1 := by simpa only [abs_neg] using hz
  have hQneg := cofactorSeries_summable hzneg
  unfold oddCofactorSeries cofactorSeries
  rw [← tsum_mul_left, ← hQ.tsum_sub hQneg]
  apply tsum_congr
  intro k
  by_cases ho : Odd (k + 4)
  · simp [ho, ho.neg_pow]
    ring
  · have he : Even (k + 4) := Nat.not_odd_iff_even.mp ho
    simp [ho, he.neg_pow]

#print axioms ratioSeries_summable
#print axioms ratioBirthSeries_summable
#print axioms ratioSeries_abel
#print axioms primeSeries_summable
#print axioms primeSeries_eq_one_shift
#print axioms cofactor_eq_antidiagonal
#print axioms cofactor_antidiagonal
#print axioms cofactorSeries_abs_summable
#print axioms cofactorSeries_summable
#print axioms cofactorSeries_eq_mul
#print axioms evenCofactorSeries_summable
#print axioms oddCofactorSeries_summable
#print axioms evenCofactorSeries_projection
#print axioms oddCofactorSeries_projection

end
end BuildingBlocks.GoldbachCofactorParitySeries
