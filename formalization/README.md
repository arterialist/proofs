# Lean formalization

[BuildingBlocks.lean](BuildingBlocks.lean) imports the theorem modules. The [verification folder](verification/) contains the audit files and supporting build records. Import names remain under `BuildingBlocks`; the Lake source directory is `formalization`.

From the repository root, run `lake exe cache get` and `lake build`. To check the axiom audit directly, run `lake env lean formalization/verification/Audit.lean`.

Compiled Lean theorems should be read with their hypotheses. In particular, a theorem deriving RH from an arithmetic bound does not establish that bound.
