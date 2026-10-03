# Actual Möbius cofactor identities and conditional norm composition

The [mathematical note](../../../building-blocks/prime-distribution/mobius-low-cofactor-energy-explicit-bound.md) gives an explicit corollary of Ramaré--Zuniga-Alterman, [arXiv2603.25961v3](https://arxiv.org/abs/2603.25961v3), Lemmas2.6,4.5(iii),4.13. The written arithmetic bound is unconditional on the full stated range. The Lean module checks the finite identities and composition under three named source hypotheses; it does not prove those analytic inputs or RH.

The root project uses Lean4.24.0 and Mathlib `f897ebcf72cd16f89ab4577d0c826cd14afaafc7`. The public source is [ActualMobiusCoprimeHarmonic.lean](../../BuildingBlocks/ActualMobiusCoprimeHarmonic.lean); [the separate audit](../ActualMobiusCoprimeHarmonicAudit.lean) imports that public module.

`multipleHarmonic_reindex` and `multipleHarmonic_eq_coprime` hold for every natural cutoff and positive integer label. They retain the zero cutoff, unit and nonsquarefree labels. `multipleHarmonicReal_eq_coprime` holds for every real cutoff through Mathlib's floor-division identity. The actual functions use Mathlib's `ArithmeticFunction.moebius`.

`lowCofactorEnergy_le_of_source_estimates` proves the displayed numerical composition for every real `1 <= D <= X / 10^12`. Its premises are exactly `SourcePointwiseEstimate`, `SourceRootMeanEstimate D` and `SourceLogMeanEstimate D`; their definitions contain the actual coprime harmonic sum, finite prime-factor Euler products and numerical constants. These propositions are not axioms or discharged theorems. The source estimates, their computational verifications, and the continuous logarithm/monotonicity proof of the square-root-cutoff bound remain outside this finite kernel check.

From the repository root, reproduce the check with:

```sh
lake build BuildingBlocks.ActualMobiusCoprimeHarmonic
lake env lean formalization/verification/ActualMobiusCoprimeHarmonicAudit.lean
lake build
```

[acceptance.json](acceptance.json) records the checks, source hashes and mathematical boundary. [axioms.txt](axioms.txt) records the eight public audit rows. Only Lean's standard axioms `propext`, `Classical.choice` and `Quot.sound` are permitted. An audit of a conditional theorem does not discharge its ordinary proof arguments.

This is useful finite support for the attributed energy corollary. It supplies no full signed prime-error inequality, critical-sign premise or RH proof.
