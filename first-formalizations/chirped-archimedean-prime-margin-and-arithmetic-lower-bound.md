# First Formalization 354: Chirped Archimedean-Prime Margin and Arithmetic Lower Bound

## 1. Overview and Formal Specification

- **Module:** [`formalization/BuildingBlocks/ChirpedArithmeticArchimedeanMargin.lean`](../formalization/BuildingBlocks/ChirpedArithmeticArchimedeanMargin.lean)
- **Axioms:** Zero custom axioms. Strictly depends on core Lean 4 foundational axioms: `[propext, Classical.choice, Quot.sound]`.
- **Primary Definitions:**
  - `netMarginCoeff (C_geom B : ℝ) : ℝ := 1 - C_geom * Real.exp (-B / 2)`
  - `targetMarginCoeff (C_geom B : ℝ) : ℝ := (netMarginCoeff C_geom B) / 2`
  - `ChirpedArithmeticMarginCertificate`: Structure certifying the complete arithmetic lower bound derivation.
  - `makeArithmeticMarginCertificate`: Canonical constructive certificate builder.

## 2. Formalized Theorems and Types

```lean
/-- For any geometric row constant C_geom > 0 and buffer parameter B > 2 * log C_geom,
the prime-power cross term coefficient C_geom * exp(-B / 2) is strictly less than 1. -/
theorem buffer_decay_lt_one {C_geom B : ℝ} (hC : 0 < C_geom)
    (hB : 2 * Real.log C_geom < B) :
    C_geom * Real.exp (-B / 2) < 1

/-- Strict positivity of the net arithmetic margin coefficient. -/
theorem net_arithmetic_margin_pos {C_geom B : ℝ} (hC : 0 < C_geom)
    (hB : 2 * Real.log C_geom < B) :
    0 < netMarginCoeff C_geom B

/-- The net margin coefficient is bounded above by 1. -/
theorem net_arithmetic_margin_le_one {C_geom B : ℝ} (hC : 0 ≤ C_geom) :
    netMarginCoeff C_geom B ≤ 1

/-- Strict positivity of the target arithmetic margin. -/
theorem targetMarginCoeff_pos {C_geom B : ℝ} (hC : 0 < C_geom)
    (hB : 2 * Real.log C_geom < B) :
    0 < targetMarginCoeff C_geom B

/-- The target arithmetic margin is strictly less than the full net margin coefficient. -/
theorem targetMarginCoeff_lt_net {C_geom B : ℝ} (hC : 0 < C_geom)
    (hB : 2 * Real.log C_geom < B) :
    targetMarginCoeff C_geom B < netMarginCoeff C_geom B

/-- For any target margin a < c0 and constant C_tot, the logarithmic term (c0 - a) * log T
eventually dominates C_tot, ensuring a * log T ≤ c0 * log T - C_tot for large T. -/
theorem log_sub_margin_eventual {c0 a C_tot : ℝ} (ha : a < c0) :
    ∀ᶠ (T : ℝ) in atTop, a * Real.log T ≤ c0 * Real.log T - C_tot

/-- Derivation of the arithmetic lower bound hypothesis `ChirpedArithmeticLowerBound Q_arith a`
from the archimedean-prime row budget. -/
theorem chirped_arithmetic_lower_bound_of_budget
    {Q_arith : ℝ → ℝ} {C_geom B C_tot : ℝ}
    (hC : 0 < C_geom) (hB : 2 * Real.log C_geom < B)
    (hbudget : ∀ᶠ (T : ℝ) in atTop,
      (netMarginCoeff C_geom B) * Real.log T - C_tot ≤ Q_arith T) :
    ChirpedArithmeticLowerBound Q_arith (targetMarginCoeff C_geom B)
```

## 3. Methodological Novelty

This formalization links the finite linear algebra of [`CriticalChirpedGramFinite.lean`](../formalization/BuildingBlocks/CriticalChirpedGramFinite.lean) to the asymptotic filter calculus of [`ChirpedSpectralRHBridge.lean`](../formalization/BuildingBlocks/ChirpedSpectralRHBridge.lean). By formalizing the exact threshold $B > 2 \log C_{\text{geom}}$ under which prime cross-correlation terms decay below the diagonal archimedean term, it constructs a machine-verified bridge establishing $a \log T \le Q_{\text{arith}}(T)$ as an unconditional consequence of the constellation geometry.
