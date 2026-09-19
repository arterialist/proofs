# Half-scaled chirped trace discrepancy under assumed coercive bounds

**Classification:** conditional reformulation, not an operator resolvent theorem

**Lean module:** [`ChirpedCarlemanResolventBound.lean`](../formalization/BuildingBlocks/ChirpedCarlemanResolventBound.lean)

The module proves scalar consequences of assumed trace bounds. It does not formalize Carleman's determinant inequality, a Hilbert-Schmidt operator, a resolvent, or a zeta-related operator family.

The actual definitions are

```lean
def LogCarlemanDeterminant ... :=
  (1 / 2) * (T_arith T c - T_spec T c)

def RegularizedCarlemanDeterminant ... :=
  Real.exp (-(LogCarlemanDeterminant ...))
```

Thus the named determinant is a real exponential of half a scalar trace difference. `CarlemanSpectralBalance` says this difference vanishes. The equivalences with `FredholmSpectralBalance` and `WeilTraceEquivalence` follow from those definitions.

`log_carleman_lower_bound` and `refute_carleman_balance` are valid once `ArithmeticCoercivity` and `SpectralTraceZeroBound` are assumed. Those predicates already contain the lower and upper inequalities that create the contradiction. `CarlemanResolventEvaluation` packages the same hypotheses for a candidate point. It has no resolvent field and no proof that a zeta zero produces such an evaluation.

Likewise, `CarlemanResolventSystem` assumes both low-height zero-freeness and an evaluator for every relevant high-height candidate. Its RH theorem has the conditional type

```lean
CarlemanResolventSystem -> RiemannHypothesis
```

The checked result is a scalar reduction from a strong analytic certificate to a contradiction. The classical Carleman formulas previously quoted on this page were not declarations in the cited Lean module and have been removed. No novelty or priority conclusion follows from the present bounded source check.
