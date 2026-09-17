import Mathlib.Analysis.InnerProductSpace.Basic
import Mathlib.Tactic

/-!
# Total prime-admission energy algebra

The four named terms match the literal old endpoint `E`, old nonendpoint
`Z`, new endpoint `W`, and admitted nonendpoint `D`.  The full source and
analytic tail enclosures are supplied separately in the written audit.
-/

namespace BuildingBlocks.PostBranchTotalAdmissionFinite

noncomputable section

/-- Exact total energy increment, including every old-source and admitted
nonendpoint cross.  The first parenthesized block is precisely the scoped
mixed-plus-endpoint expression of the post-branch audit. -/
theorem total_admission_expansion
    {H : Type*} [SeminormedAddCommGroup H] [InnerProductSpace ℝ H]
    (E Z W D : H) :
    ‖(E + Z) + (W + D)‖ ^ 2 - ‖E + Z‖ ^ 2 =
      (2 * inner ℝ D E + 2 * inner ℝ D W +
       2 * inner ℝ E W + ‖W‖ ^ 2) +
      2 * inner ℝ Z W + 2 * inner ℝ Z D + ‖D‖ ^ 2 := by
  simp only [norm_add_sq_real, inner_add_left, inner_add_right]
  rw [real_inner_comm E D, real_inner_comm W D]
  ring

/-- Four independent interval enclosures add to an enclosure for the total.
This is the finite algebra consumed by the rational interval checker. -/
theorem total_interval
    (mainBlock oldW oldD deltaSq : ℝ)
    (ls us lw uw ld ud lq uq : ℝ)
    (hs : ls ≤ mainBlock ∧ mainBlock ≤ us)
    (hw : lw ≤ oldW ∧ oldW ≤ uw)
    (hd : ld ≤ oldD ∧ oldD ≤ ud)
    (hq : lq ≤ deltaSq ∧ deltaSq ≤ uq) :
    ls + lw + ld + lq ≤ mainBlock + oldW + oldD + deltaSq ∧
    mainBlock + oldW + oldD + deltaSq ≤ us + uw + ud + uq := by
  constructor <;> linarith

end
end BuildingBlocks.PostBranchTotalAdmissionFinite

#print axioms BuildingBlocks.PostBranchTotalAdmissionFinite.total_admission_expansion
#print axioms BuildingBlocks.PostBranchTotalAdmissionFinite.total_interval
