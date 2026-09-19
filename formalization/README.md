# Lean formalization

[BuildingBlocks.lean](BuildingBlocks.lean) imports the theorem modules. The [verification folder](verification/) contains the audit files and supporting build records. Import names remain under `BuildingBlocks`; the Lake source directory is `formalization`.

From the repository root, run `lake exe cache get` and `lake build`. To check the axiom audit directly, run `lake env lean formalization/verification/Audit.lean`.

Compiled Lean theorems should be read with their hypotheses. In particular, a theorem deriving RH from an arithmetic bound does not establish that bound.

The exponent and support algebra for the complete three-factor Möbius prefix extension is in [ActualMobiusK3BottomSlice.lean](BuildingBlocks/ActualMobiusK3BottomSlice.lean), with its declaration and axiom audit in [ActualMobiusK3BottomSliceAudit.lean](verification/ActualMobiusK3BottomSliceAudit.lean). The external Robert--Sargos and Bordellès estimates remain written analytic inputs.

The same applies to records and interfaces: an explicit `h_rh`, `sys`, or `evaluator` argument remains a premise, and defining a scalar or finite-dimensional model with operator or Fredholm terminology does not construct the corresponding analytic operator. In the imported threshold chain, the unconditional cumulative zero-free theorem currently reaches height `1493 / 200 = 7.465`; extensions above that height use supplied slab or high-frequency evaluation hypotheses. The imported proper-cofactor algebra does not include a proved signed cofactor estimate.
