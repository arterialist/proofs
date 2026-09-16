import BuildingBlocks.FactorialHOneFinite
import BuildingBlocks.ResidueLoadingSuccessor

/-!
# Finite factorial ground and complete residue loading

This identifies the existing positive residue loading with the original
factorial ground. It retains every von Mangoldt prime-power mass and
the integer endpoint. It makes no RH-scale estimate.
-/

namespace BuildingBlocks.FactorialResidueFinite

open BuildingBlocks.FactorialHOneFinite
open BuildingBlocks.ResidueLoadingSuccessor
open BuildingBlocks.FloorCorrection
open BuildingBlocks.CoarsePrimitive

/-- The exact finite identity behind the one-sided factorial-ground
criterion. No asymptotic estimate enters. -/
theorem ground_eq_residue_loading (N : ℕ) (hN : 0 < N) :
    (N : ℝ) * fFinite N =
      (N : ℝ) * Real.log N - Real.log (N.factorial : ℝ) + loading N := by
  have hNr : (N : ℝ) ≠ 0 := by exact_mod_cast (Nat.ne_of_gt hN)
  rw [loading_eq_factorial]
  rw [← logFactorial_eq_log]
  simp only [fFinite, psiFinite, logPrimeFinite,
    psi_eq_sum_Icc, logarithmicPrimeMass]
  field_simp
  ring

end BuildingBlocks.FactorialResidueFinite
