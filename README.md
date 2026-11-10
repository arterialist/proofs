# Proofs about primes and the Riemann hypothesis

Counting moves from $n$ to $n+1$. Factorization describes the same number through primes. This repository studies how those two structures meet, especially how a new prime affects later composite numbers and the error in counting primes.

## Status

The Riemann hypothesis (RH) is not proved here.

- **Proved in Lean with no hypotheses.** [UnconditionalResults.lean](formalization/BuildingBlocks/UnconditionalResults.lean) restates every such result in one file. The main ones are that $\zeta(s)\ne0$ for $\mathrm{Re}(s)>1/2$ and $0<\mathrm{Im}(s)\le7.538$, which is a classically known range, and a family of unconditional oscillation theorems for the arithmetic observable $W(x)$ with the exact constants $-1/6$ and $8/9-\gamma/3$.
- **Conditional.** Every Lean declaration here that concludes RH, or a statement proved equivalent to it, takes a hypothesis. The [conditionality audit](formalization/verification/conditional-audit.md) lists all 370 of them with their hypotheses and finds none without one. Some earlier commit messages describe such theorems as proofs of RH. They are implications.
- **Written mathematics and finite computations** are labelled as such in each note. A September 2026 audit found no verified theorem here that improves the global mathematical frontier toward RH.

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
| [Formalization records](formalization/records/) | Demoted claim pages preserved as documentation without novelty or firstness claims. |
| [Reviews](reviews/) | Literature comparisons and audits of published arguments. |
| [Knowledge](knowledge/) | Categories of failed approaches met in this project, with the references they rest on. |

The [long catalog](building-blocks/catalog.md) has detailed cross-references. [Adding work](CONTRIBUTING.md) explains how to record a result and its proof status.

## Check the Lean library

```sh
lake exe cache get
lake build
lake env lean formalization/verification/Audit.lean
lake env lean formalization/verification/ConditionalAudit.lean
```

The project uses Lean 4.34.1 and Mathlib revision `d13f23b7`, pinned in [lake-manifest.json](lake-manifest.json). The port to that Mathlib is in progress: the RH-chain modules and the growth criteria build, and [the build status snapshot](formalization/verification/build-status-2026-10-31.md) lists the registered modules that still fail, grouped by the module that blocks them. Read axiom reports together with the theorem's full hypotheses. A theorem can use only standard foundational axioms while still assuming RH or an unproved estimate.

Unreviewed calculations, source copies, and private research context live in the ignored `research-local/` directory of a local checkout. They are separate from the published notes and formalizations.

[MIT license](LICENSE). Dependencies keep their own licenses.
