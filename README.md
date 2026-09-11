# Proofs

Mathematical proofs and Lean 4 formalizations toward the Riemann hypothesis. The repository contains partial results; RH remains unproved.

| Directory | Contents |
| --- | --- |
| [unique-contributions](unique-contributions/) | Original mathematical results, with proofs and comparisons to prior work. |
| [first-formalizations](first-formalizations/) | First formalizations of known mathematics, supported by a review of existing formal libraries. |
| [building-blocks](building-blocks/) | Verified results with a concrete use in the argument, including established mathematics. |

Each result includes its assumptions, mathematical use, sources, and verification records.

## Build

```sh
lake exe cache get
lake build
lake env lean building-blocks/verification/Audit.lean
```

Requires Lean 4.24.0. Dependencies are pinned in [lake-manifest.json](lake-manifest.json). The Lean proofs use only the standard axioms `Classical.choice`, `Quot.sound`, and `propext`.

[MIT license](LICENSE). Dependencies retain their own licenses.
