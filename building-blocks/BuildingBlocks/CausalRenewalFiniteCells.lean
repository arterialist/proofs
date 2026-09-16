import BuildingBlocks.PrimeStateAndRenewalArch
import Mathlib.Tactic

/-!
Finite algebra from the Euler-discrepancy cell decomposition.

The analytic Euler remainder and logarithmic-mean estimate enter only as
explicit hypotheses. No distributional convolution, infinite sum, zeta
identity, or BIBO statement is formalized here.
-/

namespace BuildingBlocks.CausalRenewalFiniteCells

open Finset
open scoped BigOperators

noncomputable section

/-- The logarithmic mean in the form used by one renewal cell. -/
noncomputable def logarithmicMean (a b : ℝ) : ℝ :=
  (b - a) / (Real.log b - Real.log a)

/-- Direct integral algebra for a cell with square-root endpoints a,b. -/
noncomputable def rawCellIncrement (A a b : ℝ) : ℝ :=
  2 * (Real.log b - Real.log a) * A - 4 * (b - a)

/-- The factored cell increment. -/
noncomputable def cellIncrement (A a b : ℝ) : ℝ :=
  2 * (Real.log b - Real.log a) * (A - 2 * logarithmicMean a b)

/-- Source notation for the same factorization. -/
noncomputable def sourceCellIncrement (A a b : ℝ) : ℝ :=
  2 * Real.log (b / a) * (A - 2 * logarithmicMean a b)

theorem cellIncrement_eq_sourceCellIncrement {A a b : ℝ}
    (ha : 0 < a) (hb : 0 < b) :
    cellIncrement A a b = sourceCellIncrement A a b := by
  unfold cellIncrement sourceCellIncrement
  rw [Real.log_div (ne_of_gt hb) (ne_of_gt ha)]

/-- Exact factorization of the cell increment. This is algebraic once the two
endpoint logarithms are distinct. -/
theorem rawCellIncrement_eq_cellIncrement {A a b : ℝ}
    (hlog : Real.log b ≠ Real.log a) :
    rawCellIncrement A a b = cellIncrement A a b := by
  unfold rawCellIncrement cellIncrement logarithmicMean
  have hd : Real.log b - Real.log a ≠ 0 := sub_ne_zero.mpr hlog
  field_simp [hd]
  ring

theorem log_sub_pos {a b : ℝ} (ha : 0 < a) (hab : a < b) :
    0 < Real.log b - Real.log a := by
  have hb : 0 < b := lt_trans ha hab
  exact sub_pos.mpr (Real.strictMonoOn_log ha hb hab)

/-- Positivity of the exact cell increment from the one required arithmetic
comparison 2L(a,b) < A. -/
theorem cellIncrement_pos {A a b : ℝ} (ha : 0 < a) (hab : a < b)
    (hmean : 2 * logarithmicMean a b < A) :
    0 < cellIncrement A a b := by
  unfold cellIncrement
  exact mul_pos (mul_pos (by norm_num) (log_sub_pos ha hab)) (sub_pos.mpr hmean)

/-- Elementary denominator comparison used after the Euler remainder estimate.
It packages no Euler--Maclaurin or zeta input. -/
theorem reciprocal_cube_gap {a b : ℝ} (ha : 0 < a) (hb : 0 < b)
    (hcube : b ^ 3 < 3 * a ^ 3) :
    1 / (24 * a ^ 3) < 1 / (8 * b ^ 3) := by
  have ha3 : 0 < a ^ 3 := pow_pos ha _
  have hb3 : 0 < b ^ 3 := pow_pos hb _
  have hden : 8 * b ^ 3 < 24 * a ^ 3 := by nlinarith
  exact one_div_lt_one_div_of_lt (by positivity) hden

theorem sqrt_nat_lt_sqrt_succ {n : ℕ} (hn : 1 ≤ n) :
    0 < Real.sqrt (n : ℝ) ∧ Real.sqrt (n : ℝ) < Real.sqrt (n + 1 : ℝ) := by
  have hn0 : (0 : ℝ) < n := by exact_mod_cast (by omega : 0 < n)
  constructor
  · exact Real.sqrt_pos.2 hn0
  · apply Real.sqrt_lt_sqrt
    · positivity
    · norm_num

/-- The elementary cube comparison used on every actual square-root cell. -/
theorem sqrt_succ_cube_lt_three {n : ℕ} (hn : 1 ≤ n) :
    Real.sqrt (n + 1 : ℝ) ^ 3 < 3 * Real.sqrt (n : ℝ) ^ 3 := by
  let x : ℝ := n
  have hx : 1 ≤ x := by
    change (1 : ℝ) ≤ (n : ℝ)
    exact_mod_cast hn
  have hx0 : 0 < x := lt_of_lt_of_le (by norm_num) hx
  have hstep : x + 1 ≤ 2 * x := by linarith
  have hpow : (x + 1) ^ 3 ≤ (2 * x) ^ 3 :=
    pow_le_pow_left₀ (by positivity) hstep 3
  have hpoly : (x + 1) ^ 3 < 9 * x ^ 3 := by
    calc
      (x + 1) ^ 3 ≤ (2 * x) ^ 3 := hpow
      _ = 8 * x ^ 3 := by ring
      _ < 9 * x ^ 3 := by
        have hx3 : 0 < x ^ 3 := pow_pos hx0 _
        nlinarith
  have ha2 : Real.sqrt x ^ 2 = x := Real.sq_sqrt (le_of_lt hx0)
  have hb2 : Real.sqrt (x + 1) ^ 2 = x + 1 := Real.sq_sqrt (by positivity)
  have hsq : (Real.sqrt (x + 1) ^ 3) ^ 2 <
      (3 * Real.sqrt x ^ 3) ^ 2 := by
    calc
      (Real.sqrt (x + 1) ^ 3) ^ 2 = (x + 1) ^ 3 := by
        rw [show (Real.sqrt (x + 1) ^ 3) ^ 2 =
          (Real.sqrt (x + 1) ^ 2) ^ 3 by ring, hb2]
      _ < 9 * x ^ 3 := hpoly
      _ = (3 * Real.sqrt x ^ 3) ^ 2 := by
        rw [show (3 * Real.sqrt x ^ 3) ^ 2 =
          9 * (Real.sqrt x ^ 2) ^ 3 by ring, ha2]
  have hleft : 0 ≤ Real.sqrt (x + 1) ^ 3 := by positivity
  have hright : 0 ≤ 3 * Real.sqrt x ^ 3 := by positivity
  have hfinal : Real.sqrt (x + 1) ^ 3 < 3 * Real.sqrt x ^ 3 := by nlinarith
  simpa only [x, Nat.cast_add, Nat.cast_one] using hfinal

/-- The strongest elementary positivity step used by the arithmetic proof.
hA is the signed Euler remainder formula and hL is the logarithmic-mean
upper bound; their analytic proofs are deliberately separate. -/
theorem cellIncrement_pos_of_euler_bounds
    {A a b r : ℝ} (ha : 0 < a) (hab : a < b)
    (hA : A = 2 * a + 1 / (2 * a) - 1 / (24 * a ^ 3) + r)
    (hr : 0 < r) (hcube : b ^ 3 < 3 * a ^ 3)
    (hL : 2 * logarithmicMean a b <
      2 * a + 1 / (2 * a) - 1 / (8 * b ^ 3)) :
    0 < cellIncrement A a b := by
  have hb : 0 < b := lt_trans ha hab
  have hgap := reciprocal_cube_gap ha hb hcube
  apply cellIncrement_pos ha hab
  rw [hA]
  linarith

/-- Actual square-root-cell specialization. The only remaining hypotheses are
the signed Euler remainder formula and the logarithmic-mean upper bound. -/
theorem sqrt_cellIncrement_pos_of_euler_bounds
    {n : ℕ} (hn : 1 ≤ n) {A r : ℝ}
    (hA : A = 2 * Real.sqrt (n : ℝ) + 1 / (2 * Real.sqrt (n : ℝ)) -
      1 / (24 * Real.sqrt (n : ℝ) ^ 3) + r)
    (hr : 0 < r)
    (hL : 2 * logarithmicMean (Real.sqrt (n : ℝ)) (Real.sqrt (n + 1 : ℝ)) <
      2 * Real.sqrt (n : ℝ) + 1 / (2 * Real.sqrt (n : ℝ)) -
        1 / (8 * Real.sqrt (n + 1 : ℝ) ^ 3)) :
    0 < cellIncrement A (Real.sqrt (n : ℝ)) (Real.sqrt (n + 1 : ℝ)) := by
  obtain ⟨ha, hab⟩ := sqrt_nat_lt_sqrt_succ hn
  exact cellIncrement_pos_of_euler_bounds ha hab hA hr
    (sqrt_succ_cube_lt_three hn) hL

/-- A finite version of the local-damping/centered-delay cancellation.
It is the algebraic core of the linked step-delay response, without asserting
any convolution regularity. -/
theorem finite_local_centered_delay_identity
    {ι : Type*} [DecidableEq ι] (s : Finset ι)
    (q delay : ι → ℝ) (f : ℝ → ℝ) (v : ℝ) :
    (∑ i ∈ s, q i) * f v +
        ∑ i ∈ s, q i * (f (v - delay i) - f v) =
      ∑ i ∈ s, q i * f (v - delay i) := by
  rw [Finset.sum_mul]
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro i hi
  ring

/-- Finite weighted energy lower bound. The correlation estimate is an explicit
hypothesis: in an analytic application it comes from weighted translation
contractivity, not from the algebra in this file. -/
theorem finite_delay_energy_lower
    {ι : Type*} [DecidableEq ι] (s : Finset ι)
    (q attenuation correlation : ι → ℝ) (energy : ℝ)
    (hq : ∀ i ∈ s, 0 ≤ q i)
    (hcorr : ∀ i ∈ s, -(attenuation i * energy) ≤ correlation i) :
    -(∑ i ∈ s, q i * attenuation i) * energy ≤
      ∑ i ∈ s, q i * correlation i := by
  calc
    -(∑ i ∈ s, q i * attenuation i) * energy =
        ∑ i ∈ s, q i * (-(attenuation i * energy)) := by
          rw [neg_mul, Finset.sum_mul, ← Finset.sum_neg_distrib]
          apply Finset.sum_congr rfl
          intro i hi
          ring
    _ ≤ ∑ i ∈ s, q i * correlation i := by
      apply Finset.sum_le_sum
      intro i hi
      exact mul_le_mul_of_nonneg_left (hcorr i hi) (hq i hi)

#print axioms rawCellIncrement_eq_cellIncrement
#print axioms cellIncrement_eq_sourceCellIncrement
#print axioms log_sub_pos
#print axioms cellIncrement_pos
#print axioms reciprocal_cube_gap
#print axioms sqrt_nat_lt_sqrt_succ
#print axioms sqrt_succ_cube_lt_three
#print axioms cellIncrement_pos_of_euler_bounds
#print axioms sqrt_cellIncrement_pos_of_euler_bounds
#print axioms finite_local_centered_delay_identity
#print axioms finite_delay_energy_lower

end
end BuildingBlocks.CausalRenewalFiniteCells
