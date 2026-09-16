import BuildingBlocks.CenteredGoldbachAdjacentTotalsFinite

/-!
# Exact finite even-total compensation from the centered heat square

The odd interior deficit, the odd cutoff transition, and all four raw
Goldbach components stay explicit. No PNT or scale-growth bound is assumed.
-/

namespace BuildingBlocks.CenteredGoldbachEvenCompensationFinite

open scoped BigOperators
open Finset Real
open BuildingBlocks.GoldbachHeat
open BuildingBlocks.CenteredGoldbachTruncatedHeat
open BuildingBlocks.CenteredGoldbachHeatScaleIncrementFinite

noncomputable section

private def totalSet (Y : ℕ) : Finset ℕ := Icc 2 (2 * Y)
private def evenSet (Y : ℕ) : Finset ℕ := (totalSet Y).filter Even
private def oddInteriorSet (Y : ℕ) : Finset ℕ :=
  (totalSet Y).filter (fun N => Odd N ∧ N ≤ Y + 1)
private def oddTransitionSet (Y : ℕ) : Finset ℕ :=
  (totalSet Y).filter (fun N => Odd N ∧ Y + 1 < N)

def oddInteriorPacket (Y : ℕ) (T : ℝ) : ℝ :=
  ∑ N ∈ oddInteriorSet Y, truncatedCoefficient Y N * shellKernel T N

def oddTransitionPacket (Y : ℕ) (T : ℝ) : ℝ :=
  ∑ N ∈ oddTransitionSet Y, truncatedCoefficient Y N * shellKernel T N

/-- The interior odd deficit retains the complete untruncated prime-power
Goldbach coefficient, psi endpoint, and exact density count. -/
def oddInteriorDeficit (Y : ℕ) (T : ℝ) : ℝ :=
  ∑ N ∈ oddInteriorSet Y,
    (2 * BuildingBlocks.CoarsePrimitive.psi (N - 1) - (N - 1 : ℕ) -
      shiftedPrimeGoldbach (N - 2)) * shellKernel T N

theorem oddScaleIncrement_eq_packets (Y : ℕ) (T : ℝ) :
    oddScaleIncrement Y T = oddInteriorPacket Y T + oddTransitionPacket Y T := by
  unfold oddScaleIncrement oddInteriorPacket oddTransitionPacket
    oddInteriorSet oddTransitionSet totalSet
  rw [← Finset.sum_filter_add_sum_filter_not
    ((Icc 2 (2 * Y)).filter Odd) (fun N => N ≤ Y + 1)]
  congr 1
  · apply Finset.sum_congr
    · ext N
      simp [and_assoc]
    · intro N hN
      rfl
  · apply Finset.sum_congr
    · ext N
      simp [and_assoc]
    · intro N hN
      rfl

theorem oddInteriorPacket_eq_neg_deficit (Y : ℕ) (T : ℝ) :
    oddInteriorPacket Y T = -oddInteriorDeficit Y T := by
  unfold oddInteriorPacket oddInteriorDeficit
  rw [← Finset.sum_neg_distrib]
  apply Finset.sum_congr rfl
  intro N hN
  have hmem := (Finset.mem_filter.mp hN).1
  have hN2 : 2 ≤ N := (Finset.mem_Icc.mp hmem).1
  have hNY : N ≤ Y + 1 := (Finset.mem_filter.mp hN).2.2
  rw [truncatedCoefficient_interior_prime_psi hN2 hNY]
  ring

theorem finiteShell_nonneg (Y : ℕ) {T : ℝ} (hT : 0 ≤ T) :
    0 ≤ finiteHeatScaleIncrement Y T := by
  rw [finiteHeatScaleIncrement_eq_integral]
  apply intervalIntegral.integral_nonneg
  · apply exp_le_exp.mpr
    linarith
  · intro t ht
    exact sq_nonneg _

/-- Every finite positive heat shell forces the even centered packet to
pay the odd interior deficit after the odd transition packet is retained. -/
theorem evenPacket_compensates_odd (Y : ℕ) {T : ℝ} (hT : 0 ≤ T) :
    oddInteriorDeficit Y T - oddTransitionPacket Y T ≤ evenScaleIncrement Y T := by
  have hnonneg := finiteShell_nonneg Y hT
  rw [finiteHeatScaleIncrement_parity, oddScaleIncrement_eq_packets,
    oddInteriorPacket_eq_neg_deficit] at hnonneg
  linarith

def evenPrimePacket (Y : ℕ) (T : ℝ) : ℝ :=
  ∑ N ∈ evenSet Y, truncatedPrimeCoefficient Y N * shellKernel T N

def evenLeftMarginalPacket (Y : ℕ) (T : ℝ) : ℝ :=
  ∑ N ∈ evenSet Y, truncatedLeftMarginal Y N * shellKernel T N

def evenRightMarginalPacket (Y : ℕ) (T : ℝ) : ℝ :=
  ∑ N ∈ evenSet Y, truncatedRightMarginal Y N * shellKernel T N

def evenPairCountPacket (Y : ℕ) (T : ℝ) : ℝ :=
  ∑ N ∈ evenSet Y, truncatedPairCount Y N * shellKernel T N

theorem evenScaleIncrement_decomposition (Y : ℕ) (T : ℝ) :
    evenScaleIncrement Y T =
      evenPrimePacket Y T - evenLeftMarginalPacket Y T -
        evenRightMarginalPacket Y T + evenPairCountPacket Y T := by
  unfold evenScaleIncrement evenPrimePacket evenLeftMarginalPacket
    evenRightMarginalPacket evenPairCountPacket evenSet totalSet
  simp_rw [truncatedCoefficient_decomposition]
  simp only [sub_mul, add_mul, Finset.sum_sub_distrib, Finset.sum_add_distrib]

/-- Exact arithmetic lower bound for the weighted even prime-prime
Goldbach packet. The odd cutoff transition remains signed and explicit. -/
theorem evenPrimePacket_lower (Y : ℕ) {T : ℝ} (hT : 0 ≤ T) :
    evenLeftMarginalPacket Y T + evenRightMarginalPacket Y T -
        evenPairCountPacket Y T + oddInteriorDeficit Y T -
        oddTransitionPacket Y T ≤ evenPrimePacket Y T := by
  have hcomp := evenPacket_compensates_odd Y hT
  rw [evenScaleIncrement_decomposition] at hcomp
  linarith

#print axioms oddScaleIncrement_eq_packets
#print axioms oddInteriorPacket_eq_neg_deficit
#print axioms finiteShell_nonneg
#print axioms evenPacket_compensates_odd
#print axioms evenScaleIncrement_decomposition
#print axioms evenPrimePacket_lower

end
end BuildingBlocks.CenteredGoldbachEvenCompensationFinite
