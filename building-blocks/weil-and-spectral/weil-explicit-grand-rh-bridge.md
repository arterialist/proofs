# RH from a supplied universal Weil evaluator and zeta symmetries

**Classification:** conditional logical assembly

**Lean module:** [`WeilExplicitGrandRHBridge.lean`](../../formalization/BuildingBlocks/WeilExplicitGrandRHBridge.lean)

`UniversalWeilSystem` assumes that every upper-half-plane zero to the right of the critical line produces a `WeilWavepacketEvaluation`. That evaluation already contains the exact identity and incompatible arithmetic and spectral bounds described in [the evaluation page](chirped-weil-explicit-admissibility.md).

Given this evaluator, a Schwarz-reflection package, and a real-axis nonvanishing package, the module applies trichotomy to the imaginary part. The upper branch calls the contradictory evaluation, the lower branch reflects to it, and the real branch uses the supplied nonvanishing result. Lean then derives `RightHalfZeroFree` and RH.

No `UniversalWeilSystem` is constructed. The module is a short conditional bridge, not a completed Weil explicit-formula proof. It substantially duplicates the trichotomy in `ZetaUniversalRHBridge.lean`; one generic lemma parameterized by an upper-half-plane exclusion hypothesis could replace both files.
