# RH consequence package and conditional constructors

This page documents catalog entry 387 and `formalization/BuildingBlocks/RiemannZetaMasterGrandUnification.lean`. The source filename remains for compatibility; its canonical API is `RHConsequences`.

## Logical status

`RHConsequences` stores `rh : RiemannHypothesis` as its first field and packages consequences and equivalent formulations:

```lean
structure RHConsequences where
  rh : RiemannHypothesis
  target : Target
  right_free : RightHalfZeroFree
  high_freq_one : HighFrequencyZeroFree 1
  upper_quadrant_free : ∀ s : ℂ,
    1 / 2 < s.re → 1 < s.im → riemannZeta s ≠ 0
  confinement : SpectralSupportConfinement
  right_offline_empty : RightOfflineSupport = ∅
  left_offline_empty : LeftOfflineSupport = ∅
  zero_trichotomy : ∀ s : ℂ, riemannZeta s = 0 →
    s = 1 ∨ (∃ n : ℕ, s = -2 * (n + 1)) ∨ s.re = 1 / 2
```

The package is equivalent to RH because it contains RH:

```lean
theorem nonempty_rhConsequences_iff_RiemannHypothesis :
    Nonempty RHConsequences ↔ RiemannHypothesis
```

`rh_equivalent_conditions` collects equivalences among `RiemannHypothesis`, `Target`, `RightHalfZeroFree`, `HighFrequencyZeroFree 1`, upper-quadrant zero-freeness, support emptiness, and `SpectralSupportConfinement`. These are logical equivalences among predicates defined or proved in imported modules; the theorem does not establish any predicate unconditionally.

## Constructors and hypotheses

The direct constructors are:

- `rhConsequences_of_RH`
- `rhConsequences_of_target`
- `rhConsequences_of_rightHalfZeroFree`
- `rhConsequences_of_highFrequencyZeroFree`
- `rhConsequences_of_upper_quadrant`
- `rhConsequences_of_confinement`
- `rhConsequences_of_right_offline_empty`
- `rhConsequences_of_offline_empty`

Each takes a premise equivalent to, or sufficient for, RH. The operator-named and spectral constructors likewise require an explicit `sys` value:

- `rhConsequences_of_autonomous_weil`
- `rhConsequences_of_autonomous_operator`
- `rhConsequences_of_autonomous_fredholm`
- `rhConsequences_of_autonomous_carleman`
- `rhConsequences_of_autonomous_linear_bridge`
- `rhConsequences_of_autonomous_canonical`
- `rhConsequences_of_high_frequency_fredholm`
- `rhConsequences_of_high_frequency_refutation`
- `rhConsequences_of_high_frequency_grand_synthesis`
- `rhConsequences_of_universal_fredholm`
- `rhConsequences_of_universal_refutation`
- `rhConsequences_of_grand_synthesis`

This module constructs none of those systems. Whether a system represents a genuine operator, determinant, or analytic evaluation must be assessed from that system's defining module; its name alone is not evidence.

## Conditional zero classification

```lean
theorem riemann_zeta_zero_trichotomy
    (h_rh : RiemannHypothesis) (s : ℂ)
    (hz : riemannZeta s = 0) :
    s = 1 ∨ (∃ n : ℕ, s = -2 * (n + 1)) ∨ s.re = 1 / 2
```

The critical-line branch uses the explicit hypothesis `h_rh`. The value `s = 1` reflects Mathlib's convention for `riemannZeta` at the pole.

## Compatibility identifiers

`MasterGrandUnification` is now an abbreviation for `RHConsequences`. The `masterGrandUnification_of_*` names and `master_grand_unification_iff_RiemannHypothesis` are compatibility aliases for downstream code. New documentation should use the `RHConsequences` names.

- **Lean:** 4.24.0
- **Mathlib revision:** `f897ebcf72cd16f89ab4577d0c826cd14afaafc7`, from `lake-manifest.json`
- **Sorries:** 0
- **Reported axioms:** `[propext, Classical.choice, Quot.sound]`
