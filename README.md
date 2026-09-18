# Proofs about primes and the Riemann hypothesis

Counting moves from $n$ to $n+1$. Factorization describes the same number through primes. This repository studies how those two structures meet, especially how a new prime affects later composite numbers and the error in counting primes.

The Riemann hypothesis (RH) remains open. Some notes prove that a particular bound would imply RH; they do not prove the bound. Each note states whether its argument is written mathematics, checked in Lean, or supported by a finite computation.

## Start reading

- [Successor and division](building-blocks/successor-and-division/) develops the counting and factorization picture.
- [Prime distribution](building-blocks/prime-distribution/) studies the resulting sums and prime-counting error. The [coarse-energy criterion](building-blocks/prime-distribution/coarse-energy-rh-criterion.md) states one precise missing bound.
- [Weil and spectral methods](building-blocks/weil-and-spectral/) studies the complete prime-power form. The [successor-cell theorem](building-blocks/weil-and-spectral/compact-weil-successor-cell-negative-index-density.md) bounds its number of nonpositive directions; it does not establish positivity.
- [Goldbach and additive pairs](building-blocks/goldbach/) includes an [unconditional signed cofactor bound](building-blocks/goldbach/goldbach-cofactor-subleading-vk-gain.md). Its estimate is separate from the still-open RH-scale prime-error bound.
- [All subjects](building-blocks/) gives the other routes, including theta functions, geometry, and dynamics.
- [Current mathematical frontier](FRONTIER.md) records the strongest established bounds and the precise missing estimate.

## Repository guide

| Directory | Contents |
| --- | --- |
| [Building blocks](building-blocks/) | Research notes by subject, with proofs, conditional results, and counterexamples. |
| [Formalization](formalization/) | Lean 4 theorem modules and verification files. |
| [Certificates](certificates/) | Scripts for finite calculations cited by notes. |
| [Unique contributions](unique-contributions/) | Results with a documented, provisional originality comparison. |
| [First formalizations](first-formalizations/) | Lean work on known mathematics with a documented search for prior formalizations. |
| [Reviews](reviews/) | Literature comparisons and audits of published arguments. |

The [long catalog](building-blocks/catalog.md) has detailed cross-references. [Adding work](CONTRIBUTING.md) explains how to record a result and its proof status.

## Check the Lean library

```sh
lake exe cache get
lake build
lake env lean formalization/verification/Audit.lean
```

The project uses Lean 4.24.0 and dependencies pinned in [lake-manifest.json](lake-manifest.json). The axiom audit reports the standard Lean axioms `Classical.choice`, `Quot.sound`, and `propext`.

Unreviewed calculations, source copies, and private research context live in the ignored `research-local/` directory of a local checkout. They are separate from the published notes and formalizations.

[MIT license](LICENSE). Dependencies keep their own licenses.
