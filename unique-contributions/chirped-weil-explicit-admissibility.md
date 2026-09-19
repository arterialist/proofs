# Contradiction in a supplied Weil wavepacket evaluation

**Classification:** conditional certificate theorem

**Lean module:** [`ChirpedWeilExplicitAdmissibility.lean`](../formalization/BuildingBlocks/ChirpedWeilExplicitAdmissibility.lean)

A `WeilWavepacketEvaluation s` includes a zeta-zero hypothesis, two real functions, their exact equality, a spectral upper bound with a negative linear term, and an arithmetic lower bound. The previous scalar modules show that those fields are inconsistent, so Lean proves

```lean
WeilWavepacketEvaluation s -> False.
```

This is a useful interface specification. It says exactly which analytic estimates would suffice for the proposed chirped argument. The module does not derive those estimates from the classical Weil explicit formula and does not construct an evaluation for any zero candidate.

The global results make the missing step explicit. They require an evaluator that assigns `WeilWavepacketEvaluation s` to every high-frequency off-line zero, together with a low-frequency certificate. `WeilGlobalSynthesisCertificate` merely bundles those assumptions. Hence the RH declarations are conditional certificate reductions.

The standard unit configuration proves positivity of chosen numerical parameters. It does not validate the arithmetic or spectral inequalities for actual wavepackets. The main open task is still the analytic construction of the evaluator.
