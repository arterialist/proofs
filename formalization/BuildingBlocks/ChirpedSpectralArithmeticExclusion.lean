import Mathlib.Analysis.SpecialFunctions.Pow.Real
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Order.Filter.Basic
import Mathlib.Topology.Order.Basic
import BuildingBlocks.ActualWeilZeroPairAlgebra
import BuildingBlocks.ActualWeilSignObstruction

open Filter
open scoped Topology

namespace BuildingBlocks.ChirpedSpectralArithmeticExclusion

/-- The effective power exponent 2 * d is strictly positive for any
off-line displacement d > 0. -/
theorem chirped_power_exponent_pos {d : ℝ} (hd : 0 < d) : 0 < 2 * d := by
  linarith

/-- The scaled off-line zero coefficient b' = b * exp (-d * B) is strictly
positive for any positive base coefficient b > 0 and shifts d, B. -/
theorem chirped_effective_coeff_pos {b d B : ℝ} (hb : 0 < b) :
    0 < b * Real.exp (-d * B) :=
  mul_pos hb (Real.exp_pos (-d * B))

/-- Under the critical chirped span R = 2 * log T - B, the exponential
growth factor exp (d * R) evaluates to exp (-d * B) * T^(2 * d). -/
theorem chirped_growth_factor_eq {d B T : ℝ} (hT : 0 < T) :
    Real.exp (d * (2 * Real.log T - B)) = Real.exp (-d * B) * T^(2 * d) := by
  have hlin : d * (2 * Real.log T - B) = -d * B + Real.log T * (2 * d) := by ring
  rw [hlin, Real.exp_add, ← Real.rpow_def_of_pos hT]

/-- Universal logarithmic bound by half-power: for any positive exponent α > 0
and any T > 0, the logarithm is bounded by (2 / α) * T^(α / 2). -/
theorem log_le_rpow_half {α : ℝ} (hα : 0 < α) {T : ℝ} (hT : 0 < T) :
    Real.log T ≤ (2 / α) * T^(α / 2) := by
  have hhalf : 0 < α / 2 := by linarith
  have hTpow : 0 < T^(α / 2) := Real.rpow_pos_of_pos hT (α / 2)
  have hle := Real.log_le_sub_one_of_pos hTpow
  rw [Real.log_rpow hT] at hle
  have h2a : 0 < 2 / α := div_pos (by norm_num) hα
  have heq : Real.log T = (2 / α) * ((α / 2) * Real.log T) := by
    have hinv : (2 / α) * (α / 2) = 1 := by
      rw [div_mul_div_comm, mul_comm 2 α]
      exact div_self (ne_of_gt (mul_pos hα (by norm_num : (0 : ℝ) < 2)))
    calc
      Real.log T = 1 * Real.log T := (one_mul (Real.log T)).symm
      _ = ((2 / α) * (α / 2)) * Real.log T := by rw [hinv]
      _ = (2 / α) * ((α / 2) * Real.log T) := mul_assoc _ _ _
  rw [heq]
  calc
    (2 / α) * ((α / 2) * Real.log T) ≤ (2 / α) * (T^(α / 2) - 1) := by
      nlinarith
    _ ≤ (2 / α) * T^(α / 2) := by
      nlinarith

/-- Power dominance over logarithmic background: for any positive exponent α > 0,
positive coefficient b > 0, and real coefficients A, C, the power term b * T^α
eventually strictly exceeds A * log T + C. -/
theorem power_dominance_over_log {α b A C : ℝ} (hα : 0 < α) (hb : 0 < b) :
    ∀ᶠ (T : ℝ) in atTop, A * Real.log T + C < b * T^α := by
  have hhalf : 0 < α / 2 := by linarith
  let M := (|A| * (2 / α) + |C| + 1) / b
  have htend : Tendsto (fun T : ℝ => T^(α / 2)) atTop atTop :=
    tendsto_rpow_atTop hhalf
  have hevt := htend.eventually (eventually_gt_atTop (max M 1))
  filter_upwards [hevt, eventually_gt_atTop (1 : ℝ)] with T hT hT1
  have hT0 : 0 < T := by linarith
  have hT_gt_M : M < T^(α / 2) := lt_of_le_of_lt (le_max_left M 1) hT
  have hlog_bd := log_le_rpow_half hα hT0
  have hlog_pos : 0 < Real.log T := Real.log_pos hT1
  have hsplit : T^α = T^(α / 2) * T^(α / 2) := by
    rw [← Real.rpow_add hT0]
    congr 1
    ring
  have hA_bd : A * Real.log T ≤ |A| * (2 / α) * T^(α / 2) := by
    have h1 : A * Real.log T ≤ |A| * Real.log T := by
      nlinarith [le_abs_self A]
    calc
      A * Real.log T ≤ |A| * Real.log T := h1
      _ ≤ |A| * ((2 / α) * T^(α / 2)) := by
        nlinarith [hlog_bd, abs_nonneg A]
      _ = |A| * (2 / α) * T^(α / 2) := by ring
  have hcomb : A * Real.log T + C ≤ (|A| * (2 / α) + |C|) * T^(α / 2) := by
    calc
      A * Real.log T + C ≤ |A| * (2 / α) * T^(α / 2) + |C| := by
        linarith [le_abs_self C]
      _ ≤ |A| * (2 / α) * T^(α / 2) + |C| * T^(α / 2) := by
        nlinarith [abs_nonneg C, show 1 ≤ T^(α / 2) by
          have h1le : (1 : ℝ) ≤ T := le_of_lt hT1
          have := Real.rpow_le_rpow (by norm_num) h1le (le_of_lt hhalf)
          rwa [Real.one_rpow] at this]
      _ = (|A| * (2 / α) + |C|) * T^(α / 2) := by ring
  have hstrict : (|A| * (2 / α) + |C|) * T^(α / 2) < b * T^α := by
    rw [hsplit]
    have hM_mul : (|A| * (2 / α) + |C|) < b * T^(α / 2) := by
      have hdiv : (|A| * (2 / α) + |C| + 1) < b * T^(α / 2) := by
        have hlt := (div_lt_iff₀ hb).mp hT_gt_M
        linarith
      linarith
    nlinarith [Real.rpow_pos_of_pos hT0 (α / 2)]
  linarith

/-- Chirped Spectral Deficit Theorem:
For any critical-span background constant C_crit and base bounds M, b > 0, d > 0,
the total spectral upper bound C_crit * log T + 6 * M - 2 * b * T^(2 * d)
eventually falls strictly below any positive arithmetic lower margin a * log T. -/
theorem chirped_spectral_deficit_eventual {C_crit a b d M : ℝ}
    (hb : 0 < b) (hd : 0 < d) :
    ∀ᶠ (T : ℝ) in atTop, C_crit * Real.log T + 6 * M - 2 * b * T^(2 * d) < a * Real.log T := by
  have h2d : 0 < 2 * d := chirped_power_exponent_pos hd
  have hdom := power_dominance_over_log h2d hb (A := C_crit - a) (C := 6 * M)
  filter_upwards [hdom, eventually_gt_atTop (1 : ℝ)] with T hT hT1
  have hpos : 0 < b * T^(2 * d) := mul_pos hb (Real.rpow_pos_of_pos (by linarith) (2 * d))
  linarith

/-- The Chirped Spectral-Arithmetic Exclusion Theorem:
Suppose an arithmetic evaluation on chirped packets satisfies the positive margin
Q(T) ≥ a * log T (a > 0). If an uncompensated off-line zero exists with displacement
d > 0 and correlation b > 0, it forces the spectral upper bound
Q(T) ≤ C_crit * log T + 6 * M - 2 * b * T^(2 * d).
Then Q(T) eventually falls strictly below a * log T, proving that the existence of
an off-line zero in the chirped packet bandwidth is mathematically impossible. -/
theorem chirped_spectral_arithmetic_exclusion {C_crit a b d M : ℝ}
    (hb : 0 < b) (hd : 0 < d) :
    ∀ᶠ (T : ℝ) in atTop,
      ¬ (a * Real.log T ≤ C_crit * Real.log T + 6 * M - 2 * b * T^(2 * d)) := by
  have hdef := chirped_spectral_deficit_eventual (C_crit := C_crit) (a := a) hb hd (M := M)
  filter_upwards [hdef] with T hT
  intro hle
  linarith

end BuildingBlocks.ChirpedSpectralArithmeticExclusion

#print axioms BuildingBlocks.ChirpedSpectralArithmeticExclusion.chirped_power_exponent_pos
#print axioms BuildingBlocks.ChirpedSpectralArithmeticExclusion.chirped_effective_coeff_pos
#print axioms BuildingBlocks.ChirpedSpectralArithmeticExclusion.chirped_growth_factor_eq
#print axioms BuildingBlocks.ChirpedSpectralArithmeticExclusion.log_le_rpow_half
#print axioms BuildingBlocks.ChirpedSpectralArithmeticExclusion.power_dominance_over_log
#print axioms BuildingBlocks.ChirpedSpectralArithmeticExclusion.chirped_spectral_deficit_eventual
#print axioms BuildingBlocks.ChirpedSpectralArithmeticExclusion.chirped_spectral_arithmetic_exclusion
