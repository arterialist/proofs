# Catalog entry 357: scalar logarithmic-ratio and mass accounting

This page documents `formalization/BuildingBlocks/ChirpedBrunTitchmarshMass.lean`.

The file proves real logarithmic inequalities and scalar accounting bounds. The two names that suggest prime-mass theorems have the following scope:

```lean
theorem ordinary_prime_mass_le {u h logT loglogT : ℝ}
    (hhpos : 0 ≤ h)
    (hlog_ratio : sieveLogRatio logT loglogT ≤ 5)
    (h_ratio_bound : Real.log (u + h) / Real.log h ≤
      sieveLogRatio logT loglogT) :
    Real.log (u + h) * (2 * h / Real.log h) ≤ 10 * h

theorem short_interval_psi_mass_le (h : ℝ) :
    10 * h + 2 * h ≤ sieveConstant * h
```

The first is an implication from a supplied ratio bound. The second unfolds `sieveConstant = 12` and proves a linear identity/inequality. Neither theorem mentions primes, `π(x)`, `ArithmeticFunction.vonMangoldt`, or a short-interval sum. The module therefore does not formalize Brun–Titchmarsh or a von Mangoldt mass estimate.

Pinned Mathlib does contain the von Mangoldt function and identities such as `ArithmeticFunction.vonMangoldt_sum` and `vonMangoldt_le_log` in `Mathlib/NumberTheory/VonMangoldt.lean`; the audited module does not use them. A bounded search found no Brun–Titchmarsh declaration in the pinned tree, but that absence does not establish worldwide priority for these scalar lemmas.

- **Lean:** 4.24.0
- **Mathlib revision:** `f897ebcf72cd16f89ab4577d0c826cd14afaafc7`
- **Sorries:** 0
- **Reported axioms:** `[propext, Classical.choice, Quot.sound]`
