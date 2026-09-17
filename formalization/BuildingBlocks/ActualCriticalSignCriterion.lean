import BuildingBlocks.ActualCriticalConvergence
import BuildingBlocks.CriticalTransformContinuationRH

open Filter
open scoped Topology

namespace BuildingBlocks.ActualCriticalSignCriterion

/-- Eventual nonpositivity of the actual arithmetic W implies the full
Riemann hypothesis. The sign is the explicit, still unproved arithmetic premise;
all Mellin, positive-measure Landau, continuation, and multiplicity steps are proved. -/
theorem RiemannHypothesis_of_nonpos_after {A : ℝ} (hA : 1 ≤ A)
    (hsign : ∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ 0) :
    RiemannHypothesis :=
  CriticalTransformContinuationRH.RiemannHypothesis_of_holomorphic_continuation
    (ActualCriticalConvergence.continuation_analyticOnNhd hA hsign)
    (fun s hs => ActualCriticalConvergence.continuation_eq_filledTransform hA hsign hs)

/-- Filter form of the actual eventual-sign criterion, with no chosen cutoff
or hidden convergence hypothesis left in the premise. -/
theorem RiemannHypothesis_of_eventually_nonpos
    (hsign : ∀ᶠ x : ℝ in atTop, (ActualCriticalMellin.W x).re ≤ 0) :
    RiemannHypothesis := by
  obtain ⟨A, hA, hs⟩ := ActualCriticalConvergence.cutoff_of_eventually_nonpos hsign
  exact RiemannHypothesis_of_nonpos_after hA hs

end BuildingBlocks.ActualCriticalSignCriterion
