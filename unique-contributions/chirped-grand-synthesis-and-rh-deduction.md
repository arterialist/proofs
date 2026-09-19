# Power-log contradiction from a `GrandSynthesisSystem`

**Classification:** conditional certificate theorem

**Lean module:** [`ChirpedGrandSynthesis.lean`](../formalization/BuildingBlocks/ChirpedGrandSynthesis.lean)

The module proves several elementary buffer identities and a contradiction from supplied functions satisfying an arithmetic lower bound, a spectral decomposition, a logarithmic critical-line bound, a bounded continuous term, and a positive-power pair lower bound.

`GrandSynthesisSystem` is the conjunction of those analytic inputs for every positive displacement. It is a proposition, not a constructed object. The module proves

```lean
GrandSynthesisSystem -> RiemannHypothesis
```

by converting that assumption into another evaluator system. It does not establish the actual Weil-packet bounds that inhabit `GrandSynthesisSystem`.

The reusable content is the canonical buffer identity and the scalar power-log contradiction. Calling the file an end-to-end RH synthesis obscures the main open step, which is proving the system predicate for actual arithmetic and spectral quantities.
