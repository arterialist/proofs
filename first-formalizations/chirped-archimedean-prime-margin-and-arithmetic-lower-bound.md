# Catalog entry 353: scalar chirped margin bounds

This page documents `formalization/BuildingBlocks/ChirpedArithmeticArchimedeanMargin.lean`.

The module proves elementary exponential and logarithmic inequalities for the real-valued coefficients `netMarginCoeff` and `targetMarginCoeff`. Its main bridge is conditional:

```lean
theorem chirped_arithmetic_lower_bound_of_budget
    {Q_arith : ℝ → ℝ} {C_geom B C_tot : ℝ}
    (hC : 0 < C_geom) (hB : 2 * Real.log C_geom < B)
    (hbudget : ∀ᶠ T in atTop,
      netMarginCoeff C_geom B * Real.log T - C_tot ≤ Q_arith T) :
    ChirpedArithmeticLowerBound Q_arith (targetMarginCoeff C_geom B)
```

Thus Lean derives the target lower bound from the supplied eventual budget `hbudget`; it does not derive that budget from primes, an Archimedean term, or a wavepacket constellation. `makeArithmeticMarginCertificate` packages the same hypotheses. The file contains no prime sums or explicit-formula evaluation.

The real exponential and logarithmic infrastructure comes from the pinned Mathlib revision. This entry is a project-specific composition of those results. No worldwide formalization-priority claim is made.

- **Lean:** 4.24.0
- **Mathlib revision:** `f897ebcf72cd16f89ab4577d0c826cd14afaafc7`, from `lake-manifest.json`
- **Sorries:** 0
- **Reported axioms:** `[propext, Classical.choice, Quot.sound]`
