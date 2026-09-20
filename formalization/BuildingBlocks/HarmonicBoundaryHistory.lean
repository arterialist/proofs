import BuildingBlocks.CompactWeilDivisorEnergyFinite
import BuildingBlocks.PrimeSignedAverage
import BuildingBlocks.PrimePrimitiveFormula

/-!
# Harmonic Mangoldt boundary as an exact prime-error history

Finite Abel summation rewrites the actual integer prime error through the
Balazard boundary. Every von Mangoldt prime power and every integer endpoint
is retained. The sign of the boundary is exposed as a separate hypothesis;
no cancellation estimate is asserted.
-/

open scoped BigOperators

namespace BuildingBlocks

open CoarsePrimitive MertensTransfer FloorCorrection
open CompactWeilDivisorEnergyFinite

noncomputable section

/-- The actual harmonic Mangoldt boundary at an integer cutoff. -/
def harmonicMangoldtBoundary (N : ℕ) : ℝ :=
  Real.log (N : ℝ) - logarithmicPrimeMass N

private theorem logarithmicPrimeMass_succ (N : ℕ) :
    logarithmicPrimeMass (N + 1) = logarithmicPrimeMass N +
      ArithmeticFunction.vonMangoldt (N + 1) / ((N + 1 : ℕ) : ℝ) := by
  unfold logarithmicPrimeMass
  rw [Finset.sum_Icc_succ_top (by omega : 1 ≤ N + 1)]

/-- The boundary follows the smooth logarithmic clock and jumps downward by
the complete von Mangoldt weight at each newly admitted integer. -/
theorem harmonicMangoldtBoundary_succ (N : ℕ) :
    harmonicMangoldtBoundary (N + 1) - harmonicMangoldtBoundary N =
      Real.log ((N + 1 : ℕ) : ℝ) - Real.log (N : ℝ) -
        ArithmeticFunction.vonMangoldt (N + 1) / ((N + 1 : ℕ) : ℝ) := by
  unfold harmonicMangoldtBoundary
  rw [logarithmicPrimeMass_succ]
  ring

/-- The deterministic factorial drift left after Abel summation. The `range`
includes `0`, whose real logarithm is Mathlib's value `0`. -/
def factorialPrimeDrift (N : ℕ) : ℝ :=
  (N : ℝ) * Real.log (N : ℝ) -
    ∑ k ∈ Finset.range N, Real.log (k : ℝ) - (N : ℝ)

/-- Exact finite Abel identity for the full prime-power counting function. -/
theorem psi_eq_harmonicPrimeMass_abel (N : ℕ) :
    psi N = (N : ℝ) * logarithmicPrimeMass N -
      ∑ k ∈ Finset.range N, logarithmicPrimeMass k := by
  induction N with
  | zero => simp [psi, logarithmicPrimeMass]
  | succ N ih =>
      rw [CoarsePrimitive.psi_succ, logarithmicPrimeMass_succ,
        Finset.sum_range_succ, ih]
      have hne : (((N + 1 : ℕ) : ℝ)) ≠ 0 := by positivity
      field_simp
      push_cast
      ring

/-- The integer prime error is exactly a deterministic factorial drift plus
the centered history of the harmonic Mangoldt boundary. -/
theorem integerError_eq_harmonicBoundary_history (N : ℕ) :
    integerError N = factorialPrimeDrift N -
        (N : ℝ) * harmonicMangoldtBoundary N +
      ∑ k ∈ Finset.range N, harmonicMangoldtBoundary k := by
  rw [integerError, psi_eq_harmonicPrimeMass_abel]
  unfold factorialPrimeDrift harmonicMangoldtBoundary
  rw [Finset.sum_sub_distrib]
  ring

/-- Finite summation by parts turns a present-value-minus-history expression
into a positive ramp applied to the signed successor transitions. -/
theorem neg_mul_add_history_eq_transition_sum (B : ℕ → ℝ) (N : ℕ) :
    -(N : ℝ) * B N + ∑ k ∈ Finset.range N, B k =
      ∑ k ∈ Finset.range N,
        ((k + 1 : ℕ) : ℝ) * (B k - B (k + 1)) := by
  induction N with
  | zero => simp
  | succ N ih =>
      rw [Finset.sum_range_succ, Finset.sum_range_succ, ← ih]
      push_cast
      ring

/-- The actual integer prime error is a deterministic factorial drift plus
a nonnegative ramp of the signed harmonic-boundary transitions. -/
theorem integerError_eq_harmonicBoundary_transition_sum (N : ℕ) :
    integerError N = factorialPrimeDrift N +
      ∑ k ∈ Finset.range N,
        ((k + 1 : ℕ) : ℝ) *
          (harmonicMangoldtBoundary k - harmonicMangoldtBoundary (k + 1)) := by
  rw [integerError_eq_harmonicBoundary_history]
  rw [← neg_mul_add_history_eq_transition_sum harmonicMangoldtBoundary N]
  ring

/-- Substitution of the exact successor law exposes every actual von Mangoldt
jump and the smooth logarithmic clock inside the transition representation. -/
theorem integerError_eq_primeTransition_sum (N : ℕ) :
    integerError N = factorialPrimeDrift N +
      ∑ k ∈ Finset.range N,
        ((k + 1 : ℕ) : ℝ) *
          (ArithmeticFunction.vonMangoldt (k + 1) / ((k + 1 : ℕ) : ℝ) -
            (Real.log ((k + 1 : ℕ) : ℝ) - Real.log (k : ℝ))) := by
  rw [integerError_eq_harmonicBoundary_transition_sum]
  apply congrArg (fun z : ℝ => factorialPrimeDrift N + z)
  apply Finset.sum_congr rfl
  intro k hk
  rw [show harmonicMangoldtBoundary k - harmonicMangoldtBoundary (k + 1) =
      -(harmonicMangoldtBoundary (k + 1) - harmonicMangoldtBoundary k) by ring,
    harmonicMangoldtBoundary_succ]
  ring

/-- Balazard's finite cutoff inequality is exactly nonnegativity of the
harmonic boundary used in the history formula. -/
theorem harmonicMangoldtBoundary_nonneg_of_balazardBoundAt
    {N : ℕ}
    (hB : CompactWeilDivisorEnergyFinite.BalazardBoundAt N) :
    0 ≤ harmonicMangoldtBoundary N := by
  unfold
    CompactWeilDivisorEnergyFinite.BalazardBoundAt
    CompactWeilDivisorEnergyFinite.mangoldtHarmonicSum at hB
  unfold harmonicMangoldtBoundary
  unfold logarithmicPrimeMass
  exact sub_nonneg.mpr hB

/-- The elementary factorial bounds place the actual harmonic boundary below
one at every positive integer cutoff. -/
theorem harmonicMangoldtBoundary_le_one {N : ℕ} (hN : 1 ≤ N) :
    harmonicMangoldtBoundary N ≤ 1 := by
  have h := (logarithmicPrimeMass_bounds hN).1
  unfold harmonicMangoldtBoundary
  linarith

/-- The published Balazard input and elementary factorial bounds constrain
every positive integer boundary value to the compact interval `[0,1]`. -/
theorem harmonicMangoldtBoundary_mem_unitInterval_of_balazardBoundAt
    {N : ℕ} (hN : 1 ≤ N)
    (hB : CompactWeilDivisorEnergyFinite.BalazardBoundAt N) :
    harmonicMangoldtBoundary N ∈ Set.Icc (0 : ℝ) 1 :=
  ⟨harmonicMangoldtBoundary_nonneg_of_balazardBoundAt hB,
    harmonicMangoldtBoundary_le_one hN⟩

/-- The literal discrete dyadic terminal mass: summing the integer prime
error over every cell and retaining the integral's half-cell density. -/
def discreteDyadicTerminalMass (X : ℕ) : ℝ :=
  (∑ k ∈ Finset.Ico X (2 * X), integerError k) - (X : ℝ) / 2

/-- Exact boundary-history expansion of the discrete dyadic terminal mass.
No estimate for the signed old-history/new-boundary cancellation is used. -/
theorem discreteDyadicTerminalMass_eq_boundary_history (X : ℕ) :
    discreteDyadicTerminalMass X =
      (∑ k ∈ Finset.Ico X (2 * X),
        (factorialPrimeDrift k -
            (k : ℝ) * harmonicMangoldtBoundary k +
          ∑ j ∈ Finset.range k, harmonicMangoldtBoundary j)) -
        (X : ℝ) / 2 := by
  unfold discreteDyadicTerminalMass
  apply congrArg (fun z : ℝ => z - (X : ℝ) / 2)
  apply Finset.sum_congr rfl
  intro k hk
  exact integerError_eq_harmonicBoundary_history k

/-- At every integer endpoint, the continuous primitive is the complete
sum of preceding integer errors with the exact half-cell density correction. -/
theorem primePrimitiveArea_nat_eq_sum_integerError (N : ℕ) :
    primePrimitiveArea (N : ℝ) =
      (∑ k ∈ Finset.range N, integerError k) - ((N : ℝ) - 1) / 2 := by
  induction N with
  | zero => simp [primePrimitiveArea, psi, integerError]
  | succ N ih =>
      have hstep : primePrimitiveArea ((N + 1 : ℕ) : ℝ) =
          primePrimitiveArea (N : ℝ) + integerError N - 1 / 2 := by
        unfold primePrimitiveArea integerError
        rw [Nat.floor_natCast, Nat.floor_natCast,
          CoarsePrimitive.psi_succ,
          Finset.sum_Icc_succ_top (by omega : 1 ≤ N + 1)]
        push_cast
        ring
      rw [hstep, ih, Finset.sum_range_succ]
      push_cast
      ring

/-- The discrete cell sum is the previously formalized literal continuous
dyadic terminal mass. This closes the endpoint convention exactly. -/
theorem coarseTerminalMassFinite_eq_discreteDyadicTerminalMass
    {X : ℕ} (hX : 1 ≤ X) :
    coarseTerminalMassFinite X = discreteDyadicTerminalMass X := by
  rw [← coarsePrefix_nat_double_eq_terminalMassFinite hX]
  rw [coarsePrefix_eq_area_sub (by exact_mod_cast hX)
    (by exact_mod_cast (show 1 ≤ 2 * X by omega))]
  have hcast : 2 * (X : ℝ) = ((2 * X : ℕ) : ℝ) := by norm_num
  rw [hcast]
  rw [primePrimitiveArea_nat_eq_sum_integerError,
    primePrimitiveArea_nat_eq_sum_integerError]
  unfold discreteDyadicTerminalMass
  have hsum := Finset.sum_Ico_eq_sub (f := integerError)
    (show X ≤ 2 * X by omega)
  rw [hsum]
  push_cast
  ring

/-- Exact Balazard-boundary representation of the literal continuous dyadic
terminal channel, with all old history and new boundary terms retained. -/
theorem coarseTerminalMassFinite_eq_harmonicBoundary_history
    {X : ℕ} (hX : 1 ≤ X) :
    coarseTerminalMassFinite X =
      (∑ k ∈ Finset.Ico X (2 * X),
        (factorialPrimeDrift k -
            (k : ℝ) * harmonicMangoldtBoundary k +
          ∑ j ∈ Finset.range k, harmonicMangoldtBoundary j)) -
        (X : ℝ) / 2 := by
  rw [coarseTerminalMassFinite_eq_discreteDyadicTerminalMass hX,
    discreteDyadicTerminalMass_eq_boundary_history]

/-- Exact transition form of the literal dyadic terminal channel. The nested
ramps are nonnegative; their arithmetic increments retain both signs. -/
theorem coarseTerminalMassFinite_eq_harmonicBoundary_transitions
    {X : ℕ} (hX : 1 ≤ X) :
    coarseTerminalMassFinite X =
      (∑ k ∈ Finset.Ico X (2 * X),
        (factorialPrimeDrift k +
          ∑ j ∈ Finset.range k,
            ((j + 1 : ℕ) : ℝ) *
              (harmonicMangoldtBoundary j -
                harmonicMangoldtBoundary (j + 1)))) -
        (X : ℝ) / 2 := by
  rw [coarseTerminalMassFinite_eq_discreteDyadicTerminalMass hX]
  unfold discreteDyadicTerminalMass
  apply congrArg (fun z : ℝ => z - (X : ℝ) / 2)
  apply Finset.sum_congr rfl
  intro k hk
  exact integerError_eq_harmonicBoundary_transition_sum k

#print axioms psi_eq_harmonicPrimeMass_abel
#print axioms integerError_eq_harmonicBoundary_history
#print axioms harmonicMangoldtBoundary_succ
#print axioms integerError_eq_harmonicBoundary_transition_sum
#print axioms discreteDyadicTerminalMass_eq_boundary_history
#print axioms coarseTerminalMassFinite_eq_harmonicBoundary_history
#print axioms coarseTerminalMassFinite_eq_harmonicBoundary_transitions

end

end BuildingBlocks
