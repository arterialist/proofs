import BuildingBlocks.RiemannZetaChebyshevFluctuationBound
import Mathlib.Algebra.BigOperators.Intervals
import Mathlib.Tactic

/-!
# Module 325: Cubic Fluctuation Bounds and Divisor Sum Convergence

This module sharpens the global bound on the centered prime fluctuation sum
`fullNumerator(x)` from quartic $O(x^4)$ to cubic $O(x^3)$ for all $x \ge 0$.

In `RiemannZetaChebyshevFluctuationBound.lean`, each term in the divisor sum
`fullNumerator(x) = ∑_{d ≤ x} √d N(x/d)` was bounded by $C_N x^3$, yielding
$C_N x^4$ via the trivial bound $\lfloor x \rfloor \le x$.

Here, we evaluate the divisor sum directly against the convergent series $\sum d^{-5/2}$:
`∑_{d ≤ x} √d (x/d)^3 = x^3 ∑_{d ≤ x} √d / d^3 ≤ x^3 ∑_{d ≤ x} 1 / d^2 ≤ 2 x^3`.

All declarations are verified in Lean 4.34.1 with **0 `sorry`** and standard
foundational axioms `[propext, Classical.choice, Quot.sound]`.
-/

open scoped BigOperators
open Filter

namespace BuildingBlocks.RiemannZetaCubicFluctuationBound

open RiemannZetaChebyshevFluctuationBound

/-- Telescoping harmonic-square partial sum bound:
`∑_{d=1}^N 1/d^2 ≤ 2 - 1/N` for all $N \ge 1$. -/
lemma sum_inv_sq_le_two_sub_inv (N : ℕ) (hN : 1 ≤ N) :
    ∑ d ∈ Finset.Icc 1 N, (1 : ℝ) / ((d : ℝ) ^ 2) ≤ 2 - 1 / (N : ℝ) := by
  induction N, hN using Nat.le_induction with
  | base =>
    simp only [Finset.Icc_self, Finset.sum_singleton, Nat.cast_one, one_pow, div_one]
    norm_num
  | succ n hn ih =>
    rw [Finset.sum_Icc_succ_top (by omega)]
    have hn0 : (0 : ℝ) < (n : ℝ) := by positivity
    have hn1 : (0 : ℝ) < (n : ℝ) + 1 := by positivity
    have hcast : ((n + 1 : ℕ) : ℝ) = (n : ℝ) + 1 := by push_cast; rfl
    rw [hcast]
    have hstep : (1 : ℝ) / (((n : ℝ) + 1) ^ 2) ≤ 1 / (n : ℝ) - 1 / ((n : ℝ) + 1) := by
      have h1 : 1 / (n : ℝ) - 1 / ((n : ℝ) + 1) = 1 / ((n : ℝ) * ((n : ℝ) + 1)) := by
        field_simp
        ring
      rw [h1]
      have hle : (n : ℝ) * ((n : ℝ) + 1) ≤ ((n : ℝ) + 1) ^ 2 := by
        nlinarith
      have hpos : 0 < (n : ℝ) * ((n : ℝ) + 1) := mul_pos hn0 hn1
      exact one_div_le_one_div_of_le hpos hle
    linarith

/-- Universal upper bound `∑_{d=1}^N 1/d^2 ≤ 2` for all $N \in \mathbb{N}$. -/
lemma sum_inv_sq_le_two (N : ℕ) :
    ∑ d ∈ Finset.Icc 1 N, (1 : ℝ) / ((d : ℝ) ^ 2) ≤ 2 := by
  cases N with
  | zero =>
    simp
  | succ n =>
    have h := sum_inv_sq_le_two_sub_inv (n + 1) (by omega)
    have : (0 : ℝ) ≤ 1 / (((n + 1 : ℕ) : ℝ)) := by positivity
    linarith

/-- The factor `√d / d^3 ≤ 1 / d^2` for all $d \ge 1$. -/
lemma sqrt_div_pow_three_le_one_div_sq {d : ℕ} (hd : 1 ≤ d) :
    Real.sqrt (d : ℝ) / ((d : ℝ) ^ 3) ≤ 1 / ((d : ℝ) ^ 2) := by
  have hd0 : (0 : ℝ) < (d : ℝ) := by positivity
  have hd1 : (1 : ℝ) ≤ (d : ℝ) := by exact_mod_cast hd
  have h1 : Real.sqrt (d : ℝ) ≤ (d : ℝ) := by
    calc Real.sqrt (d : ℝ) ≤ Real.sqrt ((d : ℝ) ^ 2) := Real.sqrt_le_sqrt (by nlinarith)
    _ = (d : ℝ) := Real.sqrt_sq (le_of_lt hd0)
  have hd3 : (d : ℝ) ^ 3 = (d : ℝ) * (d : ℝ) ^ 2 := by ring
  rw [hd3]
  have hsplit : Real.sqrt (d : ℝ) / ((d : ℝ) * (d : ℝ) ^ 2) = (Real.sqrt (d : ℝ) / (d : ℝ)) / ((d : ℝ) ^ 2) := by
    ring
  rw [hsplit]
  have hdiv : Real.sqrt (d : ℝ) / (d : ℝ) ≤ 1 := by
    rw [div_le_one hd0]
    exact h1
  have hd2_pos : 0 < (d : ℝ) ^ 2 := by positivity
  exact div_le_div_of_nonneg_right hdiv (le_of_lt hd2_pos)

/-- Universal divisor sum bound `∑_{d=1}^N √d / d^3 ≤ 2`. -/
lemma sum_sqrt_div_pow_three_le_two (N : ℕ) :
    ∑ d ∈ Finset.Icc 1 N, Real.sqrt (d : ℝ) / ((d : ℝ) ^ 3) ≤ 2 := by
  have hle : ∑ d ∈ Finset.Icc 1 N, Real.sqrt (d : ℝ) / ((d : ℝ) ^ 3) ≤
      ∑ d ∈ Finset.Icc 1 N, (1 : ℝ) / ((d : ℝ) ^ 2) := by
    apply Finset.sum_le_sum
    intro d hd
    exact sqrt_div_pow_three_le_one_div_sq (Finset.mem_Icc.mp hd).1
  exact hle.trans (sum_inv_sq_le_two N)

/-- Scaled divisor convolution bound: `∑_{d=1}^N √d (x/d)^3 ≤ 2 x^3`. -/
lemma sum_sqrt_mul_div_le {x : ℝ} (hx : 0 ≤ x) (N : ℕ) :
    ∑ d ∈ Finset.Icc 1 N, Real.sqrt (d : ℝ) * (x / (d : ℝ)) ^ 3 ≤ 2 * x ^ 3 := by
  have heq : (∑ d ∈ Finset.Icc 1 N, Real.sqrt (d : ℝ) * (x / (d : ℝ)) ^ 3) =
      x ^ 3 * ∑ d ∈ Finset.Icc 1 N, Real.sqrt (d : ℝ) / ((d : ℝ) ^ 3) := by
    rw [Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro d hd
    rw [div_pow, mul_div, mul_comm (Real.sqrt (d : ℝ)), mul_div_assoc]
  rw [heq]
  have hsum := sum_sqrt_div_pow_three_le_two N
  have hx3 : 0 ≤ x ^ 3 := by positivity
  nlinarith

/-- The universal cubic constant `C_cubic = 2 * C_N`. -/
noncomputable def C_cubic : ℝ := 2 * C_N

theorem C_cubic_pos : 0 < C_cubic := by
  unfold C_cubic
  have h := C_N_pos
  positivity

/-- Unconditional cubic bound on the full centered numerator:
`Re fullNumerator(x) ≤ C_cubic * x^3` for all $x \ge 0$. -/
theorem fullNumerator_re_le_cubic {x : ℝ} (hx : 0 ≤ x) :
    (ActualFullCenteredMellin.fullNumerator x).re ≤ C_cubic * x ^ 3 := by
  rw [ActualFullCenteredMellin.fullNumerator_eq_real_sum x]
  simp only [Complex.ofReal_re]
  have hterm_le : (∑ d ∈ Finset.Icc 1 ⌊x⌋₊, Real.sqrt d * (ActualCenteredMellin.N (x / (d : ℝ))).re) ≤
      ∑ d ∈ Finset.Icc 1 ⌊x⌋₊, Real.sqrt d * (C_N * (x / (d : ℝ)) ^ 3) := by
    apply Finset.sum_le_sum
    intro d hd
    have hd1 : 1 ≤ d := (Finset.mem_Icc.mp hd).1
    have hd_pos : 0 < (d : ℝ) := Nat.cast_pos.mpr (by omega)
    have hxd : 0 ≤ x / (d : ℝ) := div_nonneg hx (le_of_lt hd_pos)
    have hN := N_re_le hxd
    have hsqrt_nonneg : 0 ≤ Real.sqrt (d : ℝ) := Real.sqrt_nonneg _
    exact mul_le_mul_of_nonneg_left hN hsqrt_nonneg
  have hfactor : (∑ d ∈ Finset.Icc 1 ⌊x⌋₊, Real.sqrt d * (C_N * (x / (d : ℝ)) ^ 3)) =
      C_N * ∑ d ∈ Finset.Icc 1 ⌊x⌋₊, Real.sqrt d * (x / (d : ℝ)) ^ 3 := by
    rw [Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro d hd
    ring
  rw [hfactor] at hterm_le
  have hscale := sum_sqrt_mul_div_le hx ⌊x⌋₊
  have hCN_nonneg : 0 ≤ C_N := le_of_lt C_N_pos
  have hmul := mul_le_mul_of_nonneg_left hscale hCN_nonneg
  have hring : C_N * (2 * x ^ 3) = C_cubic * x ^ 3 := by
    unfold C_cubic
    ring
  rw [hring] at hmul
  exact hterm_le.trans hmul

/-- Unconditional cubic bound on the critical transform kernel:
`Re W(x) ≤ C_cubic * x^3` for all $x \ge 0$. -/
theorem W_re_le_cubic {x : ℝ} (hx : 0 ≤ x) :
    (ActualCriticalMellin.W x).re ≤ C_cubic * x ^ 3 := by
  have hW := RiemannZetaPrimeAllocationGrowth.W_re_le_fullNumerator_re x
  exact hW.trans (fullNumerator_re_le_cubic hx)

/-- Eventual cubic bound on `fullNumerator`:
`∀ᶠ x in atTop, Re fullNumerator(x) ≤ C_cubic * x^3`. -/
theorem eventually_fullNumerator_re_le_cubic :
    ∀ᶠ (x : ℝ) in Filter.atTop, (ActualFullCenteredMellin.fullNumerator x).re ≤ C_cubic * x ^ 3 := by
  filter_upwards [Filter.eventually_ge_atTop 0] with x hx
  exact fullNumerator_re_le_cubic hx

/-- Eventual cubic bound on `W`:
`∀ᶠ x in atTop, Re W(x) ≤ C_cubic * x^3`. -/
theorem eventually_W_re_le_cubic :
    ∀ᶠ (x : ℝ) in Filter.atTop, (ActualCriticalMellin.W x).re ≤ C_cubic * x ^ 3 := by
  filter_upwards [Filter.eventually_ge_atTop 0] with x hx
  exact W_re_le_cubic hx

end BuildingBlocks.RiemannZetaCubicFluctuationBound

#print axioms BuildingBlocks.RiemannZetaCubicFluctuationBound.sum_inv_sq_le_two
#print axioms BuildingBlocks.RiemannZetaCubicFluctuationBound.sum_sqrt_div_pow_three_le_two
#print axioms BuildingBlocks.RiemannZetaCubicFluctuationBound.sum_sqrt_mul_div_le
#print axioms BuildingBlocks.RiemannZetaCubicFluctuationBound.fullNumerator_re_le_cubic
#print axioms BuildingBlocks.RiemannZetaCubicFluctuationBound.W_re_le_cubic
#print axioms BuildingBlocks.RiemannZetaCubicFluctuationBound.eventually_fullNumerator_re_le_cubic
#print axioms BuildingBlocks.RiemannZetaCubicFluctuationBound.eventually_W_re_le_cubic
