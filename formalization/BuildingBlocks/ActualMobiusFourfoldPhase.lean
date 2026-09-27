import Mathlib.Tactic

/-!
# Oriented phase of the completed high fourfold block

This checks the elementary change of variables used in equation (17) of
`actual-mobius-double-q-fourfold-resonance-bound.md` and equation (4) of
`actual-mobius-product-divisor-centering.md`. With the Fourier convention
`sum f(j) = sum_m integral f(t) e(-m*t) dt`, the stationary `k,k'` modes
are `(-ell,+ell')`. The identity keeps the first coefficient attached to
the `k/n` side. It does not formalize Poisson summation or an estimate.
-/

namespace BuildingBlocks.ActualMobiusFourfoldPhase

/-- The phase after introducing the mean and difference coordinates. -/
theorem oriented_phase (C A A' s z : ℝ) :
    -C * z + A * (s + z / 2) - A' * (s - z / 2) =
      (A - A') * s - (C - (A + A') / 2) * z := by
  ring

/-- The same phase directly from the original `k/n`, `k'/n'` variables. -/
theorem oriented_phase_from_ratios
    (C ell ell' k k' n n' : ℝ) (hn : n ≠ 0) (hn' : n' ≠ 0) :
    -C * (k / n - k' / n') + ell * k - ell' * k' =
      (ell * n - ell' * n') * ((k / n + k' / n') / 2) -
        (C - (ell * n + ell' * n') / 2) * (k / n - k' / n') := by
  field_simp
  ring

end BuildingBlocks.ActualMobiusFourfoldPhase

#print axioms BuildingBlocks.ActualMobiusFourfoldPhase.oriented_phase
#print axioms BuildingBlocks.ActualMobiusFourfoldPhase.oriented_phase_from_ratios
