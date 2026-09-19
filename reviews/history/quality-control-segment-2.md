# Published-history quality control: segment 2

This review covers the 329 published commits from
`d92a63927ccfe4963c31c3a1b17a0665a8339ceb` through
`30bd62f38b8a0474d40826dffcb5ee7a9d72ad88`, as they stand at the frozen
baseline `356d968c7ac34a23113d6fe0a5e10217cef4316c`.

The audit checks the substantive mathematical and Lean changes introduced by
those commits. A successful Lean build is treated as evidence for the stated
formal implication only; hypotheses representing analytic or arithmetic input
remain hypotheses. Routine finite algebra is not described as new analytic
cancellation. Priority language is retained only when supported by a bounded,
documented literature search.

The local coverage ledger inventories all 329 assigned commits without gaps.
For each substantive commit it records targeted theorem-level evidence for the
principal changed claim; this is not a line-by-line independent reproof of
every theorem in every touched file. The review distinguishes current defects,
historical defects repaired by the baseline, conditional results, superseded
intermediate versions, index-only changes, and root-owned catalog overlap.

## Confirmed findings

- Commit `a81ad4c8` published an uncut identity for a heat integral that
  diverges at the lower endpoint. Commit `09508859` repaired the current note
  by introducing an explicit positive cutoff. The defect is historical and is
  not present at the audited baseline.
- The original certificate in commit `de754a71` also omitted the comparison
  requiring the operator residual to be smaller than the certified spectral
  gap before identifying the nearby spectral value with the ground state.
  Commit `cc576bd1` added that condition before the audited baseline.
- Commit `28485368` counted the measure-zero endpoint $n=2X$ as a full
  discrete dyadic cell. Commit `5ac73551` repaired the affected sums to use
  $X\le n<2X$ before the audited baseline.
- Commit `de754a71` introduced a determinant acceptance test in the validated
  killed-ground Galerkin certificate that multiplied two interval lower
  endpoints without checking their signs. Two intervals that cross zero can
  therefore produce a positive number that is not a lower bound for their
  product. The current certificate now requires both diagonal lower endpoints
  to be nonnegative before using that shortcut; validated interval
  multiplication is stated as the general alternative.
- Commit `18fa7a4f` attributed a pointwise cubic Binet bound to a displayed
  moment identity that does not imply it. The bound itself is valid and the
  coefficient sign proof is unchanged; the note now cites equation (9) of the
  linked factorial-clock derivation.
- Commit `188ba36f` contained malformed inline mathematics and a comma in
  place of multiplication in the quadratic defining a finite self-dual
  partition-function example. The intended polynomial and its roots were
  correct. The current note now renders the formulas correctly.

## Source and certificate checks

- Commit `5d65a8fb` accurately identifies a gap in the proof printed in
  Suzuki's arXiv v1, Section 6.2. The repository note correctly limits the
  criticism to that proof and does not claim the theorem is false.
- Exact rational certificates for the prime-prefix contrast and unrestricted
  factorial score counterexample passed. The two renewal interval
  certificates also passed under `python-flint`.

## Scientific housekeeping

The subject-directory reorganization and replacement of narrower intermediate
notes by stronger endpoint versions are recorded as housekeeping or
supersession rather than mathematical advances. A scan of the underlying
assigned notes and Lean modules found no remaining inflated `grand`, `master`,
`definitive`, `unification`, or `breakthrough` descriptions outside the
repository-wide catalogs owned by the supervising review. No exact duplicate
Lean theorem statements were found among the assigned files. The narrower
sub-half-log frequency note was already removed when its endpoint-strengthened
replacement was published; no additional current theorem or proof had a
verified simplification substantial enough to justify changing it.
Labels such as “independently reviewed” are treated only as internal provenance
metadata unless they point to a public review record; they are not used as
evidence of correctness in this audit.

## Scope limits

Repository-wide catalogs, `first-formalizations/`, `unique-contributions/`,
private local inventories, and the recent Chirped/RiemannZeta prose are being
corrected by the supervising review. Findings in those areas are reported for
integration rather than duplicated here.
