import BuildingBlocks.CoarsePrimeBounds
import Mathlib.Analysis.SpecialFunctions.Integrals.Basic

open Filter Set MeasureTheory
open scoped BigOperators Interval

namespace BuildingBlocks

open CoarsePrimitive

/-- The finite prime-power expression for the integral of the actual prime error
from one to `x`. At an integer endpoint its last summand has zero coefficient. -/
noncomputable def primePrimitiveArea (x : ℝ) : ℝ :=
  x * psi ⌊x⌋₊ -
    (∑ n ∈ Finset.Icc 1 ⌊x⌋₊, (n : ℝ) * ArithmeticFunction.vonMangoldt n) -
    (x ^ 2 - 1) / 2

theorem primePrimitiveArea_eq_weighted_sum (x : ℝ) :
    primePrimitiveArea x =
      (∑ n ∈ Finset.Icc 1 ⌊x⌋₊, (x - n) * ArithmeticFunction.vonMangoldt n) -
        (x ^ 2 - 1) / 2 := by
  simp only [primePrimitiveArea, psi_eq_sum_Icc, Finset.mul_sum,
    sub_mul, Finset.sum_sub_distrib]

theorem integral_psi_floor_eq_finite {x : ℝ} (hx : 1 ≤ x) :
    (∫ t in (1 : ℝ)..x, psi ⌊t⌋₊) =
      x * psi ⌊x⌋₊ -
        ∑ n ∈ Finset.Icc 1 ⌊x⌋₊, (n : ℝ) * ArithmeticFunction.vonMangoldt n := by
  have hd : IntegrableOn (deriv (fun t : ℝ => t)) (Icc 1 x) := by
    simp only [deriv_id'']
    exact continuous_const.integrableOn_Icc
  have hab := sum_mul_eq_sub_integral_mul₀ ArithmeticFunction.vonMangoldt
    (by simp) x (fun _ _ => differentiableAt_id) hd
  have hs : ∀ N : ℕ,
      (∑ n ∈ Finset.Icc 0 N, ArithmeticFunction.vonMangoldt n) = psi N := by
    intro N
    have hset : Finset.Icc 0 N = Finset.range (N + 1) := by
      ext n
      simp
      omega
    rw [hset, psi]
  simp only [hs, deriv_id, id_eq, one_mul] at hab
  rw [Finset.Icc_eq_cons_Ioc (Nat.zero_le _), Finset.sum_cons] at hab
  simp only [Nat.cast_zero, zero_mul, zero_add,
    ← Finset.Icc_add_one_left_eq_Ioc] at hab
  rw [intervalIntegral.integral_of_le hx]
  linarith

/-- This identity has no prime-error bound as a hypothesis. -/
theorem integral_primeErrorReal_eq_area {x : ℝ} (hx : 1 ≤ x) :
    (∫ t in (1 : ℝ)..x, primeErrorReal t) = primePrimitiveArea x := by
  have hp : IntervalIntegrable (fun t : ℝ => psi ⌊t⌋₊) volume 1 x :=
    (show Monotone (fun t : ℝ => psi ⌊t⌋₊) from
      fun _ _ h => psi_mono (Nat.floor_mono h)).intervalIntegrable
  change (∫ t in (1 : ℝ)..x, (fun t : ℝ => psi ⌊t⌋₊) t - id t) = _
  rw [intervalIntegral.integral_sub hp (continuous_id.intervalIntegrable _ _),
    integral_psi_floor_eq_finite hx]
  simp only [id_eq, integral_id, one_pow, primePrimitiveArea]

/-- Every coarse primitive sample is an explicit finite expression, including
the initial value through the subtraction at the lower endpoint. -/
theorem coarsePrefix_eq_area_sub {X t : ℝ} (hX : 1 ≤ X) (ht : 1 ≤ t) :
    coarsePrefix X t = primePrimitiveArea t - primePrimitiveArea X := by
  have h := intervalIntegral.integral_add_adjacent_intervals
    (primeErrorReal_intervalIntegrable 1 X) (primeErrorReal_intervalIntegrable X t)
  rw [integral_primeErrorReal_eq_area hX, integral_primeErrorReal_eq_area ht] at h
  change (∫ x in X..t, primeErrorReal x) = _
  linarith

/-- The prime-power part of the literal terminal mass on `[X,2X]`. -/
noncomputable def dyadicTerminalPrimeMass (X : ℕ) : ℝ :=
  (X : ℝ) * psi X +
    ∑ n ∈ Finset.Ioc X (2 * X),
      (((2 * X : ℕ) : ℝ) - (n : ℝ)) * ArithmeticFunction.vonMangoldt n

/-- The literal finite terminal mass on the dyadic block `[X,2X]`.
Every prime power at both integer endpoints is retained; the coefficient
of the upper endpoint is zero. -/
noncomputable def coarseTerminalMassFinite (X : ℕ) : ℝ :=
  dyadicTerminalPrimeMass X - 3 * (X : ℝ) ^ 2 / 2

/-- Exact finite formula for the terminal/scaling channel missing from a
zero-mean local packet. -/
theorem coarsePrefix_nat_double_eq_terminalMassFinite
    {X : ℕ} (hX : 1 ≤ X) :
    coarsePrefix (X : ℝ) (2 * (X : ℝ)) = coarseTerminalMassFinite X := by
  have hsplit (f : ℕ → ℝ) :
      (∑ n ∈ Finset.Icc 1 (2 * X), f n) =
        (∑ n ∈ Finset.Icc 1 X, f n) +
          ∑ n ∈ Finset.Ioc X (2 * X), f n := by
    have hdisj : Disjoint (Finset.Icc 1 X) (Finset.Ioc X (2 * X)) := by
      rw [Finset.disjoint_left]
      intro n hnIcc hnIoc
      simp only [Finset.mem_Icc] at hnIcc
      simp only [Finset.mem_Ioc] at hnIoc
      omega
    calc
      (∑ n ∈ Finset.Icc 1 (2 * X), f n) =
          ∑ n ∈ Finset.Icc 1 X ∪ Finset.Ioc X (2 * X), f n := by
            apply Finset.sum_congr
            · ext n
              simp only [Finset.mem_Icc, Finset.mem_union, Finset.mem_Ioc]
              omega
            · intro n hn
              rfl
      _ = _ := Finset.sum_union hdisj
  have hXreal : (1 : ℝ) ≤ (X : ℝ) := by exact_mod_cast hX
  have h2Xreal : (1 : ℝ) ≤ 2 * (X : ℝ) := by linarith
  have hfloor : ⌊2 * (X : ℝ)⌋₊ = 2 * X := by
    have hcast : 2 * (X : ℝ) = ((2 * X : ℕ) : ℝ) := by norm_num
    rw [hcast, Nat.floor_natCast]
  rw [coarsePrefix_eq_area_sub hXreal h2Xreal]
  unfold primePrimitiveArea coarseTerminalMassFinite dyadicTerminalPrimeMass
  rw [Nat.floor_natCast, hfloor]
  rw [psi_eq_sum_Icc, psi_eq_sum_Icc]
  rw [hsplit (fun n => ArithmeticFunction.vonMangoldt n)]
  rw [hsplit (fun n => (n : ℝ) * ArithmeticFunction.vonMangoldt n)]
  simp_rw [sub_mul]
  rw [Finset.sum_sub_distrib, ← Finset.mul_sum]
  push_cast
  ring

#print axioms coarsePrefix_nat_double_eq_terminalMassFinite

end BuildingBlocks
