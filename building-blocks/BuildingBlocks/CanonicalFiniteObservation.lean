import Mathlib.Analysis.InnerProductSpace.Orthonormal
import Mathlib.Tactic

namespace PaidThetaCompensation

/-! Algebra for the canonical finite edge observation.  The analytic edge
measure and the exterior ground state remain explicit inputs. -/

/-- Finite normalized cell indicators give a coefficient-one observation;
this is exactly the Bessel step used after partitioning the labelled edge
space. -/
theorem canonical_cell_observation_le
    {E ι : Type*} [SeminormedAddCommGroup E] [InnerProductSpace ℂ E]
    {v : ι → E} (h : E) (s : Finset ι) (hv : Orthonormal ℂ v) :
    ∑ i ∈ s, ‖inner ℂ (v i) h‖ ^ 2 ≤ ‖h‖ ^ 2 :=
  hv.sum_inner_products_le h

/-- A complex observation of dimension `d` contributes two real rows per
coordinate, in addition to the mean and arrival rows. -/
def actualRealConstraintCount (d : ℕ) : ℕ := 2 + 2 * d

theorem four_real_constraints_iff_scalar (d : ℕ) :
    actualRealConstraintCount d = 4 ↔ d = 1 := by
  simp [actualRealConstraintCount]
  omega

/-- Retaining a coefficient-one finite observation in a lower bound does not
change its coefficient. -/
theorem coefficient_one_observation
    {full base gain observed : ℝ}
    (hfull : base + gain ≤ full)
    (hobs : observed ≤ gain) :
    base + observed ≤ full := by
  linarith

/-- The exact old affine optimizer has to be inserted before applying the
observation.  This elementary identity records the completion of the square. -/
theorem affine_optimizer_identity
    {Qff Qfq Qqq m c : ℂ}
    (hc : c = (Qfq + m) / Qqq) :
    (Qff - (Qfq + m) * star (Qfq + m) / Qqq) =
      Qff - c * star (Qfq + m) := by
  rw [hc]
  ring

end PaidThetaCompensation
