import Mathlib.Tactic
import Mathlib.NumberTheory.ArithmeticFunction

/-!
# Finite assembly algebra for the simultaneous Green expansion

This module contains only the exact finite algebra used after the analytic
estimates have supplied bounds for the named remainder packets.  In
particular, it neither asserts a prime number theorem nor an endpoint
asymptotic.
-/

namespace BuildingBlocks.SimultaneousGreenAssemblyFinite

open scoped BigOperators

/-- The actual Möbius coefficient of a nonsquarefree integer is zero.  This
records why prime powers do not form a nonzero part of the rough-composite
row. -/
theorem moebius_eq_zero_of_not_squarefree {n : ℕ} (hn : ¬ Squarefree n) :
    ArithmeticFunction.moebius n = 0 := by
  exact ArithmeticFunction.moebius_eq_zero_of_not_squarefree hn

/-- Every actual Möbius coefficient has absolute value at most one. -/
theorem abs_moebius_cast_le_one (n : ℕ) :
    |(ArithmeticFunction.moebius n : ℝ)| ≤ 1 := by
  exact_mod_cast ArithmeticFunction.abs_moebius_le_one (n := n)

/-- Exact assembly of the five non-endpoint errors and the complete endpoint
error in one normalization. -/
theorem exact_discrepancy_assembly
    (fullEnergy profileEnergy cross logX secondLog pnt sampling ceiling rough endpoint : ℝ)
    (hlog : logX ≠ 0)
    (hnonendpoint :
      fullEnergy - profileEnergy =
        -(4 / logX) * cross + secondLog + pnt + sampling + ceiling + rough + endpoint) :
    (fullEnergy - profileEnergy) - (-(4 / logX) * cross) =
      secondLog + pnt + sampling + ceiling + rough + endpoint := by
  rw [hnonendpoint]
  field_simp
  ring

/-- Triangle-inequality consumer for the complete assembled remainder. -/
theorem assembled_remainder_abs_le
    (secondLog pnt sampling ceiling rough endpoint
      Bsecond Bpnt Bsampling Bceiling Brough Bendpoint : ℝ)
    (hs : |secondLog| ≤ Bsecond) (hp : |pnt| ≤ Bpnt)
    (hsa : |sampling| ≤ Bsampling) (hc : |ceiling| ≤ Bceiling)
    (hr : |rough| ≤ Brough) (he : |endpoint| ≤ Bendpoint) :
    |secondLog + pnt + sampling + ceiling + rough + endpoint| ≤
      Bsecond + Bpnt + Bsampling + Bceiling + Brough + Bendpoint := by
  calc
    |secondLog + pnt + sampling + ceiling + rough + endpoint| ≤
        |secondLog| + |pnt| + |sampling| + |ceiling| + |rough| + |endpoint| := by
      rw [show secondLog + pnt + sampling + ceiling + rough + endpoint =
        ((((secondLog + pnt) + sampling) + ceiling) + rough) + endpoint by ring]
      exact (abs_add_le _ _).trans <| by
        gcongr
        exact (abs_add_le _ _).trans <| by
          gcongr
          exact (abs_add_le _ _).trans <| by
            gcongr
            exact (abs_add_le _ _).trans <| by
              gcongr
              exact abs_add_le _ _
    _ ≤ Bsecond + Bpnt + Bsampling + Bceiling + Brough + Bendpoint := by linarith

/-- Exact quadratic perturbation identity used to pass from a packet norm to
its energy. -/
theorem norm_sq_perturbation_identity (u r : ℝ) :
    (u + r) ^ 2 - u ^ 2 = 2 * u * r + r ^ 2 := by ring

/-- Absolute energy perturbation bound with no hidden orthogonality. -/
theorem abs_norm_sq_sub_le (u r : ℝ) :
    |(u + r) ^ 2 - u ^ 2| ≤ 2 * |u| * |r| + |r| ^ 2 := by
  rw [norm_sq_perturbation_identity]
  calc
    |2 * u * r + r ^ 2| ≤ |2 * u * r| + |r ^ 2| := abs_add_le _ _
    _ = 2 * |u| * |r| + |r| ^ 2 := by
      rw [abs_mul, abs_mul, abs_of_nonneg (by norm_num : (0 : ℝ) ≤ 2), abs_pow]

/-- A finite Minkowski consumer for any separately bounded rough packet. -/
theorem finite_rough_packet_norm_le
    {E : Type*} [SeminormedAddCommGroup E]
    (D : Finset ℕ) (packet : ℕ → E) (bound : ℕ → ℝ)
    (h : ∀ d ∈ D, ‖packet d‖ ≤ bound d) :
    ‖∑ d ∈ D, packet d‖ ≤ ∑ d ∈ D, bound d := by
  exact (norm_sum_le _ _).trans (Finset.sum_le_sum h)

end BuildingBlocks.SimultaneousGreenAssemblyFinite

#print axioms BuildingBlocks.SimultaneousGreenAssemblyFinite.moebius_eq_zero_of_not_squarefree
#print axioms BuildingBlocks.SimultaneousGreenAssemblyFinite.abs_moebius_cast_le_one
#print axioms BuildingBlocks.SimultaneousGreenAssemblyFinite.exact_discrepancy_assembly
#print axioms BuildingBlocks.SimultaneousGreenAssemblyFinite.assembled_remainder_abs_le
#print axioms BuildingBlocks.SimultaneousGreenAssemblyFinite.norm_sq_perturbation_identity
#print axioms BuildingBlocks.SimultaneousGreenAssemblyFinite.abs_norm_sq_sub_le
#print axioms BuildingBlocks.SimultaneousGreenAssemblyFinite.finite_rough_packet_norm_le
