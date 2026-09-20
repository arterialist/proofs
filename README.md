# Proofs about primes and the Riemann hypothesis

Counting moves from $n$ to $n+1$. Factorization describes the same number through primes. This repository studies how those two structures meet, especially how a new prime affects later composite numbers and the error in counting primes.

Some results prove that a particular bound would imply the Riemann hypothesis (RH); they do not prove the bound. The recent Lean zero-free result covers $\operatorname{Re}(s)>1/2$ and $0<\operatorname{Im}(s)\le 7.465$. The high-frequency operator interfaces still require unproved estimates. Each result states whether it is written mathematics, a Lean theorem, or a finite computation. A September 2026 audit found no verified theorem here that improves the global mathematical frontier toward RH. The repository still contains seven specialized results with plausible originality and five provisional first-Lean packages. These labels record bounded searches, not worldwide priority. Demoted statements remain in [formalization records](formalization/records/) or the subject building blocks.

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
| [Candidate original results](unique-contributions/) | 7 specialized reports with exact statements, proof or certificate evidence, and bounded source comparisons. None is currently certified as a global RH-frontier advance. |
| [First formalizations](first-formalizations/) | 5 provisional Lean records with no-`sorry` artifacts and bounded public search scopes. |
| [Formalization records](formalization/records/) | 374 demoted claim pages preserved as documentation without novelty or firstness claims. |
| [Reviews](reviews/) | Literature comparisons and audits of published arguments. |

The [long catalog](building-blocks/catalog.md) has detailed cross-references. [Adding work](CONTRIBUTING.md) explains how to record a result and its proof status.

## Check the Lean library

```sh
lake exe cache get
lake build
lake env lean formalization/verification/Audit.lean
```

The project uses Lean 4.24.0 and dependencies pinned in [lake-manifest.json](lake-manifest.json). Read axiom reports together with the theorem's full hypotheses. A theorem can use only standard foundational axioms while still assuming RH or an unproved estimate.

Unreviewed calculations, source copies, and private research context live in the ignored `research-local/` directory of a local checkout. They are separate from the published notes and formalizations.

[MIT license](LICENSE). Dependencies keep their own licenses.
