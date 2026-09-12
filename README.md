# Proofs

Mathematical proofs, Lean 4 formalizations and precisely stated investigations arising from work on the Riemann hypothesis. The collection preserves useful known results, different proofs, counterexamples and explicitly incomplete arguments. RH remains unproved.

| Directory | Contents |
| --- | --- |
| [unique-contributions](unique-contributions/) | Original mathematical results, with proofs and comparisons to prior work. |
| [first-formalizations](first-formalizations/) | First formalizations of known mathematics, supported by a review of existing formal libraries. |
| [building-blocks](building-blocks/) | Useful mathematical building blocks, including established results, counterexamples and explicitly labeled incomplete attempts. |

Each result states its assumptions, mathematical use, sources and proof status. Written or computer-assisted mathematics is distinguished from compiled Lean theorems. A refutation records the exact claim it excludes; an open claim is not presented as a theorem. Priority claims require a specific comparison with prior work.

The [building-blocks index](building-blocks/README.md) organizes the mathematical results. The [arithmetic subject index](building-blocks/arithmetic-subject-index.md) follows dependencies from finite integer laws and phase rigidity to the analytic sign criterion.

## Build

```sh
lake exe cache get
lake build
lake env lean building-blocks/verification/Audit.lean
```

Requires Lean 4.24.0. Dependencies are pinned in [lake-manifest.json](lake-manifest.json). The Lean proofs use only the standard axioms `Classical.choice`, `Quot.sound`, and `propext`.

[MIT license](LICENSE). Dependencies retain their own licenses.
