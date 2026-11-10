import BuildingBlocks.RiemannZetaFourThirtySixRatioDeficit
import BuildingBlocks.ActualCriticalLowerExcursion
import BuildingBlocks.ActualCriticalUpperSharpConstant
import BuildingBlocks.ActualCriticalSecondOrder
import BuildingBlocks.ActualCriticalLineAmplitude
import BuildingBlocks.ActualCriticalSharpOscillation
import BuildingBlocks.ActualCriticalGrowthCriterion
import BuildingBlocks.ActualCriticalZeroFreeCriterion

/-!
# Front door: what this repository proves without an unproved hypothesis

Every theorem in this file is a restatement `theorem name : statement := existing_proof`.
Each statement is written out in full so that it can be read against Mathlib. Nothing here
is new mathematics, and nothing here proves the Riemann hypothesis.

The file has three sections, each in its own namespace.

1. `BuildingBlocks.UnconditionalResults`: results with no hypothesis beyond the ranges of
   their variables.
2. `BuildingBlocks.UnconditionalResults.AboutAZero`: statements about a zero `ρ` of `ζ`.
   Their hypothesis is "`ρ` is a zero". The repository does not exhibit any zero.
3. `BuildingBlocks.UnconditionalResults.Criteria`: implications whose hypothesis is an
   estimate that is **not proved here**.

`formalization/verification/UnconditionalResultsAudit.lean` prints the axioms of every theorem
in this file and fails if any axiom other than `propext`, `Classical.choice`, `Quot.sound`
appears.

## The one repository definition that the statements keep

`BuildingBlocks.ActualCriticalMellin.W : ℝ → ℂ` is the arithmetic sum
`W x = ∑ d ∈ Finset.Icc 1 ⌊x⌋₊, √d * V (x / d)` (`ActualCriticalMellin.W_eq_Icc`), where
`V = ActualCenteredMellin.V` is a finite sum over prime powers up to the cutoff minus an
explicit baseline. `W` is real valued (`W_im` below) and, for `1 < s.re`, the Mellin transform
of `W` at `-s - 1` is `CriticalTransformPoles.transform s` (`ActualCriticalMellin.hasMellin_W`).
The statements below use `(W x).re`.

Other repository names are unfolded in the statements: `c₁` is written as
`8 / 9 - Real.eulerMascheroniConstant / 3`, and `ShiftedZetaMultiplier.M ρ` is written as
`riemannZeta (ρ + 1 / 2) / (ρ * (ρ + 1))`.
-/

set_option autoImplicit false

open Filter

namespace BuildingBlocks.UnconditionalResults

/-! ## Section 1. Unconditional results -/

/-- **Zero-free band.** `ζ` has no zero with `Re s > 1/2` and `0 < Im s ≤ 7.538`. -/
theorem riemannZeta_ne_zero_of_im_le_3769_div_500 :
    ∀ s : ℂ, 1 / 2 < s.re → 0 < s.im → s.im ≤ 3769 / 500 → riemannZeta s ≠ 0 :=
  fun _ hre him him' =>
    RiemannZetaFourThirtySixRatioDeficit.cumulative_zero_free_to_seven_five_three_eight
      hre him him'

/-- `ζ(1/2) ≠ 0`. -/
theorem riemannZeta_one_half_ne_zero : riemannZeta (((1 : ℝ) / 2 : ℝ) : ℂ) ≠ 0 :=
  ActualCriticalLowerExcursion.riemannZeta_half_ne_zero

/-- `ActualCriticalMellin.W` (the repository's arithmetic sum, see the file header) is real
valued. -/
theorem W_im : ∀ x : ℝ, (ActualCriticalMellin.W x).im = 0 :=
  ActualCriticalMellin.W_real

/-- **Lower excursion.** For every `C` and every `B` there is `x > B` with
`W x < -C x^(3/2)`. `ActualCriticalMellin.W` is the repository's arithmetic sum, see the file
header. -/
theorem exists_lower_excursion :
    ∀ C B : ℝ, ∃ x : ℝ, B < x ∧ (ActualCriticalMellin.W x).re < -(C * x ^ ((3 : ℝ) / 2)) :=
  ActualCriticalLowerExcursion.exists_lower_excursion

/-- Filter form of the lower excursion: for every `C`, `W x < -C x^(3/2)` holds for
arbitrarily large `x`. `ActualCriticalMellin.W` is the repository's arithmetic sum. -/
theorem frequently_lower_excursion :
    ∀ C : ℝ, ∃ᶠ x : ℝ in atTop, (ActualCriticalMellin.W x).re < -(C * x ^ ((3 : ℝ) / 2)) :=
  ActualCriticalLowerExcursion.frequently_lower_excursion

/-- **Sharp first-order constant, from both sides.** For every `ε > 0` and every `B` there is
`x > B` with `W x < -(1/6 - ε) x^(3/2) log² x` and there is `x > B` with
`-(1/6 + ε) x^(3/2) log² x < W x`. In words:
`liminf W x / (x^(3/2) log² x) ≤ -1/6 ≤ limsup W x / (x^(3/2) log² x)`.
`ActualCriticalMellin.W` is the repository's arithmetic sum. -/
theorem sharp_constant_two_sided :
    ∀ ε : ℝ, 0 < ε → ∀ B : ℝ,
      (∃ x : ℝ, B < x ∧ (ActualCriticalMellin.W x).re <
        -((1 / 6 - ε) * x ^ ((3 : ℝ) / 2) * (Real.log x) ^ 2)) ∧
      (∃ x : ℝ, B < x ∧ -((1 / 6 + ε) * x ^ ((3 : ℝ) / 2) * (Real.log x) ^ 2) <
        (ActualCriticalMellin.W x).re) :=
  fun _ hε B => ActualCriticalUpperSharpConstant.two_sided_sharp_constant hε B

/-- **Second-order constant, from both sides.** With `c₁ = 8/9 - γ/3` (`γ` the
Euler-Mascheroni constant), for every `ε > 0` and every `B` there is `x > B` with
`W x > -(1/6) x^(3/2) log² x + (c₁ - ε) x^(3/2) log x` and there is `x > B` with
`W x < -(1/6) x^(3/2) log² x + (c₁ + ε) x^(3/2) log x`.
`ActualCriticalMellin.W` is the repository's arithmetic sum. -/
theorem second_order_two_sided :
    ∀ ε : ℝ, 0 < ε → ∀ B : ℝ,
      (∃ x : ℝ, B < x ∧ -(1 / 6) * x ^ ((3 : ℝ) / 2) * (Real.log x) ^ 2 +
        (8 / 9 - Real.eulerMascheroniConstant / 3 - ε) * x ^ ((3 : ℝ) / 2) * Real.log x <
          (ActualCriticalMellin.W x).re) ∧
      (∃ x : ℝ, B < x ∧ (ActualCriticalMellin.W x).re <
        -(1 / 6) * x ^ ((3 : ℝ) / 2) * (Real.log x) ^ 2 +
          (8 / 9 - Real.eulerMascheroniConstant / 3 + ε) * x ^ ((3 : ℝ) / 2) * Real.log x) :=
  fun _ hε B => ActualCriticalSecondOrder.second_order_two_sided hε B

end BuildingBlocks.UnconditionalResults

namespace BuildingBlocks.UnconditionalResults.AboutAZero

/-! ## Section 2. Statements about a zero `ρ`

The hypothesis of each theorem is that `ρ` is a zero of `ζ` in a stated position. Zeros on
the critical line exist, but the repository does not exhibit one. A zero with `Re ρ > 1/2`
exists exactly when the Riemann hypothesis fails. -/

/-- **Amplitude forced by a zero on the critical line.** If `ζ ρ = 0` and `Re ρ = 1/2`, then
with `c₁ = 8/9 - γ/3` and `a = ‖ζ(ρ + 1/2) / (ρ (ρ + 1))‖`, for every `ε > 0` and `B` there is
`x > B` with `W x > -(1/6) x^(3/2) log² x + (c₁ + a - ε) x^(3/2) log x` and there is `x > B`
with `W x < -(1/6) x^(3/2) log² x + (c₁ - a + ε) x^(3/2) log x`.
`ActualCriticalMellin.W` is the repository's arithmetic sum. -/
theorem line_amplitude :
    ∀ ρ : ℂ, riemannZeta ρ = 0 → ρ.re = 1 / 2 → ∀ ε : ℝ, 0 < ε → ∀ B : ℝ,
      (∃ x : ℝ, B < x ∧ -(1 / 6) * x ^ ((3 : ℝ) / 2) * (Real.log x) ^ 2 +
        (8 / 9 - Real.eulerMascheroniConstant / 3 +
            ‖riemannZeta (ρ + 1 / 2) / (ρ * (ρ + 1))‖ - ε) * x ^ ((3 : ℝ) / 2) * Real.log x <
          (ActualCriticalMellin.W x).re) ∧
      (∃ x : ℝ, B < x ∧ (ActualCriticalMellin.W x).re <
        -(1 / 6) * x ^ ((3 : ℝ) / 2) * (Real.log x) ^ 2 +
          (8 / 9 - Real.eulerMascheroniConstant / 3 -
            ‖riemannZeta (ρ + 1 / 2) / (ρ * (ρ + 1))‖ + ε) * x ^ ((3 : ℝ) / 2) * Real.log x) :=
  fun _ hz hρ _ hε B => ActualCriticalLineAmplitude.line_amplitude hz hρ hε B

/-- **Oscillation forced by a zero off the line.** If `ζ ρ = 0` and `Re ρ > 1/2`, then for
every `C` both `W x > C x^(1 + Re ρ)` and `W x < -C x^(1 + Re ρ)` hold for arbitrarily large
`x`. `ActualCriticalMellin.W` is the repository's arithmetic sum. -/
theorem sharp_oscillation_of_zero :
    ∀ ρ : ℂ, riemannZeta ρ = 0 → 1 / 2 < ρ.re → ∀ C : ℝ,
      (∃ᶠ x : ℝ in atTop, C * x ^ (1 + ρ.re) < (ActualCriticalMellin.W x).re) ∧
      (∃ᶠ x : ℝ in atTop, (ActualCriticalMellin.W x).re < -(C * x ^ (1 + ρ.re))) :=
  fun _ hz hρ C => ActualCriticalSharpOscillation.sharp_oscillation_of_zero hz hρ C

end BuildingBlocks.UnconditionalResults.AboutAZero

namespace BuildingBlocks.UnconditionalResults.Criteria

/-! ## Section 3. Criteria (the hypothesis is not proved here)

Each theorem is an implication. Its hypothesis is a one-sided growth bound on `W` that the
repository does **not** prove. By `exists_lower_excursion` in Section 1 the mirrored bound
`-C x^(3/2) ≤ W x` is false for every `C`; the upper bound below is open and, by the first
criterion, at least as strong as the Riemann hypothesis. -/

/-- **Growth criterion.** If `W x ≤ C x^(3/2)` for all large `x`, for some `C`, then the
Riemann hypothesis holds. The hypothesis is not proved here.
`ActualCriticalMellin.W` is the repository's arithmetic sum. -/
theorem RiemannHypothesis_of_eventually_growth :
    ∀ C : ℝ, (∀ᶠ x : ℝ in atTop, (ActualCriticalMellin.W x).re ≤ C * x ^ ((3 : ℝ) / 2)) →
      RiemannHypothesis :=
  fun _ hgrow => ActualCriticalGrowthCriterion.RiemannHypothesis_of_eventually_growth hgrow

/-- **Growth criterion at level `θ`.** For `1/2 ≤ θ < 1` and `1 ≤ A`: if
`W x ≤ C x^(1 + θ)` for all `x > A`, then `ζ` has no zero with `Re ρ > θ`. The hypothesis is
not proved here. `ActualCriticalMellin.W` is the repository's arithmetic sum. -/
theorem zeroFree_of_power_growth :
    ∀ θ C A : ℝ, 1 / 2 ≤ θ → θ < 1 → 1 ≤ A →
      (∀ x : ℝ, A < x → (ActualCriticalMellin.W x).re ≤ C * x ^ (1 + θ)) →
      ∀ ρ : ℂ, θ < ρ.re → riemannZeta ρ ≠ 0 :=
  fun _ _ _ hθ hθ1 hA hgrow =>
    ActualCriticalZeroFreeCriterion.zeroFree_of_power_growth hθ hθ1 hA hgrow

end BuildingBlocks.UnconditionalResults.Criteria
