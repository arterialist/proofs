import Mathlib.Tactic

open scoped BigOperators

namespace PaidThetaCompensation

/-!
Finite algebra used by the boundary-packet obstruction to a constrained
Hardy estimate. Analytic form estimates and convergence of constraint
coefficients remain hypotheses of the consumer.
-/

variable {V : Type*} [AddCommGroup V] [Module ℝ V]

/-- Subtract a finite dual family to impose all linear constraints exactly. -/
noncomputable def constraintCorrected {n : ℕ}
    (L : Fin n → V →ₗ[ℝ] ℝ) (z : Fin n → V) (x : V) : V :=
  x - ∑ j, (L j x) • z j

/-- A biorthogonal corrector family kills every constraint. -/
theorem constraintCorrected_mem_kernel {n : ℕ}
    (L : Fin n → V →ₗ[ℝ] ℝ) (z : Fin n → V) (x : V)
    (hdual : ∀ i j, L i (z j) = if i = j then 1 else 0) :
    ∀ i, L i (constraintCorrected L z x) = 0 := by
  intro i
  simp [constraintCorrected, hdual]

/-- The scalar growth comparison behind the endpoint obstruction. Writing
`t = sqrt(log(1/epsilon))`, the pulled weight is cubic in `t`, while the
logarithmic core energy is at most quadratic. -/
theorem cubic_weight_beats_quadratic_energy
    {c C D t port energy : ℝ}
    (hD : 0 ≤ D) (ht : 1 ≤ t)
    (hthreshold : C + D < c * t)
    (hport : c * t^3 ≤ port)
    (henergy : energy ≤ C * t^2 + D) :
    energy < port := by
  have ht2 : 1 ≤ t^2 := by nlinarith
  have hDt : D ≤ D * t^2 := by nlinarith
  have hsum : C * t^2 + D ≤ (C + D) * t^2 := by nlinarith
  have htpos : 0 < t := lt_of_lt_of_le zero_lt_one ht
  have hstrict : (C + D) * t^2 < c * t^3 := by
    nlinarith [mul_lt_mul_of_pos_right hthreshold (sq_pos_of_pos htpos)]
  linarith

/-- A finite constraint correction cannot repair a growth mismatch when its
additional energy has a fixed ceiling. -/
theorem corrected_packet_failure
    {c C D t port rawEnergy correctionEnergy correctedEnergy : ℝ}
    (hD : 0 ≤ D) (ht : 1 ≤ t)
    (hthreshold : C + D < c * t)
    (hport : c * t^3 ≤ port)
    (hraw : rawEnergy ≤ C * t^2)
    (hcorr : correctionEnergy ≤ D)
    (htotal : correctedEnergy ≤ rawEnergy + correctionEnergy) :
    correctedEnergy < port := by
  apply cubic_weight_beats_quadratic_energy hD ht hthreshold hport
  linarith

/-- If the correction is supported away from the packet, its nonnegative
weighted cost adds rather than cancelling the packet cost. -/
theorem disjoint_weight_keeps_packet_lower_bound
    {packet correction total : ℝ}
    (hcorrection : 0 ≤ correction)
    (htotal : total = packet + correction) :
    packet ≤ total := by
  linarith

end PaidThetaCompensation

#print axioms PaidThetaCompensation.constraintCorrected_mem_kernel
#print axioms PaidThetaCompensation.cubic_weight_beats_quadratic_energy
#print axioms PaidThetaCompensation.corrected_packet_failure
#print axioms PaidThetaCompensation.disjoint_weight_keeps_packet_lower_bound
