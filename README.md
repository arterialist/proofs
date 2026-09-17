# Proofs

This repository collects written proofs, Lean formalizations, and reproducible calculations about primes and the Riemann hypothesis. A central question is how counting by $n\mapsto n+1$ fits with factorization. Each new prime adds a multiplicative generator; its multiples appear later in the count. The notes test what that relationship can prove.

There is no proof of RH here. Several results show that a stated bound or sign would imply RH; the bound or sign is still open. Counterexamples record when a proposed shortcut fails.

## Where to look

| Directory | What it contains |
| --- | --- |
| [Building blocks](building-blocks/) | Research notes grouped by subject, including proved identities, conditional criteria, and counterexamples. |
| [Formalization](formalization/) | Lean 4 modules and build checks. |
| [Certificates](certificates/) | Scripts for finite computations and interval bounds cited by the notes. |
| [Unique contributions](unique-contributions/) | Results whose specific statements or proofs appear original after a documented literature search. |
| [First formalizations](first-formalizations/) | Lean work on known mathematics for which no earlier public formalization was found in a bounded search. |
| [Reviews](reviews/) | Literature comparisons and audits of published arguments. |

The novelty labels describe the searches recorded with each entry. They do not assert that every possible source has been checked. [Adding work](CONTRIBUTING.md) explains where new notes, Lean files, and certificates go.

For a short route through the project, start with the [successor and division notes](building-blocks/successor-and-division/), then the [prime distribution notes](building-blocks/prime-distribution/). The [coarse-energy criterion](building-blocks/prime-distribution/coarse-energy-rh-criterion.md) and the [eventual-sign criterion](building-blocks/zeta-and-zeros/actual-critical-sign-criterion.md) show two precise places where an RH-scale estimate is needed. The [subject guide](building-blocks/) points to the other lines of work. The [long catalog](building-blocks/catalog.md) preserves the detailed cross-references.

## Reading a claim

A Lean file proves its stated theorem under the assumptions in that file. A written argument or numerical certificate has a different scope; the surrounding note says which parts it supports. A conditional RH criterion does not prove its premise. The repository keeps failed approaches because their counterexamples prevent the same mistake from reappearing in a new model.

## Build the Lean library

```sh
lake exe cache get
lake build
lake env lean formalization/verification/Audit.lean
```

The project uses Lean 4.24.0 and the dependencies pinned in [lake-manifest.json](lake-manifest.json). The compiled proofs use the standard axioms `Classical.choice`, `Quot.sound`, and `propext`.

[MIT license](LICENSE). Dependencies retain their own licenses.
