# Power-log contradiction from a supplied universal wavepacket evaluator

**Classification:** conditional bridge theorem

**Lean module:** [`ChirpedUniversalZeroRefutation.lean`](../formalization/BuildingBlocks/ChirpedUniversalZeroRefutation.lean)

For positive $\gamma$ and $d$, `UniversalZeroEvaluation gamma d` stores two real functions with an arithmetic lower bound, a spectral upper bound containing $-2bT^{2d}$, and exact equality. Carrier tuning selects a scale where those fields contradict each other. The theorem `refute_universal_evaluation` is sound.

The decisive global step is assumed by

```lean
UniversalZeroRefutationSystem.evaluator :
  ∀ s, 1 / 2 < s.re -> 0 < s.im -> riemannZeta s = 0 ->
    UniversalZeroEvaluation s.im (s.re - 1 / 2)
```

The module does not construct this evaluator or derive its inequalities from the Weil explicit formula. Its zero-exclusion and RH theorems are implications from the supplied system, reflection symmetry, and real-axis nonvanishing. Carrier tuning does not fill the analytic gap.

The checked contribution is an abstract contradiction and an exact statement of the missing interface. It is not a frequency-unconstrained elimination of zeta zeros.
