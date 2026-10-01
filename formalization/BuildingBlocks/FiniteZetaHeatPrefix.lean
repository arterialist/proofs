import Mathlib.Analysis.Complex.Exponential
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Tactic

/-!
Finite heated zeta prefixes and their exact recentering.  The sums run over
the literal integers `1 ≤ n ≤ N`; no prime model or infinite tail is used.
The recentering holds for every real heat parameter and center.  The two
rational certificates below verify only scalar margins, not their analytic
denominator estimates.  This file asserts no zero-free region or RH result.
-/

namespace BuildingBlocks.FiniteZetaHeatPrefix

/-- The literal finite prefix `∑_{n=1}^N exp(t log²(n)/4) n^{-s}`,
with `n^{-s}` written using the real logarithm of the positive integer. -/
noncomputable def heatedPrefix (N : ℕ) (t : ℝ) (s : ℂ) : ℂ :=
  ∑ n ∈ Finset.Icc 1 N,
    (Real.exp (t / 4 * Real.log (n : ℝ) ^ 2) : ℂ) *
      Complex.exp (-s * (Real.log (n : ℝ) : ℂ))

/-- The same finite exponential polynomial with real frequencies
`b - log n` and their corresponding heat weights. -/
noncomputable def centeredPrefix (N : ℕ) (t b : ℝ) (s : ℂ) : ℂ :=
  ∑ n ∈ Finset.Icc 1 N,
    (Real.exp (t / 4 * (b - Real.log (n : ℝ)) ^ 2) : ℂ) *
      Complex.exp ((b - Real.log (n : ℝ) : ℝ) * s)

theorem recenter_summand (t b l : ℝ) (s : ℂ) :
    (Real.exp (t / 4 * l ^ 2) : ℂ) * Complex.exp (-s * (l : ℂ)) =
      Complex.exp (-(b : ℂ) * s + (t / 4 * b ^ 2 : ℝ)) *
        ((Real.exp (t / 4 * (b - l) ^ 2) : ℂ) *
          Complex.exp ((b - l : ℝ) * (s - (t / 2 * b : ℝ)))) := by
  simp only [Complex.ofReal_exp]
  rw [← Complex.exp_add, ← Complex.exp_add, ← Complex.exp_add]
  congr 1
  push_cast
  ring

/-- Exact recentering, including the empty prefix, with no sign condition
on `t` and no restriction on the complex argument. -/
theorem heatedPrefix_recenter (N : ℕ) (t b : ℝ) (s : ℂ) :
    heatedPrefix N t s =
      Complex.exp (-(b : ℂ) * s + (t / 4 * b ^ 2 : ℝ)) *
        centeredPrefix N t b (s - (t / 2 * b : ℝ)) := by
  unfold heatedPrefix centeredPrefix
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro n hn
  exact recenter_summand t b (Real.log (n : ℝ)) s

theorem heatedPrefix_zero (t : ℝ) (s : ℂ) : heatedPrefix 0 t s = 0 := by
  simp [heatedPrefix]

theorem heatedPrefix_one (t : ℝ) (s : ℂ) : heatedPrefix 1 t s = 1 := by
  simp [heatedPrefix]

/-- Arithmetic margin for the independent `22/15` entry estimate.
The analytic estimates giving these three constants are not formalized here. -/
theorem entry_corner_margin :
    (3 : ℝ) / 100 < 883 / 2000 - 1233 / 3920 - 59 / 625 := by
  norm_num

/-- Exact surplus over `1/10` in the independent large-prefix estimate. -/
theorem large_prefix_corner_surplus :
    (53 : ℝ) / 200 - 7863 / 48400 - 1 / 5500 =
      1 / 10 + 571 / 242000 := by
  norm_num

theorem large_prefix_corner_margin :
    (1 : ℝ) / 10 < 53 / 200 - 7863 / 48400 - 1 / 5500 := by
  norm_num

#print axioms recenter_summand
#print axioms heatedPrefix_recenter
#print axioms heatedPrefix_zero
#print axioms heatedPrefix_one
#print axioms entry_corner_margin
#print axioms large_prefix_corner_surplus
#print axioms large_prefix_corner_margin

end BuildingBlocks.FiniteZetaHeatPrefix
