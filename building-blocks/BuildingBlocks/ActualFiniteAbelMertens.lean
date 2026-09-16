import Mathlib.NumberTheory.ArithmeticFunction
import Mathlib.Analysis.SpecialFunctions.ExpDeriv
import Mathlib.Tactic

namespace BuildingBlocks.ActualFiniteAbelMertens

open Finset

noncomputable section

/-- The actual Möbius coefficient, embedded in the reals. -/
def mobiusReal (n : ℕ) : ℝ := (ArithmeticFunction.moebius n : ℤ)

/-- Finite Mertens sum, recursively presented to expose its exact increment. -/
def finiteMertens : ℕ → ℝ
  | 0 => 0
  | N + 1 => finiteMertens N + mobiusReal (N + 1)

/-- Truncated Abel sum with the actual Möbius coefficients. -/
def truncatedMobiusPower : ℕ → ℝ → ℝ
  | 0, _ => 0
  | N + 1, q => truncatedMobiusPower N q + mobiusReal (N + 1) * q ^ (N + 1)

@[simp] theorem finiteMertens_zero : finiteMertens 0 = 0 := rfl

@[simp] theorem finiteMertens_succ (N : ℕ) :
    finiteMertens (N + 1) = finiteMertens N + mobiusReal (N + 1) := rfl

@[simp] theorem truncatedMobiusPower_zero (q : ℝ) :
    truncatedMobiusPower 0 q = 0 := rfl

@[simp] theorem truncatedMobiusPower_succ (N : ℕ) (q : ℝ) :
    truncatedMobiusPower (N + 1) q =
      truncatedMobiusPower N q + mobiusReal (N + 1) * q ^ (N + 1) := rfl

/-- Exact finite Abel summation. The terminal Mertens term is retained. -/
theorem truncated_mobius_abel (N : ℕ) (q : ℝ) :
    truncatedMobiusPower N q =
      finiteMertens N * q ^ N +
        (1 - q) * ∑ k ∈ range N, finiteMertens k * q ^ k := by
  induction N with
  | zero => simp
  | succ N ih =>
    rw [truncatedMobiusPower_succ, finiteMertens_succ, sum_range_succ, ih, pow_succ]
    ring

/-- Every actual Möbius coefficient has absolute value at most one. -/
theorem abs_mobiusReal_le_one (n : ℕ) : |mobiusReal n| ≤ 1 := by
  obtain h | h | h := ArithmeticFunction.moebius_eq_or n
  · simp [mobiusReal, h]
  · simp [mobiusReal, h]
  · simp [mobiusReal, h]

/-- The finite exponential sum with the actual Möbius coefficients. -/
def truncatedMobiusExp : ℕ → ℝ → ℝ
  | 0, _ => 0
  | N + 1, t => truncatedMobiusExp N t + mobiusReal (N + 1) *
      Real.exp (-((N + 1 : ℕ) : ℝ) * t)

/-- The formal derivative of the finite exponential Möbius sum. -/
def truncatedMobiusDerivative (N : ℕ) (t : ℝ) : ℝ :=
  ∑ k ∈ range N, mobiusReal (k + 1) *
    (-((k + 1 : ℕ) : ℝ) * Real.exp (-((k + 1 : ℕ) : ℝ) * t))

/-- The finite exponential sum has the displayed finite derivative. -/
theorem hasDerivAt_truncatedMobiusExp (N : ℕ) (t : ℝ) :
    HasDerivAt (truncatedMobiusExp N) (truncatedMobiusDerivative N t) t := by
  induction N with
  | zero =>
      simpa [truncatedMobiusDerivative] using (hasDerivAt_const (x := t) (c := (0 : ℝ)))
  | succ N ih =>
      have hlin : HasDerivAt (fun x : ℝ => -((N + 1 : ℕ) : ℝ) * x)
          (-((N + 1 : ℕ) : ℝ)) t := by
        simpa using (hasDerivAt_id t).const_mul (-((N + 1 : ℕ) : ℝ))
      have hexp := (Real.hasDerivAt_exp (-((N + 1 : ℕ) : ℝ) * t)).comp t hlin
      have hterm := hexp.const_mul (mobiusReal (N + 1))
      have hd : truncatedMobiusDerivative (N + 1) t =
          truncatedMobiusDerivative N t + mobiusReal (N + 1) *
            (-((N + 1 : ℕ) : ℝ) * Real.exp (-((N + 1 : ℕ) : ℝ) * t)) := by
        unfold truncatedMobiusDerivative
        rw [sum_range_succ]
      rw [hd]
      change HasDerivAt (fun x => truncatedMobiusExp N x + mobiusReal (N + 1) *
        Real.exp (-((N + 1 : ℕ) : ℝ) * x)) _ t
      convert ih.add hterm using 1 <;> ring

/-- Absolute derivative bound for every finite truncation. No infinite-series
or analytic-continuation step is used. -/
theorem abs_truncatedMobiusDerivative_le (N : ℕ) (t : ℝ) :
    |truncatedMobiusDerivative N t| ≤
      ∑ k ∈ range N, ((k + 1 : ℕ) : ℝ) *
        Real.exp (-((k + 1 : ℕ) : ℝ) * t) := by
  unfold truncatedMobiusDerivative
  refine (abs_sum_le_sum_abs _ _).trans ?_
  apply sum_le_sum
  intro k hk
  have hm := abs_mobiusReal_le_one (k + 1)
  have hfactor : 0 ≤ ((k + 1 : ℕ) : ℝ) *
      Real.exp (-((k + 1 : ℕ) : ℝ) * t) :=
    mul_nonneg (Nat.cast_nonneg' (k + 1)) (Real.exp_pos _).le
  calc
    |mobiusReal (k + 1) *
        (-((k + 1 : ℕ) : ℝ) * Real.exp (-((k + 1 : ℕ) : ℝ) * t))| =
      |mobiusReal (k + 1)| *
        (((k + 1 : ℕ) : ℝ) * Real.exp (-((k + 1 : ℕ) : ℝ) * t)) := by
          have hnabs : |((k + 1 : ℕ) : ℝ)| = ((k + 1 : ℕ) : ℝ) :=
            abs_of_nonneg (Nat.cast_nonneg' (k + 1))
          have heabs : |Real.exp (-((k + 1 : ℕ) : ℝ) * t)| =
              Real.exp (-((k + 1 : ℕ) : ℝ) * t) := abs_of_pos (Real.exp_pos _)
          rw [abs_mul, abs_mul, abs_neg, hnabs, heabs]
    _ ≤ 1 * (((k + 1 : ℕ) : ℝ) * Real.exp (-((k + 1 : ℕ) : ℝ) * t)) :=
      mul_le_mul_of_nonneg_right hm hfactor
    _ = ((k + 1 : ℕ) : ℝ) * Real.exp (-((k + 1 : ℕ) : ℝ) * t) := by ring

/-- Exact gap between consecutive integer sampling points `2/X`. -/
theorem integer_grid_gap (X : ℕ) (hX : 1 ≤ X) :
    (2 : ℝ) / X - 2 / (X + 1) = 2 / (X * (X + 1)) := by
  have hX0 : (X : ℝ) ≠ 0 := by positivity
  have hXs0 : ((X + 1 : ℕ) : ℝ) ≠ 0 := by positivity
  field_simp
  ring

/-- The consecutive grid gap is strictly positive on its explicit domain. -/
theorem integer_grid_gap_pos (X : ℕ) (hX : 1 ≤ X) :
    0 < (2 : ℝ) / X - 2 / (X + 1) := by
  rw [integer_grid_gap X hX]
  positivity

#print axioms truncated_mobius_abel
#print axioms abs_mobiusReal_le_one
#print axioms hasDerivAt_truncatedMobiusExp
#print axioms abs_truncatedMobiusDerivative_le
#print axioms integer_grid_gap
#print axioms integer_grid_gap_pos

end
end BuildingBlocks.ActualFiniteAbelMertens
