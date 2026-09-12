import BuildingBlocks.SuccessorMemoryKernel
import BuildingBlocks.PrimeSeedAllPrimeLevy

/-! Actual finite-prime memory commutators, retaining every prime-power cell. -/

open MeasureTheory Real Set

namespace BuildingBlocks.PrimeSeedMass

theorem seed_memLp_two {L : ℝ} (hL : 0 < L) : MemLp (seed L) 2 volume :=
  (memLp_two_iff_integrable_sq (measurable_seed L).aestronglyMeasurable).2
    (integrable_seed_square_and_integral hL).1

noncomputable def finitePrimeSeed (S : Finset Nat.Primes) (v : ℝ) : ℝ :=
  ∑ p ∈ S, seed (log p) v

theorem measurable_finitePrimeSeed (S : Finset Nat.Primes) : Measurable (finitePrimeSeed S) := by
  unfold finitePrimeSeed
  exact Finset.measurable_sum S (fun p _ => measurable_seed (log p))

theorem finitePrimeSeed_memLp_two (S : Finset Nat.Primes) :
    MemLp (finitePrimeSeed S) 2 volume := by
  apply memLp_finset_sum
  intro p _
  apply seed_memLp_two
  apply log_pos
  exact_mod_cast p.property.one_lt

/-- Every finite set of actual prime profiles belongs to the proved column
domain. No cutoff of the powers of an admitted prime is introduced. -/
theorem finitePrimeSeed_memory_commutator (S : Finset Nat.Primes) {f : ℝ → ℝ}
    (hf : MemLp f 2 (volume.restrict (Ioi (0 : ℝ)))) (v : ℝ) :
    SuccessorCharge.successor (SuccessorCharge.causalMemory (finitePrimeSeed S) f) v -
      SuccessorCharge.causalMemory (finitePrimeSeed S) (SuccessorCharge.successor f) v =
    ∫ u in Ioi (0 : ℝ), SuccessorCharge.memoryKernel (finitePrimeSeed S) v u * f u :=
  SuccessorCharge.successor_memory_commutator (measurable_finitePrimeSeed S)
    (finitePrimeSeed_memLp_two S) hf v

end BuildingBlocks.PrimeSeedMass
