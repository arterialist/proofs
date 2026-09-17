import BuildingBlocks.RHContinuation
import BuildingBlocks.CoarseContinuation
import BuildingBlocks.CoarseInitialIdentity

namespace BuildingBlocks.CoarsePrimitive

/-- The dyadic error-integral sum supplies the existing continuation
interface with its required normalization `G(s) = s * F(s)`. -/
theorem primeExtension_of_coarsePrimitiveBound (hb : CoarsePrimitiveBound) :
    HolomorphicPrimeExtension := by
  refine ⟨fun s => s * coarseMellinSum s, ?_, ?_⟩
  · intro s hs
    exact analyticAt_id.mul (coarseMellinSum_analytic hb s hs)
  · intro s hs
    exact coarseMellinSum_eq_logDerivative hs

/-- Conditional analytic sufficiency for the unchanged full mathlib RH.
The actual coarse primitive-energy growth condition is the sole hypothesis;
this theorem does not establish that condition. -/
theorem target_of_coarsePrimitiveBound (hb : CoarsePrimitiveBound) : Target :=
  target_of_holomorphicPrimeExtension (primeExtension_of_coarsePrimitiveBound hb)

end BuildingBlocks.CoarsePrimitive
