import BuildingBlocks.FactorialAbelEnvelope

open Finset MeasureTheory
namespace BuildingBlocks.FactorialAbelClockEnergy
open FactorialBirthLcmEnergy FactorialBirthInteriorBound

/-- Actual complete compensated density bounded after coherent reciprocal-prefix cancellation. -/
theorem energy_row_linear (N : ℕ) (t : ℝ) (ht : 0 < t) :
    FactorialBinaryEnergy.energyRow N t ≤ 9 * (N : ℝ)^2 * t / 2 := by
  have hr := FactorialAbelEnvelope.actual_response_linear N t ht.le
  have hs : (FactorialBinaryCarry.response N t)^2 ≤ (3 * (N : ℝ) * t)^2 := by
    simpa only [sq_abs] using pow_le_pow_left₀ (abs_nonneg _) hr 2
  have hw := FactorialOriginNeutralization.weight_le_half_inverse t ht
  have hp := FactorialBinaryEnergy.weight_pos t ht
  unfold FactorialBinaryEnergy.energyRow
  calc
    _ ≤ (3 * (N : ℝ) * t)^2 * (1 / (2 * t)) :=
      mul_le_mul hs hw hp.le (by positivity)
    _ = _ := by field_simp; ring

/-- Every finite positive clock interval has a log-free actual energy upper bound. -/
theorem energy_band_bound (N : ℕ) (T : ℝ) (hT : 0 ≤ T) :
    (∫ t : ℝ in Set.Ioc 0 T, FactorialBinaryEnergy.energyRow N t) ≤ 9 * (N : ℝ)^2 * T^2 / 4 := by
  have hi : IntegrableOn (FactorialBinaryEnergy.energyRow N) (Set.Ioc 0 T) :=
    (FactorialBinaryIntegrability.energyRow_integrable N).mono_set Set.Ioc_subset_Ioi_self
  have hc : Continuous (fun t : ℝ => 9 * (N : ℝ)^2 * t / 2) := by fun_prop
  have hm : IntegrableOn (fun t : ℝ => 9 * (N : ℝ)^2 * t / 2) (Set.Ioc 0 T) :=
    hc.integrableOn_Icc.mono_set Set.Ioc_subset_Icc_self
  have hupper := integral_mono_ae hi hm (by
    filter_upwards [ae_restrict_mem measurableSet_Ioc] with t ht
    exact energy_row_linear N t ht.1)
  have he : (∫ t : ℝ in Set.Ioc 0 T, 9 * (N : ℝ)^2 * t / 2) = 9 * (N : ℝ)^2 * T^2 / 4 := by
    have hfun : (fun t : ℝ => 9 * (N : ℝ)^2 * t / 2) =
        (fun t : ℝ => (9 * (N : ℝ)^2 / 2) * t) := by funext t; ring
    rw [hfun, integral_const_mul, ← intervalIntegral.integral_of_le hT, integral_id]
    simp
    ring
  exact hupper.trans_eq he

/-- The actual restricted clock through inverse square-root horizon has linear energy. -/
theorem critical_clock_energy (N : ℕ) (hN : 0 < N) :
    (∫ t : ℝ in Set.Ioc 0 (1 / Real.sqrt (N : ℝ)), FactorialBinaryEnergy.energyRow N t) ≤
      9 * (N : ℝ) / 4 := by
  have hnR : (0 : ℝ) < N := by exact_mod_cast hN
  have hs := Real.sq_sqrt hnR.le
  have hsp := Real.sqrt_pos.mpr hnR
  have h := energy_band_bound N (1 / Real.sqrt (N : ℝ)) (by positivity)
  have he : 9 * (N : ℝ)^2 * (1 / Real.sqrt (N : ℝ))^2 / 4 = 9 * (N : ℝ) / 4 := by
    field_simp
    rw [hs]
  exact h.trans_eq he

/-- Signed escaping boundary on every finite clock, with the actual interior allowance. -/
theorem boundary_band_bound (N : ℕ) (T : ℝ) (hT : 0 ≤ T) :
    (∫ t : ℝ in Set.Ioc 0 T, boundaryRow N t) ≤
      9 * (N : ℝ)^2 * T^2 / 4 + (N : ℝ) * T / 4 := by
  exact (actual_boundary_band_upper N T hT).trans
    (add_le_add_right (energy_band_bound N T hT) _)

/-- Linear signed boundary budget through the actual inverse-square-root clock. -/
theorem critical_clock_boundary (N : ℕ) (hN : 0 < N) :
    (∫ t : ℝ in Set.Ioc 0 (1 / Real.sqrt (N : ℝ)), boundaryRow N t) ≤
      9 * (N : ℝ) / 4 + Real.sqrt (N : ℝ) / 4 := by
  have hnR : (0 : ℝ) < N := by exact_mod_cast hN
  have hs := Real.sq_sqrt hnR.le
  have hsp := Real.sqrt_pos.mpr hnR
  have h := (actual_boundary_band_upper N (1 / Real.sqrt (N : ℝ)) (by positivity)).trans
    (add_le_add_right (critical_clock_energy N hN) _)
  have he : (N : ℝ) * (1 / Real.sqrt (N : ℝ)) = Real.sqrt (N : ℝ) := by
    field_simp
    nlinarith
  simpa only [he] using h

/-- Complete integer dyad: an absolute positive horizon-square budget. -/
theorem dyadic_square_budget (X : ℕ) :
    (∑ N ∈ Ico X (2 * X), (N : ℝ)^2) ≤ 4 * (X : ℝ)^3 := by
  calc
    _ ≤ ∑ N ∈ Ico X (2 * X), ((2 * X : ℕ) : ℝ)^2 := by
      apply sum_le_sum
      intro N hN
      apply pow_le_pow_left₀ (Nat.cast_nonneg N)
      exact_mod_cast (mem_Ico.mp hN).2.le
    _ = _ := by
      have hc : (Ico X (2 * X)).card = X := by rw [Nat.card_Ico]; omega
      simp only [sum_const, nsmul_eq_mul, hc, Nat.cast_mul, Nat.cast_ofNat]
      ring

/-- Original restricted averaged energy on one common dyadic clock, with a fixed constant. -/
theorem dyadic_critical_energy (X : ℕ) (hX : 0 < X) :
    (∑ N ∈ Ico X (2 * X),
      ∫ t : ℝ in Set.Ioc 0 (1 / Real.sqrt ((2 * X : ℕ) : ℝ)), FactorialBinaryEnergy.energyRow N t) ≤
        9 * (X : ℝ)^2 / 2 := by
  have hxR : (0 : ℝ) < X := by exact_mod_cast hX
  have hpos : (0 : ℝ) < ((2 * X : ℕ) : ℝ) := by positivity
  have hs := Real.sq_sqrt hpos.le
  have hsp := Real.sqrt_pos.mpr hpos
  let T : ℝ := 1 / Real.sqrt ((2 * X : ℕ) : ℝ)
  have ht : 0 ≤ T := by dsimp [T]; positivity
  calc
    _ ≤ ∑ N ∈ Ico X (2 * X), 9 * (N : ℝ)^2 * T^2 / 4 :=
      sum_le_sum (fun N hN => energy_band_bound N T ht)
    _ = (9 * T^2 / 4) * ∑ N ∈ Ico X (2 * X), (N : ℝ)^2 := by
      rw [mul_sum]
      apply sum_congr rfl
      intro N hN
      ring
    _ ≤ (9 * T^2 / 4) * (4 * (X : ℝ)^3) :=
      mul_le_mul_of_nonneg_left (dyadic_square_budget X) (by positivity)
    _ = _ := by
      dsimp [T]
      field_simp
      rw [hs]
      push_cast
      ring

/-- Actual signed escaping boundary on that same common clock. -/
theorem dyadic_critical_boundary (X : ℕ) (hX : 0 < X) :
    (∑ N ∈ Ico X (2 * X),
      ∫ t : ℝ in Set.Ioc 0 (1 / Real.sqrt ((2 * X : ℕ) : ℝ)), boundaryRow N t) ≤
        9 * (X : ℝ)^2 / 2 +
          (X : ℝ) * (3 * (X : ℝ) - 1) / (8 * Real.sqrt ((2 * X : ℕ) : ℝ)) := by
  have hxR : (0 : ℝ) < X := by exact_mod_cast hX
  let T : ℝ := 1 / Real.sqrt ((2 * X : ℕ) : ℝ)
  have ht : 0 ≤ T := by dsimp [T]; positivity
  calc
    _ ≤ ∑ N ∈ Ico X (2 * X),
        ((∫ t : ℝ in Set.Ioc 0 T, FactorialBinaryEnergy.energyRow N t) + (N : ℝ) * T / 4) :=
      sum_le_sum (fun N hN => actual_boundary_band_upper N T ht)
    _ = (∑ N ∈ Ico X (2 * X), ∫ t : ℝ in Set.Ioc 0 T, FactorialBinaryEnergy.energyRow N t) +
        (T / 4) * ((X : ℝ) * (3 * (X : ℝ) - 1) / 2) := by
      rw [sum_add_distrib, ← real_dyadic_sum, mul_sum]
      congr 1
      apply sum_congr rfl
      intro N hN
      ring
    _ ≤ 9 * (X : ℝ)^2 / 2 + (T / 4) * ((X : ℝ) * (3 * (X : ℝ) - 1) / 2) :=
      add_le_add_right (dyadic_critical_energy X hX) _
    _ = _ := by dsimp [T]; ring

end BuildingBlocks.FactorialAbelClockEnergy
#print axioms BuildingBlocks.FactorialAbelClockEnergy.energy_row_linear
#print axioms BuildingBlocks.FactorialAbelClockEnergy.energy_band_bound
#print axioms BuildingBlocks.FactorialAbelClockEnergy.critical_clock_energy
#print axioms BuildingBlocks.FactorialAbelClockEnergy.boundary_band_bound
#print axioms BuildingBlocks.FactorialAbelClockEnergy.critical_clock_boundary

#print axioms BuildingBlocks.FactorialAbelClockEnergy.dyadic_square_budget
#print axioms BuildingBlocks.FactorialAbelClockEnergy.dyadic_critical_energy
#print axioms BuildingBlocks.FactorialAbelClockEnergy.dyadic_critical_boundary
