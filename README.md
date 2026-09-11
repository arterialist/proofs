# Proofs

Reviewed mathematical proofs and Lean formalizations from an ongoing investigation of the Riemann hypothesis. RH has not been proved in this project.

| Directory | What belongs here |
| --- | --- |
| [unique-contributions](unique-contributions/) | Mathematical results judged original after comparison with prior work, with completed proofs and explicit scope. |
| [first-formalizations](first-formalizations/) | First formalizations supported by a documented search, including formalizations of known mathematics with its authors credited. |
| [building-blocks](building-blocks/) | Verified results that enable a specific next step, establish a needed baseline, or rule out a concrete failed argument. Prior publication or formalization is allowed with attribution. |

Each result has one primary location. Original mathematical results belong in `unique-contributions`; a first-formalization contribution to known mathematics belongs in `first-formalizations`. Results whose priority remains unresolved can qualify as building blocks on demonstrated utility, with that uncertainty stated. Shared support is imported or linked rather than copied between categories.

Every entry must state its theorem and assumptions, mathematical and code provenance, verification status, and practical use. The first two categories also require dated evidence supporting the originality claim and a comparison with the closest prior results. Search cannot certify universal historical absence, and a directory name is not such a certificate. Category decisions can change as evidence arrives.

Formalized results require a successful build of the published snapshot and an audit of the exposed theorems' full axiom dependencies. No unfinished proof or postulated mathematical axiom may be hidden in that dependency chain. A proved conditional implication must retain its assumptions in both the code and its description. Written arguments must be identified separately from kernel-checked statements.

Building blocks need a concrete use: what previously missing step is now justified, what existing result becomes applicable, or what failed inference is excluded. Routine renaming, duplicate copies, and theorem counts alone do not meet that standard. This third category was explicitly authorized on 11 September 2026 and supersedes the earlier repository-wide restriction to original contributions.

## Build

Install the Lean toolchain specified in `lean-toolchain`, then run from this directory:

```sh
lake exe cache get
lake build
lake env lean building-blocks/verification/Audit.lean
```

Lean 4.24.0 and mathlib revision `f897ebcf72cd16f89ab4577d0c826cd14afaafc7` are pinned; transitive dependencies are recorded in `lake-manifest.json`. The current build target covers the building-block library. The other categories contain no admitted proof modules yet.

The repository's original code uses the [MIT license](LICENSE). Dependencies retain their own licenses and authorship.
